// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/date_util.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/Loggers.dart';
import 'package:midas/model/investments/other_assets/other_assets_model.dart';
import 'package:midas/service/investment/other_assets/other_assets_service.dart';
import 'package:midas/widgets/alert_message/snackbar.dart';
import 'package:midas/widgets/loader.dart';

class OtherAssetsController extends GetxController {
  OtherAssetsService otherAssetsService = OtherAssetsService();

  var isLoading = false.obs;
  Rx<OtherAssetsModel> otherAssets = OtherAssetsModel(
      currentValue: 0, lastUpdatedDate: DateTime.now(), investment: []).obs;
  int currentPage = 1;
  int pageSize = 5;
  bool canLoadMore = true;
  final List<Investment> investments = [];
  Future<bool> addOtherAssets(String assetName, double currentPrice,
      double purchasePrice, String purchaseDate, BuildContext context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      String convertedPurchaseDate =
          DateUtil.convertDateInIsoFormat(purchaseDate);
      var response = await otherAssetsService.addOtherAssets(assetName,
          currentPrice, purchasePrice, convertedPurchaseDate, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert("asset ${ConstantUtil.addSuccess}");
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(OtherAssetsController, "ERROR",
            "error in add other asset ${jsonResponse['message']}");
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

  Future<bool> getOtherAssetsList(BuildContext context, {int page = 1}) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      isLoading.value=true;
      if (page == 1) {
        currentPage = page;
        canLoadMore = true;
      }
      if (!canLoadMore) {
        return false;
      }
      // isLoading.value = true;
      var response = await otherAssetsService.getOtherAssetsList(
          currentPage, pageSize, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (page == 1) {
          // Clear the list when fetching the first page
          investments.clear();
          otherAssets.value = OtherAssetsModel(
              currentValue: 0, lastUpdatedDate: DateTime.now(), investment: []);
        }
        List<dynamic> data = jsonResponse['result']['investment'];
        currentPage++;
        if (data.isNotEmpty) {
          investments.addAll(data.map((item) => Investment.fromJson(item)));
          otherAssets.value = OtherAssetsModel.fromJson(jsonResponse['result']);
        }
        update();
        print(
            "json resposne list length ${jsonResponse['result']['investment'].length}");
        canLoadMore = jsonResponse['result']['investment'].length >= pageSize;
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(OtherAssetsController, "ERROR",
            "error in get other assets list ${jsonResponse['message']}");
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
      isLoading.value = false;
    }
    return false;
  }

  // otherAssets.value = OtherAssetsModel(
  //     currentValue: 0, lastUpdatedDate: DateTime.now(), investment: []);
  // List<dynamic> data = jsonResponse['result']['investment'];
  // if (data.isNotEmpty) {
  //   otherAssets.value = OtherAssetsModel.fromJson(jsonResponse['result']);
  // }
  deleteOtherAsset(String investmentId, BuildContext context) async {
    try {
      isLoading.value = true;
      var response =
          await otherAssetsService.deleteOtherAsset(investmentId, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        getOtherAssetsList(context);
        showSuccessAlert("asset ${ConstantUtil.deleteSuccess}");
        update();
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(OtherAssetsController, "ERROR",
            "error in delete other asset ${jsonResponse['message']}");
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

  Future<bool> updateOtherAsset(
      String otherAssetId,
      String assetName,
      double purchasePrice,
      double currentValue,
      String purchaseDate,
      BuildContext context) async {
    try {
      Loader.showLoading();
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      String convertedPurchaseDate =
          DateUtil.convertDateInIsoFormat(purchaseDate);
      var response = await otherAssetsService.updateOtherAsset(
          otherAssetId,
          assetName,
          purchasePrice,
          currentValue,
          convertedPurchaseDate,
          context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert("asset ${ConstantUtil.updateSuccess}");
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(OtherAssetsController, "ERROR",
            "error in update other assets ${jsonResponse['message']}");
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
}
