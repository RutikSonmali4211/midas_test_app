// import 'package:midas/Widgets/appbar/large_appbar.dart';
// import 'package:midas/Widgets/buttons/large_button.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/sizeConstant.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:midas/widgets/confirmation_dialog_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class MutualFundSchemeRedeem extends StatefulWidget {
//   const MutualFundSchemeRedeem({super.key});

//   @override
//   State<MutualFundSchemeRedeem> createState() => _MutualFundSchemeRedeemState();
// }

// class _MutualFundSchemeRedeemState extends State<MutualFundSchemeRedeem> {
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
//             const LargeAppbar(heading: "", isAmount: false, isbackButtonAvailable: true, content: "UTI AMC", timeline: "Last Updated: Aug 6, 2023 | 5:00 pm"),
//           SizedBox(
//             height: SizeUtil.verticalSpacingMedium(context),
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(
//                   left:width *0.04,
//                   right: width *0.04),
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
//                                 const SizedBox(
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
//                                const SizedBox(
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
//                                 'Redemption Multiple',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                                const SizedBox(
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
//                                 'Units',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                           const SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               Text(
//                                 "3984.2829",
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
//                                 'Approx. Value',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
                               
//                              const SizedBox(
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
//                                       text: "31,049.093",
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
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Redemption Amount',
//                           style: TextStyle(
//                               color: AppColors.primary,
//                               fontSize: SizeUtil.bodyLarge(context),
//                               fontFamily: "Helvetica"),
//                         ),
//                       const SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
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
//                                           horizontal: width * 0.04,
//                                           vertical: SizeUtil.verticalSpacingMedium(context),),
//                                       counterText: "",
//                                       filled: true,
//                                       isDense: true,
//                                       hintText: '₹',
//                                       hintStyle: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize: SizeUtil.scallingFactor(context)*24),
//                                       border: InputBorder.none,
//                                       fillColor: TextfieldColors.background,
//                                     ),
//                                     style: TextStyle(
//                                         fontSize: SizeUtil.scallingFactor(context)*24,
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
//                                           vertical: SizeUtil.verticalSpacingMedium(context)),
//                                       counterText: "",
//                                       suffixIconConstraints: const BoxConstraints(),
//                                       filled: true,
//                                       isDense: true,
//                                       border: InputBorder.none,
//                                       hintText: '1,000',
//                                       hintStyle: TextStyle(
//                                           color: AppColors.grey,
//                                           fontSize: SizeUtil.scallingFactor(context)*24),
//                                       fillColor: TextfieldColors.background,
//                                     ),
//                                     style: TextStyle(fontSize: SizeUtil.scallingFactor(context)*24),
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
//                       children: [
//                         Theme(
//                           data: ThemeData(
//                             unselectedWidgetColor: AppColors.primary,
//                           ),
//                           child: Transform.scale(
//                             scale: 1,
//                             child: Checkbox(
//                               activeColor: AppColors.primary,
//                               value: isRedeemAllUnits,
//                               visualDensity: const VisualDensity(
//                                 horizontal: VisualDensity.minimumDensity,
//                                 vertical: VisualDensity.minimumDensity,
//                               ),
//                               materialTapTargetSize:
//                                   MaterialTapTargetSize.shrinkWrap,
//                               onChanged: (value) {
//                                 setState(() {
//                                   isRedeemAllUnits = value ?? false;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           'Redeem all units',
//                           style: TextStyle(
//                               fontSize: SizeUtil.bodyLarge(context),
//                               color: AppColors.primary,
//                               fontFamily: "Helvetica"),
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
//                         Icon(Icons.error_outline, size: height * 0.04),
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
//                      SizedBox(
//                       height: SizeUtil.verticalSpacingMedium(context),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//                 right: width * 0.10, left: width * 0.10, bottom: SizeUtil.buttonPaddingBottom(context)),
//             child: Container(
//               color: AppColors.white,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   LargeButton(
//                       text: "Redeem",
//                       backgroundColor: AppColors.primary,
//                       textColor: AppColors.white,
//                       onPressed: () {
//                         confirmRedeem(context);
//                       })
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> confirmRedeem(BuildContext context) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return ConfirmDialogBox(
//             heading: "Confirm Redemption",
//             body: "Redeem Rs. <\$amount> in <\$mutual_fund>",
//             message: "Redemption cannot be cancelled after they are placed");
//       },
//     );
//   }
// }
