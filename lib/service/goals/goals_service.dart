import 'package:flutter/material.dart';
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';
import 'package:midas/storage/local_storage.dart';
import 'package:http/http.dart' as http;

class GolasService {
  // this service is used to add new goal details
  Future<http.Response> addNewGoal(String goalName, double goalValue,
      String goalTargetdate, String description, BuildContext context) async {
    try {
      final userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "user_id": userId,
        "goalName": goalName,
        "value": goalValue,
        "description": description,
        "targetDate": goalTargetdate,
        "status": "active"
      };
      var response =
          await ApiHandler.post(ApplicationUrls.goalsUrl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getGoalsList(
      int page, int pageSize, BuildContext context) async {
    try {
      final userId = LocalStorage.getUserId();
      var response = await ApiHandler.get(
          "${ApplicationUrls.getGoalsListByUserIdUrl}/userId/$userId?page=$page&pageSize=$pageSize",
          {},
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> deleteGoal(String goalId, BuildContext context) async {
    try {
      var response = await ApiHandler.delete(
          "${ApplicationUrls.goalsUrl}/$goalId", {}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> updateGoal(
      String goalId,
      String goalName,
      double goalValue,
      String goalTargetDate,
      String description,
      BuildContext context) async {
    try {
      Map<String, dynamic> requestBody = {
        "goalName": goalName,
        "value": goalValue,
        "description": description,
        "targetDate": goalTargetDate,
        "status": "active"
      };
      var response = await ApiHandler.put(
          "${ApplicationUrls.goalsUrl}/$goalId", requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
