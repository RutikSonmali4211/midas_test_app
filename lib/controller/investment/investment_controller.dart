// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/Loggers.dart';
import 'package:midas/model/investments/investment_model.dart';
import 'package:midas/model/investments/mutual__funds/portfolio/mutual_fund_portfolio_details_model.dart';
import 'package:midas/service/investment/investment_service.dart';
import 'package:midas/service/investment/mutual_funds/mutual_funds_service.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';

class InvestmentController extends GetxController {
  InvestmentService investmentService = InvestmentService();
  MutualFundsService mutualFundsService = MutualFundsService();

  var isLoading = false.obs;

  RxDouble totalInvestedValue = 0.0.obs;
  RxDouble goldCurrentValue = 0.0.obs;
  RxDouble otherAssetsCurrentValue = 0.0.obs;
  RxDouble mutualFundCurrentValue = 0.0.obs;

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
      var investResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        goldCurrentValue.value = 0.0;
        otherAssetsCurrentValue.value = 0.0;
        mutualFundCurrentValue.value=0.0;
        investmentList = InvestmentModel(
            totalValue: 0.0,
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
        update();
        List<dynamic> data = investResponse['result']['investments'];
        if (data.isNotEmpty) {
          investmentList.value.lastUpdatedDate =
              investResponse['result']['lastUpdatedDate'] != null
                  ? DateTime.parse(investResponse['result']['lastUpdatedDate'])
                  : DateTime.now();

          investmentList.value.totalValue =
              investResponse['result']['totalValue'].toDouble() ?? 0;
          for (var apiData in data) {
            for (var investment in investmentList.value.investments) {
              if (apiData['type'] == investment.type) {
                investment.currentValue = apiData['currentValue'].toDouble();
                investment.investedValue = apiData['investedValue'].toDouble();
                update();
              }
            }
            if (apiData['type'] == "Gold") {
              goldCurrentValue.value = apiData['currentValue'].toDouble();
            }
            if (apiData['type'] == "Other Assets") {
              otherAssetsCurrentValue.value = apiData['currentValue'].toDouble();
            }
          }
        }
        var response = await mutualFundsService.getMutualFundsPortfolioDetails(context);
        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode == 200) {
          MutualFundPortfolioDetailsModel portfolioData =MutualFundPortfolioDetailsModel.fromJson(jsonResponse['result']);
          if (portfolioData.data != null) {
            for (var row in portfolioData.data!.rows!) {
              if (row.isNotEmpty) {
                if (investmentList.value.investments[0].type =="Mutual Funds") {
                  investmentList.value.investments[0].investedValue = double.parse(row[1].toString());
                  investmentList.value.investments[0].currentValue =double.parse(row[2].toString());
                  mutualFundCurrentValue.value =double.parse(row[2].toString());
                  investmentList.value.totalValue = mutualFundCurrentValue.value + investmentList.value.totalValue;
                }
              }
            }
          }
        }
        update();
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(InvestmentController, "ERROR",
            "error in get invested current value nad investement value ${investResponse['message']}");
      } else {
        showErrorAlert(investResponse['message']);
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> getCurrentAndInvestedValuesForMutualFunds(
  //     BuildContext context) async {
  //   try {
  //     isLoading.value = true;
  //     var response =
  //         await mutualFundsService.getMutualFundsPortfolioDetails(context);
  //     var jsonResponse = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       MutualFundPortfolioDetailsModel portfolioData =
  //           MutualFundPortfolioDetailsModel.fromJson(jsonResponse['result']);

  //       if (portfolioData.data != null) {
  //         for (var row in portfolioData.data!.rows!) {
  //           if (row.isNotEmpty) {
  //             if (investmentList.value.investments[0].type == "Mutual Funds") {
  //               investmentList.value.investments[0].investedValue = int.parse(row[1].toString());
  //               investmentList.value.investments[0].currentValue = int.parse(row[2].toString());
  //             }
  //           }
  //         }
  //       }
  //       print(jsonResponse);
  //       update();
  //     } else if (response.statusCode >= 500) {
  //       await Loggers.printLog(InvestmentController, "ERROR",
  //           "error in get invested current value nad investement value ${jsonResponse['message']}");
  //     } else {
  //       showErrorAlert(jsonResponse['message']);
  //     }
  //   } catch (e) {
  //     if (e is CustomException) {
  //       showErrorAlert(e.toString());
  //     }
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
