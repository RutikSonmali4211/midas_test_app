import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';
import 'package:midas/storage/local_storage.dart';

class GoldTypesService extends GetxController{


   Future<http.Response> getGoldTypesList(BuildContext context) async {
    try {
      var response = await ApiHandler.get(
          ApplicationUrls.goldTypesUrl, {}, context);
      return response;
    } catch (e) {
      rethrow;
    }
   }

   Future<http.Response> getTodaysGoldRates(BuildContext context) async {
    try {
      var response = await ApiHandler.get(
          ApplicationUrls.getTodaysGoldRatesUrl, {}, context);
      return response;
    } catch (e) {
      rethrow;
    }
   }

   Future<http.Response> getGoldTypesWithCurrentValueAndQuantity(BuildContext context) async {
    try {
      final userId = LocalStorage.getUserId();
      var response = await ApiHandler.get(
          "${ApplicationUrls.goldTypesUrl}/userId/$userId", {}, context);
      return response;
    } catch (e) {
       rethrow;
    }
  }

}