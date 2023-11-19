import 'package:midas/constant/colors.dart';
import 'package:midas/screen/sign_in/sign_in.dart';
import 'package:midas/screen/sign_up/sign_up.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/login_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Welcome to Midas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: size.height * 0.03,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Helvetica"),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.13,
                      ),
                      Text(
                        'Take Control Of Your\nFinancial Freedom',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: size.height * 0.047,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Helvetica"),
                      ),
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      Text(
                        'Understand\nLearn\nGrow',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: size.height * 0.06,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Helvetica"),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        color: AppColors.shadow,
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    color: AppColors.white,
                  ),
                  height: size.height * 0.21,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: size.height * 0.05,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            boxShadow: const [
                              BoxShadow(
                                spreadRadius: 2,
                                color: AppColors.shadow,
                                offset: Offset(0, 4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
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
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: const BorderSide(
                                    color: AppColors.primary, width: 2),
                              ),
                              backgroundColor: AppColors.primary,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Sign up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: size.height * 0.024,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Helvetica",
                                  shadows: const [
                                    Shadow(
                                      color: AppColors.shadow,
                                      offset: Offset(0, 4),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          height: size.height * 0.05,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            boxShadow: const [
                              BoxShadow(
                                spreadRadius: 2,
                                color: AppColors.shadow,
                                offset: Offset(0, 4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: const BorderSide(
                                    color: AppColors.primary, width: 2),
                              ),
                              backgroundColor: AppColors.white,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Sign in",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: size.height * 0.024,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Helvetica",
                                  shadows: const [
                                    Shadow(
                                      color: AppColors.shadow,
                                      offset: Offset(0, 4),
                                      blurRadius: 8,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
