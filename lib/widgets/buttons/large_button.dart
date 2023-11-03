// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:flutter/material.dart';

// class LargeButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final Color textColor;
//   const LargeButton(
//       {super.key,
//       required this.text,
//       required this.onPressed,
//       required this.backgroundColor,
//       required this.textColor});

//   @override
//   Widget build(BuildContext context) {
//     return
//         Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         SizedBox(
//           child: ElevatedButton(
//             onPressed: onPressed,
//             style: ElevatedButton.styleFrom(
//               elevation: 0,
//               padding: EdgeInsets.symmetric(
//                   vertical: SizeUtil.scallingFactor(context) * 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(
//                     SizeUtil.scallingFactor(context) * 30),
//                 side: const BorderSide(color: AppColors.primary, width: 2),
//               ),
//               backgroundColor: backgroundColor,
//             ),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 text,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: textColor,
//                   fontSize: SizeUtil.headingMedium(context),
//                   fontWeight: FontWeight.w700,
//                   fontFamily: "Helvetica",
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//     // );
//   }
// }
