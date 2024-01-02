// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/date_util.dart';
import 'package:midas/exception/custom_exception.dart';
import 'package:midas/logs/loggers.dart';
import 'package:midas/model/investments/mutual__funds/amc/mutual_fund_amc_model.dart';
import 'package:midas/model/investments/mutual__funds/holding_reports/mutual_fund_holding_reports_model.dart';
import 'package:midas/model/investments/mutual__funds/mutual_fund_scheme_details_model.dart';
import 'package:midas/model/investments/mutual__funds/orders/mutual_fund_orders_model.dart';
import 'package:midas/model/investments/mutual__funds/portfolio/mutual_fund_portfolio_details_model.dart';
import 'package:midas/model/investments/mutual__funds/sip/sip_details_model.dart';
import 'package:midas/screen/Investments/mutual_funds/sip/authorize_mandate_screen.dart';
import 'package:midas/screen/payments/payment_browser_screen.dart';
import 'package:midas/service/investment/mutual_funds/mutual_funds_service.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:midas/widgets/loader.dart';

class MutualFundsController extends GetxController {
  MutualFundsService mutualFundsService = MutualFundsService();
  StreamSubscription? sub;

  // loading for all amc list
  var isLoadingAllAmc = false.obs;
  var isLoadingMoreAllAmc = false.obs;
  var noMoreDataLoadAllAmc = false.obs;

  var isLoading = false.obs;

  int page = 1;
  int pageSize = 10;

  TextEditingController mutualFundAmcSearchController = TextEditingController();

  final FocusNode mutualFundAmcSearchFocusNode = FocusNode();
  RxList mutualFundAllAmcsWatchlist = <MutualFundAmcModel>[].obs;
  RxList mutualFundUsersAmcWatchlist = <MutualFundAmcModel>[].obs;

  RxString schemeName = "".obs;
  RxString schemeType = "".obs;
  RxString schemeCategory = "".obs;
  RxString isinNumber = "".obs;
  RxString currentNav = "".obs;
  RxString minimumInvestment = "".obs;
  RxString exitLoad = "".obs;
  RxString expenseRatio = "".obs;
  RxString lockInPeriod = "".obs;
  RxString investmentMultiple = "".obs;
  RxDouble growthPercentage = 0.0.obs;
  RxString userMobileNumber = "".obs;
  RxString mfPurchaseId = "".obs;
  RxString mfRedeemId = "".obs;
  RxInt paymentId = 0.obs;

  // mutual fund schedular last updated date and timing
  RxString schedularLastUpdatedDate = "".obs;
  RxString schedularLastUpdatedTime = "".obs;

  bool fetchSIPDetails(int index) {
    if (index >= 0 && index < sipDetailsList.length) {
      var sipDetails = sipDetailsList[index];
      investmentMultiple =
          sipDetails.fundDetails?.initialInvestmentMultiples ?? '';
      minimumInvestment = sipDetails.fundDetails?.minInitialInvestment ?? '';
      schemeName = sipDetails.masterData?.amc ?? '';
      schemeType = sipDetails.masterData?.type ?? '';
      schemeCategory = sipDetails.masterData?.category ?? '';
      currentNav = sipDetails.amcNav?.currentNav ?? '';
      print('Investment Multiple: $investmentMultiple');
      print('Minimum Investment: $minimumInvestment');
      print('Scheme Name: $schemeName');
      print('Scheme Type: $schemeType');
      print('Scheme Category: $schemeCategory');
      print('Current NAV: $currentNav');
    } else {
      print('Invalid index or index out of bounds');
    }
    return true;
  }

  // mutual fund graph data lists
  RxList<FlSpot> mutualFundGraphNavList = <FlSpot>[].obs;
  RxList<dynamic> mutualFundGraphDateList = <dynamic>[].obs;
  RxDouble minY = 0.0.obs;
  RxDouble maxY = 0.0.obs;

  // list for sip details
  RxList sipDetailsList = <SipDetailsModel>[].obs;

  // loading for all amc list
  var isLoadingSipDetails = false.obs;
  var isLoadingMoreSipDetails = false.obs;
  var noMoreDataLoadSipDetails = false.obs;

