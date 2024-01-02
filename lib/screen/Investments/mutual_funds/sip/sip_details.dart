// ignore_for_file: use_build_context_synchronously

import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/Widgets/buttons/small_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_details.dart';
import 'package:flutter/material.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_sip.dart';
import 'package:midas/widgets/confirmation_dialog_box.dart';
import 'package:get/get.dart';
import 'package:midas/widgets/pause_sip_dialog_box.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'mutual_funds_sip.dart';

class SIPDetailsScreen extends StatefulWidget {
  final String amfiCode;
  final String isinNumber;
  final String sipId;
  final double currentValue;
  const SIPDetailsScreen(
      {super.key,
      required this.amfiCode,
      required this.isinNumber,
      required this.sipId,
      required this.currentValue});

  @override
  State<SIPDetailsScreen> createState() => _SIPDetailsScreenState();
}

class _SIPDetailsScreenState extends State<SIPDetailsScreen> {
  var height;
  var width;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  GlobalKey<FormState> pauseSIPFormKey = GlobalKey<FormState>();

  bool isRedeemAllUnits = false;
  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());
  String selectedTimeline = '20';
  @override
  void initState() {
    super.initState();
    // updateDateLabels();
    if (widget.amfiCode.isNotEmpty) {
      mutualFundsController.getMutualFundSchemeDetailsByAmfiCode(
          widget.amfiCode, selectedTimeline, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               LargeAppbar(
                  heading: "Current Value",
                  isAmount: true,
                  isbackButtonAvailable: true,
                  content: widget.currentValue.toStringAsFixed(0),   
                  timeline: "Last Updated: ${mutualFundsController.schedularLastUpdatedDate} | ${mutualFundsController.schedularLastUpdatedTime}"),
              SizedBox(
                height: SizeUtil.verticalSpacingMedium(context),
              ),
              Expanded(
                child: mutualFundsController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: EdgeInsets.only(
                            left: height * 0.02, right: height * 0.02),
                        child: SingleChildScrollView(
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
                                              isinNumber: "",
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
                                    padding: EdgeInsets.all(
                                        SizeUtil.verticalSpacingSmall(context)),
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
                                                  size: SizeUtil.iconsSize(
                                                      context)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                                text: (mutualFundsController
                                                    .currentNav
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
                                          'Minimum Investment',
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
                                              if (mutualFundsController
                                                  .minimumInvestment.isNotEmpty)
                                                TextSpan(
                                                  text: '₹',
                                                  style: TextStyle(
                                                      letterSpacing: 2,
                                                      color: AppColors.grey,
                                                      fontSize: SizeUtil.body(
                                                          context)),
                                                ),
                                              TextSpan(
                                                text: mutualFundsController
                                                        .minimumInvestment
                                                        .isEmpty
                                                    ? "-"
                                                    : mutualFundsController
                                                        .minimumInvestment
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
                                          'Investment Multiple',
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
                                                text: "1.0",
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
                            ],
                          ),
                        ),
                      ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.10,
                        left: width * 0.10,
                        bottom: SizeUtil.buttonPaddingBottom(context)),
                    child: Container(
                      color: AppColors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LargeButton(
                              text: "Modify",
                              backgroundColor: AppColors.primary,
                              textColor: AppColors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MutualFundSchemeSIP(
                                          isUpdate: true,
                                          amfiCode: widget.amfiCode.toString(),
                                          isinNumber:
                                              widget.isinNumber.toString(),
                                          folioNumber: "",
                                          sipid: widget.sipId.toString())),
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmallButton(
                            text: "Pause",
                            onPressed: () {
                              confirmPauseSIP();
                            },
                            backgroundColor: AppColors.white,
                            textColor: AppColors.primary),
                        SmallButton(
                            text: "Delete",
                            onPressed: () {
                              confirmDeleteSIP(context);
                            },
                            backgroundColor: AppColors.white,
                            textColor: AppColors.primary),
                      ]),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> confirmPauseSIP() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PauseSIPDialogBox(
            onConfirm: () async {
              if (pauseSIPFormKey.currentState!.validate()) {
                Navigator.of(context).pop();
                bool response = await mutualFundsController.pauseSip(
                    widget.sipId.toString(),
                    startDateController.text.toString(),
                    endDateController.text.toString(),
                    this.context);
                if (response) {
                  startDateController.clear();
                  endDateController.clear();
                  Navigator.maybePop(
                    this.context,
                    MaterialPageRoute(
                        builder: (context) => const MutualFundsOrdersSIP()),
                  ).then((value) =>
                      mutualFundsController.getSIPDetails(context, 1));
                }
              }
            },
            endDateController: endDateController,
            startDateController: startDateController,
            formKey: pauseSIPFormKey,
            heading: "Confirm Pause",
            body: "please select start and end date to pause an sip",
            message: "");
      },
    );
  }

  Future<void> confirmDeleteSIP(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialogBox(
            onConfirm: () async {
              bool response = await mutualFundsController.cancelSip(
                  widget.sipId.toString(), this.context);
              if (response) {
                await Navigator.maybePop(
                  this.context,
                  MaterialPageRoute(
                      builder: (context) => const MutualFundsOrdersSIP()),
                ).then(
                    (value) => mutualFundsController.getSIPDetails(context, 1));
              }
            },
            heading: "Confirm Delete",
            body: "Do you confirm to delete the SIP ?",
            message: "");
      },
    );
  }
}
