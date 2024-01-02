// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:http_interceptor/extensions/extensions.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:midas/screen/payments/payment_failed_screen.dart';
import 'package:midas/screen/payments/payment_success_screen.dart';

class AuthorizeMandateScreen extends StatefulWidget {
  final String isinNumber;
  final double amount;
  final String frequency;
  final int installmentDay;
  final int numberOfInstallments;
  final String postbackUrl;
  final bool isModifySip;
  final String sipId;
  const AuthorizeMandateScreen({
    super.key,
    required this.isinNumber,
    required this.amount,
    required this.frequency,
    required this.installmentDay,
    required this.numberOfInstallments,
    required this.postbackUrl,
    required this.isModifySip,
    required this.sipId,
  });

  @override
  State<AuthorizeMandateScreen> createState() => _AuthorizeMandateScreenState();
}

class _AuthorizeMandateScreenState extends State<AuthorizeMandateScreen> {
  InAppWebViewController? webViewController;

  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri.uri(widget.postbackUrl.toUri()),
              ),
              onWebViewCreated: (controller) =>
                  webViewController = webViewController,
              onUpdateVisitedHistory: onPageChange,
            ),
          ),
        ],
      ),
    );
  }

  void onPageChange(InAppWebViewController controller, Uri? uri, __) async {
    String url = uri.toString();

    if (!widget.isModifySip) {

      if (url.contains('eoxgk333pft8s7x.m.pipedream.net/')) {
        try {
          await Future.delayed(const Duration(seconds: 1));
          var response = await controller.evaluateJavascript(
            source: 'document.body.innerText');
        var jsonresponse = jsonDecode(response);
        if (jsonresponse['Payment_status'] == "success") {
          bool isSuccess = await mutualFundsController.confirmSIPPurchaseOrder(
              widget.isinNumber,
              widget.amount,
              widget.frequency,
              widget.installmentDay,
              widget.numberOfInstallments,
              context);
          if (isSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const PaymentSuccessScreen()));
          } 
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const PaymentFailedScreen()));
        }
          
        } catch (e) {
           Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const PaymentFailedScreen()));
        }
      }

    }else{

      if (url.contains('eoxgk333pft8s7x.m.pipedream.net')) {
         await Future.delayed(const Duration(seconds: 1));
        var response = await controller.evaluateJavascript(
            source: 'document.body.innerText');
        var jsonresponse = jsonDecode(response);
        if (jsonresponse['Payment_status'] == "success") {
          bool isSuccess = await mutualFundsController.modifySIPOrder(widget.sipId,widget.amount,context);
          if (isSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const PaymentSuccessScreen()));
          } 
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const PaymentFailedScreen()));
        }
      }




    }
  }
}
