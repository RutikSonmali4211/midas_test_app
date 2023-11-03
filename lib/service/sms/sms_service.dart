import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:midas/constant/application_urls.dart';
import 'package:midas/constant/constant_util.dart';

class SmsService {

  Future<http.Response> sendOtp(String mobileNumber) async {
    try {
      var response = await http
          .post(Uri.parse(ApplicationUrls.sendOtpUrl),
              headers: {"Content-Type": "application/json","isvalidrequest":ConstantUtil.requestValidKey},
              body: json.encode({
                "mobileNumber": mobileNumber,
              }))
          .timeout(ConstantUtil.requestTimeout, onTimeout: () {
        throw ConstantUtil.requestTimeoutMesssage;
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> verifyOtp(String mobileNumber,String otp) async {
    try {
      var response = await http
          .post(Uri.parse(ApplicationUrls.verifyOtpUrl),
              headers: {"Content-Type": "application/json","isvalidrequest":ConstantUtil.requestValidKey},
              body: json.encode({
                "mobileNumber": mobileNumber,
                "otp": otp,
              }))
          .timeout(ConstantUtil.requestTimeout, onTimeout: () {
        throw ConstantUtil.requestTimeoutMesssage;
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
