import 'package:flutter/material.dart';
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';
import 'package:midas/storage/local_storage.dart';
import 'package:http/http.dart' as http;

class OtherAssetsService {
  // investment type
  static const String type = 'Other Assets';

  // this service is used to add new gold details
  Future<http.Response> addOtherAssets(String assetName, double currentPrice,
      double purchasePrice, String purchaseDate, BuildContext context) async {
    try {
      final userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "userId": userId,
        "status": "active",
        "type": type,
        "data": {
          "assetName": assetName,
          "currentPrice": currentPrice,
          "purchasePrice": purchasePrice,
          "purchaseDate": purchaseDate
        }
      };
      var response = await ApiHandler.post(
          ApplicationUrls.investmentUrl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getOtherAssetsList(
      int page, int pageSize, BuildContext context) async {
    try {
      final userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {"type": type};
      var response = await ApiHandler.get(
          "${ApplicationUrls.investmentUrl}/userId/$userId?page=$page&pageSize=$pageSize",
          requestBody,
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> deleteOtherAsset(
      String investmentId, BuildContext context) async {
    try {
      var response = await ApiHandler.delete(
          "${ApplicationUrls.investmentUrl}/$investmentId", {}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> updateOtherAsset(
      String otherAssetId,
      String assetName,
      double purchasePrice,
      double currentValue,
      String purchaseDate,
      BuildContext context) async {
    try {
      Map<String, dynamic> requestBody = {
        "type": type,
        "status": "active",
        "data": {
          "assetName": assetName,
          "currentPrice": currentValue,
          "purchasePrice": purchasePrice,
          "purchaseDate": purchaseDate
        }
      };
      var response = await ApiHandler.put(
          "${ApplicationUrls.investmentUrl}/$otherAssetId",
          requestBody,
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
