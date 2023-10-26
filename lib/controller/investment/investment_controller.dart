import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/Loggers.dart';
import 'package:midas/model/investments/investment_model.dart';
import 'package:midas/service/investment/investment_service.dart';
import 'package:midas/widgets/alert_message/snackbar.dart';

class InvestmentController extends GetxController {
  InvestmentService investmentService = InvestmentService();

  var isLoading = false.obs;
  RxInt goldCurrentValue = 0.obs;
  RxInt otherAssetsCurrentValue = 0.obs;

  // RxList<InvestmentModel> investmentList = <InvestmentModel>[].obs;
  Rx<InvestmentModel> investmentList = InvestmentModel(
      totalValue: 0,
      lastUpdatedDate: DateTime.now(),
      investments: [
        InvestmentData(
          type: 'Mutual Funds',
          investedValue: 0,
          currentValue: 0,
        ),
        InvestmentData(
          type: 'Gold',
          investedValue: 0,
          currentValue: 0,
        ),
        InvestmentData(
          type: 'Other Assets',
          investedValue: 0,
          currentValue: 0,
        )
      ]).obs;

  Future<void> getCurrentAndInvestedValues(BuildContext context) async {
    try {
      isLoading.value = true;
      var response =
          await investmentService.getCurrentAndInvestedValues(context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
         goldCurrentValue.value=0;
         otherAssetsCurrentValue.value=0;
        investmentList.value = InvestmentModel(
            totalValue: 0,
            lastUpdatedDate: DateTime.now(),
            investments: [
              InvestmentData(
                type: 'Mutual Funds',
                investedValue: 0,
                currentValue: 0,
              ),
              InvestmentData(
                type: 'Gold',
                investedValue: 0,
                currentValue: 0,
              ),
              InvestmentData(
                type: 'Other Assets',
                investedValue: 0,
                currentValue: 0,
              )
            ]);

        List<dynamic> data = jsonResponse['result']['investments'];
        if (data.isNotEmpty) {
          investmentList.value.lastUpdatedDate =
              jsonResponse['result']['lastUpdatedDate'] != null
                  ? DateTime.parse(jsonResponse['result']['lastUpdatedDate'])
                  : DateTime.now();

          investmentList.value.totalValue =
              jsonResponse['result']['totalValue'] ?? 0;
          for (var apiData in data) {
            for (var investment in investmentList.value.investments) {
              if (apiData['type'] == investment.type) {
                investment.currentValue = apiData['currentValue'];
                investment.investedValue = apiData['investedValue'];
                update();
              }
            }
            if(apiData['type'] == "Gold"){
                goldCurrentValue.value = apiData['currentValue'];
              }
              if(apiData['type'] == "Other Assets"){
                otherAssetsCurrentValue.value = apiData['currentValue'];
              }
          }
        }
        update();
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(InvestmentController, "ERROR",
            "error in get invested current value nad investement value ${jsonResponse['message']}");
      } else {
        showErrorAlert(jsonResponse['message']);
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }
}
