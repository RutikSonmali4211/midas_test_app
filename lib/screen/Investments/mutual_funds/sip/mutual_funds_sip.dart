// import 'package:midas/constant/colors.dart';
// import 'package:midas/constant/size_util.dart';
// import 'package:midas/data/mutual_funds/sip_details_list.dart';
// import 'package:midas/model/investments/mutual__funds/sip_details.dart';
// import 'package:midas/screen/Investments/mutual_funds/sip/sip_details.dart';
// import 'package:flutter/material.dart';

// class MutualFundsOrdersSIP extends StatefulWidget {
//   const MutualFundsOrdersSIP({super.key});

//   @override
//   State<MutualFundsOrdersSIP> createState() => _MutualFundsOrdersSIPState();
// }

// class _MutualFundsOrdersSIPState extends State<MutualFundsOrdersSIP> {
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
//           //  const LargeAppbar(heading: "", isAmount: false, isbackButtonAvailable: true, content: "SIP Details", timeline: "Last Updated: Aug 6, 2023 | 5:00 pm"),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: width * 0.04,
//                 right: width * 0.04,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                       child: SingleChildScrollView(
//                           child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     physics: const ScrollPhysics(),
//                     itemCount: sipDetailsList.length,
//                     itemBuilder: (context, index) {
//                       SIPDetails sip = sipDetailsList[index];
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const SIPDetailsScreen()),
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
//                               color: AppColors.lightgrey,
//                               width: 2.0,
//                             ),
//                             color: AppColors.white,
//                           ),
//                           width: double.infinity,
//                           margin: EdgeInsets.only(
//                               bottom: SizeUtil.verticalSpacingMedium(context)),
//                           child: Padding(
//                             padding: EdgeInsets.all(
//                                 SizeUtil.verticalSpacingSmall(context)),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       sip.name,
//                                       style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize:
//                                             SizeUtil.headingMedium(context),
//                                         fontWeight: FontWeight.w700,
//                                         fontFamily: "Helvetica",
//                                       ),
//                                     ),
//                                     Text(
//                                       sip.isActive ? "Active" : "Paused",
//                                       style: TextStyle(
//                                         color: sip.isActive
//                                             ? AppColors.green
//                                             : AppColors.grey,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica",
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       SizeUtil.verticalSpacingSmall(context),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Growth | ${sip.sipType} - ${sip.sipTypeValue}',
//                                       style: TextStyle(
//                                           color: AppColors.primary,
//                                           fontSize: SizeUtil.body(context),
//                                           fontFamily: "Helvetica"),
//                                     ),
//                                     Text(
//                                       '${sip.sipDuration}',
//                                       style: TextStyle(
//                                           color: AppColors.primary,
//                                           fontSize: SizeUtil.body(context),
//                                           fontFamily: "Helvetica"),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       SizeUtil.verticalSpacingSmall(context),
//                                 ),
//                                 Text(
//                                   'Amount: ${sip.amount}',
//                                   style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.body(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       SizeUtil.verticalSpacingSmall(context),
//                                 ),
//                                 Text(
//                                   'Next SIP Instalment: ${sip.nextInstallment}',
//                                   style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.body(context),
//                                       fontFamily: "Helvetica"),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ))),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget sipDetails() {
//   //   return
//   // }
// }
