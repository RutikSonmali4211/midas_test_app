import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import '../../constant/sizeConstant.dart';
import '../../constant/size_util.dart';
import '../../data/transection_data/sell_list.dart';
import '../../data/transection_data/top_selling_list.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double bodyLargeFontSize = SizeUtil.scaleFontSize(context, 20);
    double bodyFontSize = SizeUtil.scaleFontSize(context, 18);
    double bodySmallFontSize = SizeUtil.scaleFontSize(context, 17);
    // double bodyultraSmallFontSize = SizeUtil.scaleFontSize(context, 12);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LargeAppbar(heading: "Outstanding", isAmount: true, isbackButtonAvailable: true, content: "1,04,250", timeline: "Last Updated: 5:00 pm"),
          // Container(
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //     boxShadow: [
          //       BoxShadow(
          //         color: AppColors.shadow,
          //         offset: Offset(0, 4),
          //         blurRadius: 4.0,
          //         spreadRadius: 2.0,
          //       ),
          //     ],
          //     color: AppColors.primary,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(20.0),
          //       bottomRight: Radius.circular(20.0),
          //     ),
          //   ),
          //   child: Column(
          //     children: [
          //       Padding(
          //         padding: EdgeInsets.only(
          //             top: SizeUtil.getStatusBarHeight(context), right: 20),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             IconButton(
          //               color: AppColors.white,
          //               iconSize: SizeUtil.iconsSize(context),
          //               icon: const Icon(Icons.notifications_outlined),
          //               onPressed: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => const Notifications()),
          //                 );
          //               },
          //             ),
          //             IconButton(
          //               color: AppColors.white,
          //               icon: const Icon(Icons.account_circle),
          //               iconSize: SizeUtil.iconsSize(context),
          //               onPressed: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) =>
          //                           const ProfileAndSettings()),
          //                 );
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(
          //             left: screenSize.width * 0.02,
          //             right: screenSize.width * 0.02,
          //             bottom: DefaultSizes.bottemspaceofheader),
          //         child: Stack(
          //           alignment: Alignment.center,
          //           children: [
          //             Positioned(
          //               left: 0,
          //               child: IconButton(
          //                 padding: EdgeInsets.zero,
          //                 icon: Icon(
          //                   Icons.arrow_back,
          //                   color: AppColors.white,
          //                   size: SizeUtil.iconsSize(context),
          //                 ),
          //                 onPressed: () {
          //                   Navigator.of(context).pop();
          //                 },
          //               ),
          //             ),
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   'Outstanding',
          //                   style: TextStyle(
          //                     color: AppTextColors.white,
          //                     fontFamily:
          //                         "Helvetica",
          //                     fontWeight: FontWeight.w400,
          //                     fontSize: SizeUtil.headingMedium(context),
          //                   ),
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Icon(
          //                       Icons.currency_rupee_outlined,
          //                       color: Colors.white,
          //                       size: SizeUtil.headingLarge(context),
          //                     ),
          //                     Text(
          //                       '1,04,250',
          //                       style: TextStyle(
          //                         color: AppTextColors.white,
          //                         fontFamily: "Helvetica",
          //                         fontWeight: FontWeight.w700,
          //                         fontSize: SizeUtil.headingLarge(context),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 const SizedBox(
          //                   height: 5,
          //                 ),
          //                 Text(
          //                   'Last Updated: 5:00 pm',
          //                   style: TextStyle(
          //                     color: AppTextColors.white,
          //                     fontFamily: "Helvetica",
          //                     fontWeight: FontWeight.w400,
          //                     fontSize: SizeUtil.headingSmall(context),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: size.height * 0.02,
                right: size.height * 0.02,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: DefaultSizes.bottemspaceafterheader,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow.withOpacity(0.01),
                            offset: const Offset(0, 1),
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.lightgrey, // Border color
                          width: 2.0, // Border width
                        ),
                        color: AppColors.white,
                      ),
                      width: screenSize.width,
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.01),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Top Spending Categories',
                                style: TextStyle(
                                  color: AppTextColors.primary,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w700,
                                  fontSize: bodyLargeFontSize,
                                  letterSpacing: 0.33,
                                ),
                              ),
                            ),
                            const Divider(
                              height: 20,
                              color: AppTextColors.primary,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Container(
                              height: 100,
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: topSellingList.length,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: AppColors.lightgrey,
                                    thickness: 1.0,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  final topSpending = topSellingList[index];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(topSpending.catagory,
                                            style: TextStyle(
                                                fontSize: bodyLargeFontSize,
                                                color: AppTextColors.primary,
                                                fontFamily: "Helvetica",
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.start),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '₹',
                                                style: TextStyle(
                                                  letterSpacing: 2,
                                                  fontFamily: 'NotoSans',
                                                  color: AppTextColors.primary,
                                                  fontSize: bodyLargeFontSize,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              TextSpan(
                                                text: topSpending.amount,
                                                style: TextStyle(
                                                  fontFamily: "Helvetica",
                                                  color: AppTextColors.primary,
                                                  fontSize: bodyFontSize,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(topSpending.percentage,
                                            style: TextStyle(
                                                fontSize: bodySmallFontSize,
                                                color: AppTextColors.grey,
                                                fontFamily: "Helvetica",
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.start),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeUtil.verticalSpacingMedium(context),
                    ),
                    Container(
                      height: size.height * 0.62,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow.withOpacity(0.01),
                            offset: const Offset(0, 1),
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.lightgrey, // Border color
                          width: 2.0, // Border width
                        ),
                        color: AppColors.white,
                      ),
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transactions',
                              style: TextStyle(
                                color: AppTextColors.primary,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w700,
                                fontSize: bodyLargeFontSize,
                                letterSpacing: 0.33,
                              ),
                            ),
                            const Divider(
                              height: 20,
                              color: AppTextColors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: size.height * 0.5,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: sellingList.length,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        color: AppColors.lightgrey,
                                        thickness: 1.0,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      final selling = sellingList[index];
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(selling.name,
                                                style: TextStyle(
                                                    fontSize: bodyFontSize,
                                                    color:
                                                        AppTextColors.primary,
                                                    fontFamily: "Helvetica",
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.start),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(selling.date,
                                                style: TextStyle(
                                                    fontSize: bodySmallFontSize,
                                                    color: AppTextColors.grey,
                                                    fontFamily: "Helvetica",
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.start),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '₹',
                                                    style: TextStyle(
                                                      letterSpacing: 2,
                                                      fontFamily: 'NotoSans',
                                                      color:
                                                          AppTextColors.primary,
                                                      fontSize:
                                                          bodySmallFontSize,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: selling.amount,
                                                    style: TextStyle(
                                                      fontFamily: "Helvetica",
                                                      color:
                                                          AppTextColors.primary,
                                                      fontSize:
                                                          bodySmallFontSize,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(selling.des,
                                                style: TextStyle(
                                                    fontSize: bodySmallFontSize,
                                                    color: selling.des == "Cr"
                                                        ? AppTextColors.green
                                                        : AppTextColors.red,
                                                    fontFamily: "Helvetica",
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.start),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
