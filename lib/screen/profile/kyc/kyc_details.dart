// import 'package:midas/Widgets/buttons/large_button.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:flutter/material.dart';
// import 'package:midas/widgets/appbar/small_appbar.dart';

// import 'kyy_processing_first_phase.dart';

// class KycDetailsPhase extends StatefulWidget {
//   const KycDetailsPhase({super.key});

//   @override
//   State<KycDetailsPhase> createState() => _KyKycDetailsPhaseState();
// }

// class _KyKycDetailsPhaseState extends State<KycDetailsPhase> {
//   var height;
//   var width;
//   bool kycCompleted = false;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     height = size.height;
//     width = size.width;
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SmallAppbar(heading: "KYC Details"),
//           SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (!kycCompleted)
//                 Center(
//                   child: Icon(
//                     Icons.check_circle,
//                     size: SizeUtil.scallingFactor(context) * 180,
//                     color: AppColors.grey,
//                   ),
//                 ),
//               if (kycCompleted)
//                 Center(
//                   child: Icon(
//                     Icons.check_circle,
//                     size: SizeUtil.scallingFactor(context) * 180,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               const SizedBox(height: 20),
//               if (kycCompleted)
//                 Text(
//                   textAlign: TextAlign.center,
//                   "KYC done",
//                   style: TextStyle(
//                       fontSize: SizeUtil.bodyLarge(context),
//                       color: AppColors.primary),
//                 ),
//               if (!kycCompleted)
//                 Text(
//                   textAlign: TextAlign.center,
//                   "KYC not complete",
//                   style: TextStyle(
//                       fontSize: SizeUtil.bodyLarge(context),
//                       color: AppColors.grey),
//                 ),
//               SizedBox(height: height * 0.161),
//               if (!kycCompleted)
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: width * 0.10),
//                   child: LargeButton(
//                       text: "Start KYC",
//                       backgroundColor: AppColors.primary,
//                       textColor: AppColors.white,
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const KycProcessingFirstPhase()),
//                         );
//                       }),
//                 ),
//               if (kycCompleted)
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: width * 0.10),
//                   child: LargeButton(
//                       text: "Start KYC",
//                       backgroundColor: AppColors.grey,
//                       textColor: AppColors.white,
//                       onPressed: () {}),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
