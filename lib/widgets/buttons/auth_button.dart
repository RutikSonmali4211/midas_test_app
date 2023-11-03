// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:flutter/material.dart';

// class AuthButton extends StatelessWidget {
//   final String imageUrl;
//   final VoidCallback onPressed;
//   const AuthButton(
//       {super.key, required this.imageUrl, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SizedBox(
//       width: size.width * 0.26,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5.0),
//             side: const BorderSide(color: AppColors.grey, width: 0.8),
//           ),
//           elevation: 0,
//           padding: EdgeInsets.symmetric(
//               vertical: SizeUtil.scallingFactor(context) * 10),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(imageUrl, height: SizeUtil.body(context)),
//           ],
//         ),
//       ),
//     );
//   }
// }
