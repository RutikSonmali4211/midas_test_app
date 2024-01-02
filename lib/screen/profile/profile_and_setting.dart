import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/kyc/kyc_controller.dart';
import 'package:midas/controller/user/user_controller.dart';
import 'package:midas/screen/profile/investment_profile/investment_profile.dart';
import 'package:midas/screen/profile/kyc/kycBankDetailsPage.dart';
import 'package:midas/screen/profile/pincode/pincode.dart';
import 'package:midas/screen/profile/user_information/user_information.dart';
import 'package:midas/screen/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';
import '../../model/Dto/ImageData.dart';
import '../../constant/sizeConstant.dart';
import 'package:midas/storage/local_storage.dart';
import 'contactUs/contactUs.dart';
import 'investmentReport/investmentReport.dart';
import 'package:url_launcher/url_launcher.dart';

import 'kyc/esign_required_screen.dart';
import 'kyc/kyc_done_screen.dart';
import 'kyc/kyc_rejected_screen.dart';
import 'kyc/kyc_submitted.dart';
import 'kyc/start_kyc.dart';

class ProfileAndSettings extends StatefulWidget {
  const ProfileAndSettings({super.key});

  @override
  State<ProfileAndSettings> createState() => _ProfileAndSettingsState();
}

class _ProfileAndSettingsState extends State<ProfileAndSettings> {
  var height;
  var width;

