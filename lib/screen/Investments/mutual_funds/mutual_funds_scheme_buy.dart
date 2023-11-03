// import 'package:midas/Widgets/appbar/large_appbar.dart';
// import 'package:midas/Widgets/buttons/large_button.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/sizeConstant.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:midas/widgets/confirmation_dialog_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class MutualFundSchemeBuy extends StatefulWidget {
//   const MutualFundSchemeBuy({super.key});

//   @override
//   State<MutualFundSchemeBuy> createState() => _MutualFundSchemeBuyState();
// }

// class _MutualFundSchemeBuyState extends State<MutualFundSchemeBuy> {
//   var height;
//   var width;

//   int selectedPaymentMode = 0;

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
//           const LargeAppbar(
//               heading: "",
//               isAmount: false,
//               isbackButtonAvailable: true,
//               content: "UTI AMC",
//               timeline: "Last Updated: Aug 6, 2023 | 5:00 pm"),
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
//           //                           builder: (context) =>
//           //                               const Notifications()),
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
//           //                           builder: (context) =>
//           //                               const ProfileAndSettings()),
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
//           //                   'UTI AMC',
//           //                   style: TextStyle(
//           //                     color: AppTextColors.white,
//           //                     fontFamily: "Helvetica",
//           //                     fontWeight: FontWeight.w700,
//           //                     fontSize: SizeUtil.headingLarge(context),
//           //                   ),
//           //                 ),
//           //                 const SizedBox(
//           //                   height: 5,
//           //                 ),
//           //                 Center(
//           //                   child: Text(
//           //                     'Last Updated: Aug 6, 2023 | 5:00 pm',
//           //                     style: TextStyle(
//           //                       color: AppTextColors.white,
//           //                       fontFamily: "Helvetica",
//           //                       fontWeight: FontWeight.w400,
//           //                       fontSize: SizeUtil.headingSmall(context),
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
//               padding:
//                   EdgeInsets.only(left: height * 0.02, right: height * 0.02),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
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
//                               const SizedBox(
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
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               Text(
//                                 'Regular | Growth',
//                                 style: TextStyle(
//                                     color: AppColors.grey,
//                                     fontSize: SizeUtil.body(context),
//                                     fontFamily: "Helvetica"),
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
//                                 'Category',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const SizedBox(
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
//                               const SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               RichText(
//                                textScaleFactor:MediaQuery.of(context).textScaleFactor,
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
//                               const SizedBox(
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
//                                       text: "1000",
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
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const SizedBox(
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
//                                       text: "1.0",
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
//                                 'Expense Ratio',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               Text(
//                                 '1.25%',
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
//                                 'Lock-in-period',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               Text(
//                                 "NA",
//                                 style: TextStyle(
//                                     color: AppColors.grey,
//                                     fontSize: SizeUtil.body(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: SizeUtil.verticalSpacingMedium(context),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Payment Mode',
//                           style: TextStyle(
//                               color: AppColors.primary,
//                               fontSize: SizeUtil.bodyLarge(context),
//                               fontFamily: "Helvetica"),
//                         ),
//                         const SizedBox(
//                           height: DefaultSizes.spacingBetweenTexts,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: Row(
//                                 children: [
//                                   Radio(
//                                     activeColor: AppColors.primary,
//                                     value: 0,
//                                     groupValue: selectedPaymentMode,
//                                     visualDensity: const VisualDensity(
//                                         horizontal:
//                                             VisualDensity.minimumDensity,
//                                         vertical: VisualDensity.minimumDensity),
//                                     materialTapTargetSize:
//                                         MaterialTapTargetSize.shrinkWrap,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         selectedPaymentMode = value!;
//                                       });
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       "UPI",
//                                       style: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize: SizeUtil.body(context),
//                                           fontFamily: "Helvetica"),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               flex: 3,
//                               child: Row(
//                                 children: [
//                                   Radio(
//                                     activeColor: AppColors.primary,
//                                     value: 1,
//                                     groupValue: selectedPaymentMode,
//                                     visualDensity: const VisualDensity(
//                                         horizontal:
//                                             VisualDensity.minimumDensity,
//                                         vertical: VisualDensity.minimumDensity),
//                                     materialTapTargetSize:
//                                         MaterialTapTargetSize.shrinkWrap,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         selectedPaymentMode = value!;
//                                       });
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       "Net Banking",
//                                       style: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize: SizeUtil.body(context),
//                                           fontFamily: "Helvetica"),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               flex: 3,
//                               child: Row(
//                                 children: [
//                                   Radio(
//                                     activeColor: AppColors.primary,
//                                     value: 2,
//                                     groupValue: selectedPaymentMode,
//                                     visualDensity: const VisualDensity(
//                                         horizontal:
//                                             VisualDensity.minimumDensity,
//                                         vertical: VisualDensity.minimumDensity),
//                                     materialTapTargetSize:
//                                         MaterialTapTargetSize.shrinkWrap,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         selectedPaymentMode = value!;
//                                       });
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       "NEFT / RTGS",
//                                       style: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize: SizeUtil.body(context),
//                                           fontFamily: "Helvetica"),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: SizeUtil.verticalSpacingMedium(context),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Investment Amount',
//                           style: TextStyle(
//                               color: AppColors.primary,
//                               fontSize: SizeUtil.bodyLarge(context),
//                               fontFamily: "Helvetica"),
//                         ),
//                         const SizedBox(
//                           height: DefaultSizes.spacingBetweenTexts,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 40),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 width: width * 0.12,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5),
//                                   child: TextFormField(
//                                     readOnly: true,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.symmetric(
//                                         horizontal: width * 0.04,
//                                         vertical:
//                                             SizeUtil.verticalSpacingMedium(
//                                                 context),
//                                       ),
//                                       counterText: "",
//                                       filled: true,
//                                       isDense: true,
//                                       hintText: '₹',
//                                       hintStyle: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize:
//                                               SizeUtil.scallingFactor(context) *
//                                                   24),
//                                       border: InputBorder.none,
//                                       fillColor: TextfieldColors.background,
//                                     ),
//                                     style: TextStyle(
//                                         fontSize:
//                                             SizeUtil.scallingFactor(context) *
//                                                 24,
//                                         color: AppColors.grey),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Expanded(
//                                 flex: 14,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5),
//                                   child: TextFormField(
//                                     maxLength: 15,
//                                     keyboardType:
//                                         const TextInputType.numberWithOptions(
//                                             signed: true, decimal: true),
//                                     inputFormatters: [
//                                       FilteringTextInputFormatter.digitsOnly,
//                                     ],
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.symmetric(
//                                           horizontal: width * 0.04,
//                                           vertical:
//                                               SizeUtil.verticalSpacingMedium(
//                                                   context)),
//                                       counterText: "",
//                                       suffixIconConstraints:
//                                           const BoxConstraints(),
//                                       filled: true,
//                                       isDense: true,
//                                       border: InputBorder.none,
//                                       hintText: '1,000',
//                                       hintStyle: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize:
//                                               SizeUtil.scallingFactor(context) *
//                                                   24),
//                                       fillColor: TextfieldColors.background,
//                                     ),
//                                     style: TextStyle(
//                                         fontSize:
//                                             SizeUtil.scallingFactor(context) *
//                                                 24),
//                                   ),
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
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.error_outline,
//                             size: SizeUtil.iconsSize(context)),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Expanded(
//                           child: Text(
//                             "NAV allotment is based on the day funds are realised at the clearing corporation",
//                             style: TextStyle(
//                                 color: AppColors.grey,
//                                 fontSize: SizeUtil.body(context),
//                                 fontFamily: "Helvetica"),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: SizeUtil.verticalSpacingMedium(context),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//                 right: width * 0.10,
//                 left: width * 0.10,
//                 bottom: SizeUtil.buttonPaddingBottom(context)),
//             child: Container(
//               color: AppColors.white,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   LargeButton(
//                       text: "Buy",
//                       backgroundColor: AppColors.primary,
//                       textColor: AppColors.white,
//                       onPressed: () {
//                         confirmBuy(context);
//                       })
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> confirmBuy(BuildContext context) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return ConfirmDialogBox(
//             heading: "Confirm Order",
//             body: "Invest Rs. <\$amount> in <\$mutual_fund>",
//             message: "Orders cannot be cancelled after they are placed");
//       },
//     );
//   }
// }
