import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/small_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';

class ConfirmDialogBox extends StatelessWidget {
  final String heading;
  final String body;
  final String message;
  final VoidCallback onConfirm;

  const ConfirmDialogBox(
      {super.key, required this.heading, required this.body, required this.message,required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(heading.isNotEmpty)
            Text(
              heading,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: SizeUtil.headingLarge2(context),
                fontWeight: FontWeight.w700,
                fontFamily: "Helvetica",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.050),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize:  SizeUtil.headingMedium(context),
                        fontFamily: "Helvetica"),
                  ),
                  if(message.isNotEmpty)
                  const SizedBox(height: 30),
                  if(message.isNotEmpty)
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize:SizeUtil.bodyLarge(context),
                      fontFamily: "Helvetica",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallButton(
                    text: "Cancel",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColors.white,
                    textColor: AppColors.primary),
                SmallButton(
                    text: "Confirm",
                    onPressed: (){
                     Get.back();
                      onConfirm();
                    },
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
