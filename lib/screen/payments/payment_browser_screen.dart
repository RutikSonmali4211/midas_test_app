// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:http_interceptor/extensions/extensions.dart';
import 'package:midas/controller/kyc/kyc_controller.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/screen/payments/payment_failed_screen.dart';
import 'package:midas/screen/payments/payment_success_screen.dart';


class PaymentBrowserScreen extends StatefulWidget {
  final String postbackUrl;
  const PaymentBrowserScreen({super.key, required this.postbackUrl});

  @override
  State<PaymentBrowserScreen> createState() => _PaymentBrowserScreenState();
}

class _PaymentBrowserScreenState extends State<PaymentBrowserScreen> {
   InAppWebViewController? webViewController;
  KYCController kycController = Get.put(KYCController());

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
                  onLoadStart: onPageChange,
              // onUpdateVisitedHistory: onPageChange,
            ),
          ),
        ],
      ),
    );
  }

  void onPageChange(InAppWebViewController controller, Uri? uri,) async {
    String url = uri.toString();
    print("api url is " + url.toString());
    if (url.contains('eoxgk333pft8s7x.m.pipedream.net')) {
      await Future.delayed(const Duration(seconds: 1));
      var response = await controller.evaluateJavascript(
          source: 'document.body.innerText');
      var jsonresponse = jsonDecode(response);
      if (jsonresponse['Payment_status'] == "success") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const PaymentSuccessScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const PaymentFailedScreen()));
      }
    }
  }
}
















// const script = '''
      //           const responseData = document.body.innerText;
      //           window.flutter_inappwebview.callHandler('responseData', responseData);
      //         ''';

      // await controller.evaluateJavascript(source: script);
      // try {
      //   controller.addJavaScriptHandler(
      //     handlerName: 'responseData',
      //     callback: (data) {
      //       print('Response Data: $data');
      //     },
      //   );
      // } catch (e) {
      //   print('Error adding JavaScript handler: $e');
      // }