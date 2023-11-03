// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class KycProcessingFirstPhase extends StatefulWidget {
  const KycProcessingFirstPhase({super.key});

  @override
  State<KycProcessingFirstPhase> createState() =>
      _KycProcessingFirstPhaseState();
}

class _KycProcessingFirstPhaseState extends State<KycProcessingFirstPhase> {
  var height;
  var width;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SmallAppbar(heading: "KYC Processing"),
          SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
          Container(
            padding: EdgeInsets.all(width * 0.085),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _launchURL(
                        'https://docs.fintechprimitives.com/identity/required-information/');
                  },
                  child: Container(
                    child: Text(
                      'https://docs.fintechprimitives.com/identity/required-information/',
                      style: TextStyle(
                        color: AppTextColors.primary,
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.w700,
                        fontSize: SizeUtil.body(context),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.062),
                GestureDetector(
                  onTap: () {
                    _launchURL(
                        'https://fintechprimitives.com/docs/api/#create-a-kyc-request');
                  },
                  child: Container(
                    child: Text(
                      'https://fintechprimitives.com/docs/api/#create-a-kyc-request',
                      style: TextStyle(
                        color: AppTextColors.primary,
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.w700,
                        fontSize: SizeUtil.bodyLarge(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: duplicate_ignore
  _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: true, enableJavaScript: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
