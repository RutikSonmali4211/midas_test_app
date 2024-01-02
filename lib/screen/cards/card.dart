import 'package:get/get.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/model/cards/cardAds.dart';
import 'package:midas/data/cards/card_ads._list.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/colors.dart';
import '../../constant/sizeConstant.dart';
import '../../constant/size_util.dart';
import 'card_details.dart';

class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    bool iscardSectionActive = false;
    bool isADsSectionActive = true;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (iscardSectionActive == true)
            Container(
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
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(DefaultSizes.appheadercircularborder),
                  bottomRight:
                      Radius.circular(DefaultSizes.appheadercircularborder),
                ),
                color: AppColors.primary,
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
                                    icon: const Icon(
                                        Icons.notifications_outlined),
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Notifications()),
                                      );
                                      ConstantUtil
                                          .isNotificationReceived.value = false;
                                    },
                                  ),
                                  if (ConstantUtil.isNotificationReceived.value)
                                    Positioned(
                                      top: 11,
                                      right: 13,
                                      child: Container(
                                        width:
                                            SizeUtil.scallingFactor(context) *
                                                11,
                                        height:
                                            SizeUtil.scallingFactor(context) *
                                                11,
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
                                  builder: (context) =>
                                      const ProfileAndSettings()),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total Outstanding',
                          style: TextStyle(
                            color: AppTextColors.white,
                            fontFamily:
                                "Helvetica", // Use a similar font to .SF Compact
                            fontWeight: FontWeight.w400,
                            fontSize: SizeUtil.headingMedium(context),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.currency_rupee_outlined,
                              color: Colors.white,
                              size: SizeUtil.headingLarge(context),
                            ),
                            Text(
                              '2,04,250',
                              style: TextStyle(
                                color: AppTextColors.white,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w700,
                                fontSize: SizeUtil.headingLarge(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Last Updated: 5:00 pm',
                          style: TextStyle(
                            color: AppTextColors.white,
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w400,
                            fontSize: SizeUtil.headingSmall(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (isADsSectionActive == true)
            Container(
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
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(DefaultSizes.appheadercircularborder),
                  bottomRight:
                      Radius.circular(DefaultSizes.appheadercircularborder),
                ),
                color: AppColors.primary,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeUtil.getStatusBarHeight(context),
                      right: 20,
                      bottom: DefaultSizes.bottemspaceofheader,
                    ),
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
                          padding: const EdgeInsets.all(0),
                          color: AppColors.white,
                          icon: const Icon(Icons.account_circle),
                          iconSize: SizeUtil.iconsSize(context),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProfileAndSettings()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (iscardSectionActive == true)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeUtil.verticalSpacingMedium(context),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CardDetails()),
                          );
                          print('Container pressed!');
                        },
                        child: Container(
                          padding: EdgeInsets.all(size.height * 0.015),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/hdfc_icon.png'),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                'Card Number: xxxxxxx1234',
                                style: TextStyle(
                                  color: AppTextColors.primary,
                                  fontFamily:
                                      "Helvetica", // Use a similar font to .SF Compact
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeUtil.bodyLarge(context),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Balance: ',
                                        style: TextStyle(
                                          color: AppTextColors.primary,
                                          fontFamily:
                                              "Helvetica", // Use a similar font to .SF Compact
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeUtil.bodyLarge(context),
                                        ),
                                      ),
                                      Icon(
                                        Icons.currency_rupee_outlined,
                                        color: AppTextColors.primary,
                                        size: SizeUtil.bodyLarge(context),
                                      ),
                                      Text(
                                        '1,04,250',
                                        style: TextStyle(
                                          color: AppTextColors.primary,
                                          fontFamily:
                                              "Helvetica", // Use a similar font to .SF Compact
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeUtil.bodyLarge(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt,
                                    color: AppTextColors.primary,
                                    size: SizeUtil.iconsSize(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CardDetails()),
                          );
                          print('Container pressed!');
                        },
                        child: Container(
                          padding: EdgeInsets.all(size.height * 0.015),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/ICICI_icon.png'),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                'Card Number: xxxxxxx1234',
                                style: TextStyle(
                                  color: AppTextColors.primary,
                                  fontFamily:
                                      "Helvetica", // Use a similar font to .SF Compact
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeUtil.bodyLarge(context),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Balance: ',
                                        style: TextStyle(
                                          color: AppTextColors.primary,
                                          fontFamily:
                                              "Helvetica", // Use a similar font to .SF Compact
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeUtil.bodyLarge(context),
                                        ),
                                      ),
                                      Icon(
                                        Icons.currency_rupee_outlined,
                                        color: AppTextColors.primary,
                                        size: SizeUtil.bodyLarge(context),
                                      ),
                                      Text(
                                        '1,00,000',
                                        style: TextStyle(
                                          color: AppTextColors.primary,
                                          fontFamily:
                                              "Helvetica", // Use a similar font to .SF Compact
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeUtil.bodyLarge(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt,
                                    color: AppTextColors.primary,
                                    size: SizeUtil.iconsSize(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppTextColors
                                  .grey, // Replace with your desired line color
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Sponsored',
                              style: TextStyle(
                                  color: AppTextColors
                                      .grey, // Replace with your desired text color
                                  fontSize: SizeUtil.bodyLarge(context),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Helvetica"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppTextColors
                                  .grey, // Replace with your desired line color
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Image.asset('assets/Kotak_icon.png'),
                                // SizedBox(
                                //   height: size.height * 0.02,
                                // ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    left: 10,
                                  ),
                                  // color: const Color.fromARGB(255, 189, 189, 189),
                                  // width: screenSize.width * 0.37,
                                  // height: screenSize.height * 0.033,
                                  child: Image.asset('assets/Kotak_icon.png'),
                                ),
                                const Spacer(),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: Text(
                                    'Ad',
                                    style: TextStyle(
                                      color: AppTextColors.primary,
                                      fontFamily:
                                          "Helvetica", // Use a similar font to .SF Compact
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeUtil.bodySmall(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 10,
                              ),
                              width: size.width,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(bottom: size.height * 0.01),
                                child: Text(
                                  'Sign up for a new credit card and earn upto 6% in rewards',
                                  style: TextStyle(
                                    color: AppTextColors.primary,
                                    fontFamily:
                                        "Helvetica", // Use a similar font to .SF Compact
                                    fontWeight: FontWeight.w400,
                                    fontSize: SizeUtil.bodyLarge(context),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isADsSectionActive == true)
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeUtil.verticalSpacingMedium(context),
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: SizeUtil.verticalSpacingMedium(context),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Text(
                            'Apply for Credit Cards for added benefits',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontFamily: "Helvetica",
                              fontSize: SizeUtil.headingMedium(context),
                              fontWeight: FontWeight.w700,
                              // letterSpacing: 0.33074989914894104,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AdsSection(),
                  ],
                ),
              ),
            )),
        ],
      ),
    );
  }

  Widget AdsSection() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: CardsAdsEntityList.length,
      itemBuilder: (context, index) {
        CardsAdsEntity item = CardsAdsEntityList[index];
        return GestureDetector(
          onTap: () {
            _launchURL(item.url);
            // launchUrl(Uri.parse(item.url),mode: LaunchMode.inAppWebView);
          },
          child: Container(
            margin: EdgeInsets.only(
                bottom: SizeUtil.verticalSpacingMedium(context)),
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  10.0), // Adjust the border radius as needed
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover, // You can change the fit mode as needed
              ),
            ),
          ),
        );
      },
    );
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
}
