// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/investment_controller.dart';
import 'package:midas/model/investments/investment_model.dart';
import 'package:midas/screen/Investments/gold/gold.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds.dart';
import 'package:midas/screen/Investments/other_assets/other_assets.dart';
import 'package:midas/screen/notifications/notifications.dart';

import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:flutter/material.dart';

class Investment extends StatefulWidget {
  const Investment({super.key});

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  InvestmentController investmentController = Get.put(InvestmentController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      investmentController.getCurrentAndInvestedValues(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
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
          SizedBox(
            height: SizeUtil.verticalSpacingMedium(context),
          ),
          Expanded(
            child: Obx(() => investmentController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.only(
                        bottom: SizeUtil.verticalSpacingMedium(context)),
                    itemCount: investmentController
                        .investmentList.value.investments.length,
                    itemBuilder: (context, index) {
                      InvestmentData item = investmentController
                          .investmentList.value.investments[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showInvestmentSection(item.type);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    SizeUtil.verticalSpacingMedium(context)),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/investment_icon.png',
                                        fit: BoxFit.fill,
                                        height: SizeUtil.bodyLarge(context),
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      Text(
                                        item.type,
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize:
                                                SizeUtil.bodyLarge(context),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Helvetica"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        SizeUtil.verticalSpacingMedium(context),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Investment: ',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      RichText(
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor,
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: '₹',
                                                style: TextStyle(
                                                    letterSpacing: 2,
                                                    color: AppColors.primary,
                                                    fontSize: SizeUtil.body(
                                                        context))),
                                            TextSpan(
                                              text: ConstantUtil.formatAmount(
                                                  item.investedValue
                                                      .toDouble()),
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Current Value: ',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          ),
                                          RichText(
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: '₹',
                                                    style: TextStyle(
                                                        letterSpacing: 2,
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: SizeUtil.body(
                                                            context))),
                                                TextSpan(
                                                  text:
                                                      ConstantUtil.formatAmount(
                                                          item.currentValue
                                                              .toDouble()),
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: SizeUtil.body(
                                                          context),
                                                      fontFamily: "Helvetica"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_right_alt_sharp,
                                        size: SizeUtil.iconsSize(context),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
          )
        ],
      ),
    );
  }

  showInvestmentSection(String title) async {
    switch (title) {
      // case 'Stocks':
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => StocksScreen()),
      //   );
      //   break;
      case 'Mutual Funds':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MutualFundsScreen()),
        );
        await investmentController.getCurrentAndInvestedValues(context);
        break;
      // case 'Deposits':
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => DepositsScreen()),
      //   );
      //   break;
      // case 'PPF':
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => PpfScreen()),
      //   );
      //   break;
      case 'Gold':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GoldScreen()),
        );
        await investmentController.getCurrentAndInvestedValues(context);
        break;
      case 'P2P Lending':
        break;
      case 'Other Assets':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OtherAssetsScreen()),
        );
        await investmentController.getCurrentAndInvestedValues(context);
        break;
      default:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Container()));
        break;
    }
  }
}
