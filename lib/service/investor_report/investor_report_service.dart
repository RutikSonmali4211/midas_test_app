import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';
import 'package:midas/storage/local_storage.dart';
class InvestorReportService {

  Future<http.Response> downloadHoldingReport(BuildContext context) async {
    try {
     String? userId = LocalStorage.getUserId();
      var response = await ApiHandler.downloadFile(
        "${ApplicationUrls.downloadHoldingReportUrl}/$userId/download",{}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> downloadCapitalGainReport(BuildContext context) async {
    try {
     String? userId = LocalStorage.getUserId();
      var response = await ApiHandler.downloadFile(
        "${ApplicationUrls.downloadCapitalGainReportUrl}/$userId/download",{}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

   Future<http.Response> downloadInvestmentAccountWiseReport(BuildContext context) async {
    try {
     String? userId = LocalStorage.getUserId();
      var response = await ApiHandler.downloadFile(
        "${ApplicationUrls.downloadInvestmentAccountWiseReportUrl}/$userId/download",{}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }


   Future<http.Response> downloadSchemeWiseReport(BuildContext context) async {
    try {
     String? userId = LocalStorage.getUserId();
      var response = await ApiHandler.downloadFile(
        "${ApplicationUrls.downloadSchemeWiseReportUrl}/$userId/download",{}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

}