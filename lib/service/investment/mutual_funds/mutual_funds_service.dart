// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:midas/constant/application_urls.dart';
import 'package:midas/service/api_handler.dart';
import 'package:http/http.dart' as http;
import 'package:midas/storage/local_storage.dart';

class MutualFundsService {
  Future<http.Response> getAllMutualFundAMCWatchList(int page, int pageSize,
      String type, String data, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {"type": type, "data": data};
      var response = await ApiHandler.get(
          "${ApplicationUrls.getMutualFundsAmcWatchlist}?page=$page&pageSize=$pageSize&userId=$userId",
          requestBody,
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getUsersMutualFundAMCWatchList(
      BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {"user_id": userId};
      var response = await ApiHandler.post(
          ApplicationUrls.getUsersMutualFundsAmcWatchlist,
          requestBody,
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> cancelSip(String sipId, BuildContext context) async {
    try {
      var response = await ApiHandler.get(
          '${ApplicationUrls.sipUrl}/$sipId/cancel', {}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getSIPDetailsById(
      String sipId, BuildContext context) async {
    try {
      var response = await ApiHandler.get(
          '${ApplicationUrls.getsipbyid}?sipid=$sipId', {}, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> addAmcToUsersWatchList(
      String masterDataId, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "user_id": userId,
        "masterData": {"masterDataId": masterDataId}
      };
      var response = await ApiHandler.post(
          ApplicationUrls.addAmcToUsersWatchList, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> removeAmcFromUsersWatchList(
      String masterDataId, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "user_id": userId,
        "masterData": {"masterDataId": masterDataId}
      };
      var response = await ApiHandler.post(
          ApplicationUrls.removeAmcFromUsersWatchList, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> pauseSip(String sipId, String fromdate, String toDate,
      BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "user_id": userId,
        "sip_id": sipId,
        "from": fromdate,
        "to": toDate
      };
      var response =
          await ApiHandler.post(ApplicationUrls.skipSip, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getMutualFundSchemeDetailsByAmfiCode(
      String amfiCode, String time, BuildContext context) async {
    try {
      var response = await ApiHandler.get(
          '${ApplicationUrls.getMutualFundsSchemeDetailsByAmfiCode}?amficode=$amfiCode&time=$time',
          {},
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getSchedularLastUpdatedDate(BuildContext context) async {
    try {
      var response = await ApiHandler.get(
          '${ApplicationUrls.getMutualFundsSchemeDetailsByAmfiCode}?amficode=148918&time=1',
          {},
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getSIPDetails(
      int page, int pageSize, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      var response = await ApiHandler.get(
          "${ApplicationUrls.getSIPDetails}?userId=$userId&page=$page&pageSize=$pageSize",
          {},
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> requestMutualFundPurchaseOrder(
      String isinNumber,
      String folioNumber,
      double amount,
      String userIp,
      String serverIp,
      BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "scheme": isinNumber,
        "folioNumber": folioNumber,
        "amount": amount,
        "userIp": userIp,
        "serverIp": serverIp,
        "user_id": userId,
        "euin": null
      };
      var response = await ApiHandler.post(
          ApplicationUrls.mutualFundPurchaseUrl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> confirmMutualFundPurchaseOrderAndMakePayment(
      String mfPurchaseId,
      String otp,
      String mobileNumber,
      String paymentMethod,
      BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "mfppid": mfPurchaseId,
        "user_id": userId,
        "otp": otp,
        "method": paymentMethod,
        "mobileNumber": mobileNumber
      };
      var response = await ApiHandler.post(
          ApplicationUrls.verifyOrderAndMakePaymenturl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getMutualFundPurchaseDetailsByFolioNumber(
      String folioNumber, BuildContext context) async {
    try {
      var response = await ApiHandler.get(
          '${ApplicationUrls.getMutualFundPurchaseByFolioNumber}/$folioNumber',
          {},
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getMutualFundsPortfolioDetails(
      BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {"userId": userId};
      var response = await ApiHandler.post(
          ApplicationUrls.getMutualFundsPortfolioDetailsUrl,
          requestBody,
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getMutualFundsHoldingReports(
      BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      var response = await ApiHandler.get(
          "${ApplicationUrls.getMutualFundsHoldingReportstUrl}/$userId",
          {},
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> requestMutualFundRedeemOrder(
      String folioNumber,
      double amount,
      double units,
      String userIp,
      String serverIp,
      BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "user_id": userId,
        "folio_number": folioNumber,
        "amount": amount,
        "units": units,
        "user_ip": userIp,
        "server_ip": serverIp
      };
      var response = await ApiHandler.post(
          ApplicationUrls.mutualFundRedeemUrl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> confirmMutualFundRedeemOrder(
      String mfRedeemId, String otp, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "mfrId": mfRedeemId,
        "user_id": userId,
        "otp": otp
      };
      var response = await ApiHandler.post(
          ApplicationUrls.confirmMutualFundRedeemUrl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> requestSIPPurchaseOrder(BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {"userId": userId};
      var response = await ApiHandler.post(
          ApplicationUrls.requestSIPPurchaseUrl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> verifyOtpAndConfirmSipMandate(
      String otp, double amount, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "userId": userId,
        "otp": otp,
        "amount": amount,
        "postbackUrl": ApplicationUrls.postbackUrl
      };
      var response = await ApiHandler.post(
          ApplicationUrls.verifyOtpAndConfirmSipMandate, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }


   Future<http.Response> createMandateForModifySip(double amount, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "userId": userId,
        "amount": amount,
        "postbackUrl": ApplicationUrls.postbackUrl
      };
      var response = await ApiHandler.post(
          ApplicationUrls.createmandateForModifySip, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> confirmSIPPurchaseOrder(
      String isinNumber,
      double amount,
      String frequency,
      int installmentDay,
      int numberOfInstallments,
      int paymentId,
      BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {
        "userId": userId,
        "scheme": isinNumber,
        "frequency": frequency,
        "amount": amount,
        "installment_day": installmentDay,
        "number_of_installments": numberOfInstallments,
        "paymentId": paymentId,
      };
      var response = await ApiHandler.post(
          ApplicationUrls.confirmSIPPurchaseUrl, requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> modifySIPOrder(
      String sipId, double amount, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      Map<String, dynamic> requestBody = {"id": sipId, "amount": amount};
      var response = await ApiHandler.patch(
          "${ApplicationUrls.sipUrl}/$userId", requestBody, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getAllMutualFundOrders(
      int page, int pageSize, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      var response = await ApiHandler.get(
          "${ApplicationUrls.getMutualFundOrders}?userId=$userId&page=$page&pageSize=$pageSize",
          {},
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getMutualFundOrdersByISINNumber(
      String isinNumber, BuildContext context) async {
    try {
      String? userId = LocalStorage.getUserId();
      var response = await ApiHandler.get(
          "${ApplicationUrls.getMutualFundOrdersByIsinNumber}?userId=$userId&isin=$isinNumber",
          {},
          context);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
