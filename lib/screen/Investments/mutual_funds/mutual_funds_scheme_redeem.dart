// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:midas/controller/sms/sms_controller.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:midas/widgets/confirmation_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midas/widgets/otp_verification.dart';

class MutualFundSchemeRedeem extends StatefulWidget {
  final String amfiCode;
  final String isinNumber;
  final String folioNumber;
  final double units;
  final double currentNav;
  const MutualFundSchemeRedeem(
      {super.key,
      required this.amfiCode,
      required this.isinNumber,
      required this.folioNumber,
      required this.units,
      required this.currentNav});

  @override
  State<MutualFundSchemeRedeem> createState() => _MutualFundSchemeRedeemState();
}

class _MutualFundSchemeRedeemState extends State<MutualFundSchemeRedeem> {
  var height;
  var width;

  bool isRedeemAllUnits = false;
  bool isRedeemAmountIsReadOnly = false;
  double singleUnitPrice = 0.0;
  double redemableUnits = 0.0;

  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());
  SmsController smsController = Get.put(SmsController());

  TextEditingController redeemAmountController = TextEditingController();
  FocusNode redeemAmountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    mutualFundsController.getMutualFundSchemeDetailsByAmfiCode(
        widget.amfiCode, "1", context);
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
                  timeline:
                      "Last Updated: ${mutualFundsController.schedularLastUpdatedDate} | ${mutualFundsController.schedularLastUpdatedTime}"),
              SizedBox(
                height: SizeUtil.verticalSpacingMedium(context),
              ),
              Expanded(
                child: mutualFundsController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.04, right: width * 0.04),
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
                                          'Redemption Multiple',
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
                                                text: "",
                                                style: TextStyle(
                                                    letterSpacing: 2,
                                                    color: AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.body(context)),
                                              ),
                                              TextSpan(
                                                text: "-",
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
                                          widget.units.toStringAsFixed(3),
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
                                          'Approx. Value',
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
                                                text: (widget.units *
                                                        widget.currentNav)
                                                    .toStringAsFixed(3),
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Redemption Amount',
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
                                              controller:
                                                  redeemAmountController,
                                              focusNode: redeemAmountFocusNode,
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  singleUnitPrice = ((widget
                                                              .units *
                                                          widget.currentNav) /
                                                      widget.units);
                                                  redemableUnits =
                                                      double.parse(value) /
                                                          singleUnitPrice;
                                                  print(redemableUnits);
                                                }
                                              },
                                              readOnly:
                                                  isRedeemAmountIsReadOnly,
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
                                children: [
                                  Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor: AppColors.primary,
                                    ),
                                    child: Transform.scale(
                                      scale: 1,
                                      child: Checkbox(
                                        activeColor: AppColors.primary,
                                        value: isRedeemAllUnits,
                                        visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity,
                                        ),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (value) {
                                          isRedeemAllUnits = value ?? false;
                                          if (value!) {
                                            setState(() {
                                              isRedeemAmountIsReadOnly = true;
                                              singleUnitPrice = ((widget.units *
                                                      widget.currentNav) /
                                                  widget.units);
                                              print(singleUnitPrice);
                                              redeemAmountController.clear();
                                              redeemAmountController.text =
                                                  (widget.units *
                                                          widget.currentNav)
                                                      .toStringAsFixed(3);
                                            });
                                          } else {
                                            setState(() {
                                              isRedeemAmountIsReadOnly = false;
                                              redeemAmountController.clear();
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Redeem all units',
                                    style: TextStyle(
                                        fontSize: SizeUtil.bodyLarge(context),
                                        color: AppColors.primary,
                                        fontFamily: "Helvetica"),
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
                                      size: height * 0.04),
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
                          text: "Redeem",
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                          onPressed: () {
                            print(widget.folioNumber);
                            if (redeemAmountController.text.isNotEmpty) {
                              if (double.parse(redeemAmountController.text) <=
                                  double.parse(
                                      (widget.units * widget.currentNav)
                                          .toStringAsFixed(3))) {
                                confirmRedeem(
                                    mutualFundsController.schemeName.toString(),
                                    widget.folioNumber.toString(),
                                    double.parse(redeemAmountController.text),
                                    redemableUnits,
                                    context);
                                print("success");
                              } else {
                                showErrorAlert(
                                    "redeem amount is not grater than approx value");
                              }
                            } else {
                              showErrorAlert(
                                  "please enter valid redeem amount");
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

  Future<void> confirmRedeem(String schemeName, String folioNumber,
      double amount, double units, BuildContext context) async {
    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return ConfirmDialogBox(
            onConfirm: () async {
              bool isSuccess =
                  await mutualFundsController.requestMutualFundRedeemOrder(
                      widget.folioNumber, amount, units, this.context);
              if (isSuccess) {
                showDialog(
                  barrierDismissible: false,
                  context: this.context,
                  builder: (BuildContext context) {
                    return OtpVerification(
                      mobileNumber:
                          mutualFundsController.userMobileNumber.toString(),
                      onConfirm: () async {
                        String otp = smsController.otpController.text;
                        if (otp.length == 6) {
                          smsController.otpController.clear();
                          bool isSuccess = await mutualFundsController
                              .confirmMutualFundRedeemOrder(
                                  mutualFundsController.mfRedeemId.toString(),
                                  otp,
                                  this.context);

                          if (isSuccess) {
                            Navigator.of(this.context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MutualFundsScreen()));
                          }
                        } else {
                          showErrorAlert("please enter valid otp");
                        }
                      },
                    );
                  },
                );
              }
            },
            heading: "Confirm Redemption",
            body: "Redeem Rs. $amount in $schemeName",
            message: "Redemption cannot be cancelled after they are placed");
      },
    );
  }
}
