// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/loggers.dart';
import 'package:midas/model/mutual_fund_recommondation/mutual_fund_recommondation_model.dart';
import 'package:midas/service/mutual_fund_recommondation/mutual_fund_recommondation_service.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';

class MutualfundRecommondationControlller extends GetxController {
  MutualFundRecommondationService mutualFundRecommondationService =
      MutualFundRecommondationService();

  var isLoadingMfRecommondation = false.obs;
  var isLoadingMoreMfRecommondation = false.obs;
  var noMoreLoadMfRecommondation = false.obs;
  int pageSize = 10;

  RxList mutualFundRecommondationStrategiesList =
      <MutualFundRecommondationModel>[].obs;

  Future<bool> getMutualFundRecommondationStrategies(
      int page, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      if (page == 1) {
        isLoadingMfRecommondation.value = true;
      }
      var response = await mutualFundRecommondationService
          .getMutualFundRecommondationStrategies(page, pageSize, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (page == 1) {
          mutualFundRecommondationStrategiesList.clear();
        }
        List data = jsonResponse['result'];
        if (data.length < pageSize) {
          noMoreLoadMfRecommondation.value = true;
        }
        for (var element in jsonResponse['result']) {
          MutualFundRecommondationModel mutualFundRecommondation =
              MutualFundRecommondationModel.fromJson(element);
          mutualFundRecommondationStrategiesList.add(mutualFundRecommondation);
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualfundRecommondationControlller, "ERROR",
            "error in getting mf recommondation ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    } finally {
      isLoadingMfRecommondation.value = false;
    }
    return false;
  }

  Future<bool> createMutualFundRecommondationByGoals(
      String goalId,
      String goalName,
      String targetDate,
      double goalAmount,
      BuildContext context) async {
    var response = await mutualFundRecommondationService
        .createMutualFundRecommondationByGoals(
            goalId, goalName, targetDate, goalAmount, context);
    try {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert("mutual fund recommondation created successfully");
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualfundRecommondationControlller, "ERROR",
            "error in create mf recommmondation for goal ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    }
    return false;
  }
}
