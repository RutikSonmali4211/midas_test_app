// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/date_util.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/Loggers.dart';
import 'package:midas/model/user/user_model.dart';
import 'package:midas/screen/sign_up/sign_up.dart';
import 'package:midas/service/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:midas/storage/local_storage.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:midas/widgets/biometric_alert_box.dart';
import 'package:midas/widgets/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController extends GetxController {
  final UserService userService = UserService();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Rx<UserModel?> user = Rx<UserModel?>(null);
  Rx<bool> isDeviceSupport = false.obs;
  List<BiometricType>? availableBiometrics;
  LocalAuthentication? auth;
  Rx<bool> isBiometricEnabled = false.obs;
  var isLoading = false.obs;
  Rx<bool> isBometricAlertDisplay = false.obs;
  RxBool isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    deviceCapability();
  }

  changeBiometricToEnableDisabled(BuildContext context) async {
    String? deviceToken = LocalStorage.getDeviceToken();
    String? userId = LocalStorage.getUserId();
    if (isBiometricEnabled.value) {
      setBiometricEnabledDisabled(userId!, false, deviceToken!, context);
    } else {
      bool isSuccess = await checkBiometricAuthentication(
          ConstantUtil.verifyBiometricAuthMessage, context);
      if (isSuccess) {
        setBiometricEnabledDisabled(userId!, true, deviceToken!, context);
      }
    }
  }

  Future<bool> registerUser(
      String name,
      String email,
      String mobileNumber,
      bool isSso,
      String username,
      String password,
      String pan,
      String aadhaar,
      String startDate,
      String endDate,
      List<Map<String, dynamic>> data,
      List<Map<String, dynamic>> financialData,
      BuildContext context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
      String convertedStartDate = DateUtil.convertDateInIsoFormat(date);
      String convertedEndDate = DateUtil.convertDateInIsoFormat(date);
      var response = await userService.registerUser(
          name,
          email,
          mobileNumber,
          username,
          password,
          isSso,
          pan,
          aadhaar,
          convertedStartDate,
          convertedEndDate,
          data,
          financialData);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LocalStorage.setUserName(email);
        LocalStorage.removeIsBiometricEnabled();
        LocalStorage.removeIsBiometricAlert();
        isBiometricEnabled.value = false;
        isBometricAlertDisplay.value = false;
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(UserController, "ERROR",
            "error in sign up new user ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      Loader.hideLoading();
    }
  }

  loginUser(String email, String password, BuildContext context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      final response = await userService.loginUser(
          email, password, ConstantUtil.normalLogin);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LocalStorage.setUserName(email);
        String? deviceToken = LocalStorage.getDeviceToken();
        user.value = UserModel.fromJson(jsonResponse['result']['user']);
        await userService.addDeviceTokenForBiometricLogin(
            deviceToken!, jsonResponse['result']['user']["_id"]);
        if (user.value!.deviceTokens.isNotEmpty) {
          for (var element in user.value!.deviceTokens) {
            if (element.deviceToken == deviceToken) {
              LocalStorage.setIsBiometricEnabled(element.bioMatric);
              isBiometricEnabled.value = element.bioMatric;
              update();
            }
          }
        }
        LocalStorage.setToken(jsonResponse['result']['token']);
        LocalStorage.setUserId(jsonResponse['result']['user']['_id']);
        LocalStorage.setUser(json.encode(jsonResponse['result']['user']));
        isLogin.value = true;
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(UserController, "ERROR",
            "error in login user ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      Loader.hideLoading();
    }
  }

  Future<bool> logoutUser(BuildContext context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      await FirebaseAuth.instance.signOut();
      await FacebookAuth.i.logOut();
      await _googleSignIn.signOut();
      var response = await userService.logoutUser(context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Set<String> keys = LocalStorage.instance.getKeys();
        for (String key in keys) {
          if (key != ConstantUtil.userId &&
              key != ConstantUtil.deviceToken &&
              key != ConstantUtil.bioMatric &&
              key != ConstantUtil.biometricAlert &&
              key != ConstantUtil.username) {
            LocalStorage.instance.remove(key);
          }
        }
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(UserController, "ERROR",
            "error in logout user ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      Loader.hideLoading();
    }
  }

  Future<bool> loginWithBiometric(BuildContext context) async {
    try {
      auth = LocalAuthentication();
      deviceCapability();
      bool didAuthenticate = await checkBiometricAuthentication(
          ConstantUtil.biometricAuthMessage, context);
      if (didAuthenticate) {
        Loader.showLoading();
        if (!await ConstantUtil.isInternetConnected()) {
          throw CustomException(ConstantUtil.internetUnavailable);
        }
        String? deviceToken = LocalStorage.getDeviceToken();
        String? userId = LocalStorage.getUserId();
        final response =
            await userService.loginWithBiometric(deviceToken!, userId!);
        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          LocalStorage.setToken(jsonResponse['result']['token']);
          LocalStorage.setUserId(jsonResponse['result']['user']['_id']);
          LocalStorage.setUser(json.encode(jsonResponse['result']['user']));
          return true;
        } else if (response.statusCode >= 500) {
          await Loggers.printLog(UserController, "ERROR",
              "error in login with biometric ${jsonResponse['message']}");
          return false;
        } else {
          showErrorAlert(jsonResponse['message']);
          return false;
        }
      } else {
        final List<BiometricType> availableBiometrics =
            await auth!.getAvailableBiometrics();
        if (availableBiometrics.isNotEmpty) {
          showErrorAlert("Error Authenticating");
        }
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      Loader.hideLoading();
    }
  }

  Future<bool> loginWithSso(name, email, BuildContext context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      final response =
          await userService.loginUser(email, "password", ConstantUtil.ssoLogin);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        LocalStorage.setUserName(email);
        String? deviceToken = LocalStorage.getDeviceToken();
        user.value = UserModel.fromJson(jsonResponse['result']['user']);
        await userService.addDeviceTokenForBiometricLogin(
            deviceToken!, jsonResponse['result']['user']["_id"]);
        if (user.value!.deviceTokens.isNotEmpty) {
          for (var element in user.value!.deviceTokens) {
            if (element.deviceToken == deviceToken) {
              LocalStorage.setIsBiometricEnabled(element.bioMatric);
              isBiometricEnabled.value = element.bioMatric;
              update();
            }
          }
        }
        LocalStorage.setToken(jsonResponse['result']['token']);
        LocalStorage.setUserId(jsonResponse['result']['user']['_id']);
        LocalStorage.setUser(json.encode(jsonResponse['result']['user']));
        isLogin.value = true;
        return true;
      } else if (response.statusCode == 404) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => SignUpScreen(
                    ssoName: name,
                    ssoemail: email,
                    ssoLogin: 'sso_login',
                    isWatch: true)),
            (Route route) => false);
        return false;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(UserController, "ERROR",
            "error in login user ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      Loader.hideLoading();
    }
  }

  Future<void> setBiometricEnabledDisabled(
      String userId, bool isBiometric, String deviceToken, context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      final response = await userService.setBiometricLoginEnabledOrDisabled(
          userId, isBiometric, deviceToken, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['result']['bioMatric']) {
          isBiometricEnabled.value = true;
          LocalStorage.setIsBiometricEnabled(true);
          print(jsonResponse['message']);
          update();
        } else {
          isBiometricEnabled.value = false;
          LocalStorage.setIsBiometricEnabled(false);
          print(jsonResponse['message']);
          update();
        }
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(UserController, "ERROR",
            "error in set biometric enabled disabled ${jsonResponse['message']}");
      } else {
        showErrorAlert(jsonResponse['message']);
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
    } finally {
      Loader.hideLoading();
    }
  }

  Future<bool> checkBiometricAuthentication(
      String authmessage, BuildContext context) async {
    try {
      final List<BiometricType> availableBiometrics =
          await auth!.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.strong) ||
          availableBiometrics.contains(BiometricType.fingerprint)) {
        final bool didAuthenticate = await auth!.authenticate(
          localizedReason: authmessage,
          options: const AuthenticationOptions(
              biometricOnly: false, stickyAuth: false),
        );
        return didAuthenticate;
      } else if (availableBiometrics.contains(BiometricType.weak) ||
          availableBiometrics.contains(BiometricType.face)) {
        final bool didAuthenticate = await auth!.authenticate(
          localizedReason: authmessage,
          options: const AuthenticationOptions(
              biometricOnly: false, stickyAuth: false),
        );
        return didAuthenticate;
      } else {
        showErrorAlert(ConstantUtil.biometricAuthNotSetMessage);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  getUserDetailsById(BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      isLoading.value = true;
      String? userId = LocalStorage.getUserId();
      var response = await userService.getUserDetailsById(userId!, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        user.value = jsonResponse['result'];
        update();
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(UserController, "ERROR",
            "error in get user details by id ${jsonResponse['message']}");
      } else {
        showErrorAlert(jsonResponse['message']);
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  getUserDetailsFromLocalStorage(BuildContext context) async {
    try {
      isLoading.value = true;
      user.value = userModelFromJson(LocalStorage.getUser()!);
      update();
    } catch (e) {
      e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> showBiometricAuthEnbleAlert(BuildContext context) async {
    bool shouldShowAlert = LocalStorage.getBiometricAlert() != null
        ? LocalStorage.getBiometricAlert()!
        : false;

    if (!shouldShowAlert && isLogin.value) {
      isLogin.value = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BiometricAlertBox(
              message: ConstantUtil.biometricAuthEnableMessage,
              onConfirm: () async {
                Navigator.pop(context, false);
                String? userId = LocalStorage.getUserId();
                String? deviceToken = LocalStorage.getDeviceToken();
                LocalStorage.setBiometricAlert(isBometricAlertDisplay.value);
                bool isSuccess = await checkBiometricAuthentication(
                    ConstantUtil.verifyBiometricAuthMessage, context);
                if (isSuccess) {
                  setBiometricEnabledDisabled(
                      userId!, true, deviceToken!, context);
                }
              });
        },
      );
    }
  }

  void deviceCapability() async {
    auth = LocalAuthentication();
    final bool isCapable = await auth!.canCheckBiometrics;
    isDeviceSupport.value = isCapable || await auth!.isDeviceSupported();
  }

  Future<bool> currentPassword(String password, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('username') ?? '';
      Loader.showLoading();
      final response = await userService.loginUser(
          email, password, ConstantUtil.normalLogin);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // showSuccessAlert("Password is Correct");
        return true;
      } else if (response.statusCode >= 500) {
        // showErrorAlert("wrong pin");
        await Loggers.printLog(UserController, "ERROR",
            "error in login user ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert("wrong pin");
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      Loader.hideLoading();
    }
  }

  Future<bool> savePassword(String pin, BuildContext context) async {
    try {
      Loader.showLoading();
      String userId = LocalStorage.getUserId().toString();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      var response = await userService.updatePin(userId, pin, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert("pin updated successfully");
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(UserController, "ERROR",
            "error in password ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert("failed to update pin");
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      Loader.hideLoading();
    }
  }

  Future<bool> saveInvestmentProfile(
      List<Map<String, dynamic>> InvestmentProfileData,
      BuildContext context) async {
    try {
      Loader.showLoading();
      String userId = LocalStorage.getUserId().toString();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      var response = await userService.updateInvestmentProfile(
          userId, InvestmentProfileData, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert("investment profile saved successfully");
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(UserController, "ERROR",
            "error in save investment profile ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert("Failed to save investment profile");
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      Loader.hideLoading();
    }
  }
}
