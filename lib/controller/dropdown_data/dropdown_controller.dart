import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/Loggers.dart';
import 'package:midas/service/dropdown_data/dropdown_data_service.dart';
import 'package:get/get.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';

class DropdownController extends GetxController {
  final DropdownDataService dropdownDataService = DropdownDataService();

  Future<Map<String, dynamic>> fetchDropdownData(
      String type, BuildContext context) async {
    try {
      var response = await dropdownDataService.getDropdownData(type, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse['result'];
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(DropdownController, "ERROR",
            "error in getting dropdown data ${jsonResponse['message']}");
        return {};
      } else {
        showErrorAlert(jsonResponse['message']);
        return {};
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchDataAndFinancialDataDropdown(
      String type) async {
    try {
      var response =
          await dropdownDataService.fetchDataAndFinancialDataDropdown(type);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse['result'];
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(DropdownController, "ERROR",
            "error in getting data and financial dropdown data ${jsonResponse['message']}");
        return {};
      } else {
        showErrorAlert(jsonResponse['message']);
        return {};
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return {};
    }
  }
}
