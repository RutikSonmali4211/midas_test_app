import 'package:flutter/material.dart';
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';
import 'package:midas/storage/local_storage.dart';
import 'package:http/http.dart' as http;

class GoldService {
  // investment type
  static const String type = 'Gold';

  // this service is used to add new gold details
  Future<http.Response> addNewGold(String shortTitle, double weight,
      String goldPurity, String description, BuildContext context) async {
    try {
      final userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "userId": userId,
        "type": type,
        "status": "active",
        "data": {
          "shortTitle": shortTitle,
          "weight": weight,
          "goldPurity": goldPurity,
          "description": description,
          "investedValue": 0
        }
      };
      var response = await ApiHandler.post(
          ApplicationUrls.investmentUrl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getGoldItemsList(
      int page, int pageSize, String goldPurity, BuildContext context) async {
    try {
      final userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "type": type,
        "goldPurity": goldPurity
      };
      var response = await ApiHandler.get(
          "${ApplicationUrls.investmentUrl}/userId/$userId?page=$page&pageSize=$pageSize",
          requestBody,
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> deleteGoldItem(
      String investmentId, BuildContext context) async {
    try {
      var response = await ApiHandler.delete(
          "${ApplicationUrls.investmentUrl}/$investmentId", {}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> updateGoldItems(
      String goldId,
      String shortTitle,
      double weight,
      String goldPurity,
      String description,
      BuildContext context) async {
    try {
      Map<String, dynamic> requestBody = {
        "type": type,
        "status": "active",
        "data": {
          "shortTitle": shortTitle,
          "weight": weight,
          "goldPurity": goldPurity,
          "description": description,
          "investedValue": 0
        }
      };
      var response = await ApiHandler.put(
          "${ApplicationUrls.investmentUrl}/$goldId", requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