  bool isBiometricEnabled = true;

  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.isBiometricEnabled =
        LocalStorage.getIsBiometricEnabled() == null
            ? false.obs
            : LocalStorage.getIsBiometricEnabled()!.obs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userController.getUserDetailsFromLocalStorage(context);
    });
  }

  logout() async {
    bool isSuccess = await userController.logoutUser(context);
    if (isSuccess) {
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (Route route) => false);
    } else {}
  }

  KYCController kycController = Get.put(KYCController());

  switchKycScreen() async {
    ImageData data = await kycController.fetchKycStatus(context);
    if (data.value == "pending") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const KycRejected()),
      );
    }
    if (data.value == "esign_required") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EsignRequired()),
      );
    }
    if (data.value == "submitted") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const KycSubmittedPhase()),
      );
    }
    if (data.value == "successful") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const KycDone()),
      );}
    if (data.value == "expired") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const KycRejected()),
      );
    }
    if (data.value == "rejected") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const KycRejected()),
      );
    }
    if (data.value == ""||data.value == "remaining" || data.value == "Incompleted") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const KycDetailsPhase()),
      );
    }
     if (data.value == "bank_details_required") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const KycBankDetailsPage()),
      );
    }
  }

   _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
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
          const SmallAppbar(heading: "Profile & Settings"),
          SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.04,
                right: size.width * 0.04,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserInformationScreen()),
                        );
                      },
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadow.withOpacity(0.01),
                                  offset: const Offset(0, 1),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: AppColors.lightgrey, // Border color
                                width: 2.0, // Border width
                              ),
                              color: AppColors.white,
                            ),
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  SizeUtil.verticalSpacingSmall(context)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userController.user.value != null
                                        ? userController.user.value!.name
                                            .toString()
                                        : "",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: SizeUtil.headingMedium(context),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Helvetica",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: DefaultSizes.spacingBetweenTexts,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        userController.user.value != null
                                            ? userController.user.value!.email
                                                .toString()
                                            : "",
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: SizeUtil.iconsSize(context),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow.withOpacity(0.01),
                            offset: const Offset(0, 1),
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.lightgrey, // Border color
                          width: 2.0, // Border width
                        ),
                        color: AppColors.white,
                      ),
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.all(
                            SizeUtil.verticalSpacingSmall(context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Investment Details',
                              style: TextStyle(
                                color: AppTextColors.primary,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w700,
                                fontSize: SizeUtil.bodyLarge(context),
                                letterSpacing: 0.33,
                              ),
                            ),
                            const Divider(
                              height: 20,
                              color: AppTextColors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const InvestmentProfileScreen()),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Investment Profile',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: SizeUtil.iconsSize(context),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.lightgrey,
                                  thickness: 1.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    switchKycScreen();
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'KYC Details',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: SizeUtil.iconsSize(context),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.lightgrey,
                                  thickness: 1.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const InvestmentReportScreen()),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Investor Documents / Reports',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: SizeUtil.iconsSize(context),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow.withOpacity(0.01),
                            offset: const Offset(0, 1),
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.lightgrey, // Border color
                          width: 2.0, // Border width
                        ),
                        color: AppColors.white,
                      ),
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.all(
                            SizeUtil.verticalSpacingSmall(context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login & Security',
                              style: TextStyle(
                                color: AppTextColors.primary,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w700,
                                fontSize: SizeUtil.bodyLarge(context),
                                letterSpacing: 0.33,
                              ),
                            ),
                            const Divider(
                              height: 20,
                              color: AppTextColors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PincodeScreen()),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'PIN',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: SizeUtil.iconsSize(context),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Obx(() => userController.isDeviceSupport.value
                                    ? Column(
                                        children: [
                                          const Divider(
                                            color: AppColors.lightgrey,
                                            thickness: 1.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Biometric',
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5.0),
                                                child: FlutterSwitch(
                                                  borderRadius: 40,
                                                  width:
                                                      SizeUtil.scallingFactor(
                                                              context) *
                                                          50,
                                                  height:
                                                      SizeUtil.scallingFactor(
                                                              context) *
                                                          25,
                                                  value: userController
                                                      .isBiometricEnabled.value,
                                                  toggleSize:
                                                      SizeUtil.body(context),
                                                  activeColor:
                                                      AppColors.primary,
                                                  inactiveColor: AppColors.grey,
                                                  onToggle: (value) {
                                                    userController
                                                        .isLogin.value = false;
                                                    userController
                                                        .changeBiometricToEnableDisabled(
                                                            context);
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    : const SizedBox()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow.withOpacity(0.01),
                            offset: const Offset(0, 1),
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.lightgrey, // Border color
                          width: 2.0, // Border width
                        ),
                        color: AppColors.white,
                      ),
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.all(
                            SizeUtil.verticalSpacingSmall(context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Help',
                              style: TextStyle(
                                color: AppTextColors.primary,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w700,
                                fontSize: SizeUtil.bodyLarge(context),
                                letterSpacing: 0.33,
                              ),
                            ),
                            const Divider(
                              height: 20,
                              color: AppTextColors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ContactUsScreen()),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Contact Us',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: SizeUtil.iconsSize(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.lightgrey,
                                  thickness: 1.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'FAQs',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Icon(
                                        Icons.arrow_right_alt_sharp,
                                        size: SizeUtil.iconsSize(context),
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: AppColors.lightgrey,
                                  thickness: 1.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchURL(
                                        'https://www.w3.org/Provider/Style/dummy.html');
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const PrivacyPolicyScreen()),
                                    // );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Privacy Policy',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: SizeUtil.iconsSize(context),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.lightgrey,
                                  thickness: 1.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchURL(
                                        'https://www.w3.org/Provider/Style/dummy.html');
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const TermConditionsScreen()),
                                    // );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Terms and Conditions',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: SizeUtil.iconsSize(context),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                      child: LargeButton(
                          text: "Logout",
                          onPressed: () {
                            logout();
                          },
                          backgroundColor: AppColors.white,
                          textColor: AppColors.lightRed),
                    ),
                    SizedBox(height: SizeUtil.verticalSpacingSmall(context)),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                    ),
                    SizedBox(height: SizeUtil.verticalSpacingSmall(context)),
                    Center(
                      child: Text(
                        'Made by the dedicated team at Midas\nARNXXXXXXXX',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: SizeUtil.body(context),
                            fontFamily: "Helvetica"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: null,
    );
  }
}
