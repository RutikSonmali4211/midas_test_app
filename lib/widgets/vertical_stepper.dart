// import 'package:midas/constant/colors.dart';
// import 'package:flutter/material.dart';

// class VerticalStepper extends StatelessWidget {
//   final int currentStep;
//   final List<String> stepNames;
//   final Color activeColor;
//   final Color inactiveColor;

//   VerticalStepper({
//     required this.currentStep,
//     required this.stepNames,
//     this.activeColor = AppColors.primary,
//     this.inactiveColor = AppColors.grey,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       padding: EdgeInsets.only(left: size.width * 0.10),
//       child: Column(
//         children: List.generate(stepNames.length, (index) {
//           return Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         width: size.width * 0.14,
//                         height: size.height * 0.05,
//                         decoration: BoxDecoration(
//                           color: index <= currentStep
//                               ? activeColor
//                               : inactiveColor,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Text(
//                             '${index + 1}',
//                             style: TextStyle(
//                               fontSize: size.height * 0.03,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       if (index != stepNames.length - 1)
//                         Container(
//                           width: 3.0,
//                           height: size.height * 0.1,
//                           color: inactiveColor,
//                         ),
//                     ],
//                   ),
//                   const SizedBox(width: 15.0),
//                   Padding(
//                     padding:
//                         EdgeInsets.symmetric(vertical: size.height * 0.007),
//                     child: Text(
//                       stepNames[index],
//                       style: TextStyle(
//                           color: inactiveColor,
//                           fontSize: size.height * 0.025,
//                           fontWeight: FontWeight.w400,
//                           fontFamily: "Helvetica"),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
