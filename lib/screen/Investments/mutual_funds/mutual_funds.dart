import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_portfolio.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_transaction.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_watchlist.dart';
import 'package:flutter/material.dart';
import 'package:midas/screen/Investments/mutual_funds/sip/mutual_funds_sip.dart';

class MutualFundsScreen extends StatefulWidget {
  const MutualFundsScreen({super.key});

  @override
  State<MutualFundsScreen> createState() => _MutualFundsScreenState();
}

class _MutualFundsScreenState extends State<MutualFundsScreen> {
  int selectedIndex = 0;
  var height;
  var width;

  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());

  @override
  void initState() {
    super.initState();
    mutualFundsController.getSchedularlastUpdatedDate(context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          mutualFundsController.mutualFundAmcSearchFocusNode.unfocus();
        });
      },
      child: Scaffold(
        body: DefaultTabController(
          initialIndex: 0,
          length: 4,
          child: Column(
            children: [
              LargeAppbar(
                  heading: "",
                  isAmount: false,
                  isbackButtonAvailable: true,
                  content: "Mutual Funds",
                  timeline:
                      "Last Updated: ${mutualFundsController.schedularLastUpdatedTime}"),
              const SizedBox(height: 10),
              TabBar(
                isScrollable: true,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.grey,
                unselectedLabelStyle: TextStyle(
                    fontSize: SizeUtil.headingMedium(context),
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w700),
                labelStyle: TextStyle(
                    fontSize: SizeUtil.headingMedium(context),
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w700,
                    shadows: const [
                      Shadow(
                        color: AppColors.shadow,
                        offset: Offset(0, 2),
                        blurRadius: 2,
                      )
                    ]),
                indicatorPadding: const EdgeInsets.symmetric(vertical: 1),
                indicator: UnderlineTabIndicator(
                    insets: const EdgeInsets.symmetric(horizontal: 10),
                    borderSide: BorderSide(
                        width: SizeUtil.scallingFactor(context) * 4,
                        color: AppColors.primary),
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                tabs: const <Tab>[
                  Tab(text: 'Portfolio'),
                  Tab(text: 'SIP'),
                  Tab(text: 'Orders'),
                  Tab(text: 'Watchlist'),
                ],
              ),
              SizedBox(
                height: SizeUtil.verticalSpacingMedium(context),
              ),
              const Expanded(
                child: TabBarView(
                  physics: ScrollPhysics(),
                  children: <Widget>[
                    MutualFundsPortfolio(),
                    MutualFundsOrdersSIP(),
                    MutualFundTransactionScreen(
                        isSeeSingleTransaction: false, isinNumber: ""),
                    MutualFundsWatchList()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget showTabs(String title, bool isActive, int index) {
  //   final tabText = Text(
  //     title,
  //     style: TextStyle(
  //       color: isActive ? AppColors.primary : Colors.grey,
  //       fontSize: SizeUtil.headingMedium(context),
  //       fontWeight: FontWeight.w700,
  //       fontFamily: "Helvetica",
  //       shadows: [
  //         isActive
  //             ? const Shadow(
  //                 color: AppColors.shadow,
  //                 offset: Offset(0, 4),
  //                 blurRadius: 4,
  //               )
  //             : const Shadow(),
  //       ],
  //     ),
  //   );

  //   final tabTextPainter = TextPainter(
  //     text: TextSpan(text: title, style: tabText.style),
  //     textDirection: TextDirection.ltr,
  //   );
  //   tabTextPainter.layout();

  //   final underlineWidth = tabTextPainter.width + 20.0;

  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         selectedIndex = index;
  //       });
  //     },
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           width: tabTextPainter.width,
  //           child: tabText,
  //         ),
  //         const SizedBox(
  //           height: 7.0,
  //         ),
  //         if (isActive)
  //           Container(
  //             decoration: const BoxDecoration(
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: AppColors.shadow,
  //                   spreadRadius: 2,
  //                   blurRadius: 4,
  //                   offset: Offset(0, 4),
  //                 ),
  //               ],
  //               borderRadius: BorderRadius.all(Radius.circular(20)),
  //               color: AppColors.primary,
  //             ),
  //             height: height * 0.009,
  //             width: underlineWidth,
  //           ),
  //       ],
  //     ),
  //   );
  // }

  // Widget getSwitchedTab(int index) {
  //   switch (selectedIndex) {
  //     case 0:
  //       return portfolioSection();
  //     case 1:
  //       return ordersSection();
  //     case 2:
  //       return watchListSection();
  //     default:
  //       return Container();
  //   }
  // }

  // Widget portfolioSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         decoration: BoxDecoration(
  //           boxShadow: [
  //             BoxShadow(
  //               color: AppColors.shadow.withOpacity(0.1),
  //               offset: const Offset(0, 1),
  //               blurRadius: 1.0,
  //               spreadRadius: 1.0,
  //             ),
  //           ],
  //           borderRadius: BorderRadius.circular(5),
  //           border: Border.all(
  //             color: AppColors.lightgrey, // Border color
  //             width: 2.0, // Border width
  //           ),
  //           color: AppColors.white,
  //         ),
  //         width: double.infinity,
  //         child: Padding(
  //           padding:  EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         'Investment',
  //                         style: TextStyle(
  //                           color: AppColors.primary,
  //                           fontSize: SizeUtil.body(context),
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: "Helvetica",
  //                         ),
  //                       ),
  //                        SizedBox(
  //                         height: SizeUtil.verticalSpacingSmall(context),
  //                       ),
  //                       RichText(
  //                         textAlign: TextAlign.start,
  //                         text: TextSpan(
  //                           children: [
  //                             TextSpan(
  //                                 text: '₹',
  //                                 style: TextStyle(
  //                                   letterSpacing: 2,
  //                                   color: AppColors.primary,
  //                                   fontSize: SizeUtil.headingMedium(context),
  //                                 )),
  //                             TextSpan(
  //                               text: '1,00,000',
  //                               style: TextStyle(
  //                                   color: AppColors.primary,
  //                                   fontSize: SizeUtil.headingMedium(context),
  //                                   fontFamily: "Helvetica"),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         'Current Value',
  //                         style: TextStyle(
  //                           color: AppColors.primary,
  //                           fontSize: SizeUtil.body(context),
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: "Helvetica",
  //                         ),
  //                       ),
  //                        SizedBox(
  //                         height: SizeUtil.verticalSpacingSmall(context),
  //                       ),
  //                       RichText(
  //                         textAlign: TextAlign.start,
  //                         text: TextSpan(
  //                           children: [
  //                             TextSpan(
  //                                 text: '₹',
  //                                 style: TextStyle(
  //                                   letterSpacing: 2,
  //                                   color: AppColors.primary,
  //                                   fontSize: SizeUtil.headingMedium(context),
  //                                 )),
  //                             TextSpan(
  //                               text: '1,10,000',
  //                               style: TextStyle(
  //                                   color: AppColors.primary,
  //                                   fontSize: SizeUtil.headingMedium(context),
  //                                   fontFamily: "Helvetica"),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 ],
  //               ),
  //                SizedBox(
  //                 height: SizeUtil.verticalSpacingSmall(context),
  //               ),
  //               const Divider(
  //                 color: AppColors.lightgrey,
  //                 thickness: 1.0,
  //                 height: 10,
  //               ),
  //                SizedBox(
  //                 height: SizeUtil.verticalSpacingSmall(context),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     'P&L',
  //                     style: TextStyle(
  //                         color: AppColors.primary,
  //                         fontSize: SizeUtil.bodyLarge(context),
  //                         fontWeight: FontWeight.w700,
  //                         fontFamily: "Helvetica"),
  //                   ),
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       RichText(
  //                         textAlign: TextAlign.start,
  //                         text: TextSpan(
  //                           children: [
  //                             TextSpan(
  //                                 text: '₹',
  //                                 style: TextStyle(
  //                                   letterSpacing: 2,
  //                                   color: AppColors.green,
  //                                   fontSize: SizeUtil.headingMedium(context),
  //                                 )),
  //                             TextSpan(
  //                               text: '10,000',
  //                               style: TextStyle(
  //                                   color: AppColors.green,
  //                                   fontSize: SizeUtil.headingMedium(context),
  //                                   fontFamily: "Helvetica"),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: width * 0.02,
  //                       ),
  //                       Material(
  //                         borderRadius: BorderRadius.circular(SizeUtil.scallingFactor(context)*10),
  //                         elevation: 2,
  //                         shadowColor: AppColors.black,
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(SizeUtil.scallingFactor(context)*10),
  //                             color: AppColors.lightgreen,
  //                           ),
  //                           child: Center(
  //                             child: Padding(
  //                               padding:  EdgeInsets.symmetric(horizontal:SizeUtil.scallingFactor(context)*20,vertical:3),
  //                               child: Text(
  //                                 "10.0 %",
  //                                 textAlign: TextAlign.center,
  //                                 style: TextStyle(
  //                                   color: AppColors.green,
  //                                   fontSize: SizeUtil.bodySmall(context),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //        SizedBox(
  //         height: SizeUtil.verticalSpacingMedium(context),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         child: Text(
  //           "Mutual Funds",
  //           style: TextStyle(
  //             color: AppColors.primary,
  //             fontSize: SizeUtil.bodyLarge(context),
  //             fontWeight: FontWeight.w700,
  //             fontFamily: "Helvetica",
  //           ),
  //         ),
  //       ),
  //        SizedBox(
  //         height: SizeUtil.verticalSpacingSmall(context),
  //       ),
  //       getMutualFundsSection(),
  //     ],
  //   );
  // }

  // Widget getMutualFundsSection() {
  //   return ListView.builder(
  //     padding: EdgeInsets.zero,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: mutualFundsList.length,
  //     itemBuilder: (context, index) {
  //       return GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => const MutualFundDetails()),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: AppColors.shadow.withOpacity(0.1),
  //                 offset: const Offset(0, 1),
  //                 blurRadius: 1.0,
  //                 spreadRadius: 1.0,
  //               ),
  //             ],
  //             borderRadius: BorderRadius.circular(5),
  //             border: Border.all(
  //               color: AppColors.lightgrey,
  //               width: 2.0,
  //             ),
  //             color: AppColors.white,
  //           ),
  //           width: double.infinity,
  //           margin:  EdgeInsets.only(bottom:SizeUtil.verticalSpacingSmall(context),),
  //           child: Padding(
  //             padding:  EdgeInsets.all( SizeUtil.verticalSpacingSmall(context)),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'Qty. ${mutualFundsList[index]['qty']}',
  //                           style: TextStyle(
  //                             color: AppColors.primary,
  //                             fontSize: SizeUtil.body(context),
  //                             fontFamily: "Helvetica",
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           width: 5,
  //                         ),
  //                         Text(
  //                           '|',
  //                           style: TextStyle(
  //                             color: AppColors.primary,
  //                             fontSize: SizeUtil.body(context),
  //                             fontFamily: "Helvetica",
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           width: 5,
  //                         ),
  //                         Text(
  //                           'Avg. NAV ${mutualFundsList[index]['avg']}',
  //                           style: TextStyle(
  //                             color: AppColors.primary,
  //                             fontSize: SizeUtil.body(context),
  //                             fontFamily: "Helvetica",
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Text(
  //                       'NAV. ${mutualFundsList[index]['ltp']}',
  //                       style: TextStyle(
  //                         color: AppColors.primary,
  //                         fontSize: SizeUtil.body(context),
  //                         fontFamily: "Helvetica",
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: SizeUtil.verticalSpacingSmall(context),
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       '${mutualFundsList[index]['name']}',
  //                       style: TextStyle(
  //                         color: AppColors.primary,
  //                         fontSize: SizeUtil.bodyLarge(context),
  //                         fontWeight: FontWeight.w700,
  //                         fontFamily: "Helvetica",
  //                       ),
  //                     ),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       children: [
  //                         Text(
  //                           '+9,325.00',
  //                           style: TextStyle(
  //                               color: AppColors.green,
  //                               fontSize: SizeUtil.bodyLarge(context),
  //                               fontFamily: "Helvetica"),
  //                         ),
  //                         const SizedBox(
  //                           height: 5,
  //                         ),
  //                         Text(
  //                           '+31.08%',
  //                           style: TextStyle(
  //                               color: AppColors.green,
  //                               fontSize: SizeUtil.bodySmall(context),
  //                               fontFamily: "Helvetica"),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 Text(
  //                   'Invested: ${mutualFundsList[index]['invested']}',
  //                   style: TextStyle(
  //                       color: AppColors.primary,
  //                       fontSize: SizeUtil.body(context),
  //                       fontFamily: "Helvetica"),
  //                 ),
  //                 Text(
  //                   'Current Value: ${mutualFundsList[index]['currentValue']}',
  //                   style: TextStyle(
  //                       color: AppColors.primary,
  //                       fontSize: SizeUtil.body(context),
  //                       fontFamily: "Helvetica"),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget ordersSection() {
  //   return Column(
  //     children: [
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => const MutualFundsOrdersSIP()),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: AppColors.shadow.withOpacity(0.01),
  //                 offset: const Offset(0, 1),
  //                 blurRadius: 1.0,
  //                 spreadRadius: 1.0,
  //               ),
  //             ],
  //             borderRadius: BorderRadius.circular(5),
  //             border: Border.all(
  //               color: AppColors.lightgrey, // Border color
  //               width: 2.0, // Border width
  //             ),
  //             color: AppColors.white,
  //           ),
  //           width: double.infinity,
  //           child: Padding(
  //             padding: EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "SIP Details",
  //                   style: TextStyle(
  //                     color: AppColors.primary,
  //                     fontSize: SizeUtil.headingMedium(context),
  //                     fontWeight: FontWeight.w700,
  //                     fontFamily: "Helvetica",
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 2,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       '3 Active SIPs',
  //                       style: TextStyle(
  //                           color: AppColors.grey,
  //                           fontSize: SizeUtil.body(context),
  //                           fontFamily: "Helvetica"),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(right: 5.0),
  //                       child: Icon(
  //                         Icons.arrow_right_alt_sharp,
  //                         size: SizeUtil.bodyLarge(context),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height:SizeUtil.verticalSpacingMedium(context),
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => const MutualFundTransactionScreen()),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: AppColors.shadow.withOpacity(0.01),
  //                 offset: const Offset(0, 1),
  //                 blurRadius: 1.0,
  //                 spreadRadius: 1.0,
  //               ),
  //             ],
  //             borderRadius: BorderRadius.circular(5),
  //             border: Border.all(
  //               color: AppColors.lightgrey, // Border color
  //               width: 2.0, // Border width
  //             ),
  //             color: AppColors.white,
  //           ),
  //           width: double.infinity,
  //           child: Padding(
  //             padding: EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "Transaction Details",
  //                   style: TextStyle(
  //                     color: AppColors.primary,
  //                     fontSize: SizeUtil.headingMedium(context),
  //                     fontWeight: FontWeight.w700,
  //                     fontFamily: "Helvetica",
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 2,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'Processing | Complete',
  //                       style: TextStyle(
  //                           color: AppColors.grey,
  //                           fontSize: SizeUtil.body(context),
  //                           fontFamily: "Helvetica"),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(right: 5.0),
  //                       child: Icon(
  //                         Icons.arrow_right_alt_sharp,
  //                         size: SizeUtil.bodyLarge(context),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget watchListSection() {
  //   return Column(
  //     children: [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Expanded(
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(5),
  //               child: TextFormField(
  //                 controller: _searchController,
  //                 maxLength: 150,
  //                 onChanged: (value) {
  //                   setState(() {
  //                     filteredSipDetailsList = sipDetailsList
  //                         .where((sip) => sip.name
  //                             .toLowerCase()
  //                             .contains(value.toLowerCase()))
  //                         .toList();
  //                   });
  //                 },
  //                 autovalidateMode: AutovalidateMode.onUserInteraction,
  //                 decoration:  InputDecoration(
  //                   counterText: "",
  //                   prefixIcon: Padding(
  //                     padding: const EdgeInsets.only(left: 5.0,right: 5.0),
  //                     child: Icon(Icons.search,
  //                         size: SizeUtil.iconsSize(context) ,color: AppColors.primary),
  //                   ),
  //                   prefixIconConstraints: const BoxConstraints(),
  //                   suffixIcon:  Padding(
  //                     padding: const EdgeInsets.only(right: 5.0),
  //                     child: Icon(Icons.highlight_remove_rounded,
  //                         size: SizeUtil.iconsSize(context), color: AppColors.primary),
  //                   ),
  //                   suffixIconConstraints: const BoxConstraints(),
  //                   filled: true,
  //                   isDense: true,
  //                   border: InputBorder.none,
  //                   fillColor: TextfieldColors.background,
  //                 ),
  //                 style:  TextStyle(fontSize: SizeUtil.body(context)),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(width: 10),
  //            Icon(
  //             Icons.filter_alt_sharp,
  //             size: SizeUtil.iconsSize(context),
  //             color: AppColors.primary,
  //           )
  //         ],
  //       ),
  //       const Divider(
  //         color: AppColors.lightgrey,
  //         thickness: 1,
  //         indent: 0,
  //         endIndent: 0,
  //       ),
  //       if (_searchController.text.isEmpty)
  //         ListView.builder(
  //           padding: EdgeInsets.zero,
  //           shrinkWrap: true,
  //           physics: const ScrollPhysics(),
  //           itemCount: sipDetailsList.length,
  //           itemBuilder: (context, index) {
  //             SIPDetails sip = sipDetailsList[index];
  //             return Column(
  //               children: [
  //                 Container(
  //                   width: double.infinity,
  //                   child: Padding(
  //                     padding: EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text(
  //                               sip.name,
  //                               style: TextStyle(
  //                                 color: AppColors.primary,
  //                                 fontSize: SizeUtil.headingMedium(context),
  //                                 fontWeight: FontWeight.w700,
  //                                 fontFamily: "Helvetica",
  //                               ),
  //                             ),
  //                             GestureDetector(
  //                               onTap: () {
  //                               },
  //                               child: Icon(
  //                                 Icons.delete,
  //                                 color: AppColors.primary,
  //                                 size: SizeUtil.iconsSize(context),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(
  //                           height: SizeUtil.verticalSpacingSmall(context),
  //                         ),
  //                         Text(
  //                           'Growth | ${sip.sipType} - ${sip.sipTypeValue}',
  //                           style: TextStyle(
  //                               color: AppColors.primary,
  //                               fontSize: SizeUtil.body(context),
  //                               fontFamily: "Helvetica"),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Divider(
  //                   height: SizeUtil.verticalSpacingMedium(context),
  //                   color: AppColors.lightgrey,
  //                   thickness: 1,
  //                   indent: 0,
  //                   endIndent: 0,
  //                 ),
  //               ],
  //             );
  //           },
  //         ),
  //       if (_searchController.text.isNotEmpty)
  //         ListView.builder(
  //           padding: EdgeInsets.zero,
  //           shrinkWrap: true,
  //           physics: const ScrollPhysics(),
  //           itemCount: filteredSipDetailsList.length,
  //           itemBuilder: (context, index) {
  //             SIPDetails sip = filteredSipDetailsList[index];
  //             return Column(
  //               children: [
  //                 Container(
  //                   width: double.infinity,
  //                   child: Padding(
  //                     padding: EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               sip.name,
  //                               style: TextStyle(
  //                                 color: AppColors.primary,
  //                                 fontSize:SizeUtil.headingMedium(context),
  //                                 fontWeight: FontWeight.w700,
  //                                 fontFamily: "Helvetica",
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               height:SizeUtil.verticalSpacingSmall(context),
  //                             ),
  //                             Text(
  //                               'Growth | ${sip.sipType} - ${sip.sipTypeValue}',
  //                               style: TextStyle(
  //                                   color: AppColors.primary,
  //                                   fontSize: SizeUtil.body(context),
  //                                   fontFamily: "Helvetica"),
  //                             ),
  //                           ],
  //                         ),
  //                         if (_searchController.text.isNotEmpty)
  //                           Theme(
  //                             data: ThemeData(
  //                               unselectedWidgetColor: AppColors.primary,
  //                             ),
  //                             child: Transform.scale(
  //                               scale: 1,
  //                               child: Checkbox(
  //                                 activeColor: AppColors.primary,
  //                                 value: selectedSipDetails.contains(sip),
  //                                 visualDensity: const VisualDensity(
  //                                   horizontal: VisualDensity.minimumDensity,
  //                                   vertical: VisualDensity.minimumDensity,
  //                                 ),
  //                                 materialTapTargetSize:
  //                                     MaterialTapTargetSize.shrinkWrap,
  //                                 onChanged: (newValue) {
  //                                   setState(() {
  //                                     if (newValue ?? false) {
  //                                       selectedSipDetails.add(sip);
  //                                     } else {
  //                                       selectedSipDetails.remove(sip);
  //                                     }
  //                                   });
  //                                 },
  //                               ),
  //                             ),
  //                           ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Divider(
  //                   height: SizeUtil.verticalSpacingMedium(context),
  //                   color: AppColors.lightgrey,
  //                   thickness: 1,
  //                   indent: 0,
  //                   endIndent: 0,
  //                 ),
  //               ],
  //             );
  //           },
  //         )
  //     ],
  //   );
  // }
}
