import 'dart:io';
import 'package:flutter/material.dart';
import 'package:midas/constant/application_urls.dart';
import 'package:http/http.dart' as http;

import '../../storage/local_storage.dart';
import '../api_handler.dart';

class KycService {
  Future<http.Response> uploadFile(
      String documentType, File file, BuildContext context) async {
    String userId = LocalStorage.getUserId().toString();
    var response = await ApiHandler.uploadFile(
        ApplicationUrls.uploadKycFile, userId, documentType, file, context);
    return response;
  }

  Future<http.Response> fetchKycStatus(BuildContext context) async {
    String userId =LocalStorage.getUserId().toString();
    var response = await ApiHandler.get(
      "${ApplicationUrls.fetchKycStatus}/$userId", {}, context);
    return response;
  }

  Future<http.Response> startEsign(BuildContext context) async {
    String userId = LocalStorage.getUserId().toString();
    Map<String, dynamic> requestBody = {
      "userId": userId,
      "postBackUrl": "myflutterapp://callback"
    };
    var response = await ApiHandler.post(
        ApplicationUrls.createEsign, requestBody, context);
    return response;
  }

  Future<http.Response> createKyc(
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
      final userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "startkyc": startKyc,
        "userId": userId,
        "pan": pan,
        "email": email,
        "aadhaar_number": aadhaar,
        "mobile": {"isd": "+91", "number": mobileNumber},
        "name": name,
        "father_name": fatherName,
        "spouse_name": "",
        "mother_name": motherName,
        "gender": gender,
        "date_of_birth": dob,
        "country_of_birth": countryOfBirth,
        "marital_status": maritalStatus,
        "residential_status": "resident_individual",
        "occupation_type": occupation,
        "address": {
          "line_1": addressLine1,
          "line_2": addressLine2,
          "line_3": addressLine3,
          "city": city,
          "pincode": pincode,
          "country": country,
          "proof": addressProof,
          "proof_back": addressProofBack,
          "proof_type": addressProofType,
          "proof_number": addressProofNumber,
          "proof_issue_date": addressProofIssueDate,
          "proof_expiry_date": addressProofExpiryDate
        },
        "geolocation": {"latitude": 12.354, "longitude": 77.453},
        "bank_account": {
          "account_holder_name": bankAccountHolderName,
          "account_number": bankAccountNumber,
          "ifsc_code": bankAccountIfscCode,
          "proof": bankAccountProof
        },
        "ipv_video": ipvVedio,
        "identity_proof": pancardDoc,
        "signature": signatureDocument,
        "photo": photoDoc
      };
      var response = await ApiHandler.post(
          ApplicationUrls.createKyc, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
