// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas/controller/kyc/kyc_controller.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/screen/profile/kyc/esign_required_screen.dart';
import 'package:midas/screen/profile/kyc/kyc_submitted.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EsignBrowserScreen extends StatefulWidget {
  final String postbackurl;
  const EsignBrowserScreen({super.key, required this.postbackurl});

  @override
  State<EsignBrowserScreen> createState() => _EsignBrowserScreenState();
}

class _EsignBrowserScreenState extends State<EsignBrowserScreen> {
  late WebViewController webViewController;

  KYCController kycController = Get.put(KYCController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
          Expanded(
            child: WebView(
              gestureNavigationEnabled: true,
              initialUrl: widget.postbackurl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              navigationDelegate: (NavigationRequest request) async {
                if (request.url.contains(
                    'http://devmidasadmin.ergobite.com:3000/webhook')) {
                  final Uri uri = Uri.parse(request.url);
                  final Map<String, String> parameters = uri.queryParameters;
                  if (parameters.containsKey('status')) {
                    String statusValue = parameters['status']!;
                    if (statusValue == 'successful') {
                      bool isSuccess = await kycController
                          .updateKycStatusAfterEsignCompleted(
                              "submitted", context);
                      if (isSuccess) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const KycSubmittedPhase()));
                      }
                    } else {
                      showErrorAlert(
                          "your Esign is not completed please try again");
                      Navigator.of(context).maybePop(MaterialPageRoute(
                          builder: (context) => const EsignRequired()));
                    }
                  }
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          ),
        ],
      ),
    );
  }
}
