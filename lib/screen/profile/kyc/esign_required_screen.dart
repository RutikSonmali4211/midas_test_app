// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/controller/kyc/kyc_controller.dart';
import 'package:midas/screen/profile/kyc/esign_browser_screen.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/Dto/ImageData.dart';
import '../../../Widgets/alert_message/alert_message.dart';
import '../../../Widgets/buttons/large_button.dart';

class EsignRequired extends StatefulWidget {
  const EsignRequired({super.key});

  @override
  State<EsignRequired> createState() => _EsignRequiredState();
}

class _EsignRequiredState extends State<EsignRequired> {
  var height;
  var width;
  bool kycCompleted = false;

  KYCController kycController = Get.put(KYCController());

  startEsign() async {
    ImageData data = await kycController.startEsign(context);
    if (data.status == true) {
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => EsignBrowserScreen(
                postbackurl: data.value,
              )));
      //  _launchURL(data.value);
    } else {
      showErrorAlert("Esign Failed");
    }
  }

  _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: true, enableJavaScript: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SmallAppbar(heading: "KYC Details"),
          SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.error_outline,
                    size: SizeUtil.scallingFactor(context) * 180,
                    color: AppColors.lightRed,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.center,
                  "Seem Like your KYC is incomplete. We just require Esign to complete it.",
                  style: TextStyle(
                      fontSize: SizeUtil.bodyLarge(context),
                      color: AppColors.grey),
                ),
                SizedBox(height: height * 0.161),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.10),
                  child: LargeButton(
                      text: "Start Esign",
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                      onPressed: () async {
                        await startEsign();
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
