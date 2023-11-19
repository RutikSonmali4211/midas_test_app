import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/auth_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/device_token/device_token_controller.dart';
import 'package:midas/controller/user/user_controller.dart';
import 'package:midas/screen/shared/bottom_navbar.dart';
import 'package:midas/screen/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midas/storage/local_storage.dart';
import 'package:midas/widgets/buttons/large_button.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with WidgetsBindingObserver {
  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {});
    if (accessToken != null) {
      print("is Logged:::: ${accessToken.toJson()}");
      setState(() {});
    }
  }

  Future<void> _facebookLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
      } else {
        print(result.status);
        print(result.message);
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode pinFocusNode = FocusNode();

  UserController userController = Get.put(UserController());

  login() async {
    bool isSuccess = await userController.loginUser(
        userNameController.text.toString(),
        pinController.text.toString(),
        context);

    if (isSuccess) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const BottomNevbar()),
          (Route route) => false);
    } else {}
  }

  biometricLogin() async {
    if (userController.isBiometricEnabled.value) {
      bool isSuccess = await userController.loginWithBiometric(context);
      if (isSuccess) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const BottomNevbar()),
            (Route route) => false);
      }
    }
  }

  ssoLogin(name, email) async {
    bool isSuccess = await userController.loginWithSso(name, email, context);
    if (isSuccess) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomNevbar()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    generateDeviceToken();
    WidgetsBinding.instance.addObserver(this);
    _loadUsername();
    userController.isBiometricEnabled =
        LocalStorage.getIsBiometricEnabled() == null
            ? false.obs
            : LocalStorage.getIsBiometricEnabled()!.obs;
    userController.isBometricAlertDisplay =
        LocalStorage.getBiometricAlert() == null
            ? false.obs
            : LocalStorage.getBiometricAlert()!.obs;
    biometricLogin();
    _checkIfIsLogged();
    logoutFirebase();
  }


   generateDeviceToken() async {
    if (LocalStorage.getDeviceToken() == null) {
      String? deviceToken = await DeviceTokenController.getDeviceToken();
      LocalStorage.setDeviceToken(deviceToken!);
    }
  }

  logoutFirebase() async {
    await FirebaseAuth.instance.signOut();
    await FacebookAuth.i.logOut();
    await _googleSignIn.signOut();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadUsername();
    }
  }

  void _loadUsername() async {
    String username = await getUsernameFromLocalStorage();
    setState(() {
      userNameController.text = username;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<String> getUsernameFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      GoogleSignInAccount? account = _googleSignIn.currentUser;
      if (account != null) {
        ssoLogin(account.displayName, account.email);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/SimpliFin.png',
                          height: SizeUtil.scallingFactor(context) * 50,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Invest Smart',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: SizeUtil.headingLarge(context),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Helvetica"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeUtil.verticalSpacingMedium(context),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      "Login Details",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeUtil.headingLarge2(context),
                        fontFamily: "Helvetica",
                      ),
                    ),
                    SizedBox(
                      height: SizeUtil.verticalSpacingMedium(context),
                    ),
                    Form(
                      key: loginFormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.04,
                                right: size.width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Username',
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: TextFormField(
                                    maxLength: 30,
                                    controller: userNameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    autofocus: true,
                                    focusNode: userNameFocusNode,
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(pinFocusNode);
                                    },
                                    inputFormatters: const [
                                      // FilteringTextInputFormatter.allow(
                                      //     RegExp(r'[a-z A-Z]'))
                                    ],
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
                                        fontSize: SizeUtil.body(context)),
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
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeUtil.verticalSpacingMedium(context),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.04,
                                right: size.width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
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
                                Pinput(
                                  focusNode: pinFocusNode,
                                  pinputAutovalidateMode:
                                      PinputAutovalidateMode.onSubmit,
                                  controller: pinController,
                                  obscureText: true,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  length: 6,
                                  defaultPinTheme:
                                      DefaultSizes.getPinBoxTheme(context),
                                  showCursor: true,
                                  onCompleted: (value) {},
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  errorText: "pin is required",
                                  errorTextStyle: const TextStyle(
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 205, 27, 27),
                                      fontFamily: "Helvetica"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'pin is required';
                                    } else if (value.length < 6) {
                                      return 'pin must be 6 digits';
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
                    SizedBox(
                      height: SizeUtil.verticalSpacingLarge(context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.08, right: size.width * 0.08),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LargeButton(
                              text: "Sign in",
                              onPressed: () {
                                if (loginFormKey.currentState!.validate()) {
                                  login();
                                }
                                //  throw const FormatException("Test a crash for IOS app");
                              },
                              backgroundColor: AppColors.white,
                              textColor: AppColors.primary),
                          Obx(() => userController.isDeviceSupport.value && userController.isBiometricEnabled.value
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: AppTextColors.grey,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(
                                              SizeUtil.verticalSpacingMedium(
                                                  context)),
                                          child: Text(
                                            'or continue with',
                                            style: TextStyle(
                                                color: AppTextColors.grey,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Helvetica"),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: AppTextColors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: ElevatedButton(
                                          onPressed: userController
                                                  .isBiometricEnabled.value
                                              ? () async {
                                                  bool isSuccess =
                                                      await userController
                                                          .loginWithBiometric(
                                                              context);
                                                  if (isSuccess) {
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const BottomNevbar()),
                                                            (Route route) =>
                                                                false);
                                                  }
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    SizeUtil.scallingFactor(
                                                            context) *
                                                        14),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeUtil.scallingFactor(
                                                              context) *
                                                          30),
                                              side: const BorderSide(
                                                  color: AppColors.primary,
                                                  width: 2),
                                            ),
                                            backgroundColor: AppColors.primary,
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.fingerprint,
                                                  color: AppColors.white,
                                                  size: SizeUtil.scallingFactor(
                                                          context) *
                                                      18,
                                                ),
                                                Text(
                                                  " Biometric",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize:
                                                        SizeUtil.bodyLarge(
                                                            context),
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Helvetica",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ],
                                )
                              : SizedBox())
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeUtil.verticalSpacingLarge(context),
                    ),
                    const Divider(
                      color: AppColors.black,
                      thickness: 1.0,
                    ),
                    SizedBox(
                      height: SizeUtil.verticalSpacingMedium(context),
                    ),
                    Center(
                      child: Text(
                        "OR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: SizeUtil.body(context),
                          // fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeUtil.scallingFactor(context) * 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(
                                      ssoName: "",
                                      ssoemail: "",
                                      ssoLogin: '',
                                      isWatch: false)),
                            );
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Helvetica",
                                fontSize: SizeUtil.headingMedium(context)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: SizeUtil.scallingFactor(context) * 30),
                    Row(
                      mainAxisAlignment: Platform.isIOS? MainAxisAlignment.spaceBetween:MainAxisAlignment.spaceEvenly,
                      children: [
                        AuthButton(
                            imageUrl: 'assets/facebook_icon.png',
                            onPressed: () {
                              _facebookLogin();
                            }),
                        AuthButton(
                          imageUrl: 'assets/google_logo.png',
                          onPressed: () {
                            _handleSignIn();
                          },
                        ),
                        if(Platform.isIOS)
                        AuthButton(
                            imageUrl: 'assets/apple_icon.png',
                            onPressed: () {}),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
