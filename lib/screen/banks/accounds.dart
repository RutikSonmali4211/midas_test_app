// import 'package:midas/screen/notifications/notifications.dart';
// import 'package:midas/screen/profile/profile_and_setting.dart';
// import 'package:flutter/material.dart';
// import '../../constant/colors.dart';
// import 'accound_details.dart';

// class Accounds extends StatefulWidget {
//   const Accounds({super.key});

//   @override
//   State<Accounds> createState() => _AccoundsState();
// }

// class _AccoundsState extends State<Accounds> {


//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             width: screenSize.width,
//             decoration: const BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.shadow,
//                   offset: Offset(0, 4),
//                   blurRadius: 4.0,
//                   spreadRadius: 2.0,
//                 ),
//               ],
//               color: AppColors
//                   .primary, // You can change this to the desired card color
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(33.0),
//                 bottomRight: Radius.circular(33.0),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   alignment: Alignment.topCenter,
//                   padding: EdgeInsets.only(
//                       top: size.height * 0.03, left: 10, right: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const SizedBox(),
//                       Row(
//                         children: [
//                           IconButton(
//                             color: AppColors.white,
//                             icon: const Icon(Icons.notifications_outlined),
//                             iconSize: size.height * 0.030,
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const Notifications()),
//                               );
//                             },
//                           ),
//                           const SizedBox(width: 8.0),
//                           IconButton(
//                             color: AppColors.white,
//                             icon: const Icon(Icons.account_circle),
//                             iconSize: size.height * 0.030,
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const ProfileAndSettings()),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: size.width * 0.02,
//                       right: size.width * 0.02,
//                       bottom: size.height * 0.02),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Total Savings',
//                         style: TextStyle(
//                           color: AppTextColors.white,
//                           fontFamily: "Helvetica",
//                           fontWeight: FontWeight.w400,
//                           fontSize: size.height * 0.025,
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.currency_rupee_outlined,
//                             color: Colors.white,
//                             size: size.height * 0.044,
//                           ),
//                           Text(
//                             '11,53,270',
//                             style: TextStyle(
//                               color: AppTextColors.white,
//                               fontFamily: "Helvetica",
//                               fontWeight: FontWeight.w700,
//                               fontSize: size.height * 0.044,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         child: Center(
//                           child: Text(
//                             'Last Updated: 5:00 pm',
//                             style: TextStyle(
//                               color: AppTextColors.white,
//                               fontFamily: "Helvetica",
//                               fontWeight: FontWeight.w400,
//                               fontSize: size.height * 0.018,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const AccoundDetails()),
//                         );
//                         print('Container pressed!');
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(size.height * 0.015),
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppColors.shadow.withOpacity(0.01),
//                               offset: const Offset(0, 1),
//                               blurRadius: 1.0,
//                               spreadRadius: 1.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(
//                             color: AppColors.lightgrey, // Border color
//                             width: 2.0, // Border width
//                           ),
//                           color: AppColors.white,
//                         ),
//                         width: screenSize.width,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset('assets/hdfc_icon.png'),
//                             SizedBox(
//                               height: size.height * 0.02,
//                             ),
//                             Text(
//                               'Account Number: xxxxxxx1234',
//                               style: TextStyle(
//                                 color: AppTextColors.primary,
//                                 fontFamily:
//                                     "Helvetica", // Use a similar font to .SF Compact
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: size.height * 0.022,
//                               ),
//                             ),
//                             // SizedBox(
//                             //   height: size.height * 0.01,
//                             // ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Balance: ',
//                                       style: TextStyle(
//                                         color: AppTextColors.primary,
//                                         fontFamily:
//                                             "Helvetica", // Use a similar font to .SF Compact
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: size.height * 0.022,
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.currency_rupee_outlined,
//                                       color: AppTextColors.primary,
//                                       size: size.height * 0.022,
//                                     ),
//                                     Text(
//                                       '10,53,270',
//                                       style: TextStyle(
//                                         color: AppTextColors.primary,
//                                         fontFamily:
//                                             "Helvetica", // Use a similar font to .SF Compact
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: size.height * 0.022,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Icon(
//                                   Icons.arrow_right_alt,
//                                   color: AppTextColors.primary,
//                                   size: size.height * 0.03,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const AccoundDetails()),
//                         );
//                         print('Container pressed!');
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(size.height * 0.015),
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppColors.shadow.withOpacity(0.01),
//                               offset: const Offset(0, 1),
//                               blurRadius: 1.0,
//                               spreadRadius: 1.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(
//                             color: AppColors.lightgrey, // Border color
//                             width: 2.0, // Border width
//                           ),
//                           color: AppColors.white,
//                         ),
//                         width: screenSize.width,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset('assets/ICICI_icon.png'),
//                             SizedBox(
//                               height: size.height * 0.02,
//                             ),
//                             Text(
//                               'Account Number: xxxxxxx1234',
//                               style: TextStyle(
//                                 color: AppTextColors.primary,
//                                 fontFamily:
//                                     "Helvetica", // Use a similar font to .SF Compact
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: size.height * 0.022,
//                               ),
//                             ),
//                             // SizedBox(
//                             //   height: size.height * 0.01,
//                             // ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Balance: ',
//                                       style: TextStyle(
//                                         color: AppTextColors.primary,
//                                         fontFamily:
//                                             "Helvetica", // Use a similar font to .SF Compact
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: size.height * 0.022,
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.currency_rupee_outlined,
//                                       color: AppTextColors.primary,
//                                       size: size.height * 0.022,
//                                     ),
//                                     Text(
//                                       '1,00,000',
//                                       style: TextStyle(
//                                         color: AppTextColors.primary,
//                                         fontFamily:
//                                             "Helvetica", // Use a similar font to .SF Compact
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: size.height * 0.022,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Icon(
//                                   Icons.arrow_right_alt,
//                                   color: AppTextColors.primary,
//                                   size: size.height * 0.03,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             height: 1,
//                             color: AppTextColors
//                                 .grey, // Replace with your desired line color
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Text(
//                             'Sponsored',
//                             style: TextStyle(
//                                 color: AppTextColors
//                                     .grey, // Replace with your desired text color
//                                 fontSize: size.height * 0.022,
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: "Helvetica"),
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             height: 1,
//                             color: AppTextColors
//                                 .grey, // Replace with your desired line color
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.shadow.withOpacity(0.01),
//                             offset: const Offset(0, 1),
//                             blurRadius: 1.0,
//                             spreadRadius: 1.0,
//                           ),
//                         ],
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                           color: AppColors.lightgrey, // Border color
//                           width: 2.0, // Border width
//                         ),
//                         color: AppColors.white,
//                       ),
//                       width: screenSize.width,
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               // Container(
//                               //   margin: EdgeInsets.only(
//                               //     top: 10,
//                               //     left: 10,
//                               //   ),
//                               //   color: const Color.fromARGB(255, 189, 189, 189),
//                               //   width: screenSize.width * 0.37,
//                               //   height: screenSize.height * 0.033,
//                               // ),
//                               Container(
//                                 margin: const EdgeInsets.only(
//                                   top: 10,
//                                   left: 10,
//                                 ),
//                                 // color: const Color.fromARGB(255, 189, 189, 189),
//                                 // width: screenSize.width * 0.37,
//                                 // height: screenSize.height * 0.033,
//                                 child: Image.asset('assets/Kotak_icon.png'),
//                               ),
//                               const Spacer(),
//                               Container(
//                                 margin: const EdgeInsets.only(top: 10, right: 10),
//                                 child: Text(
//                                   'Ad',
//                                   style: TextStyle(
//                                     color: AppTextColors.primary,
//                                     fontFamily:
//                                         "Helvetica", // Use a similar font to .SF Compact
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: size.height * 0.015,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(
//                               top: 10,
//                               left: 10,
//                             ),
//                             width: screenSize.width,
//                             child: Padding(
//                               padding:
//                                   EdgeInsets.only(bottom: size.height * 0.01),
//                               child: Text(
//                                 'Open a savings account and earn upto 6% interest',
//                                 style: TextStyle(
//                                   color: AppTextColors.primary,
//                                   fontFamily:
//                                       "Helvetica", // Use a similar font to .SF Compact
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: size.height * 0.022,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: size.height * 0.03,
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
