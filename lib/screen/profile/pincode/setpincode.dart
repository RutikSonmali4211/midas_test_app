import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';
import 'package:pinput/pinput.dart';
import 'package:midas/controller/user/user_controller.dart';

import '../profile_and_setting.dart';

class SetPincodeScreen extends StatefulWidget {
  const SetPincodeScreen({super.key});

  @override
  State<SetPincodeScreen> createState() => _SetPincodeScreenState();
}

class _SetPincodeScreenState extends State<SetPincodeScreen> {
  var height;
  var width;
  GlobalKey<FormState> setPincodeFormKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  final FocusNode setpinFocusNode = FocusNode();
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    setpinFocusNode.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 35,
    height: 35,
    // margin: EdgeInsets.all(2),
    textStyle: const TextStyle(
        fontSize: 24, color: AppColors.black, fontWeight: FontWeight.w400),
    decoration: BoxDecoration(
      color: TextfieldColors.background,
      // border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    height = size.height;

    width = size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SmallAppbar(heading: "PIN Update"),
          SizedBox(height: SizeUtil.headingMedium2(context)),
          Expanded(
              child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.lock,
                            size: SizeUtil.scallingFactor(context) * 150,
                            color: AppColors.primary,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Enter the new PIN",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: SizeUtil.headingMedium(context),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Helvetica",
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Form(
                            key: setPincodeFormKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Pinput(
                                        pinputAutovalidateMode:
                                            PinputAutovalidateMode.onSubmit,
                                        controller: pinController,
                                        obscureText: true,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        length: 6,
                                        defaultPinTheme:
                                            DefaultSizes.getPinBoxTheme(
                                                context),
                                        showCursor: true,
                                        onCompleted: (value) {},
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(6),
                                        ],
                                        errorText: "pin is required",
                                        errorTextStyle: const TextStyle(
                                            fontSize: 11,
                                            color: Color.fromARGB(
                                                255, 205, 27, 27),
                                            fontFamily: "Helvetica"),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'pin is required';
                                          } else if (value.length > 6 ||
                                              value.length < 6) {
                                            return 'pin is always 6 digit';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                      child: LargeButton(
                          text: "Save Password",
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                          onPressed: () {
                            if (setPincodeFormKey.currentState!.validate()) {
                              savePassword();
                            }
                          }),
                    ),
                    // Container(
                    //   width: size.width * 0.85,
                    //   height: size.height * 0.065,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30.0),
                    //   ),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       if (setPincodeFormKey.currentState!.validate()) {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const ProfileAndSettings()),
                    //         );
                    //       }
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(30.0),
                    //         side:
                    //             const BorderSide(color: AppColors.primary, width: 2),
                    //       ),
                    //       backgroundColor: AppColors.primary,
                    //     ),
                    //     child: Align(
                    //       alignment: Alignment.center,
                    //       child: Text(
                    //         "Continue",
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //           color: AppColors.white,
                    //           fontSize: height * 0.024,
                    //           fontWeight: FontWeight.w700,
                    //           fontFamily: "Helvetica",
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  savePassword() async {
    bool isSuccess = await userController.savePassword(
        pinController.text.toString(), context);
    if (isSuccess) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileAndSettings()),
      );
    } else {}
  }
}
