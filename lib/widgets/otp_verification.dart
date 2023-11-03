// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:midas/Widgets/buttons/small_button.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/sizeConstant.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:flutter/material.dart';
// import 'package:midas/controller/sms/sms_controller.dart';
// import 'package:pinput/pinput.dart';

// class OtpVerification extends StatefulWidget {
//   final String mobileNumber;
//   const OtpVerification({super.key, required this.mobileNumber});

//   @override
//   State<OtpVerification> createState() => _OtpVerificationState();
// }

// class _OtpVerificationState extends State<OtpVerification> {
//   SmsController smsController = Get.find();
//   TextEditingController otpController = TextEditingController();
//   int countdown = 30;
//   Timer? _countdownTimer;

//   @override
//   void initState() {
//     super.initState();
//     startCountdown();
//   }

//   void startCountdown() {
//     _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (countdown == 0) {
//         _countdownTimer?.cancel();
//       } else {
//         setState(() {
//           countdown--;
//         });
//       }
//     });
//   }

//   void resetCountdown() {
//     setState(() {
//       countdown = 30;
//     });
//   }

//   @override
//   void dispose() {
//     _countdownTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: AppColors.white,
//       insetPadding: const EdgeInsets.all(10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               "Enter OTP",
//               style: TextStyle(
//                 fontSize: SizeUtil.headingLarge2(context),
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.primary,
//                 fontFamily: "Helvetica",
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Pinput(
//               controller: otpController,
//               pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//               length: 6,
//               defaultPinTheme: DefaultSizes.getPinBoxTheme(context),
//               inputFormatters: [
//                 FilteringTextInputFormatter.digitsOnly,
//                 LengthLimitingTextInputFormatter(6),
//               ],
//               showCursor: true,
//               onCompleted: (value) {},
//             ),
//             const SizedBox(height: 30.0),
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SmallButton(
//                         text: "Cancel",
//                         onPressed: () {
//                           Navigator.pop(context, null);
//                         },
//                         backgroundColor: AppColors.white,
//                         textColor: AppColors.primary),
//                     SmallButton(
//                         text: "Confirm",
//                         onPressed: () async {
//                           final otp = otpController.text;
//                           if (otp.length == 6) {
//                             bool isSuccess = await smsController.verifyOtp(
//                                 widget.mobileNumber, otp);
//                             if (isSuccess) {
//                               Navigator.pop(context, otp);
//                             }
//                           }
//                         },
//                         backgroundColor: AppColors.primary,
//                         textColor: AppColors.white),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: countdown == 0
//                             ? () async {
//                                 bool isSuccess = await smsController
//                                     .sendOtp(widget.mobileNumber);
//                                 if (isSuccess) {
//                                   resetCountdown();
//                                   startCountdown();
//                                 }
//                               }
//                             : null,
//                         child: Text(
//                           "Resend OTP",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: countdown == 0
//                                 ? AppColors.primary
//                                 : AppColors.grey,
//                             fontWeight: FontWeight.w400,
//                             fontSize: SizeUtil.body(context),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         countdown == 0 ? "0s" : "${countdown}s",
//                         style: TextStyle(
//                           color: AppColors.primary,
//                           fontWeight: FontWeight.w400,
//                           fontSize: SizeUtil.body(context),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
