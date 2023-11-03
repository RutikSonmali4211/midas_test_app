import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';
import 'package:midas/storage/local_storage.dart';

class InvestmentService {


  Future<http.Response> getCurrentAndInvestedValues(BuildContext context) async {
    try {
      final userId = LocalStorage.getUserId();
      var response = await ApiHandler.get(
          "${ApplicationUrls.investmentUrl}/values/userId/$userId", {}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }


 
}