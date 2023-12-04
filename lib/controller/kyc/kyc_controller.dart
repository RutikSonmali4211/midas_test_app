import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../Logs/Loggers.dart';
import '../../Model/Dto/ImageData.dart';
import '../../Service/kyc/kyc_service.dart';
import '../../Widgets/alert_message/alert_message.dart';
import '../../Widgets/loader.dart';
import '../../constant/constant_util.dart';
import '../../exception/custom_exception.dart';

class KycController extends GetxController {
  //  Position? _position;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  final KycService kycService = KycService();

  Future<Position?> getCurrentLocation() async {
    Position position = await _determinePosition();
    update();
    return position;
    // setState(() {
    //   _position = position;
    // });
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
    var response = await kycService.uploadFile(name, file, context);
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      bool status = jsonResponse['status'];
      String id = jsonResponse['result']['id'];
      String message = jsonResponse['message'];

      ImageData data = ImageData(status: status, value: id, message: message);
      return data;
    } else {
      ImageData data =
          ImageData(status: false, value: "", message: jsonResponse['message']);
      return data;
    }
  }

  startEsign(BuildContext context) async {
    var response = await kycService.startEsign(context);
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      bool status = jsonResponse['status'];
      String url = jsonResponse['result']['redirect_url'];
      String message = jsonResponse['message'];
      ImageData data = ImageData(status: status, value: url, message: message);
      return data;
    } else {
      ImageData data =
          ImageData(status: false, value: "", message: jsonResponse['message']);
      return data;
    }
  }

  fetchKycStatus(BuildContext context) async {
    var response = await kycService.fetchKycStatus(context);
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      bool status = jsonResponse['status'];
      String url = jsonResponse['result']["status"]??"";
      String message = jsonResponse['message'];
      ImageData data = ImageData(status: status, value: url, message: message);
      return data;
    } else {
      ImageData data =
          ImageData(status: false, value: "", message: jsonResponse['message']);
      return data;
    }
  }

  fetchKycDetails(BuildContext context) async {
    var response = await kycService.fetchKycStatus(context);
    final Map<String, dynamic> jsonResponse =  jsonDecode(response.body);
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
      // ignore: use_build_context_synchronously
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
          context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(KycController, "ERROR",
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
}
