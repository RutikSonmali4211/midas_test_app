import 'package:flutter/material.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/screen/shared/bottom_navbar.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';

class PaymentFailedScreen extends StatefulWidget {
  const PaymentFailedScreen({super.key});

  @override
  State<PaymentFailedScreen> createState() => _PaymentFailedScreenState();
}

class _PaymentFailedScreenState extends State<PaymentFailedScreen> {
  var height;
  var width;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SmallAppbar(heading: "Payments"),
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
                  "Your payment is failed",
                  style: TextStyle(
                      fontSize: SizeUtil.bodyLarge(context),
                      color: AppColors.grey),
                ),
                SizedBox(height: height * 0.161),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.10),
                  child: LargeButton(
                      text: "Go back to Home Screen",
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                      onPressed: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const BottomNevbar()),
                            (Route route) => false);
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
