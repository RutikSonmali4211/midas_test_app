import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:midas/model/investments/mutual__funds/holding_reports/mutual_fund_holding_reports_model.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_details.dart';
import 'package:flutter/material.dart';

class MutualFundsPortfolio extends StatefulWidget {
  const MutualFundsPortfolio({super.key});

  @override
  State<MutualFundsPortfolio> createState() => _MutualFundsPortfolioState();
}

class _MutualFundsPortfolioState extends State<MutualFundsPortfolio> {
  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());

  // ScrollController scrollControllerForHoldingReports = ScrollController();
  // int pageforAllAmcs = 1;

  @override
  void initState() {
    super.initState();
    mutualFundsController.getSchedularlastUpdatedDate(context);
    mutualFundsController.getMutualFundsPortfolioDetails(context);
    mutualFundsController.getMutualFundsHoldingReports(context);
    if (mutualFundsController.mutualFundAmcSearchFocusNode.hasFocus) {
      mutualFundsController.mutualFundAmcSearchFocusNode.unfocus();
      mutualFundsController.update();
    }
  }

  // Future<void> scrollMoreMutalFundHoldingReports() async {
  //   if (mutualFundsController.isLoadingMoreAllAmc.value ||
  //       mutualFundsController.noMoreDataLoadAllAmc.value) return;
  //   if (scrollControllerForHoldingReports.position.pixels ==
  //       scrollControllerForHoldingReports.position.maxScrollExtent) {
  //     setState(() {
  //       mutualFundsController.isLoadingMoreAllAmc.value = true;
  //     });
  //     pageforAllAmcs = pageforAllAmcs + 1;
  //     await mutualFundsController
  //         .getAllAmcWatchList(
  //             _selectedFilter,
  //             mutualFundsController.mutualFundAmcSearchController.text
  //                 .toString(),
  //             context,
  //             pageforAllAmcs)
  //         .then((value) {
  //       setState(() {
  //         mutualFundsController.isLoadingMoreAllAmc.value = false;
  //       });
  //     });
  //   }
  //   mutualFundsController.update();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: Obx(() => mutualFundsController.isLoadingPortfolio.value ||
                  mutualFundsController.isLoadingHoldingReports.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(
                                SizeUtil.verticalSpacingSmall(context)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Investment',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Helvetica",
                                          ),
                                        ),
                                        SizedBox(
                                          height: SizeUtil.verticalSpacingSmall(
                                              context),
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
                                                    color: AppColors.primary,
                                                    fontSize:
                                                        SizeUtil.headingMedium(
                                                            context),
                                                  )),
                                              TextSpan(
                                                text: ConstantUtil.formatAmount(
                                                    mutualFundsController
                                                        .investedValue
                                                        .toDouble()),
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize:
                                                        SizeUtil.headingMedium(
                                                            context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Current Value',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Helvetica",
                                          ),
                                        ),
                                        SizedBox(
                                          height: SizeUtil.verticalSpacingSmall(
                                              context),
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
                                                    color: AppColors.primary,
                                                    fontSize:
                                                        SizeUtil.headingMedium(
                                                            context),
                                                  )),
                                              TextSpan(
                                                text: ConstantUtil.formatAmount(
                                                    mutualFundsController
                                                        .currentValue
                                                        .toDouble()),
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize:
                                                      SizeUtil.headingMedium(
                                                          context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      SizeUtil.verticalSpacingSmall(context),
                                ),
                                const Divider(
                                  color: AppColors.lightgrey,
                                  thickness: 1.0,
                                  height: 10,
                                ),
                                SizedBox(
                                  height:
                                      SizeUtil.verticalSpacingSmall(context),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'P&L',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Helvetica"),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
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
                                                    color: mutualFundsController
                                                                .profitAndLoss
                                                                .toInt() >=
                                                            0
                                                        ? AppColors.green
                                                        : AppColors.red,
                                                    fontSize:
                                                        SizeUtil.headingMedium(
                                                            context),
                                                  )),
                                              TextSpan(
                                                text: ConstantUtil.formatAmount(
                                                    mutualFundsController
                                                        .profitAndLoss
                                                        .toDouble()),
                                                style: TextStyle(
                                                  color: mutualFundsController
                                                              .profitAndLoss
                                                              .toInt() >=
                                                          0
                                                      ? AppColors.green
                                                      : AppColors.red,
                                                  fontSize:
                                                      SizeUtil.headingMedium(
                                                          context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        ),
                                        Material(
                                          borderRadius: BorderRadius.circular(
                                              SizeUtil.scallingFactor(context) *
                                                  10),
                                          elevation: 2,
                                          shadowColor: AppColors.black,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeUtil.scallingFactor(
                                                              context) *
                                                          10),
                                              color: AppColors.lightgreen,
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        SizeUtil.scallingFactor(
                                                                context) *
                                                            20,
                                                    vertical: 3),
                                                child: Text(
                                                  "${mutualFundsController.growthPercentageOnPortfolio} %",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: mutualFundsController
                                                                .growthPercentageOnPortfolio
                                                                .value >=
                                                            0
                                                        ? AppColors.green
                                                        : AppColors.red,
                                                    fontSize:
                                                        SizeUtil.bodySmall(
                                                            context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeUtil.verticalSpacingMedium(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Mutual Funds",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: SizeUtil.headingMedium(context),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Helvetica",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeUtil.verticalSpacingSmall(context),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: mutualFundsController
                              .mutualFundHoldingReportsList.length,
                          itemBuilder: (context, index) {
                            MutualFundHoldingReportsModel mutualFundData =
                                mutualFundsController
                                    .mutualFundHoldingReportsList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MutualFundDetails(
                                          amfiCode: mutualFundData.schemes![0].masterData!.amfiCode!.toString(),
                                          isinNumber: mutualFundData.schemes![0].isin.toString(),
                                          folioNumber: mutualFundData.folioNumber.toString(),
                                          averageNav:  double.parse(mutualFundData.schemes![0].avgNavValue.toString()),
                                          currentNav:  double.parse(mutualFundData.schemes![0].nav!.value.toString()),
                                          units: mutualFundData.schemes![0].holdings!.units!,
                                          investedValue: mutualFundData
                                              .schemes![0]
                                              .investedValue!
                                              .amount!
                                              .toString(),
                                          currentValue: mutualFundData
                                              .schemes![0].marketValue!.amount!
                                              .toString(),
                                          profitAndloss: ConstantUtil
                                              .getDifferenceInCurrentValueAndInvestedValueOnPortfolio(
                                                  mutualFundData.schemes![0]
                                                      .marketValue!.amount!.toDouble(),
                                                  mutualFundData.schemes![0]
                                                      .investedValue!.amount!.toDouble()),
                                          growthPercentage: double.parse(
                                              mutualFundData
                                                  .schemes![0].growthPercentage
                                                  .toString()))),
                                );
                              },
                              child: Container(
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
                                    color: AppColors.lightgrey,
                                    width: 2.0,
                                  ),
                                  color: AppColors.white,
                                ),
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                  bottom:
                                      SizeUtil.verticalSpacingSmall(context),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      SizeUtil.verticalSpacingSmall(context)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Units ${mutualFundData.schemes![0].holdings!.units!.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica",
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '|',
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica",
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Avg. NAV ${mutualFundData.schemes![0].avgNavValue.toString()}',
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica",
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'NAV. ${mutualFundData.schemes![0].nav!.value!.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: SizeUtil.verticalSpacingSmall(
                                            context),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Text(
                                              mutualFundData.schemes![0].name!
                                                  .toString(),
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                letterSpacing: 0.2,
                                                fontSize:
                                                    SizeUtil.bodyLarge(context),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Helvetica",
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  (ConstantUtil.getDifferenceInCurrentValueAndInvestedValueOnPortfolio(
                                                              mutualFundData
                                                                  .schemes![0]
                                                                  .marketValue!
                                                                  .amount!.toDouble(),
                                                              mutualFundData
                                                                  .schemes![0]
                                                                  .investedValue!
                                                                  .amount!.toDouble()) >=
                                                          0
                                                      ? "+${ConstantUtil.getDifferenceInCurrentValueAndInvestedValueOnPortfolio(mutualFundData.schemes![0].marketValue!.amount!.toDouble(), mutualFundData.schemes![0].investedValue!.amount!.toDouble()).toStringAsFixed(2)}"
                                                      : ConstantUtil.getDifferenceInCurrentValueAndInvestedValueOnPortfolio(
                                                              mutualFundData
                                                                  .schemes![0]
                                                                  .marketValue!
                                                                  .amount!.toDouble(),
                                                              mutualFundData
                                                                  .schemes![0]
                                                                  .investedValue!
                                                                  .amount!.toDouble())
                                                          .toStringAsFixed(2)),
                                                  style: TextStyle(
                                                      color: ConstantUtil.getDifferenceInCurrentValueAndInvestedValueOnPortfolio(
                                                                  mutualFundData
                                                                      .schemes![
                                                                          0]
                                                                      .marketValue!
                                                                      .amount!.toDouble(),
                                                                  mutualFundData
                                                                      .schemes![
                                                                          0]
                                                                      .investedValue!
                                                                      .amount!.toDouble()) >=
                                                              0
                                                          ? AppColors.green
                                                          : AppColors.red,
                                                      fontSize:
                                                          SizeUtil.bodyLarge(
                                                              context),
                                                      fontFamily: "Helvetica"),
                                                ),
                                                const SizedBox(
                                                  height: DefaultSizes
                                                      .spacingBetweenTexts,
                                                ),
                                                Text(
                                                  (double.parse(mutualFundData
                                                              .schemes![0]
                                                              .growthPercentage
                                                              .toString()) >=
                                                          0
                                                      ? "+${double.parse(mutualFundData.schemes![0].growthPercentage.toString())}"
                                                      : "${double.parse(mutualFundData.schemes![0].growthPercentage.toString())}"),
                                                  style: TextStyle(
                                                      color: double.parse(mutualFundData
                                                                  .schemes![0]
                                                                  .growthPercentage
                                                                  .toString()) >=
                                                              0
                                                          ? AppColors.green
                                                          : AppColors.red,
                                                      fontSize:
                                                          SizeUtil.bodySmall(
                                                              context),
                                                      fontFamily: "Helvetica"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: SizeUtil.verticalSpacingSmall(
                                            context),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Invested: ${mutualFundData.schemes![0].investedValue!.amount!.toString()}',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          ),
                                          Text(
                                            'Value: ${mutualFundData.schemes![0].marketValue!.amount!.toString()}',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )),
        ),
      ],
    );
  }
}