  // data for mutual fund portfolio
  var isLoadingPortfolio = false.obs;
  var isLoadingHoldingReports = false.obs;
  var isLoadingMoreHoldingReports = false.obs;
  var noMoreDataLoadHoldingReports = false.obs;
  RxList mutualFundPortfolioDetails = <MutualFundPortfolioDetailsModel>[].obs;
  RxDouble investedValue = 0.0.obs;
  RxDouble currentValue = 0.0.obs;
  RxDouble profitAndLoss = 0.0.obs;
  RxDouble growthPercentageOnPortfolio = 0.0.obs;

  RxList mutualFundHoldingReportsList = <MutualFundHoldingReportsModel>[].obs;

  // loading for orders
  var isLoadingOrders = false.obs;
  var isLoadingMoreOrders = false.obs;
  var noMoreLoadOrders = false.obs;
  RxList mutualFundOrdersList = <MutualFundOrdersModel>[].obs;

  Future<bool> getAllAmcWatchList(
      String type, String data, BuildContext context, int page) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      if (page == 1) {
        isLoadingAllAmc.value = true;
      }
      var response = await mutualFundsService.getAllMutualFundAMCWatchList(
          page, pageSize, type, data, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (page == 1) {
          mutualFundAllAmcsWatchlist.clear();
        }
        List data = jsonResponse['result'];
        if (data.length < pageSize) {
          noMoreDataLoadAllAmc.value = true;
        }
        for (var element in jsonResponse['result']) {
          MutualFundAmcModel mutualFundAmc =
              MutualFundAmcModel.fromJson(element);
          mutualFundAllAmcsWatchlist.add(mutualFundAmc);
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting all amc data ${jsonResponse['message']}");
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
      isLoadingAllAmc.value = false;
    }
    return false;
  }

