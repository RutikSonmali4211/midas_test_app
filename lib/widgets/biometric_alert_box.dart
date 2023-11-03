import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/user/user_controller.dart';
import 'package:midas/storage/local_storage.dart';
import 'package:midas/widgets/buttons/small_button.dart';

UserController userController = Get.find();

class BiometricAlertBox extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;

  const BiometricAlertBox(
      {super.key, required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Enable Biometric Auth",
              style: TextStyle(
                fontSize: SizeUtil.headingLarge2(context),
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontFamily: "Helvetica",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeUtil.bodyLarge(context),
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                  fontFamily: "Helvetica",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: userController.isBometricAlertDisplay.value,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    onChanged: (newValue) {
                      userController.isBometricAlertDisplay.value =
                          !userController.isBometricAlertDisplay.value;
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      userController.isBometricAlertDisplay.value =
                          !userController.isBometricAlertDisplay.value;
                    },
                    child: Text(
                      'Don\'t show again',
                      style: TextStyle(
                        fontSize: SizeUtil.body(context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                        fontFamily: "Helvetica",
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallButton(
                    text: "Keep Disable",
                    onPressed: () {
                      LocalStorage.setBiometricAlert(userController.isBometricAlertDisplay.value);
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColors.white,
                    textColor: AppColors.primary),
                SmallButton(
                    text: "Enable",
                    onPressed: onConfirm,
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
