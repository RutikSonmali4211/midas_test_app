import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/controller/kyc/kyc_controller.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';

class KycSubmittedPhase extends StatefulWidget {
  const KycSubmittedPhase({super.key});

  @override
  State<KycSubmittedPhase> createState() => _KycSubmittedPhaseState();
}

class _KycSubmittedPhaseState extends State<KycSubmittedPhase> {
  var height;
  var width;
  bool kycCompleted = false;

  KYCController kycController = Get.put(KYCController());

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
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.center,
                  "KYC is under verification. Please wait for some time.",
                  style: TextStyle(
                      fontSize: SizeUtil.bodyLarge(context),
                      color: AppColors.grey),
                ),
                SizedBox(height: height * 0.161),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
