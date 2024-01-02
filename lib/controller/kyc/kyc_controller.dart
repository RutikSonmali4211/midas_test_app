// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../Logs/Loggers.dart';
import '../../model/Dto/ImageData.dart';
import '../../service/kyc/kyc_service.dart';
import '../../Widgets/alert_message/alert_message.dart';
import '../../Widgets/loader.dart';
import '../../constant/constant_util.dart';
import '../../exception/custom_exception.dart';
import '../../screen/profile/kyc/esign_required_screen.dart';
import '../../screen/profile/kyc/kyc_rejected_screen.dart';

class KYCController extends GetxController {
  KycService kycService = KycService();

  var isLoading = false.obs;

  Future<Position?> getCurrentLocation() async {
    Position position = await _determinePosition();
    update();
    return position;
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            'please give permissions to enable your location to continue');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  uploadFile(name, file, BuildContext context) async {
    try {
      Loader.showLoading();
      var response = await kycService.uploadFile(name, file, context);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse.toString());
      if (response.statusCode == 200) {
        bool status = jsonResponse['status'];
        String id = jsonResponse['result']['id'];
        String message = jsonResponse['message'];
        ImageData data = ImageData(status: status, value: id, message: message);
        return data;
      } else {
        showErrorAlert(jsonResponse['message']);
        ImageData data = ImageData(
            status: false, value: "", message: jsonResponse['message']);
        return data;
      }
    } catch (e) {
      return ImageData(status: false, value: "", message: e.toString());
    } finally {
      Loader.hideLoading();
    }
  }

  RxList<Map<String, dynamic>> verificationDetails =
      <Map<String, dynamic>>[].obs;

  void setVerificationDetails(Map<String, dynamic> details) {
    List<Map<String, dynamic>> updatedDetails = [];
    details.forEach((field, error) {
      updatedDetails.add({
        'field': field,
        'error': error['reason'] ?? 'Unknown error',
      });
    });
    verificationDetails.assignAll(updatedDetails);
  }

  startEsign(BuildContext context) async {
    try {
      Loader.showLoading();
      var response = await kycService.startEsign(context);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse.toString());
      if (response.statusCode == 200) {
        bool status = jsonResponse['status'];
        String url = jsonResponse['result']['redirect_url'];
        String message = jsonResponse['message'];
        ImageData data =
            ImageData(status: status, value: url, message: message);
        return data;
      } else {
        ImageData data = ImageData(
            status: false, value: "", message: jsonResponse['message']);
        return data;
      }
    } catch (e) {
      e.toString();
    } finally {
      Loader.hideLoading();
    }
  }

  Future<ImageData> fetchKycStatus(BuildContext context) async {
    try {
      isLoading.value = true;
      var response = await kycService.fetchKycStatus(context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        bool status = jsonResponse['status'];
        String url = jsonResponse['result']["status"] ?? "";
        String message = jsonResponse['message'];
        ImageData data =
            ImageData(status: status, value: url, message: message);
        return data;
      } else {
        ImageData data = ImageData(
            status: false, value: "", message: jsonResponse['message']);
        return data;
      }
    } catch (e) {
      return ImageData(status: false, value: "", message: "");
    } finally {
      isLoading.value = false;
    }
  }

  fetchKycDetails(BuildContext context) async {
    var response = await kycService.fetchKycStatus(context);
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse;
    } else {
      return jsonResponse;
    }
  }

  Future<bool> createKyc(
      bool startKyc,
      String name,
      String mobileNumber,
      String email,
      String pan,
      String aadhaar,
      String dob,
      String gender,
      String fatherName,
      String motherName,
      String countryOfBirth,
      String maritalStatus,
      String occupation,
      String addressLine1,
      String addressLine2,
      String addressLine3,
      String city,
      String pincode,
      String country,
      String addressProof,
      String addressProofBack,
      String addressProofType,
      String addressProofNumber,
      String addressProofIssueDate,
      String addressProofExpiryDate,
      String bankAccountHolderName,
      String bankAccountNumber,
      String bankAccountIfscCode,
      String bankAccountProof,
      String pancardDoc,
      String signatureDocument,
      String photoDoc,
      String ipvVedio,
      BuildContext context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      Position? position = await getCurrentLocation();
      var latitude = position?.latitude;
      var longitude = position?.longitude;
      var response = await kycService.createKyc(
          startKyc,
          name,
          mobileNumber,
          email,
          pan,
          aadhaar,
          dob,
          gender,
          fatherName,
          motherName,
          countryOfBirth,
          maritalStatus,
          occupation,
          addressLine1,
          addressLine2,
          addressLine3,
          city,
          pincode,
          country,
          addressProof,
          addressProofBack,
          addressProofType,
          addressProofNumber,
          addressProofIssueDate,
          addressProofExpiryDate,
          bankAccountHolderName,
          bankAccountNumber,
          bankAccountIfscCode,
          bankAccountProof,
          pancardDoc,
          signatureDocument,
          photoDoc,
          ipvVedio,
          latitude,
          longitude,
          context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        Loader.hideLoading();
        print(jsonResponse["result"]["status"]);
        if (jsonResponse["result"]["status"] == "esign_required") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const EsignRequired()),
          );
        }
        if (jsonResponse["result"]["status"] == "pending") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const KycRejected()),
          );
        }
        return true;
      } else if (response.statusCode >= 500) {
        Loader.hideLoading();
        await Loggers.printLog(KYCController, "ERROR",
            "error in sign up new user ${jsonResponse['message']}");
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse != null && jsonResponse['result'] != null) {
          var errorMessage = '';
          for (var result in jsonResponse['result']) {
            errorMessage += '${result['field']}: ${result['message']}\n';
          }
          showErrorDialogBox(errorMessage);
        }
        return false;
      }
    } catch (e) {
      Loader.hideLoading();
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    }
  }

  Future<bool> updateBankDetails(
      String bankAccountHolderName,
      String bankAccountNumber,
      String bankAccountIfscCode,
      BuildContext context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      var response = await kycService.updateBankDetails(bankAccountHolderName,
          bankAccountNumber, bankAccountIfscCode, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Loader.hideLoading();
        return true;
      } else if (response.statusCode >= 500) {
        Loader.hideLoading();
        await Loggers.printLog(KYCController, "ERROR",
            "error in sign up new user ${jsonResponse['message']}");
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse != null) {
          showErrorAlert(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      Loader.hideLoading();
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    }
  }

  Future<bool> updateKycStatusAfterEsignCompleted(
      String status, BuildContext context) async {
    try {
      Loader.showLoading();
      var response =
          await kycService.updateKycStatusAfterEsignCompleted(status, context);
      if (response.statusCode == 200) {
        showSuccessAlert("your Esign is completed");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    } finally {
      Loader.hideLoading();
    }
    return false;
  }
}
