// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/sizeConstant.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:midas/data/mutual_funds_list.dart';
// import 'package:midas/screen/Investments/mutual_funds/mutual_funds_details.dart';
// import 'package:flutter/material.dart';

// class MutualFundsPortfolio extends StatefulWidget {
//   const MutualFundsPortfolio({super.key});

//   @override
//   State<MutualFundsPortfolio> createState() => _MutualFundsPortfolioState();
// }

// class _MutualFundsPortfolioState extends State<MutualFundsPortfolio> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.shadow.withOpacity(0.01),
//                     offset: const Offset(0, 1),
//                     blurRadius: 1.0,
//                     spreadRadius: 1.0,
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(5),
//                 border: Border.all(
//                   color: AppColors.lightgrey, // Border color
//                   width: 2.0, // Border width
//                 ),
//                 color: AppColors.white,
//               ),
//               width: double.infinity,
//               child: Padding(
//                 padding: EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Investment',
//                               style: TextStyle(
//                                 color: AppColors.primary,
//                                 fontSize: SizeUtil.body(context),
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: "Helvetica",
//                               ),
//                             ),
//                             SizedBox(
//                               height: SizeUtil.verticalSpacingSmall(context),
//                             ),
//                             RichText(
//                                textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                               textAlign: TextAlign.start,
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                       text: '₹',
//                                       style: TextStyle(
//                                         letterSpacing: 2,
//                                         color: AppColors.primary,
//                                         fontSize:
//                                             SizeUtil.headingMedium(context),
//                                       )),
//                                   TextSpan(
//                                     text: '1,00,000',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize:
//                                             SizeUtil.headingMedium(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Current Value',
//                               style: TextStyle(
//                                 color: AppColors.primary,
//                                 fontSize: SizeUtil.body(context),
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: "Helvetica",
//                               ),
//                             ),
//                             SizedBox(
//                               height: SizeUtil.verticalSpacingSmall(context),
//                             ),
//                             RichText(
//                                textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                               textAlign: TextAlign.start,
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                       text: '₹',
//                                       style: TextStyle(
//                                         letterSpacing: 2,
//                                         color: AppColors.primary,
//                                         fontSize:
//                                             SizeUtil.headingMedium(context),
//                                       )),
//                                   TextSpan(
//                                     text: '1,10,000',
//                                     style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.headingMedium(context),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: SizeUtil.verticalSpacingSmall(context),
//                     ),
//                     const Divider(
//                       color: AppColors.lightgrey,
//                       thickness: 1.0,
//                       height: 10,
//                     ),
//                     SizedBox(
//                       height: SizeUtil.verticalSpacingSmall(context),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'P&L',
//                           style: TextStyle(
//                               color: AppColors.primary,
//                               fontSize: SizeUtil.bodyLarge(context),
//                               fontWeight: FontWeight.w700,
//                               fontFamily: "Helvetica"),
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             RichText(
//                                textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                               textAlign: TextAlign.start,
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                       text: '₹',
//                                       style: TextStyle(
//                                         letterSpacing: 2,
//                                         color: AppColors.green,
//                                         fontSize:
//                                             SizeUtil.headingMedium(context),
//                                       )),
//                                   TextSpan(
//                                     text: '10,000',
//                                     style: TextStyle(
//                                       color: AppColors.green,
//                                       fontSize: SizeUtil.headingMedium(context),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.02,
//                             ),
//                             Material(
//                               borderRadius: BorderRadius.circular(
//                                   SizeUtil.scallingFactor(context) * 10),
//                               elevation: 2,
//                               shadowColor: AppColors.black,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(
//                                       SizeUtil.scallingFactor(context) * 10),
//                                   color: AppColors.lightgreen,
//                                 ),
//                                 child: Center(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             SizeUtil.scallingFactor(context) *
//                                                 20,
//                                         vertical: 3),
//                                     child: Text(
//                                       "10.0 %",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: AppColors.green,
//                                         fontSize: SizeUtil.bodySmall(context),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: SizeUtil.verticalSpacingMedium(context),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Text(
//                 "Mutual Funds",
//                 style: TextStyle(
//                   color: AppColors.primary,
//                   fontSize: SizeUtil.headingMedium(context),
//                   fontWeight: FontWeight.w700,
//                   fontFamily: "Helvetica",
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: SizeUtil.verticalSpacingSmall(context),
//             ),
//             getMutualFundsSection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget getMutualFundsSection() {
//     return ListView.builder(
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: mutualFundsList.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const MutualFundDetails()),
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.shadow.withOpacity(0.01),
//                   offset: const Offset(0, 1),
//                   blurRadius: 1.0,
//                   spreadRadius: 1.0,
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(
//                 color: AppColors.lightgrey,
//                 width: 2.0,
//               ),
//               color: AppColors.white,
//             ),
//             width: double.infinity,
//             margin: EdgeInsets.only(
//               bottom: SizeUtil.verticalSpacingSmall(context),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Units ${mutualFundsList[index]['qty']}',
//                             style: TextStyle(
//                               color: AppColors.primary,
//                               fontSize: SizeUtil.body(context),
//                               fontFamily: "Helvetica",
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             '|',
//                             style: TextStyle(
//                               color: AppColors.primary,
//                               fontSize: SizeUtil.body(context),
//                               fontFamily: "Helvetica",
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             'Avg. NAV ${mutualFundsList[index]['avg']}',
//                             style: TextStyle(
//                               color: AppColors.primary,
//                               fontSize: SizeUtil.body(context),
//                               fontFamily: "Helvetica",
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         'NAV. ${mutualFundsList[index]['ltp']}',
//                         style: TextStyle(
//                           color: AppColors.primary,
//                           fontSize: SizeUtil.body(context),
//                           fontFamily: "Helvetica",
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: SizeUtil.verticalSpacingSmall(context),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '${mutualFundsList[index]['name']}',
//                         style: TextStyle(
//                           color: AppColors.primary,
//                           fontSize: SizeUtil.bodyLarge(context),
//                           fontWeight: FontWeight.w700,
//                           fontFamily: "Helvetica",
//                         ),
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             '+9,325.00',
//                             style: TextStyle(
//                                 color: AppColors.green,
//                                 fontSize: SizeUtil.bodyLarge(context),
//                                 fontFamily: "Helvetica"),
//                           ),
//                           const SizedBox(
//                             height: DefaultSizes.spacingBetweenTexts,
//                           ),
//                           Text(
//                             '+31.08%',
//                             style: TextStyle(
//                                 color: AppColors.green,
//                                 fontSize: SizeUtil.bodySmall(context),
//                                 fontFamily: "Helvetica"),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                    SizedBox(height: SizeUtil.verticalSpacingSmall(context),),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Invested: ${mutualFundsList[index]['invested']}',
//                         style: TextStyle(
//                             color: AppColors.primary,
//                             fontSize: SizeUtil.body(context),
//                             fontFamily: "Helvetica"),
//                       ),
//                        Text(
//                     'Value: ${mutualFundsList[index]['currentValue']}',
//                     style: TextStyle(
//                         color: AppColors.primary,
//                         fontSize: SizeUtil.body(context),
//                         fontFamily: "Helvetica"),
//                   ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
