// import 'package:flutter/material.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/sizeConstant.dart';
// import 'package:midas/constant/size_util.dart';

// class SmallAppbar extends StatelessWidget {
//   final String heading;
//   const SmallAppbar({super.key, required this.heading});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.shadow,
//             offset: Offset(0, 4),
//             blurRadius: 4.0,
//             spreadRadius: 2.0,
//           ),
//         ],
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(DefaultSizes.appheadercircularborder),
//           bottomRight: Radius.circular(DefaultSizes.appheadercircularborder),
//         ),
//         color: AppColors.primary,
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 top: SizeUtil.getStatusBarHeight(context) +
//                     DefaultSizes.bottemspaceofheader +
//                     6,
//                 left: size.width * 0.02,
//                 right: size.width * 0.02,
//                 bottom: DefaultSizes.bottemspaceofheader + 6),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Positioned(
//                   left: 0,
//                   child: IconButton(
//                     padding: EdgeInsets.all(0),
//                     icon: Icon(
//                       Icons.arrow_back,
//                       color: AppColors.white,
//                       size: SizeUtil.iconsSize(context),
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           heading,
//                           style: TextStyle(
//                             color: AppTextColors.white,
//                             fontFamily: "Helvetica",
//                             fontWeight: FontWeight.w700,
//                             fontSize: SizeUtil.iconsSize(context),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
