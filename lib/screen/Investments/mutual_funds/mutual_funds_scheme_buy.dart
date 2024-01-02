// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:midas/controller/sms/sms_controller.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:midas/widgets/confirmation_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midas/widgets/otp_verification.dart';

class MutualFundSchemeBuy extends StatefulWidget {
  final String amfiCode;
  final String isinNumber;
  const MutualFundSchemeBuy(
      {super.key, required this.amfiCode, required this.isinNumber});

  @override
  State<MutualFundSchemeBuy> createState() => _MutualFundSchemeBuyState();
}

class _MutualFundSchemeBuyState extends State<MutualFundSchemeBuy> {
  var height;
  var width;

  String selectedPaymentMode = "UPI";

  Map<int,String> paymentMethods= {
    0:"UPI",
    1:"NETBANKING"
  };
  GlobalKey<FormState> mutualFundBuyFormKey = GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();
  FocusNode amountFocusNode = FocusNode();

  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());
  SmsController smsController = Get.put(SmsController());

  @override
  void initState() {
    super.initState();
    // mutualFundsController.initUniLinks();
    mutualFundsController.getMutualFundSchemeDetailsByAmfiCode(
        widget.amfiCode, "1", context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mutualFundsController.sub?.cancel();
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
                  heading: "",
                  isAmount: false,
                  isbackButtonAvailable: true,
                  content: "UTI AMC",
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
                                              if (mutualFundsController
                                                  .currentNav.isNotEmpty)
                                                TextSpan(
                                                  text: '₹',
                                                  style: TextStyle(
                                                      letterSpacing: 2,
                                                      color: AppColors.grey,
                                                      fontSize: SizeUtil.body(
                                                          context)),
                                                ),
                                              TextSpan(
                                                text: (mutualFundsController
                                                        .currentNav.isEmpty
                                                    ? "-"
                                                    : mutualFundsController
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
                                              if (mutualFundsController
                                                  .investmentMultiple
                                                  .isNotEmpty)
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
                                                        .investmentMultiple
                                                        .isEmpty
                                                    ? "-"
                                                    : mutualFundsController
                                                        .investmentMultiple
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
                              SizedBox(
                                height: SizeUtil.verticalSpacingMedium(context),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Expanded(
                                  //   flex: 6,
                                  //   child: Column(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.start,
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         'Expense Ratio',
                                  //         style: TextStyle(
                                  //             color: AppColors.primary,
                                  //             fontSize:
                                  //                 SizeUtil.bodyLarge(context),
                                  //             fontFamily: "Helvetica"),
                                  //       ),
                                  //       const SizedBox(
                                  //         height:
                                  //             DefaultSizes.spacingBetweenTexts,
                                  //       ),
                                  //       Text(
                                  //         '1.25%',
                                  //         style: TextStyle(
                                  //             color: AppColors.grey,
                                  //             fontSize: SizeUtil.body(context),
                                  //             fontFamily: "Helvetica"),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // const Spacer(),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Lock-in-period',
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
                                          mutualFundsController
                                                  .lockInPeriod.isEmpty
                                              ? "NA"
                                              : mutualFundsController
                                                  .lockInPeriod
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payment Mode',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: SizeUtil.bodyLarge(context),
                                        fontFamily: "Helvetica"),
                                  ),
                                  const SizedBox(
                                    height: DefaultSizes.spacingBetweenTexts,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Radio(
                                              activeColor: AppColors.primary,
                                              value: "UPI",
                                              groupValue: selectedPaymentMode,
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: VisualDensity
                                                          .minimumDensity,
                                                      vertical: VisualDensity
                                                          .minimumDensity),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedPaymentMode = value!;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "UPI",
                                                style: TextStyle(
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          children: [
                                            Radio(
                                              activeColor: AppColors.primary,
                                              value: "NETBANKING",
                                              groupValue: selectedPaymentMode,
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: VisualDensity
                                                          .minimumDensity,
                                                      vertical: VisualDensity
                                                          .minimumDensity),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedPaymentMode = value!;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Net Banking",
                                                style: TextStyle(
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeUtil.verticalSpacingMedium(context),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Investment Amount',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: SizeUtil.bodyLarge(context),
                                        fontFamily: "Helvetica"),
                                  ),
                                  const SizedBox(
                                    height: DefaultSizes.spacingBetweenTexts,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 40),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: width * 0.12,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: width * 0.04,
                                                  vertical: SizeUtil
                                                      .verticalSpacingMedium(
                                                          context),
                                                ),
                                                counterText: "",
                                                filled: true,
                                                isDense: true,
                                                hintText: '₹',
                                                hintStyle: TextStyle(
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.scallingFactor(
                                                                context) *
                                                            24),
                                                border: InputBorder.none,
                                                fillColor:
                                                    TextfieldColors.background,
                                              ),
                                              style: TextStyle(
                                                  fontSize:
                                                      SizeUtil.scallingFactor(
                                                              context) *
                                                          24,
                                                  color: AppColors.grey),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 14,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: TextFormField(
                                              controller: amountController,
                                              focusNode: amountFocusNode,
                                              maxLength: 15,
                                              keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                  signed: true, decimal: true),
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal:
                                                            width * 0.04,
                                                        vertical: SizeUtil
                                                            .verticalSpacingMedium(
                                                                context)),
                                                counterText: "",
                                                suffixIconConstraints:
                                                    const BoxConstraints(),
                                                filled: true,
                                                isDense: true,
                                                border: InputBorder.none,
                                                hintText: '1,000',
                                                hintStyle: TextStyle(
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.scallingFactor(
                                                                context) *
                                                            24),
                                                fillColor:
                                                    TextfieldColors.background,
                                              ),
                                              style: TextStyle(
                                                  fontSize:
                                                      SizeUtil.scallingFactor(
                                                              context) *
                                                          24),
                                            ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline,
                                      size: SizeUtil.iconsSize(context)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "NAV allotment is based on the day funds are realised at the clearing corporation",
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
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
                          text: "Buy",
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                          onPressed: () {
                            if (amountController.text.isNotEmpty) {
                              if (mutualFundsController
                                  .minimumInvestment.value.isNotEmpty) {
                                if (double.parse(mutualFundsController
                                        .minimumInvestment.value) >
                                    double.parse(
                                        amountController.text.toString())) {
                                  showErrorAlert(
                                      "please enter amount grater than minimum investment amount");
                                } else {
                                  print(widget.isinNumber);
                                  confirmBuy(
                                      mutualFundsController.schemeName
                                          .toString(),
                                      double.parse(
                                          amountController.text.toString()),
                                      widget.isinNumber);
                                }
                              } else {
                                print(widget.isinNumber);
                                confirmBuy(
                                    mutualFundsController.schemeName.toString(),
                                    double.parse(
                                        amountController.text.toString()),
                                    widget.isinNumber);
                              }
                            } else {
                              showErrorAlert("please enter valid amount");
                            }
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> confirmBuy(String schemeName, double amount, String isinNumber) async {
    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return ConfirmDialogBox(
            onConfirm: () async {
              bool isSuccess = 
                  await mutualFundsController.requestMutualFundPurchaseOrder(
                      isinNumber, "", amount, this.context);
              if (isSuccess) {
                showDialog(
                  barrierDismissible: false,
                  context: this.context,
                  builder: (BuildContext context) {
                    return OtpVerification(
                      mobileNumber: mutualFundsController.userMobileNumber.toString(),
                      onConfirm: () async {
                        String otp = smsController.otpController.text;
                        if (otp.length == 6) {
                          smsController.otpController.clear();
                          await mutualFundsController
                              .confirmMutualFundPurchaseOrderAndMakePayment(
                                  mutualFundsController.mfPurchaseId.toString(),
                                  otp,
                                  mutualFundsController.userMobileNumber
                                      .toString(),
                                      selectedPaymentMode,
                                  this.context);
                        } else {
                          showErrorAlert("please enter valid otp");
                        }
                      },
                    );
                  },
                );
              }
            },
            heading: "Confirm Order",
            body: "Invest Rs.$amount in $schemeName",
            message: "Orders cannot be cancelled after they are placed");
      },
    );
  }
}
