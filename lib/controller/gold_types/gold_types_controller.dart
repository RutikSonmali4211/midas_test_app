import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/Loggers.dart';
import 'package:midas/model/gold_types/gold_types_model.dart';
import 'package:midas/service/gold_types/gold_types_service.dart';
import 'package:midas/widgets/alert_message/snackbar.dart';

class GoldTypesController extends GetxController {
  GoldTypesService goldTypesService = GoldTypesService();

  var isLoading = false.obs;

  Rx<GoldTypesModel> goldDetails = GoldTypesModel(
          goldData: [], totalValue: 0, lastUpdatedDate: DateTime.now())
      .obs;

  RxInt gold24kprice = 0.obs;
  RxInt gold22kprice = 0.obs;
  RxInt gold18kprice = 0.obs;

  Future<List<String>> getGoldTypesList(BuildContext context) async {
    try {
      var response = await goldTypesService.getGoldTypesList(context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<String> goldTypeList = [];
        for (var element in jsonResponse['result']) {
          goldTypeList.add(element['goldType']);
        }
        return goldTypeList;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(GoldTypesController, "ERROR",
            "error in getting gold types with current value and quantity ${jsonResponse['message']}");
        return [];
      } else {
        showErrorAlert(jsonResponse['message']);
        return [];
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return [];
    }
  }

  Future<void> getGoldTypesWithCurrentValueAndQuantity(
      BuildContext context) async {
    try {
      isLoading.value = true;
      var response = await goldTypesService
          .getGoldTypesWithCurrentValueAndQuantity(context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        gold24kprice.value = 0;
        gold22kprice.value = 0;
        gold18kprice.value = 0;

        goldDetails.value = GoldTypesModel(
            goldData: [], lastUpdatedDate: DateTime.now(), totalValue: 0);
        List<dynamic> dataList = jsonResponse['result']['goldData'];
        if (dataList.isNotEmpty) {
          for (var data in dataList) {
            if (data['goldType'] == "24K") {
              gold24kprice.value = data['goldPrice'] ?? 0;
            } else if (data['goldType'] == "22K") {
              gold22kprice.value = data['goldPrice'] ?? 0;
            } else {
              gold18kprice.value = data['goldPrice'] ?? 0;
            }
          }
          goldDetails.value = GoldTypesModel.fromJson(jsonResponse['result']);
        }
        update();
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(GoldTypesController, "ERROR",
            "error in getting gold types with current value and quantity ${jsonResponse['message']}");
      } else {
        showErrorAlert(jsonResponse['message']);
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      await Loggers.printLog(GoldTypesController, "ERROR",
          "error in getting gold types with current value and quantity ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
