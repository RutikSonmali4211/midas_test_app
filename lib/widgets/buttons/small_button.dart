// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:flutter/material.dart';

// class SmallButton extends StatelessWidget {
//   final String text;
//   final Color backgroundColor;
//   final Color textColor;
//   final VoidCallback onPressed;
//   const SmallButton(
//       {super.key,
//       required this.text,
//       required this.onPressed,
//       required this.backgroundColor,
//       required this.textColor});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: SizeUtil.buttonPaddingBottom(context)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.4,
//             child: ElevatedButton(
//               onPressed: onPressed,
//               style: ElevatedButton.styleFrom(
//                 elevation: 0,
//                 padding: EdgeInsets.symmetric(
//                     vertical: SizeUtil.scallingFactor(context) * 14),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(
//                       SizeUtil.scallingFactor(context) * 30),
//                   side: const BorderSide(color: AppColors.primary, width: 2),
//                 ),
//                 backgroundColor: backgroundColor,
//               ),
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   text,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: textColor,
//                     fontSize: SizeUtil.headingMedium(context),
//                     fontWeight: FontWeight.w700,
//                     fontFamily: "Helvetica",
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
