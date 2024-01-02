import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:flutter/material.dart';

class LargeAppbar extends StatelessWidget {
  final String heading;
  final bool isAmount;
  final bool isbackButtonAvailable;
  final String content;
  final String timeline;
  const LargeAppbar(
      {super.key,
      required this.heading,
      required this.isAmount,
      required this.isbackButtonAvailable,
      required this.content,
      required this.timeline});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, 4),
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ],
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: SizeUtil.getStatusBarHeight(context), right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => Center(
                            child: Stack(
                              children: [
                                IconButton(
                                  color: AppColors.white,
                                  iconSize: SizeUtil.iconsSize(context),
                                  icon:
                                      const Icon(Icons.notifications_outlined),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Notifications()),
                                    );
                                    ConstantUtil.isNotificationReceived.value =
                                        false;
                                  },
                                ),
                                if (ConstantUtil.isNotificationReceived.value)
                                  Positioned(
                                    top: 11,
                                    right: 13,
                                    child: Container(
                                      width:
                                          SizeUtil.scallingFactor(context) * 11,
                                      height:
                                          SizeUtil.scallingFactor(context) * 11,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )),
                IconButton(
                  color: AppColors.white,
                  icon: const Icon(Icons.account_circle),
                  iconSize: SizeUtil.iconsSize(context),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileAndSettings()),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.02,
                right: size.width * 0.02,
                bottom: DefaultSizes.bottemspaceofheader),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isbackButtonAvailable)
                  Positioned(
                    left: 0,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                        size: SizeUtil.iconsSize(context),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      heading,
                      style: TextStyle(
                        color: AppTextColors.white,
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.w400,
                        fontSize: SizeUtil.headingMedium(context),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              if (isAmount)
                                TextSpan(
                                  text: '₹',
                                  style: TextStyle(
                                    letterSpacing: 4,
                                    fontFamily: 'NotoSans',
                                    color: AppTextColors.white,
                                    fontSize: SizeUtil.headingLarge(context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              TextSpan(
                                text: content,
                                style: TextStyle(
                                  fontFamily: "Helvetica",
                                  color: AppTextColors.white,
                                  fontSize: SizeUtil.headingLarge(context), // Use the same fontSize
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      timeline,
                      style: TextStyle(
                        color: AppTextColors.white,
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.w400,
                        fontSize: SizeUtil.headingSmall(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
