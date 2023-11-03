// import 'package:midas/Widgets/appbar/large_appbar.dart';
// import 'package:midas/Widgets/buttons/large_button.dart';
// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/sizeConstant.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class MutualFundSchemeSIP extends StatefulWidget {
//   const MutualFundSchemeSIP({super.key});

//   @override
//   State<MutualFundSchemeSIP> createState() => _MutualFundSchemeSIPState();
// }

// class _MutualFundSchemeSIPState extends State<MutualFundSchemeSIP> {
//   var height;
//   var width;

//   bool isRedeemAllUnits = false;
//   List startDays = [
//     {"id": 1, "days": "14"}
//   ];

//   bool _showDataDropdown = false;
//   String _selectedData = "";
//   List<String> dataList = ["14", "15", "16"];
//   TextEditingController dataController = TextEditingController();

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
//                   left: height * 0.02,
//                   right: height * 0.02,
//                   ),
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
//                              const SizedBox(
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
//                             const SizedBox(
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
//                                  textScaleFactor:MediaQuery.of(context).textScaleFactor,
//                                 textAlign: TextAlign.start,
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: '₹',
//                                       style: TextStyle(
//                                           letterSpacing: 2,
//                                           color: AppColors.grey,
//                                           fontSize:SizeUtil.body(context)),
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
//                                     fontSize:SizeUtil.bodyLarge(context),
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
//                                       text: "1,000",
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
//                                           fontSize:SizeUtil.body(context),
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
//                       height:SizeUtil.verticalSpacingMedium(context),
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
//                         SizedBox(height: SizeUtil.verticalSpacingSmall(context),),
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
//                                 'Frequency',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                               const SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               SizedBox(
//                                 width: SizeUtil.scallingFactor(context)*100,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5),
//                                   child: TextFormField(
//                                     readOnly: true,
//                                     decoration: const InputDecoration(
//                                       counterText: "",
//                                       filled: true,
//                                       isDense: true,
//                                       hintText: 'Monthly',
//                                       hintStyle: TextStyle(
//                                         color: AppColors.grey,
//                                       ),
//                                       border: InputBorder.none,
//                                       fillColor: TextfieldColors.background,
//                                     ),
//                                     style:  TextStyle(color: AppColors.grey,fontSize: SizeUtil.body(context)),
//                                   ),
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
//                                 'Start Day',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.bodyLarge(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                              const SizedBox(
//                                 height: DefaultSizes.spacingBetweenTexts,
//                               ),
//                               SizedBox(
//                                 width: SizeUtil.scallingFactor(context)*100,
//                                 child: Column(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(5),
//                                       child: TextFormField(
//                                         autovalidateMode:
//                                             AutovalidateMode.onUserInteraction,
//                                         decoration:  InputDecoration(
//                                           suffixIcon: Icon(
//                                             Icons.arrow_drop_down,
//                                             size: SizeUtil.iconsSize(context),
//                                             color: AppColors.primary,
//                                           ),
//                                           suffixIconConstraints:
//                                               BoxConstraints(),
//                                           filled: true,
//                                           isDense: true,
//                                           border: InputBorder.none,
//                                           hintText: '14',
//                                           hintStyle: TextStyle(
//                                               color: AppColors.grey,
//                                               fontSize:  SizeUtil.body(context),
//                                               fontFamily: "Helvetica"),
//                                           fillColor: TextfieldColors.background,
//                                         ),
//                                         readOnly: true,
//                                         onTap: _toggleDataDropDown,
//                                         style:  TextStyle(fontSize: SizeUtil.body(context),color: AppColors.grey),
//                                         controller: dataController,
//                                       ),
//                                     ),
//                                     if (_showDataDropdown)
//                                       Card(
//                                         color:
//                                             const Color.fromARGB(255, 255, 254, 254),
//                                         elevation: 2,
//                                         child: ListView.builder(
//                                           padding: EdgeInsets.zero,
//                                           shrinkWrap: true,
//                                           itemCount: dataList.length,
//                                           itemBuilder: (context, index) {
//                                             final option = dataList[index];
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _selectedData = option;
//                                                   dataController.text =
//                                                       _selectedData;
//                                                   _showDataDropdown = false;
//                                                 });
//                                               },
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 8,
//                                                         horizontal: 16),
//                                                 child: Text(option,style: TextStyle(fontSize:SizeUtil.body(context)),),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: SizeUtil.verticalSpacingLarge(context),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.error_outline, size: SizeUtil.iconsSize(context)),
//                          SizedBox(
//                           width: width*0.02,
//                         ),
//                         Expanded(
//                           child: Text(
//                             "Currently on monthly SIP is supported",
//                             style: TextStyle(
//                                 color: AppColors.grey,
//                                 fontSize:SizeUtil.body(context),
//                                 fontFamily: "Helvetica"),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height:SizeUtil.verticalSpacingMedium(context),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.error_outline, size: SizeUtil.iconsSize(context)),
//                          SizedBox(
//                           width: width*0.02,
//                         ),
//                         Expanded(
//                           child: Text(
//                             "SIP will remain active until cancelled",
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
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.error_outline, size: SizeUtil.iconsSize(context)),
//                          SizedBox(
//                           width: width*0.02,
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
//                     SizedBox(height:SizeUtil.verticalSpacingMedium(context))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//            Padding(
//             padding: EdgeInsets.only(right:width * 0.10,left:width * 0.10,bottom:SizeUtil.buttonPaddingBottom(context)),
//              child: Container(
//               color: AppColors.white,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   LargeButton(text: "Create SIP",
//                    backgroundColor: AppColors.primary,
//                               textColor: AppColors.white,
//                                onPressed:  () {
//                      })
//                 ],
//               ),
//                      ),
//            ),
//         ],
//       ),
//     );
//   }

//   void _toggleDataDropDown() {
//     setState(() {
//       _showDataDropdown = !_showDataDropdown;
//     });
//   }
// }
