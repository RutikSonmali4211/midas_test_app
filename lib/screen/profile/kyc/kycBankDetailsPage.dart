import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:midas/controller/kyc/kyc_controller.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/widgets/alert_message/warning_message.dart';

import '../../../Widgets/appbar/small_appbar.dart';
import '../../../Widgets/buttons/small_button.dart';
import 'kyc_submitted.dart';

class KycBankDetailsPage extends StatefulWidget {
  const KycBankDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KycBankDetailsPageState createState() => _KycBankDetailsPageState();
}

class _KycBankDetailsPageState extends State<KycBankDetailsPage> {
  var height;
  var width;
  TextEditingController bankAccountHolderNameController =
      TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();
  TextEditingController bankAccountIfscCodeController = TextEditingController();
  final FocusNode bankAccountHolderNameFocusNode = FocusNode();
  final FocusNode bankAccountNumberFocusNode = FocusNode();
  final FocusNode bankAccountIfscCodeFocusNode = FocusNode();
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> BankDetailsformKeys = GlobalKey<FormState>();
  KYCController kycController = Get.put(KYCController());

  Future<bool> updatebankdetails(BuildContext context) async {
    bool isSuccess = await kycController.updateBankDetails(
        bankAccountHolderNameController.text.toString(),
        bankAccountNumberController.text.toString(),
        bankAccountIfscCodeController.text.toString(),
        context);
    if (isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> next() async {
    if (BankDetailsformKeys.currentState!.validate()) {
      try {
        bool kycupdate = await updatebankdetails(context);
        if (kycupdate) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KycSubmittedPhase()),
          );
        } else {
          print("KYC update failed");
        }
      } catch (e) {
        print("Error during KYC update: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SmallAppbar(heading: "Bank Details"),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: SizeUtil.scallingFactor(context) * 20),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                ),
                child: Form(
                  key: BankDetailsformKeys,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor,
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Account holder name',
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      color: AppColors.grey,
                                      fontFamily: "Helvetica"),
                                ),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                        fontSize: SizeUtil.body(context),
                                        color: AppColors.red,
                                        fontFamily: "Helvetica")),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: TextFormField(
                                maxLength: 40,
                                controller: bankAccountHolderNameController,
                                autofocus: true,
                                focusNode: bankAccountHolderNameFocusNode,
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(bankAccountNumberFocusNode);
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: 'e.g. John Doe',
                                  hintStyle: TextStyle(
                                      color: AppColors.grey,
                                      fontFamily: "Helvetica",
                                      fontSize: SizeUtil.body(context)),
                                  fillColor: TextfieldColors.background,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-z A-Z]'))
                                ],
                                style:
                                    TextStyle(fontSize: SizeUtil.body(context)),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'account holder name is required';
                                  } else {
                                    if (value.length < 2) {
                                      return 'please enter valid account holder name';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor,
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Account Number',
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      color: AppColors.grey,
                                      fontFamily: "Helvetica"),
                                ),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                        fontSize: SizeUtil.body(context),
                                        color: AppColors.red,
                                        fontFamily: "Helvetica")),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: TextFormField(
                                maxLength: 40,
                                controller: bankAccountNumberController,
                                focusNode: bankAccountNumberFocusNode,
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(bankAccountIfscCodeFocusNode);
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: 'e.g. John Doe',
                                  hintStyle: TextStyle(
                                      color: AppColors.grey,
                                      fontFamily: "Helvetica",
                                      fontSize: SizeUtil.body(context)),
                                  fillColor: TextfieldColors.background,
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(17),
                                ],
                                style:
                                    TextStyle(fontSize: SizeUtil.body(context)),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'account number is required';
                                  } else {
                                    if (value.length < 11) {
                                      return 'please enter valid account number';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor,
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'IFSC code',
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      color: AppColors.grey,
                                      fontFamily: "Helvetica"),
                                ),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                        fontSize: SizeUtil.body(context),
                                        color: AppColors.red,
                                        fontFamily: "Helvetica")),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: TextFormField(
                                maxLength: 11,
                                controller: bankAccountIfscCodeController,
                                focusNode: bankAccountIfscCodeFocusNode,
                                onEditingComplete: () {},
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: 'e.g. John Doe',
                                  hintStyle: TextStyle(
                                      color: AppColors.grey,
                                      fontFamily: "Helvetica",
                                      fontSize: SizeUtil.body(context)),
                                  fillColor: TextfieldColors.background,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9 a-z A-Z]'))
                                ],
                                style:
                                    TextStyle(fontSize: SizeUtil.body(context)),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'ifsc code is required';
                                  } else {
                                    if (value.length < 11) {
                                      return 'please enter valid ifsc code';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeUtil.verticalSpacingMedium(context),
                      ),
                      const WarningMessage(
                          message: ConstantUtil.warningMessageToUploadImage),
                      SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: AppColors.white,
            padding: EdgeInsets.only(bottom: size.height * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SmallButton(
                      text: "Cancel",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      backgroundColor: AppColors.white,
                      textColor: AppColors.primary,
                    ),
                    SmallButton(
                      text: "Submit",
                      onPressed: next,
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}
