import 'dart:convert';

import 'package:get/get.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/Loggers.dart';
import 'package:midas/service/sms/sms_service.dart';
import 'package:midas/widgets/alert_message/snackbar.dart';
import 'package:midas/widgets/loader.dart';

class SmsController extends GetxController {
  SmsService smsService = SmsService();
  RxBool isMobileNumberVerified=false.obs;

  Future<bool> sendOtp(String mobileNumber) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      var response = await smsService.sendOtp(mobileNumber);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert("otp send successfully");
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(SmsController, "ERROR",
            "error in sned otp ${jsonResponse['message']}");
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


    Future<bool> verifyOtp(String mobileNumber,String otp) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      var response = await smsService.verifyOtp(mobileNumber,otp);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
         isMobileNumberVerified.value=true;
         update();
        showSuccessAlert(jsonResponse['message']?? "otp verifled successfully");
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(SmsController, "ERROR",
            "error in verify otp ${jsonResponse['message']}");
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
}
