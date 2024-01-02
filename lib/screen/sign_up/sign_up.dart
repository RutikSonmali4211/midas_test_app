// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/Widgets/buttons/small_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/dropdown_data/dropdown_controller.dart';
import 'package:midas/controller/sms/sms_controller.dart';
import 'package:midas/controller/user/user_controller.dart';
import 'package:midas/screen/sign_in/sign_in.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:midas/widgets/otp_verification.dart';
import 'package:midas/widgets/upper_case_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

class SignUpScreen extends StatefulWidget {
  final String ssoName;
  final String ssoemail;
  final String ssoLogin;
  final bool isWatch;

  const SignUpScreen(
      {super.key,
      required this.ssoName,
      required this.ssoemail,
      required this.ssoLogin,
      required this.isWatch});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var height;
  var width;
  int currentStep = 1;
  int stepLength = 3;
  bool complete = false;

  bool showForm = true;
  bool isCheckedTermsAndCondition = false;
  bool isMobileNumberValid = false;

  // final Set<String> _selectedData = {};
  // final Set<String> _selectedFinancialData = {};
  // bool _selectAllData = false;
  // bool _selectAllFinancialData = false;
  // bool _showDataDropdown = false;
  // bool _showFinancialDataDropdown = false;

  // List<String> dataList = [];
  Map<String, dynamic> dataMap = {
    // 'profile': 'PROFILE',
    // 'summary': 'SUMMARY',
    // 'transaction': 'TRANSACTION',
  };
  Map<String, dynamic> financialDataMap = {
    // 'Savings': 'SAVINGS',
    // 'Bonds': 'BONDS',
    // 'Equity': 'EQUITY'
  };
  // List<String> financialDataList = ["Savings", "Bonds", "Equity"];

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController aadhaarController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController financialDataController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode phoneNoFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode panFocusNode = FocusNode();
  final FocusNode aadhaarFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode pinFocusNode = FocusNode();

  List<GlobalKey<FormState>> formKeys =
      List.generate(3, (_) => GlobalKey<FormState>());

  bool isFullNameValid = false;

  UserController userController = Get.put(UserController());
  DropdownController dropdownController = DropdownController();
  SmsController smsController = Get.put(SmsController());

