import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/screen/profile/pincode/setpincode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';
import 'package:pinput/pinput.dart';
import 'package:midas/controller/user/user_controller.dart';

class PincodeScreen extends StatefulWidget {
  const PincodeScreen({super.key});

  @override
  State<PincodeScreen> createState() => _PincodeScreenState();
}

class _PincodeScreenState extends State<PincodeScreen> {
  var height;
  var width;
  GlobalKey<FormState> pincodeFormKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  final FocusNode pincodeFocusNode = FocusNode();
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pincodeFocusNode.dispose();
    super.dispose();
  }

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
                            "Enter the current PIN",
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
                          Column(
                            children: [
                              Form(
                                key: pincodeFormKey,
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
                                              LengthLimitingTextInputFormatter(
                                                  6),
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                      child: LargeButton(
                          text: "Continue",
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                          onPressed: () {
                            if (pincodeFormKey.currentState!.validate()) {
                              checkPasword();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  checkPasword() async {
    bool isSuccess = await userController.currentPassword(
        pinController.text.toString(), context);
    if (isSuccess) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SetPincodeScreen()),
      );
    } else {}
  }
}
