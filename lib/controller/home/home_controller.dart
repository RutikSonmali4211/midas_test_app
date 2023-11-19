// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/loggers.dart';
import 'package:midas/model/net_worth/net_worth_model.dart';
import 'package:midas/service/home/home_service.dart';
import 'package:midas/storage/local_storage.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';

class HomeController extends GetxController {
  HomeService homeService = HomeService();

  var isLoading = false.obs;
  RxList<NetWorthModel> netWorthGraphList = <NetWorthModel>[].obs;

  RxDouble minY = 0.0.obs;
  RxDouble maxY = 0.0.obs;
  RxList<FlSpot> lastSevenDaysNetWorth = <FlSpot>[].obs;
  RxList<String> lastSevenDayDates = <String>[].obs;

  getLastSevenDaysGraphDataByUserId(BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      isLoading.value = true;
      String? userId = LocalStorage.getUserId();
      var response =
          await homeService.getLastSevenDaysGraphDataByUserId(userId!, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        netWorthGraphList.clear();
        lastSevenDaysNetWorth.clear();
        lastSevenDayDates.clear();
        minY.value=0.0;
        maxY.value=0.0;
        List<dynamic> netWorthList = jsonResponse;
        for (var netWorth in netWorthList) {
          netWorthGraphList.add(NetWorthModel.fromJson(netWorth));
        }
        if(netWorthGraphList.isNotEmpty){
          
        lastSevenDaysNetWorth.value = netWorthGraphList
            .asMap()
            .map((index, value) => MapEntry(index,
                FlSpot(index.toDouble(), value.revenue.round().toDouble())))
            .values
            .toList();

        lastSevenDayDates.value = netWorthGraphList
            .asMap()
            .map((index, value) => MapEntry(
                index,
                DateFormat('d MMM')
                    .format(DateTime.parse(value.date.toString()))))
            .values
            .toList();

        minY.value = lastSevenDaysNetWorth
                .map((spot) => spot.y)
                .reduce((a, b) => a < b ? a : b) -
            calculateBuffer(lastSevenDaysNetWorth, isMin: true);
        maxY.value = lastSevenDaysNetWorth
                .map((spot) => spot.y)
                .reduce((a, b) => a > b ? a : b) +
            calculateBuffer(lastSevenDaysNetWorth, isMin: false);

        }
        update();
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(HomeController, "ERROR",
            "error in getting last week  graph data ${jsonResponse['message']}");
      } else {
        showErrorAlert(jsonResponse['message']);
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  // if (homeController.netWorthGraphList.length == 7) {
  //       lastSevenDaysNetWorth = homeController.netWorthGraphList
  //           .asMap()
  //           .map((index, value) => MapEntry(index,
  //               FlSpot(index.toDouble(), value.revenue.round().toDouble())))
  //           .values
  //           .toList();

  //       lastSevenDayDates = homeController.netWorthGraphList
  //           .asMap()
  //           .map((index, value) => MapEntry(
  //               index,
  //               DateFormat('d MMM')
  //                   .format(DateTime.parse(value.date.toString()))))
  //           .values
  //           .toList();

  //       minY = lastSevenDaysNetWorth!
  //               .map((spot) => spot.y)
  //               .reduce((a, b) => a < b ? a : b) -
  //           calculateBuffer(lastSevenDaysNetWorth!, isMin: true);
  //       maxY = lastSevenDaysNetWorth!
  //               .map((spot) => spot.y)
  //               .reduce((a, b) => a > b ? a : b) +
  //           calculateBuffer(lastSevenDaysNetWorth!, isMin: false);
  //   }

  double calculateBuffer(List<FlSpot> data, {required bool isMin}) {
    // Calculate the buffer based on the range of data
    final double range = isMin
        ? data.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) -
            data.map((spot) => spot.y).reduce((a, b) => a < b ? a : b)
        : data.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) -
            data.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    return range * 0.1; // Adjust the factor as needed
  }
}