  Future<bool> getUsersMutualFundAmcWatchList(BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      isLoading.value = true;
      var response =
          await mutualFundsService.getUsersMutualFundAMCWatchList(context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        mutualFundUsersAmcWatchlist.clear();
        for (var element in jsonResponse['result']) {
          MutualFundAmcModel mutualFundAmc =
              MutualFundAmcModel.fromJson(element);
          mutualFundUsersAmcWatchlist.add(mutualFundAmc);
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting all amc data ${jsonResponse['message']}");
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

  Future<bool> addAmcToUsersWatchList(String masterDataId, BuildContext context,
      {int page = 1}) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      isLoading.value = true;
      var response = await mutualFundsService.addAmcToUsersWatchList(
          masterDataId, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        getUsersMutualFundAmcWatchList(context);
        showSuccessAlert(
            jsonResponse['message'] ?? "mutual fund added to your watchlist");
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting all amc data ${jsonResponse['message']}");
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

  Future<bool> cancelSip(String sipId, BuildContext context) async {
    var response = await mutualFundsService.cancelSip(sipId, context);
    try {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting all amc data ${jsonResponse['message']}");
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

  Future<bool> removeAmcFromUsersWatchList(
      String masterDataId, BuildContext context,
      {int page = 1}) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      isLoading.value = true;
      var response = await mutualFundsService.removeAmcFromUsersWatchList(
          masterDataId, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        getUsersMutualFundAmcWatchList(context);
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting all amc data ${jsonResponse['message']}");
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

  Future<bool> getMutualFundSchemeDetailsByAmfiCode(
      String amfiCode, String time, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      schemeName.value = "";
      schemeType.value = "";
      schemeCategory.value = "";
      currentNav.value = "";
      minimumInvestment.value = "";
      lockInPeriod.value = "";
      investmentMultiple.value = "";
      isLoading.value = true;
      var response = await mutualFundsService
          .getMutualFundSchemeDetailsByAmfiCode(amfiCode, time, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        MutualFundSchemeDetailsModel mutualFundDetails =
            MutualFundSchemeDetailsModel.fromJson(jsonResponse['result']);

        if (mutualFundDetails.schemeDetails != null) {
          mutualFundGraphNavList.value = mutualFundDetails
              .schemeDetails!.data!.reversed
              .toList()
              .asMap()
              .map((index, value) => MapEntry(
                  index,
                  FlSpot(
                      index.toDouble(),
                      double.parse(double.parse(value.nav.toString())
                          .toStringAsFixed(2)))))
              .values
              .toList();
          mutualFundGraphDateList.value = mutualFundDetails
              .schemeDetails!.data!.reversed
              .toList()
              .asMap()
              .map((index, value) => MapEntry(
                  index,
                  DateFormat('MMM d, yyyy').format(
                      DateFormat('dd-MM-yyyy').parse(value.date.toString()))))
              .values
              .toList();
          minY.value = mutualFundGraphNavList
                  .map((spot) => spot.y)
                  .reduce((a, b) => a < b ? a : b) -
              calculateBuffer(mutualFundGraphNavList, isMin: true);
          maxY.value = mutualFundGraphNavList
                  .map((spot) => spot.y)
                  .reduce((a, b) => a > b ? a : b) +
              calculateBuffer(mutualFundGraphNavList, isMin: false);

          schemeName.value =
              mutualFundDetails.schemeDetails!.meta!.fundHouse.toString();
          schemeType.value =
              mutualFundDetails.schemeDetails!.meta!.schemeType.toString();
          schemeCategory.value =
              mutualFundDetails.schemeDetails!.meta!.schemeCategory.toString();
          currentNav.value = double.parse(
                  mutualFundDetails.schemeDetails!.data![0].nav.toString())
              .toStringAsFixed(2);
          growthPercentage.value = double.parse(mutualFundDetails
              .schemeDetails!.growthPercentage!
              .toStringAsFixed(2));
        }

        if (mutualFundDetails.amcFundDetails != null) {
          minimumInvestment.value =
              mutualFundDetails.amcFundDetails!.minInitialInvestment != null
                  ? mutualFundDetails.amcFundDetails!.minInitialInvestment
                      .toString()
                  : "";
          investmentMultiple.value =
              mutualFundDetails.amcFundDetails!.initialInvestmentMultiples !=
                      null
                  ? double.parse(mutualFundDetails
                          .amcFundDetails!.initialInvestmentMultiples
                          .toString())
                      .toStringAsFixed(1)
                  : "";
          lockInPeriod.value =
              mutualFundDetails.amcFundDetails!.lockInPeriod != null
                  ? mutualFundDetails.amcFundDetails!.lockInPeriod.toString()
                  : "";
        }

        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting all amc data ${jsonResponse['message']}");
        return false;
      } else {
        showErrorDialogBox(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
      e.printInfo();
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  double calculateBuffer(List<FlSpot> data, {required bool isMin}) {
    // Calculate the buffer based on the range of data
    final double range = isMin
        ? data.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) -
            data.map((spot) => spot.y).reduce((a, b) => a < b ? a : b)
        : data.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) -
            data.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    return range * 0.1; // Adjust the factor as needed
  }


  
  Future<bool> getSchedularlastUpdatedDate(BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      var response = await mutualFundsService.getSchedularLastUpdatedDate(context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
         MutualFundSchemeDetailsModel mutualFundDetails = MutualFundSchemeDetailsModel.fromJson(jsonResponse['result']);
         if(mutualFundDetails.schemeDetails!.createdAt  != null){
          schedularLastUpdatedDate.value = DateFormat.yMMMd().format(mutualFundDetails.schemeDetails!.createdAt!.toLocal());
          schedularLastUpdatedTime.value = DateFormat.jm().format(mutualFundDetails.schemeDetails!.createdAt!.toLocal());
         }
        update();
        return true;
      } 
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    }
    return false;
  }

  Future<bool> getSIPDetails(BuildContext context, int page) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      if (page == 1) {
        isLoadingSipDetails.value = true;
      }
      var response =
          await mutualFundsService.getSIPDetails(page, pageSize, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (page == 1) {
          sipDetailsList.clear();
        }
        List data = jsonResponse['result'];
        if (data.length < pageSize) {
          noMoreDataLoadSipDetails.value = true;
        }
        for (var element in jsonResponse['result']) {
          SipDetailsModel sip = SipDetailsModel.fromJson(element);
          sipDetailsList.add(sip);
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        noMoreDataLoadSipDetails.value = true;
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting sip details ${jsonResponse['message']}");
        return false;
      } else {
        noMoreDataLoadSipDetails.value = true;
        showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    } finally {
      isLoadingSipDetails.value = false;
    }
    return false;
  }

  getSIPDetailsById(String sipId, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      var response = await mutualFundsService.getSIPDetailsById(sipId, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      }
    } finally {}
    return [];
  }

  Future<bool> pauseSip(String sipId, String fromDate, String toDate,
      BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      Loader.showLoading();
      String fromDateFormatted = DateUtil.formatDateInYYYYMMDD(fromDate);
      String toDateFormatted = DateUtil.formatDateInYYYYMMDD(toDate);
      var response = await mutualFundsService.pauseSip(
          sipId, fromDateFormatted, toDateFormatted, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert(jsonResponse['message']);
        Loader.hideLoading();
        return true;
      } else {
        Loader.hideLoading();
        if (jsonResponse['result']['message'] != null) {
          showErrorDialogBox("${jsonResponse['result']['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      Loader.hideLoading();
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    }
    return false;
  }

  Future<bool> requestMutualFundPurchaseOrder(String isinNumber,
      String folioNumber, double amount, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      Loader.showLoading();
      userMobileNumber.value = "";
      mfPurchaseId.value = "";
      String? userIp = await ConstantUtil.getUsersIPAddress();
      String? serverIp = await ConstantUtil.getServerIpAddress();
      var response = await mutualFundsService.requestMutualFundPurchaseOrder(
          isinNumber, folioNumber, amount, userIp!, serverIp!, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        userMobileNumber.value = jsonResponse['result']['mobileNumber'];
        mfPurchaseId.value = jsonResponse['result']['data']['mfid'];
        update();
        Loader.hideLoading();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in request to mutual fund purchase order ${jsonResponse['message']}");
        Loader.hideLoading();
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      Loader.hideLoading();
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    }
    return false;
  }

  Future<bool> confirmMutualFundPurchaseOrderAndMakePayment(
      String mfPurchaseId,
      String otp,
      String mobileNumber,
      String paymentMethod,
      BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      Loader.showLoading();
      var response =
          await mutualFundsService.confirmMutualFundPurchaseOrderAndMakePayment(
              mfPurchaseId, otp, mobileNumber, paymentMethod, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse["result"] != null) {
          Loader.hideLoading();
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => PaymentBrowserScreen(
                    postbackUrl: jsonResponse["result"]['token_url'],
                  )));
        }else{
          Loader.hideLoading();
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in confirm mutual fund purchase order ${jsonResponse['message']}");
        Loader.hideLoading();
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        Loader.hideLoading();
        return false;
      }
    }
    return false;
  }

  Future<bool> getMutualFundsPortfolioDetails(BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      isLoadingPortfolio.value = true;
      var response =
          await mutualFundsService.getMutualFundsPortfolioDetails(context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        MutualFundPortfolioDetailsModel portfolioData =
            MutualFundPortfolioDetailsModel.fromJson(jsonResponse['result']);
        mutualFundPortfolioDetails.clear();
        mutualFundPortfolioDetails.add(portfolioData);

        if (mutualFundPortfolioDetails.isNotEmpty) {
          for (MutualFundPortfolioDetailsModel portfolio
              in mutualFundPortfolioDetails) {
            if (portfolio.data != null) {
              for (var row in portfolio.data!.rows!) {
                if (row.isNotEmpty) {
                  investedValue.value = double.parse(row[1].toString());
                  currentValue.value = double.parse(row[2].toString());
                  profitAndLoss.value = double.parse(row[3].toString());
                  growthPercentageOnPortfolio.value =
                      double.parse(row[4].toString());
                }
              }
            }
          }
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting mutual fund portfolio details ${jsonResponse['message']}");
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
      isLoadingPortfolio.value = false;
    }
    return false;
  }

  Future<bool> getMutualFundsHoldingReports(BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      isLoadingHoldingReports.value = true;
      var response =
          await mutualFundsService.getMutualFundsHoldingReports(context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        mutualFundHoldingReportsList.clear();
        for (var report in jsonResponse['result']['folios']) {
          MutualFundHoldingReportsModel holdingReport =
              MutualFundHoldingReportsModel.fromJson(report);
          mutualFundHoldingReportsList.add(holdingReport);
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting list of mutual funds on portfolio ${jsonResponse['message']}");
        return false;
      } else {
        // showErrorAlert(jsonResponse['message']);
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    } finally {
      isLoadingHoldingReports.value = false;
    }
    return false;
  }

  Future<bool> requestMutualFundRedeemOrder(String folioNumber, double amount,
      double units, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      mfRedeemId.value = '';
      Loader.showLoading();
      String? userIp = await ConstantUtil.getUsersIPAddress();
      String? serverIp = await ConstantUtil.getServerIpAddress();
      var response = await mutualFundsService.requestMutualFundRedeemOrder(
          folioNumber, amount, units, userIp!, serverIp!, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['result'] != null) {
          mfRedeemId.value = jsonResponse['result']['data']['id'];
          userMobileNumber.value = jsonResponse['result']['mobileNumber'];
        }
        update();
        Loader.hideLoading();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in request to mutual fund redeem order ${jsonResponse['message']}");
        Loader.hideLoading();
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse['result']['msg'] != null) {
          showErrorDialogBox("${jsonResponse['result']['msg']}");
        } else if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      Loader.hideLoading();
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    }
    return false;
  }

  Future<bool> confirmMutualFundRedeemOrder(
      String mfRedeemId, String otp, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      Loader.showLoading();
      var response = await mutualFundsService.confirmMutualFundRedeemOrder(
          mfRedeemId, otp, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert("mutual fund redeem successfully");
        print(jsonResponse);

        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in confirm mutual fund redeem order ${jsonResponse['message']}");
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    } finally {
      Loader.hideLoading();
    }
    return false;
  }

  Future<bool> getMutualFundPurchaseDetailsByFolioNumber(
      String folioNumber, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      mfPurchaseId.value = "";
      var response = await mutualFundsService
          .getMutualFundPurchaseDetailsByFolioNumber(folioNumber, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['result']['mfid'] != null) {
          mfPurchaseId.value = jsonResponse['result']['mfid'];
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in confirm mutual fund purchase details by folio number ${jsonResponse['message']}");
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

  Future<bool> requestSIPPurchaseOrder(BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      Loader.showLoading();
      var response = await mutualFundsService.requestSIPPurchaseOrder(context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        userMobileNumber.value = jsonResponse['result']['mobile_number'];
        update();
        Loader.hideLoading();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in purchase sip ${jsonResponse['message']}");
        Loader.hideLoading();
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        Loader.hideLoading();
        showErrorAlert(e.toString());
        return false;
      }
    }
    return false;
  }

  Future<bool> verifyOtpAndConfirmSipMandate(
      String isinNumber,
      double amount,
      String frequency,
      int installmentDay,
      int numberOfInstallments,
      String otp,
      BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      Loader.showLoading();
      var response = await mutualFundsService.verifyOtpAndConfirmSipMandate(
          otp, amount, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['result'] != null) {
          paymentId.value = jsonResponse['result']['paymentId'];
          Loader.hideLoading();
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => AuthorizeMandateScreen(
                  isinNumber: isinNumber,
                  amount: amount,
                  frequency: frequency,
                  installmentDay: installmentDay,
                  numberOfInstallments: numberOfInstallments,
                  postbackUrl: jsonResponse['result']['tokenurl'],
                  isModifySip: false,
                  sipId: "",
                  )));
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in verify otp and create mandate in sip  ${jsonResponse['message']}");
        Loader.hideLoading();
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      Loader.hideLoading();
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    }
    return false;
  }

  Future<bool> confirmSIPPurchaseOrder(
      String isinNumber,
      double amount,
      String frequency,
      int installmentDay,
      int numberOfInstallments,
      BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      Loader.showLoading();
      var response = await mutualFundsService.confirmSIPPurchaseOrder(
          isinNumber,
          amount,
          frequency,
          installmentDay,
          numberOfInstallments,
          paymentId.value,
          context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert(jsonResponse['message'] ?? "SIP created successfully");
        print(jsonResponse);
        update();
        Loader.hideLoading();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in purchase sip ${jsonResponse['message']}");
        Loader.hideLoading();
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      Loader.hideLoading();
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    }
    return false;
  }

   Future<bool> createMandateForModifySip(double amount,String sipId, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      Loader.showLoading();
      var response = await mutualFundsService.createMandateForModifySip(amount, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['result'] != null) {
          paymentId.value = jsonResponse['result']['paymentId'];
          Loader.hideLoading();
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => AuthorizeMandateScreen(
                  isinNumber: "",
                  amount: amount,
                  frequency: "",
                  installmentDay: 1,
                  numberOfInstallments: 1,
                  postbackUrl: jsonResponse['result']['token_url'],
                  isModifySip: true,
                  sipId: sipId,
                  )));
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in create mandate for modify sip  ${jsonResponse['message']}");
        Loader.hideLoading();
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      Loader.hideLoading();
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    }
    return false;
  }

  Future<bool> modifySIPOrder(
      String sipId, double amount, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      Loader.showLoading();
      var response =
          await mutualFundsService.modifySIPOrder(sipId, amount, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSuccessAlert(
            jsonResponse['message'] ?? "SIP modified successfully");
        print(jsonResponse);
        update();
        Loader.hideLoading();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in purchase sip ${jsonResponse['message']}");
        Loader.hideLoading();
        return false;
      } else {
        Loader.hideLoading();
        if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      Loader.hideLoading();
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    }
    return false;
  }

  Future<bool> getAllMutualFundOrders(int page, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      if (page == 1) {
        isLoadingOrders.value = true;
      }
      var response = await mutualFundsService.getAllMutualFundOrders(
          page, pageSize, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (page == 1) {
          mutualFundOrdersList.clear();
        }
        List data = jsonResponse['result'];
        if (data.length < pageSize) {
          noMoreLoadOrders.value = true;
        }
        for (var element in jsonResponse['result']) {
          MutualFundOrdersModel mutalFundOrder =
              MutualFundOrdersModel.fromJson(element);
          mutualFundOrdersList.add(mutalFundOrder);
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting all orders  ${jsonResponse['message']}");
        return false;
      } else {
        if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    } finally {
      isLoadingOrders.value = false;
    }
    return false;
  }

  Future<bool> getMutualFundOrdersByISINNumber(
      String isinNumber, BuildContext context) async {
    try {
      if (!await ConstantUtil.isInternetConnected()) {
        throw CustomException(ConstantUtil.internetUnavailable);
      }
      mutualFundOrdersList.clear();
      isLoadingOrders.value = true;
      var response = await mutualFundsService.getMutualFundOrdersByISINNumber(
          isinNumber, context);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var element in jsonResponse['result']) {
          MutualFundOrdersModel mutalFundOrder =
              MutualFundOrdersModel.fromJson(element);
          mutualFundOrdersList.add(mutalFundOrder);
        }
        update();
        return true;
      } else if (response.statusCode >= 500) {
        await Loggers.printLog(MutualFundsController, "ERROR",
            "error in getting all orders  ${jsonResponse['message']}");
        return false;
      } else {
        if (jsonResponse['result']['errors'] != null) {
          showErrorDialogBox(
              "${jsonResponse['result']['errors'][0]['field']} ${jsonResponse['result']['errors'][0]['message']}");
        } else {
          showErrorDialogBox(jsonResponse['message']);
        }
        return false;
      }
    } catch (e) {
      if (e is CustomException) {
        showErrorAlert(e.toString());
        return false;
      }
    } finally {
      isLoadingOrders.value = false;
    }
    return false;
  }
}
