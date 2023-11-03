// import 'package:midas/Widgets/buttons/small_button.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:flutter/material.dart';

// class AlertBox extends StatelessWidget {
//   final String message;
//   final VoidCallback onConfirm;

//    const AlertBox({super.key, required this.message,required this.onConfirm});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: const EdgeInsets.all(10),
//       backgroundColor: AppColors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               message,
//               style: TextStyle(
//                 fontSize: SizeUtil.headingLarge2(context),
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.primary,
//                 fontFamily: "Helvetica",
//               ),
//             ),
//             const SizedBox(height: 30.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 SmallButton(
//                     text: "Cancel",
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     backgroundColor: AppColors.white,
//                     textColor: AppColors.primary),
//                 SmallButton(
//                     text: "Confirm",
//                     onPressed:onConfirm,
//                     backgroundColor: AppColors.primary,
//                     textColor: AppColors.white),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
