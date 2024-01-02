import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/convertors.dart';
import 'package:midas/controller/home/home_controller.dart';
import 'package:midas/controller/investment/investment_controller.dart';
import 'package:midas/controller/user/user_controller.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import '../../constant/sizeConstant.dart';
import '../../constant/size_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var height;
  var width;

  InvestmentController investmentController = Get.put(InvestmentController());
  UserController userController = Get.put(UserController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getLastSevenDaysGraphDataByUserId(context);
      investmentController.getCurrentAndInvestedValues(context);
      if (userController.isDeviceSupport.value) {
        if (!userController.isBiometricEnabled.value &&
            !userController.isBometricAlertDisplay.value) {
          userController.showBiometricAuthEnbleAlert(context);
        }
      }
      userController.isLogin.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    double scalingFactor = SizeUtil.calculateScalingFactor(context);
    double statusbarHeight = SizeUtil.getStatusBarHeight(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Obx(() => investmentController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        bottomLeft: Radius.circular(
                            DefaultSizes.appheadercircularborder),
                        bottomRight: Radius.circular(
                            DefaultSizes.appheadercircularborder),
                      ),
                      color: AppColors.primary,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: statusbarHeight, right: 20),
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
                                        ConstantUtil.isNotificationReceived.value = false;
                                      },
                                    ),
                                    if (ConstantUtil
                                        .isNotificationReceived.value)
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
                              left: width * 0.02,
                              right: width * 0.02,
                              bottom: DefaultSizes.bottemspaceofheader),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'My Net Worth',
                                style: TextStyle(
                                  color: AppTextColors.white,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeUtil.headingMedium(context),
                                ),
                              ),
                              const SizedBox(height: 5),
                              RichText(
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '₹',
                                      style: TextStyle(
                                        letterSpacing: 4,
                                        fontFamily: 'NotoSans',
                                        color: AppTextColors.white,
                                        fontSize:
                                            SizeUtil.headingLarge(context),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ConstantUtil.formatAmountOnHeader(
                                          investmentController
                                              .investmentList.value.totalValue),
                                      style: TextStyle(
                                        fontFamily: "Helvetica",
                                        color: AppTextColors.white,
                                        fontSize: SizeUtil.headingLarge(
                                            context), // Use the same fontSize
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.only(bottom: 3.5),
                              //       child: Icon(
                              //         Icons.currency_rupee_outlined,
                              //         color: Colors.white,
                              //         size: SizeUtil.headingLarge(context),
                              //       ),
                              //     ),
                              //     Text(
                              //       '78.22 Lakh',
                              //       style: TextStyle(
                              //         color: AppTextColors.white,
                              //         fontFamily: "Helvetica",
                              //         fontWeight: FontWeight.w700,
                              //         fontSize: SizeUtil.headingLarge(context),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                investmentController
                                            .investmentList.value.totalValue !=
                                        0
                                    ? "Last Updated: ${DateFormat("dd MMM yyyy").format(investmentController.investmentList.value.lastUpdatedDate.toLocal())}"
                                    : "",
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
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: size.width * 0.05,
                        //       vertical: size.height * 0.02),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Expanded(
                        //         flex: 2,
                        //         child: Container(
                        //           padding: EdgeInsets.all(10),
                        //           decoration: BoxDecoration(
                        //             gradient: LinearGradient(
                        //               colors: [
                        //                 Color.fromRGBO(131, 132, 139, 0.5),
                        //                 Color.fromRGBO(131, 132, 139, 0.2),
                        //               ],
                        //               begin: Alignment.topLeft,
                        //               end: Alignment.bottomRight,
                        //             ),
                        //             borderRadius: BorderRadius.circular(20),
                        //           ),
                        //           child: Row(
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               Icon(
                        //                 Icons.account_balance_wallet,
                        //                 color: Colors.white,
                        //                 size: size.height * 0.050,
                        //               ),
                        //               SizedBox(
                        //                 width: 10,
                        //               ),
                        //               Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 mainAxisAlignment: MainAxisAlignment.center,
                        //                 children: [
                        //                   Text(
                        //                     'Assets',
                        //                     style: TextStyle(
                        //                       fontFamily: "Helvetica",
                        //                       fontSize: size.width * 0.04,
                        //                       fontWeight: FontWeight.w400,
                        //                       color: AppTextColors.white,
                        //                       // You can add other text styles as needed
                        //                     ),
                        //                   ),
                        //                   RichText(
                        //                     textAlign: TextAlign.start,
                        //                     text: TextSpan(
                        //                       children: [
                        //                         TextSpan(
                        //                           text: '₹',
                        //                           style: TextStyle(
                        //                             letterSpacing: 2,
                        //                             fontFamily: 'NotoSans',
                        //                             color: AppTextColors.white,
                        //                             fontSize: size.width * 0.04,
                        //                             fontWeight: FontWeight.w400,
                        //                           ),
                        //                         ),
                        //                         TextSpan(
                        //                           text: "2,30,26,270",
                        //                           style: TextStyle(
                        //                             fontFamily: "Helvetica",
                        //                             color: AppTextColors.white,
                        //                             fontSize: size.width * 0.04,
                        //                             fontWeight: FontWeight.w400,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(width: size.width * 0.03),
                        //       Expanded(
                        //         flex: 2,
                        //         child: Container(
                        //           padding: EdgeInsets.all(10),
                        //           decoration: BoxDecoration(
                        //             gradient: LinearGradient(
                        //               colors: [
                        //                 Color.fromRGBO(131, 132, 139, 0.5),
                        //                 Color.fromRGBO(131, 132, 139, 0.2),
                        //               ],
                        //               begin: Alignment.topLeft,
                        //               end: Alignment.bottomRight,
                        //             ),
                        //             borderRadius: BorderRadius.circular(20),
                        //           ),
                        //           child: Row(
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               Icon(
                        //                 Icons.info_outline,
                        //                 color: Colors.white,
                        //                 size: size.height * 0.050,
                        //               ),
                        //               SizedBox(
                        //                 width: 10,
                        //               ),
                        //               Column(
                        //                 mainAxisSize: MainAxisSize.min,
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Text(
                        //                     'Liabilities',
                        //                     style: TextStyle(
                        //                       fontFamily: "Helvetica",
                        //                       fontSize: size.width * 0.04,
                        //                       fontWeight: FontWeight.w400,
                        //                       color: AppTextColors.white,
                        //                       // You can add other text styles as needed
                        //                     ),
                        //                   ),
                        //                   RichText(
                        //                     textAlign: TextAlign.start,
                        //                     text: TextSpan(
                        //                       children: [
                        //                         TextSpan(
                        //                           text: '₹',
                        //                           style: TextStyle(
                        //                             letterSpacing: 2,
                        //                             fontFamily: 'NotoSans',
                        //                             color: AppTextColors.white,
                        //                             fontSize: size.width * 0.04,
                        //                             fontWeight: FontWeight.w400,
                        //                           ),
                        //                         ),
                        //                         TextSpan(
                        //                           text: "1,52,04,250",
                        //                           style: TextStyle(
                        //                             fontFamily: "Helvetica",
                        //                             color: AppTextColors.white,
                        //                             fontSize: size.width * 0.04,
                        //                             fontWeight: FontWeight.w400,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeUtil.verticalSpacingMedium(context),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.04,
                              right: size.width * 0.04,
                            ),
                            child: Column(
                              children: [
                                if (homeController.lastSevenDayDates.length ==
                                        7 &&
                                    homeController
                                            .lastSevenDaysNetWorth.length ==
                                        7)
                                  Container(
                                    padding: EdgeInsets.all(
                                        SizeUtil.verticalSpacingSmall(context)),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.shadow
                                              .withOpacity(0.01),
                                          offset: const Offset(0, 1),
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppColors.lightgrey,
                                        width: 2.0,
                                      ),
                                      color: AppColors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Last Week',
                                          style: TextStyle(
                                              color: AppTextColors.grey,
                                              fontSize: SizeUtil.bodyLarge(
                                                  context), //bodyLargeFontSize
                                              fontFamily: "Helvetica"),
                                        ),
                                        Container(
                                          width: size.width,
                                          height: size.height * 0.2,
                                          color: AppColors.white,
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: LineChart(
                                            LineChartData(
                                              clipData: const FlClipData.all(),
                                              minX: 0,
                                              maxX: homeController
                                                      .lastSevenDaysNetWorth
                                                      .length
                                                      .toDouble() -
                                                  1,
                                              minY: homeController.minY.value,
                                              maxY: homeController.maxY.value,
                                              titlesData: const FlTitlesData(
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    reservedSize: 30,
                                                    showTitles: false,
                                                  ),
                                                ),
                                                leftTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    reservedSize: 30,
                                                    showTitles: false,
                                                  ),
                                                ),
                                                rightTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    reservedSize: 30,
                                                    showTitles: false,
                                                  ),
                                                ),
                                                topTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    reservedSize: 30,
                                                    showTitles: false,
                                                  ),
                                                ),
                                              ),
                                              gridData: const FlGridData(
                                                show: false,
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: homeController
                                                      .lastSevenDaysNetWorth,
                                                  isCurved: true,
                                                  color: Colors.green,
                                                  dotData: const FlDotData(
                                                      show: false),
                                                ),
                                              ],
                                              lineTouchData:
                                                  const LineTouchData(
                                                handleBuiltInTouches: true,
                                                touchTooltipData:
                                                    LineTouchTooltipData(
                                                  tooltipBgColor:
                                                      AppColors.transPerent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              for (String date in homeController
                                                  .lastSevenDayDates)
                                                Text(
                                                  date,
                                                  style: TextStyle(
                                                    fontFamily: "Helvetica",
                                                    color: AppColors.grey,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        SizeUtil.bodySmall(
                                                            context),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                if (homeController.lastSevenDayDates.length ==
                                        7 &&
                                    homeController
                                            .lastSevenDaysNetWorth.length ==
                                        7)
                                  SizedBox(
                                    height:
                                        SizeUtil.verticalSpacingMedium(context),
                                  ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColors.shadow.withOpacity(0.01),
                                        offset: const Offset(0, 1),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color:
                                          AppColors.lightgrey, // Border color
                                      width: 2.0, // Border width
                                    ),
                                    color: AppColors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        SizeUtil.verticalSpacingSmall(context)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Assets',
                                          style: TextStyle(
                                              color: AppTextColors.grey,
                                              fontSize:
                                                  SizeUtil.bodyLarge(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: size.width * 0.05),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.white,
                                                    border: Border.all(
                                                      color: AppColors.primary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.white,
                                                    radius: scalingFactor * 22,
                                                    child: Image.asset(
                                                        "assets/others_icon.png",
                                                        height:
                                                            scalingFactor * 20,
                                                        color:
                                                            AppColors.primary),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Other Assets',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primary,
                                                            fontFamily:
                                                                "Helvetica",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                SizeUtil.body(
                                                                    context),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        RichText(
                                                          textScaleFactor:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaleFactor,
                                                          textAlign:
                                                              TextAlign.start,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: '₹',
                                                                style:
                                                                    TextStyle(
                                                                  letterSpacing:
                                                                      2,
                                                                  fontFamily:
                                                                      'NotoSans',
                                                                  color: AppTextColors
                                                                      .primary,
                                                                  fontSize:
                                                                      SizeUtil.body(
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: ConstantUtil.formatAmount(
                                                                    investmentController
                                                                        .otherAssetsCurrentValue
                                                                        .value
                                                                        .toDouble()),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Helvetica",
                                                                  color: AppTextColors
                                                                      .primary,
                                                                  fontSize:
                                                                      SizeUtil.body(
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          flex: 6,
                                                          child: Container(
                                                            // width: size.width * 0.46,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  LinearProgressIndicator(
                                                                value: Convertors.getLinearBarValue(
                                                                    investmentController
                                                                        .otherAssetsCurrentValue
                                                                        .value,
                                                                    investmentController
                                                                        .investmentList
                                                                        .value
                                                                        .totalValue),
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        300],
                                                                valueColor:
                                                                    const AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .green),
                                                                minHeight: 6,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Flexible(
                                                          flex: 2,
                                                          child: Text(
                                                            "${Convertors.getInvestedAssetPercentage(investmentController.otherAssetsCurrentValue.value, investmentController.investmentList.value.totalValue)} %",
                                                            // "${(((investmentController.otherAssetsCurrentValue / investmentController.investmentList.value.totalValue)*100)).toStringAsFixed(2)} %",
                                                            style: TextStyle(
                                                              color:
                                                                  AppTextColors
                                                                      .grey,
                                                              fontFamily:
                                                                  "Helvetica",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  SizeUtil.body(
                                                                      context),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          height: 5,
                                          color: AppTextColors.grey,
                                          thickness: 0.5,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        // Container(
                                        //   padding: EdgeInsets.all(10),
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.start,
                                        //     children: [
                                        //       Padding(
                                        //         padding: EdgeInsets.only(right: size.width * 0.05),
                                        //         child: Container(
                                        //           decoration: BoxDecoration(
                                        //             shape: BoxShape.circle,
                                        //             color: AppColors.white,
                                        //             border: Border.all(
                                        //               color: AppColors.primary,
                                        //               width: 1.0,
                                        //             ),
                                        //           ),
                                        //           child: CircleAvatar(
                                        //             backgroundColor: AppColors.white,
                                        //             radius: size.height * 0.026,
                                        //             child: Icon(
                                        //               Icons.account_balance,
                                        //               size: size.height * 0.026,
                                        //               color: AppColors.primary,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         child: Column(
                                        //           crossAxisAlignment:
                                        //               CrossAxisAlignment.start,
                                        //           children: [
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.spaceBetween,
                                        //               children: [
                                        //                 Text(
                                        //                   'Savings Accounts',
                                        //                   style: TextStyle(
                                        //                     color: AppColors.primary,
                                        //                     fontFamily: "Helvetica",
                                        //                     fontWeight: FontWeight.w400,
                                        //                     fontSize: size.height * 0.022,
                                        //                   ),
                                        //                 ),
                                        //                 SizedBox(
                                        //                   width: 10,
                                        //                 ),
                                        //                 RichText(
                                        //                   textAlign: TextAlign.start,
                                        //                   text: TextSpan(
                                        //                     children: [
                                        //                       TextSpan(
                                        //                         text: '₹',
                                        //                         style: TextStyle(
                                        //                           letterSpacing: 2,
                                        //                           fontFamily: 'NotoSans',
                                        //                           color:
                                        //                               AppTextColors.primary,
                                        //                           fontSize:
                                        //                               size.height * 0.022,
                                        //                           fontWeight:
                                        //                               FontWeight.w400,
                                        //                         ),
                                        //                       ),
                                        //                       TextSpan(
                                        //                         text: "11,53,270",
                                        //                         style: TextStyle(
                                        //                           fontFamily: "Helvetica",
                                        //                           color:
                                        //                               AppTextColors.primary,
                                        //                           fontSize:
                                        //                               size.height * 0.022,
                                        //                           fontWeight:
                                        //                               FontWeight.w400,
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             SizedBox(
                                        //               height: 5,
                                        //             ),
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.spaceBetween,
                                        //               children: [
                                        //                 Container(
                                        //                   width: size.width * 0.46,
                                        //                   child: ClipRRect(
                                        //                     borderRadius:
                                        //                         BorderRadius.circular(10),
                                        //                     child: LinearProgressIndicator(
                                        //                       value: 0.1,
                                        //                       backgroundColor:
                                        //                           Colors.grey[300],
                                        //                       valueColor:
                                        //                           AlwaysStoppedAnimation<
                                        //                               Color>(Colors.green),
                                        //                       minHeight: 6,
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 SizedBox(
                                        //                   width: 5,
                                        //                 ),
                                        //                 Text(
                                        //                   '5.0%',
                                        //                   style: TextStyle(
                                        //                     color: AppTextColors.grey,
                                        //                     fontFamily: "Helvetica",
                                        //                     fontWeight: FontWeight.w400,
                                        //                     fontSize: size.height * 0.022,
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Divider(
                                        //   height: 5,
                                        //   color: AppTextColors.grey,
                                        //   thickness: 0.5,
                                        //   indent: 10,
                                        //   endIndent: 10,
                                        // ),
                                        // Container(
                                        //   padding: EdgeInsets.all(10),
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.start,
                                        //     children: [
                                        //       Padding(
                                        //         padding: EdgeInsets.only(right: size.width * 0.05),
                                        //         child: Container(
                                        //           decoration: BoxDecoration(
                                        //             shape: BoxShape.circle,
                                        //             color: AppColors.white,
                                        //             border: Border.all(
                                        //               color: AppColors.primary,
                                        //               width: 1.0,
                                        //             ),
                                        //           ),
                                        //           child: CircleAvatar(
                                        //             backgroundColor: AppColors.white,
                                        //             radius: size.height * 0.026,
                                        //             child: Icon(
                                        //               Icons.account_balance_wallet_rounded,
                                        //               size: size.height * 0.026,
                                        //               color: AppColors.primary,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         child: Column(
                                        //           crossAxisAlignment:
                                        //               CrossAxisAlignment.start,
                                        //           children: [
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.spaceBetween,
                                        //               children: [
                                        //                 Text(
                                        //                   'PPF',
                                        //                   style: TextStyle(
                                        //                     color: AppColors.primary,
                                        //                     fontFamily: "Helvetica",
                                        //                     fontWeight: FontWeight.w400,
                                        //                     fontSize: size.height * 0.022,
                                        //                   ),
                                        //                 ),
                                        //                 SizedBox(
                                        //                   width: 10,
                                        //                 ),
                                        //                 RichText(
                                        //                   textAlign: TextAlign.start,
                                        //                   text: TextSpan(
                                        //                     children: [
                                        //                       TextSpan(
                                        //                         text: '₹',
                                        //                         style: TextStyle(
                                        //                           letterSpacing: 2,
                                        //                           fontFamily: 'NotoSans',
                                        //                           color:
                                        //                               AppTextColors.primary,
                                        //                           fontSize:
                                        //                               size.height * 0.022,
                                        //                           fontWeight:
                                        //                               FontWeight.w400,
                                        //                         ),
                                        //                       ),
                                        //                       TextSpan(
                                        //                         text: "3,30,000",
                                        //                         style: TextStyle(
                                        //                           fontFamily: "Helvetica",
                                        //                           color:
                                        //                               AppTextColors.primary,
                                        //                           fontSize:
                                        //                               size.height * 0.022,
                                        //                           fontWeight:
                                        //                               FontWeight.w400,
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             SizedBox(
                                        //               height: 5,
                                        //             ),
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.spaceBetween,
                                        //               children: [
                                        //                 Container(
                                        //                   width: size.width * 0.46,
                                        //                   child: ClipRRect(
                                        //                     borderRadius:
                                        //                         BorderRadius.circular(10),
                                        //                     child: LinearProgressIndicator(
                                        //                       value: 0.05,
                                        //                       backgroundColor:
                                        //                           Colors.grey[300],
                                        //                       valueColor:
                                        //                           AlwaysStoppedAnimation<
                                        //                               Color>(Colors.green),
                                        //                       minHeight: 6,
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 SizedBox(
                                        //                   width: 5,
                                        //                 ),
                                        //                 Text(
                                        //                   '1.5%',
                                        //                   style: TextStyle(
                                        //                     color: AppTextColors.grey,
                                        //                     fontFamily: "Helvetica",
                                        //                     fontWeight: FontWeight.w400,
                                        //                     fontSize: size.height * 0.022,
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Divider(
                                        //   height: 5,
                                        //   color: AppTextColors.grey,
                                        //   thickness: 0.5,
                                        //   indent: 10,
                                        //   endIndent: 10,
                                        // ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: size.width * 0.05),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.white,
                                                    border: Border.all(
                                                      color: AppColors.primary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.white,
                                                    radius: scalingFactor * 22,
                                                    child: Image.asset(
                                                      "assets/gold_icon.png",
                                                      height:
                                                          scalingFactor * 20,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Gold',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primary,
                                                            fontFamily:
                                                                "Helvetica",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                SizeUtil.body(
                                                                    context),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        RichText(
                                                          textScaleFactor:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaleFactor,
                                                          textAlign:
                                                              TextAlign.start,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: '₹',
                                                                style:
                                                                    TextStyle(
                                                                  letterSpacing:
                                                                      2,
                                                                  fontFamily:
                                                                      'NotoSans',
                                                                  color: AppTextColors
                                                                      .primary,
                                                                  fontSize:
                                                                      SizeUtil.body(
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: ConstantUtil.formatAmount(
                                                                    investmentController
                                                                        .goldCurrentValue
                                                                        .value
                                                                        .toDouble()),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Helvetica",
                                                                  color: AppTextColors
                                                                      .primary,
                                                                  fontSize:
                                                                      SizeUtil.body(
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          flex: 6,
                                                          child: Container(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  LinearProgressIndicator(
                                                                value: Convertors.getLinearBarValue(
                                                                    investmentController
                                                                        .goldCurrentValue
                                                                        .value,
                                                                    investmentController
                                                                        .investmentList
                                                                        .value
                                                                        .totalValue),
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        300],
                                                                valueColor:
                                                                    const AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .green),
                                                                minHeight: 6,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Flexible(
                                                          flex: 2,
                                                          child: Text(
                                                            "${Convertors.getInvestedAssetPercentage(investmentController.goldCurrentValue.value, investmentController.investmentList.value.totalValue)} %",
                                                            //  "${(((investmentController.goldCurrentValue / investmentController.investmentList.value.totalValue)*100)).toStringAsFixed(2)} %",
                                                            style: TextStyle(
                                                              color:
                                                                  AppTextColors
                                                                      .grey,
                                                              fontFamily:
                                                                  "Helvetica",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  SizeUtil.body(
                                                                      context),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          height: 5,
                                          color: AppTextColors.grey,
                                          thickness: 0.5,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: size.width * 0.05),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.white,
                                                    border: Border.all(
                                                      color: AppColors.primary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.white,
                                                    radius: scalingFactor * 22,
                                                    child: Icon(
                                                      Icons.trending_up,
                                                      size: scalingFactor * 22,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Mutual Funds',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primary,
                                                            fontFamily:
                                                                "Helvetica",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                SizeUtil.body(
                                                                    context),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        RichText(
                                                          textScaleFactor:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaleFactor,
                                                          textAlign:
                                                              TextAlign.start,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: '₹',
                                                                style:
                                                                    TextStyle(
                                                                  letterSpacing:
                                                                      2,
                                                                  fontFamily:
                                                                      'NotoSans',
                                                                  color: AppTextColors
                                                                      .primary,
                                                                  fontSize:
                                                                      SizeUtil.body(
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: ConstantUtil.formatAmount(
                                                                    investmentController
                                                                        .mutualFundCurrentValue
                                                                        .value
                                                                        .toDouble()),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Helvetica",
                                                                  color: AppTextColors
                                                                      .primary,
                                                                  fontSize:
                                                                      SizeUtil.body(
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          flex: 6,
                                                          child: Container(
                                                            // width: size.width * 0.46,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  LinearProgressIndicator(
                                                                value: Convertors.getLinearBarValue(
                                                                    investmentController
                                                                        .mutualFundCurrentValue
                                                                        .value,
                                                                    investmentController
                                                                        .investmentList
                                                                        .value
                                                                        .totalValue),
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        300],
                                                                valueColor:
                                                                    const AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .green),
                                                                minHeight: 6,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Flexible(
                                                          flex: 2,
                                                          child: Text(
                                                            "${Convertors.getInvestedAssetPercentage(investmentController.mutualFundCurrentValue.value, investmentController.investmentList.value.totalValue)} %",
                                                            // "${(((investmentController.otherAssetsCurrentValue / investmentController.investmentList.value.totalValue)*100)).toStringAsFixed(2)} %",
                                                            style: TextStyle(
                                                              color:
                                                                  AppTextColors
                                                                      .grey,
                                                              fontFamily:
                                                                  "Helvetica",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  SizeUtil.body(
                                                                      context),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Divider(
                                        //   height: 5,
                                        //   color: AppTextColors.grey,
                                        //   thickness: 0.5,
                                        //   indent: 10,
                                        //   endIndent: 10,
                                        // ),
                                        // Container(
                                        //   padding: EdgeInsets.all(10),
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.start,
                                        //     children: [
                                        //       Padding(
                                        //         padding: EdgeInsets.only(right: 20),
                                        //         child: Container(
                                        //           decoration: BoxDecoration(
                                        //             shape: BoxShape.circle,
                                        //             color: AppColors.white,
                                        //             border: Border.all(
                                        //               color: AppColors.primary,
                                        //               width: 1.0,
                                        //             ),
                                        //           ),
                                        //           child: CircleAvatar(
                                        //             backgroundColor: AppColors.white,
                                        //             radius: size.height * 0.026,
                                        //             child: Icon(
                                        //               Icons.trending_up,
                                        //               size: size.height * 0.026,
                                        //               color: AppColors.primary,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         child: Column(
                                        //           crossAxisAlignment:
                                        //               CrossAxisAlignment.start,
                                        //           children: [
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.spaceBetween,
                                        //               children: [
                                        //                 Text(
                                        //                   'Stocks',
                                        //                   style: TextStyle(
                                        //                     color: AppColors.primary,
                                        //                     fontFamily: "Helvetica",
                                        //                     fontWeight: FontWeight.w400,
                                        //                     fontSize: size.height * 0.022,
                                        //                   ),
                                        //                 ),
                                        //                 SizedBox(
                                        //                   width: 10,
                                        //                 ),
                                        //                 RichText(
                                        //                   textAlign: TextAlign.start,
                                        //                   text: TextSpan(
                                        //                     children: [
                                        //                       TextSpan(
                                        //                         text: '₹',
                                        //                         style: TextStyle(
                                        //                           letterSpacing: 2,
                                        //                           fontFamily: 'NotoSans',
                                        //                           color:
                                        //                               AppTextColors.primary,
                                        //                           fontSize:
                                        //                               size.height * 0.022,
                                        //                           fontWeight:
                                        //                               FontWeight.w400,
                                        //                         ),
                                        //                       ),
                                        //                       TextSpan(
                                        //                         text: "1,10,000",
                                        //                         style: TextStyle(
                                        //                           fontFamily: "Helvetica",
                                        //                           color:
                                        //                               AppTextColors.primary,
                                        //                           fontSize:
                                        //                               size.height * 0.022,
                                        //                           fontWeight:
                                        //                               FontWeight.w400,
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             SizedBox(
                                        //               height: 5,
                                        //             ),
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.spaceBetween,
                                        //               children: [
                                        //                 Container(
                                        //                   width: size.width * 0.46,
                                        //                   child: ClipRRect(
                                        //                     borderRadius:
                                        //                         BorderRadius.circular(10),
                                        //                     child: LinearProgressIndicator(
                                        //                       value: 0.02,
                                        //                       backgroundColor:
                                        //                           Colors.grey[300],
                                        //                       valueColor:
                                        //                           AlwaysStoppedAnimation<
                                        //                               Color>(Colors.green),
                                        //                       minHeight: 6,
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 SizedBox(
                                        //                   width: 5,
                                        //                 ),
                                        //                 Text(
                                        //                   '0.5%',
                                        //                   style: TextStyle(
                                        //                     color: AppTextColors.grey,
                                        //                     fontFamily: "Helvetica",
                                        //                     fontWeight: FontWeight.w400,
                                        //                     fontSize: size.height * 0.022,
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Divider(
                                        //   height: 5,
                                        //   color: AppTextColors.grey,
                                        //   thickness: 01,
                                        //   indent: 10,
                                        //   endIndent: 10,
                                        // ),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        // Container(
                                        //   width: size.width,
                                        //   color: AppColors.white,
                                        //   child: Text(
                                        //     'Liabilities',
                                        //     style: TextStyle(
                                        //         color: AppTextColors.grey,
                                        //         fontSize: SizeUtil.bodyLarge(context),
                                        //         fontFamily: "Helvetica"),
                                        //   ),
                                        // ),
                                        // Container(
                                        //   padding: EdgeInsets.all(10),
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.start,
                                        //     children: [
                                        //       Padding(
                                        //         padding: EdgeInsets.only(right: 20),
                                        //         child: Container(
                                        //           decoration: BoxDecoration(
                                        //             shape: BoxShape.circle,
                                        //             color: AppColors.white,
                                        //             border: Border.all(
                                        //               color: AppColors.primary,
                                        //               width: 1.0,
                                        //             ),
                                        //           ),
                                        //           child: CircleAvatar(
                                        //             backgroundColor: AppColors.white,
                                        //             radius: size.height * 0.026,
                                        //             child: Image.asset(
                                        //                 "assets/loans_icon.png",
                                        //                 height: size.height * 0.024,
                                        //                 color: AppColors.primary),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         child: Column(
                                        //           crossAxisAlignment:
                                        //               CrossAxisAlignment.start,
                                        //           children: [
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.spaceBetween,
                                        //               children: [
                                        //                 Text(
                                        //                   'Loans',
                                        //                   style: TextStyle(
                                        //                     color: AppColors.primary,
                                        //                     fontFamily: "Helvetica",
                                        //                     fontWeight: FontWeight.w400,
                                        //                     fontSize: size.height * 0.022,
                                        //                   ),
                                        //                 ),
                                        //                 SizedBox(
                                        //                   width: 10,
                                        //                 ),
                                        //                 RichText(
                                        //                   textAlign: TextAlign.start,
                                        //                   text: TextSpan(
                                        //                     children: [
                                        //                       TextSpan(
                                        //                         text: '₹',
                                        //                         style: TextStyle(
                                        //                           letterSpacing: 2,
                                        //                           fontFamily: 'NotoSans',
                                        //                           color:
                                        //                               AppTextColors.primary,
                                        //                           fontSize:
                                        //                               size.height * 0.022,
                                        //                           fontWeight:
                                        //                               FontWeight.w400,
                                        //                         ),
                                        //                       ),
                                        //                       TextSpan(
                                        //                         text: "1,50,00,000",
                                        //                         style: TextStyle(
                                        //                           fontFamily: "Helvetica",
                                        //                           color:
                                        //                               AppTextColors.primary,
                                        //                           fontSize:
                                        //                               size.height * 0.022,
                                        //                           fontWeight:
                                        //                               FontWeight.w400,
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             SizedBox(
                                        //               height: 5,
                                        //             ),
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.spaceBetween,
                                        //               children: [
                                        //                 Container(
                                        //                   width: size.width * 0.46,
                                        //                   child: ClipRRect(
                                        //                     borderRadius:
                                        //                         BorderRadius.circular(10),
                                        //                     child: LinearProgressIndicator(
                                        //                       value: 0.98,
                                        //                       backgroundColor:
                                        //                           Colors.grey[300],
                                        //                       valueColor:
                                        //                           AlwaysStoppedAnimation<
                                        //                               Color>(Colors.red),
                                        //                       minHeight: 6,
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 SizedBox(
                                        //                   width: 5,
                                        //                 ),
                                        //                 Text(
                                        //                   '98.7%',
                                        //                   style: TextStyle(
                                        //                     color: AppTextColors.grey,
                                        //                     fontFamily: "Helvetica",
                                        //                     fontWeight: FontWeight.w400,
                                        //                     fontSize: size.height * 0.022,
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Divider(
                                        //   height: 5,
                                        //   color: AppTextColors.grey,
                                        //   thickness: 0.5,
                                        //   indent: 10,
                                        //   endIndent: 10,
                                        // ),
                                        //   Container(
                                        //     padding: EdgeInsets.all(10),
                                        //     child: Row(
                                        //       mainAxisAlignment: MainAxisAlignment.start,
                                        //       children: [
                                        //         Padding(
                                        //           padding: EdgeInsets.only(
                                        //               right: size.width * 0.05),
                                        //           child: Container(
                                        //             decoration: BoxDecoration(
                                        //               shape: BoxShape.circle,
                                        //               color: AppColors.white,
                                        //               border: Border.all(
                                        //                 color: AppColors.primary,
                                        //                 width: 1.0,
                                        //               ),
                                        //             ),
                                        //             child: CircleAvatar(
                                        //               backgroundColor: AppColors.white,
                                        //               radius: scalingFactor * 22,
                                        //               child: Icon(
                                        //                 Icons.credit_card,
                                        //                 size: scalingFactor * 22,
                                        //                 color: AppColors.primary,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         Expanded(
                                        //           child: Column(
                                        //             crossAxisAlignment:
                                        //                 CrossAxisAlignment.start,
                                        //             children: [
                                        //               Row(
                                        //                 mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .spaceBetween,
                                        //                 children: [
                                        //                   Text(
                                        //                     'Credit Card',
                                        //                     style: TextStyle(
                                        //                       color: AppColors.primary,
                                        //                       fontFamily: "Helvetica",
                                        //                       fontWeight: FontWeight.w400,
                                        //                       fontSize:
                                        //                           SizeUtil.body(context),
                                        //                     ),
                                        //                   ),
                                        //                   SizedBox(
                                        //                     width: 10,
                                        //                   ),
                                        //                   RichText(
                                        //                     textAlign: TextAlign.start,
                                        //                     text: TextSpan(
                                        //                       children: [
                                        //                         TextSpan(
                                        //                           text: '₹',
                                        //                           style: TextStyle(
                                        //                             letterSpacing: 2,
                                        //                             fontFamily:
                                        //                                 'NotoSans',
                                        //                             color: AppTextColors
                                        //                                 .primary,
                                        //                             fontSize:
                                        //                                 SizeUtil.body(
                                        //                                     context),
                                        //                             fontWeight:
                                        //                                 FontWeight.w400,
                                        //                           ),
                                        //                         ),
                                        //                         TextSpan(
                                        //                           text: "2,04,250",
                                        //                           style: TextStyle(
                                        //                             fontFamily: "Helvetica",
                                        //                             color: AppTextColors
                                        //                                 .primary,
                                        //                             fontSize:
                                        //                                 SizeUtil.body(
                                        //                                     context),
                                        //                             fontWeight:
                                        //                                 FontWeight.w400,
                                        //                           ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //               SizedBox(
                                        //                 height: 5,
                                        //               ),
                                        //               Row(
                                        //                 mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .spaceBetween,
                                        //                 children: [
                                        //                   Flexible(
                                        //                     flex: 6,
                                        //                     child: Container(
                                        //                       child: ClipRRect(
                                        //                         borderRadius:
                                        //                             BorderRadius.circular(
                                        //                                 10),
                                        //                         child:
                                        //                             LinearProgressIndicator(
                                        //                           value: 0.018,
                                        //                           backgroundColor:
                                        //                               Colors.grey[300],
                                        //                           valueColor:
                                        //                               AlwaysStoppedAnimation<
                                        //                                       Color>(
                                        //                                   Colors.red),
                                        //                           minHeight: 6,
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   SizedBox(
                                        //                     width: 5,
                                        //                   ),
                                        //                   Flexible(
                                        //                     flex: 2,
                                        //                     child: Text(
                                        //                       '1.8%',
                                        //                       style: TextStyle(
                                        //                         color: AppTextColors.grey,
                                        //                         fontFamily: "Helvetica",
                                        //                         fontWeight:
                                        //                             FontWeight.w400,
                                        //                         fontSize: SizeUtil.body(
                                        //                             context),
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: SizeUtil.verticalSpacingMedium(context),
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              )));
  }
}
