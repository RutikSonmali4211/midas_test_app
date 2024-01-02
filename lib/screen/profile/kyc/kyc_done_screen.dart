// ignore_for_file: use_build_context_synchronously

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/controller/kyc/kyc_controller.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';

class KycDone extends StatefulWidget {
  const KycDone({super.key});

  @override
  State<KycDone> createState() => _KycDoneState();
}

class _KycDoneState extends State<KycDone> {
  var height;
  var width;

  KYCController kycController = Get.put(KYCController());

  Future<bool> getLocation() async {
    try {
      Position? position = await kycController.getCurrentLocation();
      if (position == null) {
        showErrorAlert("Give the Permission for Location");
        return false;
      }
      return true;
    } catch (e) {
      showErrorAlert(e.toString());
      return false;
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
                    Icons.check_circle,
                    size: SizeUtil.scallingFactor(context) * 180,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.center,
                  "KYC done",
                  style: TextStyle(
                      fontSize: SizeUtil.bodyLarge(context),
                      color: AppColors.primary),
                ),
                SizedBox(height: height * 0.161),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.10),
                  child: LargeButton(
                      text: "Start KYC",
                      backgroundColor: AppColors.grey,
                      textColor: AppColors.white,
                      onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
