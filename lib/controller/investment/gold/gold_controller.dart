// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/Loggers.dart';
import 'package:midas/model/investments/gold/gold_model.dart';
import 'package:midas/service/investment/gold/gold_service.dart';
import 'package:http/http.dart' as http;
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:midas/widgets/loader.dart';

class GoldController extends GetxController {
  GoldService goldService = GoldService();

  var isLoading = false.obs;
  final List<Investment> investments = [];
  Rx<GoldModel> goldItems = GoldModel(
      currentValue: 0, lastUpdatedDate: DateTime.now(), investment: []).obs;

  int currentPage = 1;
  int pageSize = 5;
  bool canLoadMore = true;

  Future<bool> addNewGold(String shortTitle, double weight, String goldPurity,
      String description, BuildContext context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      http.Response response = await goldService.addNewGold(
          shortTitle, weight, goldPurity, description, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert("gold ${ConstantUtil.addSuccess}");
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(GoldController, "ERROR",
            "error in add new gold item ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      Loader.hideLoading();
    }
  }

  getGoldItemsList(String goldPurity, BuildContext context,
      {int page = 1}) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
        isLoading.value = true;
      if (page == 1) {
        currentPage = page;
        canLoadMore = true;
      }
      if (!canLoadMore) {
        return false;
      }
      // isLoading.value = true;
      var response = await goldService.getGoldItemsList(
          currentPage, pageSize, goldPurity, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (page == 1) {
          investments.clear();
          goldItems.value = GoldModel(
              currentValue: 0, lastUpdatedDate: DateTime.now(), investment: []);
        }
        currentPage++;
        List<dynamic> data = jsonResponse['result']['investment'];
        if (data.isNotEmpty) {
          investments.addAll(data.map((item) => Investment.fromJson(item)));
          goldItems.value = GoldModel.fromJson(jsonResponse['result']);
        }
        update();
        // print("json resposne list length ${jsonResponse['result']['investment'].length}");
         canLoadMore = jsonResponse['result']['investment'].length >= pageSize;
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(GoldController, "ERROR",
            "error in get gold item list ${jsonResponse['message']}");
            return false;
      } else {
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  
  //  getGoldItemsList(String goldPurity, BuildContext context,
  //     {int page = 1}) async {
  //   try {
  //     isLoading.value = true;
  //     var response = await goldService.getGoldItemsList(
  //         page, pageSize, goldPurity, context);
  //     var jsonResponse = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       goldItems.value = GoldModel(
  //           currentValue: 0, lastUpdatedDate: DateTime.now(), investment: []);
  //       List<dynamic> data = jsonResponse['result']['investment'];
  //       if (data.isNotEmpty) {
  //         goldItems.value = GoldModel.fromJson(jsonResponse['result']);
  //       }
  //       update();
  //     } else if (response.statusCode >= 500) {
  //       await Loggers.printLog(GoldController, "ERROR",
  //           "error in get gold item list ${jsonResponse['message']}");
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

   Future<bool> updateGoldItems(String goldId,String shortTitle, double weight, String goldPurity,String description, BuildContext context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      var response = await goldService.updateGoldItems(goldId, shortTitle, weight, goldPurity, description, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert("gold ${ConstantUtil.updateSuccess}");
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(GoldController, "ERROR",
            "error in update gold ${jsonResponse['message']}");
        return false;
      } else {
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
      }
      return false;
    } finally {
      Loader.hideLoading();
    }
  }

  deleteGoldItem(
      String investmentId, String goldPurity, BuildContext context) async {
    try {
      isLoading.value = true;
      var response = await goldService.deleteGoldItem(investmentId, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        getGoldItemsList(goldPurity, context);
        showSuccessAlert("gold ${ConstantUtil.deleteSuccess}");
        update();
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(GoldController, "ERROR",
            "error in delete gold item ${jsonResponse['message']}");
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
