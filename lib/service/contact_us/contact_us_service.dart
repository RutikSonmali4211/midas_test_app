import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';
import 'package:midas/storage/local_storage.dart';

class ContactUsService {
  Future<http.Response> addNewContactRequest(
      String contactUsCategory, String details, BuildContext context) async {
    try {
      final userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "user_id": userId,
        "contactUsCategory": contactUsCategory,
        "details": details,
        "status": "active"
      };
      var response = await ApiHandler.post(
          ApplicationUrls.contactUsUrl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
