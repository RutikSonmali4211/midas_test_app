// import 'package:midas/Widgets/appbar/large_appbar.dart';
// import 'package:midas/Widgets/buttons/large_button.dart';
// import 'package:midas/Widgets/buttons/small_button.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/sizeConstant.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_details.dart';
// import 'package:flutter/material.dart';

// class SIPDetailsScreen extends StatefulWidget {
//   const SIPDetailsScreen({super.key});

//   @override
//   State<SIPDetailsScreen> createState() => _SIPDetailsScreenState();
// }

// class _SIPDetailsScreenState extends State<SIPDetailsScreen> {
//   var height;
//   var width;

//   bool isRedeemAllUnits = false;

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     height = screenSize.height;
//     width = screenSize.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//            const LargeAppbar(heading: "Current Value", isAmount: true, isbackButtonAvailable: true, content: "39,325.82", timeline: "Last Updated: Aug 6, 2023 | 5:00 pm"),
//           // Container(
//           //   width: screenSize.width,
//           //   decoration: const BoxDecoration(
//           //     boxShadow: [
//           //       BoxShadow(
//           //         color: AppColors.shadow,
//           //         offset: Offset(0, 4),
//           //         blurRadius: 4.0,
//           //         spreadRadius: 2.0,
//           //       ),
//           //     ],
//           //     color: AppColors.primary,
//           //     borderRadius: BorderRadius.only(
//           //       bottomLeft: Radius.circular(33.0),
//           //       bottomRight: Radius.circular(33.0),
//           //     ),
//           //   ),
//           //   child: Column(
//           //     children: [
//           //       Container(
//           //         alignment: Alignment.topCenter,
//           //         padding:
//           //             EdgeInsets.only(top: height * 0.03, left: 10, right: 20),
//           //         child: Row(
//           //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //           children: [
//           //             const SizedBox(),
//           //             Row(
//           //               children: [
//           //                 IconButton(
//           //                   color: AppColors.white,
//           //                   icon: const Icon(Icons.notifications_outlined),
//           //                   iconSize: SizeUtil.iconsSize(context),
//           //                   onPressed: () {
//           //                     Navigator.push(
//           //                       context,
//           //                       MaterialPageRoute(
//           //                           builder: (context) => const Notifications()),
//           //                     );
//           //                   },
//           //                 ),
//           //                 const SizedBox(width: 8.0),
//           //                 IconButton(
//           //                   color: AppColors.white,
//           //                   icon: const Icon(Icons.account_circle),
//           //                   iconSize: SizeUtil.iconsSize(context),
//           //                   onPressed: () {
//           //                     Navigator.push(
//           //                       context,
//           //                       MaterialPageRoute(
//           //                           builder: (context) => const ProfileAndSettings()),
//           //                     );
//           //                   },
//           //                 ),
//           //               ],
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //       Padding(
//           //         padding: EdgeInsets.only(
//           //             left: width * 0.02,
//           //             right: width * 0.02,
//           //             bottom: height * 0.02),
//           //         child: Stack(
//           //           alignment: Alignment.center,
//           //           children: [
//           //             Positioned(
//           //               left: 0,
//           //               child: IconButton(
//           //                 icon: Icon(
//           //                   Icons.arrow_back,
//           //                   color: AppColors.white,
//           //                   size: SizeUtil.iconsSize(context),
//           //                 ),
//           //                 onPressed: () {
//           //                   Navigator.of(context).pop();
//           //                 },
//           //               ),
//           //             ),
//           //             Column(
//           //               mainAxisAlignment: MainAxisAlignment.center,
//           //               crossAxisAlignment: CrossAxisAlignment.center,
//           //               children: [
//           //                 Text(
//           //                   'Current Value',
//           //                   style: TextStyle(
//           //                     color: AppTextColors.white,
//           //                     fontFamily: "Helvetica",
//           //                     fontWeight: FontWeight.w400,
//           //                     fontSize: SizeUtil.headingMedium(context),
//           //                   ),
//           //                 ),
//           //                 Row(
//           //                   mainAxisAlignment: MainAxisAlignment.center,
//           //                   children: [
//           //                     Icon(
//           //                       Icons.currency_rupee_outlined,
//           //                       color: Colors.white,
//           //                       size: SizeUtil.headingLarge(context),
//           //                     ),
//           //                     Text(
//           //                       '39,325.82',
//           //                       style: TextStyle(
//           //                         color: AppTextColors.white,
//           //                         fontFamily: "Helvetica",
//           //                         fontWeight: FontWeight.w700,
//           //                         fontSize:SizeUtil.headingLarge(context),
//           //                       ),
//           //                     ),
//           //                   ],
//           //                 ),
//           //                 const SizedBox(
//           //                   height: 5,
//           //                 ),
//           //                 Container(
//           //                   child: Center(
//           //                     child: Text(
//           //                       'Last Updated: Aug 6, 2023 | 5:00 pm',
//           //                       style: TextStyle(
//           //                         color: AppTextColors.white,
//           //                         fontFamily: "Helvetica",
//           //                         fontWeight: FontWeight.w400,
//           //                         fontSize: SizeUtil.headingSmall(context),
//           //                       ),
//           //                     ),
//           //                   ),
//           //                 ),
//           //               ],
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           SizedBox(
//             height: SizeUtil.verticalSpacingMedium(context),
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(
//                   left: height * 0.02,
//                   right: height * 0.02),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const MutualFundSchemeDetails()),
//                           );
//                       },
//                       child: Container(
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
//                         width: double.infinity,
//                         child: Padding(
//                           padding: EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Scheme Details",
//                                 style: TextStyle(
//                                   color: AppColors.primary,
//                                   fontSize: SizeUtil.headingMedium(context),
//                                   fontWeight: FontWeight.w700,
//                                   fontFamily: "Helvetica",
//                                 ),
//                               ),
//                               const SizedBox(
//                                   height:
//                                       DefaultSizes.spacingBetweenTexts,
//                                 ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'UTI Nifty 50 Infed Fund',
//                                     style: TextStyle(
//                                         color: AppColors.grey,
//                                         fontSize:SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 5.0),
//                                     child: Icon(
//                                       Icons.arrow_right_alt_sharp,
//                                       size: SizeUtil.iconsSize(context)
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: SizeUtil.verticalSpacingMedium(context),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 6,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Scheme',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const  SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               Text(
//                                 'UTI Nifty 50 Index Fund',
//                                 style: TextStyle(
//                                     color: AppColors.grey,
//                                     fontSize: SizeUtil.body(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Spacer(),
//                         Expanded(
//                           flex: 6,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Type',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize:  SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const  SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               Text(
//                                 'Regular | Growth',
//                                 style: TextStyle(
//                                     color: AppColors.grey,
//                                     fontSize:  SizeUtil.body(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height:  SizeUtil.verticalSpacingMedium(context),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 6,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Category',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const  SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               Text(
//                                 'Others - Index Funds/ETFs',
//                                 style: TextStyle(
//                                     color: AppColors.grey,
//                                     fontSize: SizeUtil.body(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Spacer(),
//                         Expanded(
//                           flex: 6,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Current NAV',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const  SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               RichText(
//                                  textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                                 textAlign: TextAlign.start,
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: '₹',
//                                       style: TextStyle(
//                                           letterSpacing: 2,
//                                           color: AppColors.grey,
//                                           fontSize:  SizeUtil.body(context)),
//                                     ),
//                                     TextSpan(
//                                       text: "2700.72",
//                                       style: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize: SizeUtil.body(context),
//                                           fontFamily: "Helvetica"),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: SizeUtil.verticalSpacingMedium(context),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 6,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Minimum Investment',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const  SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               RichText(
//                                  textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                                 textAlign: TextAlign.start,
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: '₹',
//                                       style: TextStyle(
//                                           letterSpacing: 2,
//                                           color: AppColors.grey,
//                                           fontSize: SizeUtil.body(context)),
//                                     ),
//                                     TextSpan(
//                                       text: "1,000",
//                                       style: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize:  SizeUtil.body(context),
//                                           fontFamily: "Helvetica"),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Spacer(),
//                         Expanded(
//                           flex: 6,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Investment Multiple',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize:  SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const  SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               RichText(
//                                  textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                                 textAlign: TextAlign.start,
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: '₹',
//                                       style: TextStyle(
//                                           letterSpacing: 2,
//                                           color: AppColors.grey,
//                                           fontSize:  SizeUtil.body(context)),
//                                     ),
//                                     TextSpan(
//                                       text: "1.0",
//                                       style: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize:  SizeUtil.body(context),
//                                           fontFamily: "Helvetica"),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height:  SizeUtil.verticalSpacingMedium(context),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Column(
//          mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//                Padding(
//             padding: EdgeInsets.only(
//                 right: width * 0.10, left: width * 0.10, bottom: SizeUtil.buttonPaddingBottom(context)),
//             child: Container(
//               color: AppColors.white,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   LargeButton(
//                       text: "Modify",
//                       backgroundColor: AppColors.primary,
//                       textColor: AppColors.white,
//                       onPressed: () {
//                       })
//                 ],
//               ),
//             ),
//           ),
//            Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           SmallButton(
//               text: "Pause",
//               onPressed: () {
//               },
//               backgroundColor: AppColors.white,
//               textColor: AppColors.primary),
//           SmallButton(
//               text: "Delete",
//               onPressed: () {
//               },
//               backgroundColor: AppColors.white,
//               textColor: AppColors.primary),
//               ]),
//         ],
//       ),
//         ],
//       ),
//     );
//   }
// }
