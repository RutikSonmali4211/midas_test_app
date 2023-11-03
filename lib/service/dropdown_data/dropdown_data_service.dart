// import 'package:flutter/material.dart';
// import 'package:midas/constant/application_urls.dart';
// import 'package:http/http.dart' as http;
// import 'package:midas/constant/constant_util.dart';
// import 'package:midas/exception/custom_exception.dart';
// import 'package:midas/service/api_handler.dart';

// class DropdownDataService {
//   //  this method is used to get the data for all dropdowns in application
//   Future<http.Response> getDropdownData(
//       String type, BuildContext context) async {
//     try {
//       var response = await ApiHandler.get(
//           "${ApplicationUrls.dropDownUrl}/$type", {}, context);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   //  this method is used to get the data for sign up form data and financial data dropdowns in application
//   Future<http.Response> fetchDataAndFinancialDataDropdown(String type) async {
//     try {
//       var response = await http
//           .get(Uri.parse("${ApplicationUrls.dropDownUrl}/$type"), headers: {
//         "Content-Type": "application/json","isvalidrequest":ConstantUtil.requestValidKey
//       }).timeout(ConstantUtil.requestTimeout, onTimeout: () {
//         throw CustomException(ConstantUtil.requestTimeoutMesssage);
//       });
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
