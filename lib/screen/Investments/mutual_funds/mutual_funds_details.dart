// import 'package:midas/Widgets/appbar/large_appbar.dart';
// import 'package:midas/Widgets/buttons/small_button.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/sizeConstant.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_buy.dart';
// import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_details.dart';
// import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_redeem.dart';
// import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_sip.dart';
// import 'package:flutter/material.dart';

// class MutualFundDetails extends StatefulWidget {
//   const MutualFundDetails({super.key});

//   @override
//   State<MutualFundDetails> createState() => _MutualFundDetailsState();
// }

// class _MutualFundDetailsState extends State<MutualFundDetails> {
//   var height;
//   var width;

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     height = screenSize.height;
//     width = screenSize.width;
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const LargeAppbar(
//               heading: "Current Value",
//               isAmount: true,
//               isbackButtonAvailable: true,
//               content: "39,325.82",
//               timeline: "Last Updated: Aug 6, 2023 | 5:00 pm"),
//           SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: width * 0.04,
//                 right: width * 0.04,
//               ),
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: height * 0.22),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     const MutualFundSchemeDetails()),
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: AppColors.shadow.withOpacity(0.01),
//                                 offset: const Offset(0, 1),
//                                 blurRadius: 1.0,
//                                 spreadRadius: 1.0,
//                               ),
//                             ],
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(
//                               color: AppColors.lightgrey, // Border color
//                               width: 2.0, // Border width
//                             ),
//                             color: AppColors.white,
//                           ),
//                           width: double.infinity,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Scheme Details",
//                                   style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.headingMedium(context),
//                                     fontWeight: FontWeight.w700,
//                                     fontFamily: "Helvetica",
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height:
//                                       DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'UTI Nifty 50 Infed Fund',
//                                       style: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize: SizeUtil.body(context),
//                                           fontFamily: "Helvetica"),
//                                     ),
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 5.0),
//                                       child: Icon(
//                                         Icons.arrow_right_alt_sharp,
//                                         size: SizeUtil.iconsSize(context),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             flex: 6,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Scheme',
//                                   style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.bodyLarge(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                                  const SizedBox(height: DefaultSizes.spacingBetweenTexts,),
//                                 Text(
//                                   'UTI Nifty 50 Index Fund',
//                                   style: TextStyle(
//                                       color: AppColors.grey,
//                                       fontSize: SizeUtil.body(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Spacer(),
//                           Expanded(
//                             flex: 6,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Type',
//                                   style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.bodyLarge(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                                 const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                 Text(
//                                   'Regular | Growth',
//                                   style: TextStyle(
//                                       color: AppColors.grey,
//                                       fontSize: SizeUtil.body(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: SizeUtil.verticalSpacingMedium(context),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             flex: 6,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Category',
//                                   style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.bodyLarge(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                                 const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                 Text(
//                                   'Others - Index Funds/ETFs',
//                                   style: TextStyle(
//                                       color: AppColors.grey,
//                                       fontSize: SizeUtil.body(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Spacer(),
//                           Expanded(
//                             flex: 6,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Current NAV',
//                                   style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.bodyLarge(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                                 const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                 RichText(
//                                    textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                                   textAlign: TextAlign.start,
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: '₹',
//                                         style: TextStyle(
//                                             letterSpacing: 2,
//                                             color: AppColors.grey,
//                                             fontSize: SizeUtil.body(context)),
//                                       ),
//                                       TextSpan(
//                                         text: "2700.72",
//                                         style: TextStyle(
//                                             color: AppColors.grey,
//                                             fontSize: SizeUtil.body(context),
//                                             fontFamily: "Helvetica"),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: SizeUtil.verticalSpacingMedium(context),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             flex: 6,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Investment',
//                                   style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.bodyLarge(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                                 const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                 RichText(
//                                    textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                                   textAlign: TextAlign.start,
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: '₹',
//                                         style: TextStyle(
//                                             letterSpacing: 2,
//                                             color: AppColors.grey,
//                                             fontSize: SizeUtil.body(context)),
//                                       ),
//                                       TextSpan(
//                                         text: "30,000.82",
//                                         style: TextStyle(
//                                             color: AppColors.grey,
//                                             fontSize: SizeUtil.body(context),
//                                             fontFamily: "Helvetica"),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Spacer(),
//                           Expanded(
//                             flex: 6,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'P&L',
//                                   style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.bodyLarge(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                                 const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                 RichText(
//                                    textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                                   textAlign: TextAlign.start,
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: '₹',
//                                         style: TextStyle(
//                                             letterSpacing: 2,
//                                             color: AppColors.green,
//                                             fontSize: SizeUtil.body(context)),
//                                       ),
//                                       TextSpan(
//                                         text: "9325.00",
//                                         style: TextStyle(
//                                             color: AppColors.green,
//                                             fontSize: SizeUtil.body(context),
//                                             fontFamily: "Helvetica"),
//                                       ),
//                                       TextSpan(
//                                         text: " (+31.08%)",
//                                         style: TextStyle(
//                                             color: AppColors.green,
//                                             fontSize: SizeUtil.body(context),
//                                             fontFamily: "Helvetica"),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: SizeUtil.verticalSpacingMedium(context),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             flex: 6,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Units',
//                                   style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.bodyLarge(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                                 const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                 Text(
//                                   '30.0000',
//                                   style: TextStyle(
//                                       color: AppColors.grey,
//                                       fontSize: SizeUtil.body(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Spacer(),
//                           Expanded(
//                             flex: 6,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Average NAV',
//                                   style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.bodyLarge(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                                 const SizedBox(
//                                   height: DefaultSizes.spacingBetweenTexts,
//                                 ),
//                                 RichText(
//                                    textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                                   textAlign: TextAlign.start,
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: '₹',
//                                         style: TextStyle(
//                                             letterSpacing: 2,
//                                             color: AppColors.grey,
//                                             fontSize: SizeUtil.body(context)),
//                                       ),
//                                       TextSpan(
//                                         text: "2300.07",
//                                         style: TextStyle(
//                                             color: AppColors.grey,
//                                             fontSize: SizeUtil.body(context),
//                                             fontFamily: "Helvetica"),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               SmallButton(
//                   text: "Buy",
//                   backgroundColor: AppColors.primary,
//                   textColor: AppColors.white,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const MutualFundSchemeBuy()),
//                     );
//                   }),
//               SmallButton(
//                   text: "Redeem",
//                   backgroundColor: AppColors.white,
//                   textColor: AppColors.primary,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const MutualFundSchemeRedeem()),
//                     );
//                   }),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               SmallButton(
//                   text: "SIP",
//                   backgroundColor: AppColors.primary,
//                   textColor: AppColors.white,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const MutualFundSchemeSIP()),
//                     );
//                   }),
//               SmallButton(
//                   text: "Transactions",
//                   backgroundColor: AppColors.white,
//                   textColor: AppColors.primary,
//                   onPressed: () {}),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
