import 'package:get/get.dart';
import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/Widgets/buttons/small_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_buy.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_details.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_redeem.dart';
import 'package:flutter/material.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_sip.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_transaction.dart';

class MutualFundDetails extends StatefulWidget {
  final String amfiCode;
  final String isinNumber;
  final String folioNumber;
  final double units;
  final double currentNav;
  final double averageNav;
  final String investedValue;
  final String currentValue;
  final double profitAndloss;
  final double growthPercentage;
  const MutualFundDetails(
      {super.key,
      required this.amfiCode,
      required this.isinNumber,
      required this.folioNumber,
      required this.units,
      required this.currentNav,
      required this.averageNav,
      required this.investedValue,
      required this.currentValue,
      required this.profitAndloss,
      required this.growthPercentage});

  @override
  State<MutualFundDetails> createState() => _MutualFundDetailsState();
}

class _MutualFundDetailsState extends State<MutualFundDetails> {
  var height;
  var width;

  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());

  @override
  void initState() {
    super.initState();
    if (widget.amfiCode.isNotEmpty) {
      mutualFundsController.getMutualFundSchemeDetailsByAmfiCode(
          widget.amfiCode, "1", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
      body: Obx(
        () => mutualFundsController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LargeAppbar(
                      heading: "Current Value",
                      isAmount: true,
                      isbackButtonAvailable: true,
                      content: ConstantUtil.formatAmount(
                          double.parse(widget.currentValue)),
                      timeline: "Last Updated: ${mutualFundsController.schedularLastUpdatedDate} | ${mutualFundsController.schedularLastUpdatedTime}"),
                  SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.04,
                        right: width * 0.04,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: height * 0.22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MutualFundSchemeDetails(
                                              amfiCode:
                                                  widget.amfiCode.toString(),
                                              isinNumber:
                                                  widget.isinNumber.toString(),
                                                  folioNumber: "",
                                            )),
                                  );
                                },
                                child: Container(
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
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color:
                                          AppColors.lightgrey, // Border color
                                      width: 2.0, // Border width
                                    ),
                                    color: AppColors.white,
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Scheme Details",
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize:
                                                SizeUtil.headingMedium(context),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Helvetica",
                                          ),
                                        ),
                                        const SizedBox(
                                          height:
                                              DefaultSizes.spacingBetweenTexts,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              mutualFundsController.schemeName
                                                  .toString(),
                                              style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(
                                                Icons.arrow_right_alt_sharp,
                                                size:
                                                    SizeUtil.iconsSize(context),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      SizeUtil.verticalSpacingMedium(context)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Scheme',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize:
                                                  SizeUtil.bodyLarge(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                        const SizedBox(
                                          height:
                                              DefaultSizes.spacingBetweenTexts,
                                        ),
                                        Text(
                                          mutualFundsController.schemeName
                                              .toString(),
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Type',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize:
                                                  SizeUtil.bodyLarge(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                        const SizedBox(
                                          height:
                                              DefaultSizes.spacingBetweenTexts,
                                        ),
                                        Text(
                                          mutualFundsController.schemeType
                                              .toString(),
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeUtil.verticalSpacingMedium(context),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Category',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize:
                                                  SizeUtil.bodyLarge(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                        const SizedBox(
                                          height:
                                              DefaultSizes.spacingBetweenTexts,
                                        ),
                                        Text(
                                          mutualFundsController.schemeCategory
                                              .toString(),
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Current NAV',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize:
                                                  SizeUtil.bodyLarge(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                        const SizedBox(
                                          height:
                                              DefaultSizes.spacingBetweenTexts,
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
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.body(context)),
                                              ),
                                              TextSpan(
                                                text: (widget.currentNav
                                                    .toString()),
                                                style: TextStyle(
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeUtil.verticalSpacingMedium(context),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Investment',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize:
                                                  SizeUtil.bodyLarge(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                        const SizedBox(
                                          height:
                                              DefaultSizes.spacingBetweenTexts,
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
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.body(context)),
                                              ),
                                              TextSpan(
                                                text: widget.investedValue,
                                                style: TextStyle(
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'P&L',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize:
                                                  SizeUtil.bodyLarge(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                        const SizedBox(
                                          height:
                                              DefaultSizes.spacingBetweenTexts,
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
                                                    color:  widget.profitAndloss >=
                                                                0
                                                            ? AppColors.green
                                                            : AppColors.red,
                                                    fontSize:
                                                        SizeUtil.body(context)),
                                              ),
                                              TextSpan(
                                                text: widget.profitAndloss
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                    color:
                                                        widget.profitAndloss >=
                                                                0
                                                            ? AppColors.green
                                                            : AppColors.red,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                              TextSpan(
                                                text: widget.growthPercentage >=
                                                        0
                                                    ? " (+${widget.growthPercentage.toStringAsFixed(2)} %)"
                                                    : " (${widget.growthPercentage.toStringAsFixed(2)} %)",
                                                style: TextStyle(
                                                    color:
                                                        widget.growthPercentage >=
                                                                0
                                                            ? AppColors.green
                                                            : AppColors.red,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeUtil.verticalSpacingMedium(context),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Units',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize:
                                                  SizeUtil.bodyLarge(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                        const SizedBox(
                                          height:
                                              DefaultSizes.spacingBetweenTexts,
                                        ),
                                        Text(
                                          widget.units.toStringAsFixed(2),
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Average NAV',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize:
                                                  SizeUtil.bodyLarge(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                        const SizedBox(
                                          height:
                                              DefaultSizes.spacingBetweenTexts,
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
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.body(context)),
                                              ),
                                              TextSpan(
                                                text: widget.averageNav
                                                    .toString(),
                                                style: TextStyle(
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmallButton(
                  text: "Buy",
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MutualFundSchemeBuy(
                                amfiCode: widget.amfiCode.toString(),
                                isinNumber: widget.isinNumber.toString(),
                              )),
                    );
                  }),
              SmallButton(
                  text: "Redeem",
                  backgroundColor: AppColors.white,
                  textColor: AppColors.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MutualFundSchemeRedeem(
                                amfiCode: widget.amfiCode.toString(),
                                isinNumber: widget.isinNumber.toString(),
                                folioNumber: widget.folioNumber.toString(),
                                units: widget.units,
                                currentNav: widget.currentNav,
                              )),
                    );
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmallButton(
                  text: "SIP",
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MutualFundSchemeSIP(
                                isUpdate: false,
                                amfiCode: widget.amfiCode,
                                isinNumber: widget.isinNumber,
                                folioNumber: widget.folioNumber,
                                sipid: "",
                              )),
                    );
                  }),
              SmallButton(
                  text: "Transactions",
                  backgroundColor: AppColors.white,
                  textColor: AppColors.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MutualFundTransactionScreen(
                                isSeeSingleTransaction: true,
                                isinNumber: widget.isinNumber,
                              )),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
