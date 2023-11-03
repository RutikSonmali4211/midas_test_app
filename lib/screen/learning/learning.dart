// import 'package:midas/constant/colors.dart';
// import 'package:midas/screen/notifications/notifications.dart';
// import 'package:midas/screen/profile/profile_and_setting.dart';
// import 'package:flutter/material.dart';

// class Learning extends StatefulWidget {
//   const Learning({super.key});

//   @override
//   State<Learning> createState() => _LearningState();
// }

// class _LearningState extends State<Learning> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.shadow,
//                   offset: Offset(0, 4),
//                   blurRadius: 4.0,
//                   spreadRadius: 2.0,
//                 ),
//               ],
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(33.0),
//                 bottomRight: Radius.circular(33.0),
//               ),
//               color: AppColors.primary,
//             ),
//             // height: size.height * 0.15,
//             width: double.infinity,
//             child: Padding(
//               padding: EdgeInsets.only(
//                   top: size.height * 0.03,
//                   bottom: size.height * 0.02,
//                   left: 10,
//                   right: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(),
//                   Row(
//                     children: [
//                       IconButton(
//                         color: AppColors.white,
//                         iconSize: size.height * 0.030,
//                         icon: Icon(Icons
//                             .notifications_outlined), // Replace 'Icons.notification' with the desired notification icon
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Notifications()),
//                           );
//                         },
//                       ),
//                       SizedBox(
//                           width:
//                               8.0), // Adjust the width to add spacing between the icons
//                       IconButton(
//                         color: AppColors.white,
//                         icon: Icon(Icons.account_circle),
//                         iconSize: size.height * 0.030,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ProfileAndSettings()),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Text(
//                 "Coming Soon",
//                 style: TextStyle(
//                   color: AppColors.grey,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: "Helvetica",
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