  @override
  void initState() {
    super.initState();
    smsController.isMobileNumberVerified.value = false;
    if (widget.isWatch) {
      fullNameController.text = widget.ssoName;
      emailController.text = widget.ssoemail;
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNoController.dispose();
    emailController.dispose();
    panController.dispose();
    aadhaarController.dispose();
    userNameController.dispose();
    pinController.dispose();
    fullNameFocusNode.dispose();
    phoneNoFocusNode.dispose();
    emailFocusNode.dispose();
    panFocusNode.dispose();
    aadhaarFocusNode.dispose();
    userNameFocusNode.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }

  // next() {
  //   if (currentStep == 0) {
  //     setState(() => currentStep += 1);
  //   } else if (currentStep == stepLength - 1) {
  //     if (isCheckedTermsAndCondition) {
  //       setState(() {
  //         currentStep += 1;
  //         showForm = true;
  //       });
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: "please accept the terms & conditions",
  //           backgroundColor: Colors.black87);
  //     }
  //   } else {
  //     print(startDateController.text.toString());
  //     // FocusScope.of(context).unfocus();
  //     // if (!fullNameFocusNode.hasFocus) {
  //     //   formKeys[0].currentState!.validate();
  //     // }
  //     if (formKeys[currentStep - 1].currentState!.validate()) {
  //       setState(() => currentStep += 1);
  //     }
  //   }
  // }

  next() {
    if (currentStep == stepLength - 1) {
      if (isCheckedTermsAndCondition) {
        setState(() {
          currentStep += 1;
          showForm = true;
        });
      } else {
        Fluttertoast.showToast(
            msg: "please accept the terms & conditions",
            backgroundColor: Colors.black87);
      }
    } else {
      if (formKeys[currentStep - 1].currentState!.validate()) {
        if (smsController.isMobileNumberVerified.value) {
          setState(() => currentStep += 1);
        } else {
          showErrorAlert(ConstantUtil.phoneNumberNotVerifieldMessage);
        }
      }
    }
  }

  back() {
    if (currentStep == 1) {
      Navigator.pop(context);
    } else {
      setState(() => currentStep -= 1);
    }
  }

  // Future<void> _selectStartDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != DateTime.now()) {
  //     setState(() {
  //       startDateController.text =
  //           "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
  //     });
  //   }
  // }

  // Future<void> _selectEndDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2101),
  //   );

  //   if (picked != null && picked != DateTime.now()) {
  //     setState(() {
  //       endDateController.text =
  //           "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
  //     });
  //   }
  // }

  Future<void> sendOtp(BuildContext context) async {
    bool isSuccess =
        await smsController.sendOtp(phoneNoController.text.toString());
    if (isSuccess) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return OtpVerification(
            mobileNumber: phoneNoController.text.toString(),
            onConfirm: () async {
              String otp = smsController.otpController.text;
              if (otp.length == 6) {
                bool isSuccess = await smsController.verifyOtp(
                    phoneNoController.text.toString(), otp);
                if (isSuccess) {
                  smsController.otpController.clear();
                  Navigator.pop(context, otp);
                }
              } else {
                showErrorAlert("please enter valid otp");
              }
            },
          );
        },
      );
    }
  }

  registerUser() async {
    bool isSuccess = await userController.registerUser(
        fullNameController.text.toString(),
        emailController.text.toString(),
        phoneNoController.text.toString(),
        widget.isWatch,
        userNameController.text.toString(),
        pinController.text.toString(),
        panController.text.toString(),
        aadhaarController.text.toString(),
        startDateController.text.toString(),
        endDateController.text.toString(),
        [],
        [],
        // Convertors.createListForSelectedDropdownData(_selectedData, dataMap),
        // Convertors.createListForSelectedDropdownData(
        //     _selectedFinancialData, financialDataMap),
        context);

    if (isSuccess) {
      // LocalStorage.instance
      //     .setString('username', emailController.text.toString());
      // String? email = LocalStorage.instance.getString('username');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (Route route) => false);
    } else {}
  }

  Widget buildStep1Form() {
    return SingleChildScrollView(
      child: Form(
        key: formKeys[0],
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Full Name (First & Last)',
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
                      readOnly: widget.isWatch,
                      controller: fullNameController,
                      autofocus: true,
                      focusNode: fullNameFocusNode,
                      onEditingComplete: () {
                        phoneNoFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(phoneNoFocusNode);
                      },
                      onFieldSubmitted: (_) {
                        phoneNoFocusNode.unfocus();
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
                        FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]'))
                      ],
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty && !userNameFocusNode.hasFocus) {
                          return 'full name is required';
                        } else {
                          if (value.length < 2) {
                            return 'please enter valid full name';
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
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Phone Number (10 digits)',
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
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            readOnly:
                                smsController.isMobileNumberVerified.value,
                            maxLength: 10,
                            focusNode:
                                phoneNoFocusNode, // Attach FocusNode to the TextFormField
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(emailFocusNode);
                            },
                            controller: phoneNoController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              counterText: "",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(Icons.check_circle,
                                    size: 30,
                                    color: smsController
                                            .isMobileNumberVerified.value
                                        ? AppColors.primary
                                        : AppColors.grey),
                              ),
                              suffixIconConstraints: const BoxConstraints(),
                              filled: true,
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'e.g., 9876543210',
                              hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Helvetica",
                                  fontSize: SizeUtil.body(context)),
                              fillColor: TextfieldColors.background,
                            ),
                            style: TextStyle(
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                            onChanged: (value) {
                              if (value.length == 10) {
                                setState(() {
                                  isMobileNumberValid = true;
                                });
                              } else {
                                setState(() {
                                  isMobileNumberValid = false;
                                });
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty &&
                                  !phoneNoFocusNode.hasFocus) {
                                return 'phone number is required';
                              } else {
                                if (value.length != 10) {
                                  return 'phone number must be exactly 10 digits.';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            if (isMobileNumberValid &&!smsController.isMobileNumberVerified.value) {
                              sendOtp(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7.5),
                            child: Text(
                              smsController.isMobileNumberVerified.value
                                  ? "Verified"
                                  : "Send OTP",
                              style: TextStyle(
                                  color: isMobileNumberValid
                                      ? AppColors.primary
                                      : AppColors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeUtil.body(context),
                                  fontFamily: "Helvetica"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Email',
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
                      maxLength: 60,
                      focusNode: emailFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(panFocusNode);
                      },
                      readOnly: widget.isWatch,
                      controller: emailController,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'e.g. something@email.com',
                        hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      style: TextStyle(
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        RegExp regex = RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                        if (value!.isEmpty) {
                          return 'email is required';
                        } else {
                          if (!regex.hasMatch(value)) {
                            return 'please enter valid email';
                          } else {
                            return null;
                          }
                        }
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
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'PAN',
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
                      focusNode: panFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      controller: panController,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'e.g., ABCD9999F',
                        hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      style: TextStyle(
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9]')),
                        LengthLimitingTextInputFormatter(10)
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        RegExp regex = RegExp(r'^[A-Za-z]{5}\d{4}[A-Za-z]$');
                        if (value!.isEmpty) {
                          return 'pan card number is required';
                        } else {
                          if (!regex.hasMatch(value)) {
                            return 'please enter valid pan card number';
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.35,
            )
          ],
        ),
      ),
    );
  }

  Widget buildStep2Form() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: AppColors.lightgrey,
                width: 2.0,
              ),
            ),
            width: double.infinity,
            height: height * 0.45,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
                    style: TextStyle(
                        fontSize: SizeUtil.body(context),
                        fontFamily: "Helvetica"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStep3Form() {
    return Form(
      key: formKeys[2],
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Login Username',
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
                    maxLength: 30,
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: true,
                    readOnly: true,
                    focusNode:
                        userNameFocusNode, // Attach FocusNode to the TextFormField
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(pinFocusNode);
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
                    style: TextStyle(
                        fontSize: SizeUtil.body(context),
                        fontFamily: "Helvetica"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'username is required';
                      } else if (value.length < 4) {
                        return 'username must be at least 4 characters long';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
          if (!widget.isWatch)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Pin',
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
                  child: Pinput(
                    focusNode: pinFocusNode,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    controller: pinController,
                    obscureText: true,
                    mainAxisAlignment: MainAxisAlignment.center,
                    length: 6,
                    defaultPinTheme: DefaultSizes.getPinBoxTheme(context),
                    showCursor: true,
                    onCompleted: (value) {},
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    errorText: "pin is required",
                    errorTextStyle: const TextStyle(
                        fontSize: 11, color: Color.fromARGB(255, 205, 27, 27)),
                    validator: (value) {
                      if (value!.isEmpty && value.length < 7) {
                        return 'pin is required';
                      } else if (value.length < 6) {
                        return 'pin must be 6 digits';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildStep4Completed() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.check_circle,
                size: SizeUtil.scallingFactor(context) * 180,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Text(
              textAlign: TextAlign.center,
              "You are all set up\nStart your journey of wealth creation",
              style: TextStyle(
                  fontSize: SizeUtil.scallingFactor(context) * 22,
                  color: AppColors.grey,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          fullNameFocusNode.unfocus();
          phoneNoFocusNode.unfocus();
          emailFocusNode.unfocus();
          panFocusNode.unfocus();
          aadhaarFocusNode.unfocus();
          userNameFocusNode.unfocus();
          pinFocusNode.unfocus();
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                        top: SizeUtil.getStatusBarHeight(context) +
                            DefaultSizes.bottemspaceofheader +
                            6,
                        left: size.width * 0.02,
                        right: size.width * 0.02,
                        bottom: DefaultSizes.bottemspaceofheader + 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign up',
                          style: TextStyle(
                            color: AppTextColors.white,
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w700,
                            fontSize: SizeUtil.headingLarge(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: SizeUtil.scallingFactor(context) * 35),
              child: Text(
                textAlign: TextAlign.start,
                getCurrentStepName(currentStep),
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeUtil.headingLarge2(context),
                  fontFamily: "Helvetica",
                ),
              ),
            ),
            // if (currentStep != 0)
            //   Padding(
            //     padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            //     child: NumberStepper(
            //       totalSteps: stepLength,
            //       width: size.width,
            //       height: size.height,
            //       curStep: currentStep,
            //       stepCompleteColor: AppColors.primary,
            //       currentStepColor: AppColors.primary,
            //       inactiveColor: AppColors.grey,
            //       lineWidth: 3,
            //     ),
            //   ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                ),
                child: getCurrentStepForm(),
              ),
            ),
            Container(
              color: AppColors.white,
              padding: EdgeInsets.only(bottom: size.height * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (currentStep == 2)
                    Padding(
                      padding:
                          EdgeInsets.only(left: size.width * 0.02, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isCheckedTermsAndCondition =
                                !isCheckedTermsAndCondition;
                          });
                        },
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: SizeUtil.scallingFactor(context) * 1.5,
                              child: Checkbox(
                                activeColor: AppColors.primary,
                                value: isCheckedTermsAndCondition,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedTermsAndCondition = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Text(
                              'Accept the terms & conditions',
                              style: TextStyle(
                                fontSize: SizeUtil.headingMedium(context),
                                color: AppColors.grey,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (currentStep < stepLength + 1)
                        SmallButton(
                          text: currentStep == 0 ? "Cancel" : "Back",
                          onPressed: currentStep == 0 ? back : back,
                          backgroundColor: AppColors.white,
                          textColor: AppColors.primary,
                        ),
                      if (currentStep <= stepLength)
                        SmallButton(
                          text: "Next",
                          onPressed: next,
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                        ),
                    ],
                  ),
                  if (currentStep > stepLength)
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.10,
                          left: width * 0.10,
                          bottom: SizeUtil.buttonPaddingBottom(context)),
                      child: LargeButton(
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white,
                        text: "Done",
                        onPressed: () {
                          setState(() {
                            complete = true;
                          });
                          registerUser();
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _toggleDataDropDown() async {
  //   if (dataMap.isEmpty) {
  //     var data =
  //         await dropdownController.fetchDataAndFinancialDataDropdown("data");
  //     setState(() {
  //       dataMap = data;
  //     });
  //   }
  //   setState(() {
  //     _showDataDropdown = !_showDataDropdown;
  //   });
  // }

  // void _toggleFinancialDataDropDown() async {
  //   if (financialDataMap.isEmpty) {
  //     var data = await dropdownController
  //         .fetchDataAndFinancialDataDropdown("financialData");
  //     setState(() {
  //       financialDataMap = data;
  //     });
  //   }
  //   setState(() {
  //     _showFinancialDataDropdown = !_showFinancialDataDropdown;
  //   });
  // }

  Widget getCurrentStepForm() {
    switch (currentStep) {
      case 1:
        return buildStep1Form();
      // case 2:
      //   return buildStep2Form();
      case 2:
        return buildStep2Form();
      case 3:
        return buildStep3Form();
      case 4:
        return buildStep4Completed();
      default:
        return Container();
    }
  }
}

String getCurrentStepName(int step) {
  switch (step) {
    // case 0:
    //   return "Journey to wealth creation";
    case 1:
      return "Confirm User Details";
    // case 2:
    //   return "Confirm User Consent";
    case 2:
      return "Understand T&C";
    case 3:
      return "Set Login Details";
    case 4:
      return "";
    default:
      return "";
  }
}
