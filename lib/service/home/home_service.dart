import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';

class HomeService {
  Future<http.Response> getLastSevenDaysGraphDataByUserId(
      String userId, BuildContext context) async {
    try {
      Map<String, dynamic> requestBody = {"user_id": userId};
      var response = await ApiHandler.post(
          ApplicationUrls.netWorthUrl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
