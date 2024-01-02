import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';
import 'package:midas/storage/local_storage.dart';

class MutualFundRecommondationService {
  Future<http.Response> getMutualFundRecommondationStrategies(
      int page, int pageSize, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      var response = await ApiHandler.get(
          "${ApplicationUrls.getMutualFundRecommondationStrategies}?userId=$userId&page=$page&pageSize=$pageSize",
          {},
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> createMutualFundRecommondationByGoals(
      String goalId,
      String goalName,
      String targetDate,
      double goalAmount,
      BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "user_id": userId,
        "goalId": goalId,
        "goalName": goalName,
        "goalAmount": goalAmount,
        "targetDate": targetDate,
      };
      var response = await ApiHandler.post(
          ApplicationUrls.createMutualFundRecommondationForGoals, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
