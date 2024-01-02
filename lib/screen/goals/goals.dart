import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/screen/goals/goalsubsection/mutual_fund_recommondation_strategy.dart';
import 'package:midas/screen/goals/goalsubsection/goalSection.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:flutter/material.dart';
import '../../constant/sizeConstant.dart';

class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<Goals> {
  var height;
  var width;
  int selectedIndex = 0;
  bool shouldShowFAB = true;
  List<String> sectionTitles = ['Goals', 'Strategy (beta)'];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    offset: Offset(0, 4),
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(DefaultSizes.appheadercircularborder),
                  bottomRight:
                      Radius.circular(DefaultSizes.appheadercircularborder),
                ),
                color: AppColors.primary,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeUtil.getStatusBarHeight(context), right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       Obx(() => Center(
                                child: Stack(
                                  children: [
                                    IconButton(
                                      color: AppColors.white,
                                      iconSize: SizeUtil.iconsSize(context),
                                      icon: const Icon(
                                          Icons.notifications_outlined),
                                      onPressed: () async {
                                       await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Notifications()),
                                        );
                                        ConstantUtil.isNotificationReceived.value = false;
                                      },
                                    ),
                                    if (ConstantUtil
                                        .isNotificationReceived.value)
                                      Positioned(
                                        top: 11,
                                        right: 13,
                                        child: Container(
                                          width:
                                              SizeUtil.scallingFactor(context) *
                                                  11,
                                          height:
                                              SizeUtil.scallingFactor(context) *
                                                  11,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )),
                        IconButton(
                          color: AppColors.white,
                          icon: const Icon(Icons.account_circle),
                          iconSize: SizeUtil.iconsSize(context),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProfileAndSettings()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenSize.width * 0.02,
                        right: screenSize.width * 0.02,
                        bottom: DefaultSizes.bottemspaceofheader),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                            color: AppTextColors.white,
                            fontFamily:
                                "Helvetica", // Use a similar font to .SF Compact
                            fontWeight: FontWeight.w400,
                            fontSize: SizeUtil.headingMedium(context),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Goals',
                              style: TextStyle(
                                color: AppTextColors.white,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w700,
                                fontSize: SizeUtil.headingLarge(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            color: AppTextColors.white,
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w400,
                            fontSize: SizeUtil.headingSmall(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TabBar(
              // isScrollable: true,
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
                  fontWeight: FontWeight.w700),
              indicatorPadding: const EdgeInsets.symmetric(vertical: 1),
              indicator: UnderlineTabIndicator(
                  insets: const EdgeInsets.symmetric(horizontal: 10),
                  borderSide: BorderSide(
                      width: SizeUtil.scallingFactor(context) * 4,
                      color: AppColors.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              tabs: const <Tab>[
                Tab(text: 'Goals'),
                Tab(text: 'Strategy (beta)'),
              ],
            ),
            SizedBox(
              height: SizeUtil.verticalSpacingMedium(context),
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[GoalsSection(), MutualFundRecommondationStrategyScreen()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> confirmDelete(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertBox(message: "Confirm Delete");
  //     },
  //   );
  // }

  //  Padding(
  //             padding: EdgeInsets.only(
  //                 right: width * 0.10,
  //                 left: width * 0.10,
  //                 bottom: SizeUtil.buttonPaddingBottom(context)),
  //             child: Visibility(
  //               visible: shouldShowFAB,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: [
  //                   LargeButton(
  //                       text: "Add Goal",
  //                       backgroundColor: AppColors.primary,
  //                       textColor: AppColors.white,
  //                       onPressed: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => AddGoalItem(
  //                                     goalName: "",
  //                                     goalValue: "",
  //                                     goalTargetDate: "",
  //                                     description: "",
  //                                     isWatch: false,
  //                                     isEdit: false,
  //                                   )),
  //                         );
  //                       }),
  //                 ],
  //               ),
  //             ),
  //           ),

  // Widget getSwitchedTab(int index) {
  //   switch (selectedIndex) {
  //     case 0:
  //       return goalSection();
  //     case 1:
  //       return strategySection();
  //     default:
  //       return Container();
  //   }
  // }

  // Widget strategySection() {
  //   shouldShowFAB = false;
  //   return Column(
  //     children: [
  //       Container(
  //         decoration: BoxDecoration(
  //           boxShadow: [
  //             BoxShadow(
  //               color: AppColors.shadow.withOpacity(0.1),
  //               offset: Offset(0, 1),
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
  //         child: Padding(
  //           padding: const EdgeInsets.all(10.0),
  //           child: Text(
  //             'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum!',
  //             style: TextStyle(
  //               fontSize: SizeUtil.body(context),
  //               fontWeight: FontWeight.w400,
  //               color: AppColors.primary,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget goalSection() {
  //   shouldShowFAB = true;
  //   return ListView.builder(
  //     padding: EdgeInsets.zero,
  //     shrinkWrap: true,
  //     physics: ScrollPhysics(),
  //     itemCount: GoalsEntityList.length,
  //     itemBuilder: (context, index) {
  //       GoalsEntity item = GoalsEntityList[index];
  //       return GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => AddGoalItem(
  //                       goalName: "Buy a House",
  //                       goalValue: "1,40,00,000",
  //                       goalTargetDate: "01 Jun 2020",
  //                       description: "description",
  //                       isWatch: true,
  //                       isEdit: false,
  //                     )),
  //           );
  //         },
  //         child: Container(
  //           margin: EdgeInsets.only(bottom: width * 0.02),
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: AppColors.shadow.withOpacity(0.1),
  //                 offset: Offset(0, 1),
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
  //             padding: EdgeInsets.all(height * 0.01),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Image.asset(
  //                           'assets/investment_icon.png',
  //                         ),
  //                         SizedBox(
  //                           width: width * 0.02,
  //                         ),
  //                         Text(
  //                           '${item.name}',
  //                           style: TextStyle(
  //                               color: AppColors.primary,
  //                               fontSize: SizeUtil.bodyLarge(context),
  //                               fontWeight: FontWeight.w700,
  //                               fontFamily: "Helvetica"),
  //                         ),
  //                       ],
  //                     ),
  //                     Container(
  //                       child: Row(
  //                         children: [
  //                           GestureDetector(
  //                             onTap: () {
  //                               Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => AddGoalItem(
  //                                           goalName: "Buy a House",
  //                                           goalValue: "1,40,00,000",
  //                                           goalTargetDate: "01 Jun 2020",
  //                                           description: "description",
  //                                           isWatch: false,
  //                                           isEdit: true,
  //                                         )),
  //                               );
  //                             },
  //                             child: Icon(
  //                               Icons.edit,
  //                               color: AppColors.primary,
  //                               size: SizeUtil.iconsSize(context),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             width: width * 0.02,
  //                           ),
  //                           GestureDetector(
  //                             onTap: () {
  //                               confirmDelete(context);
  //                             },
  //                             child: Icon(
  //                               Icons.delete,
  //                               color: AppColors.primary,
  //                               size: SizeUtil.iconsSize(context),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: height * 0.02,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Column(
  //                       // mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         SizedBox(
  //                           height: height * 0.01,
  //                         ),
  //                         Row(
  //                           children: [
  //                             Text(
  //                               'Goal Value: ',
  //                               style: TextStyle(
  //                                   color: AppColors.primary,
  //                                   fontSize: SizeUtil.body(context),
  //                                   fontFamily: "Helvetica"),
  //                             ),
  //                             RichText(
  //                               textAlign: TextAlign.start,
  //                               text: TextSpan(
  //                                 children: [
  //                                   TextSpan(
  //                                       text: '₹',
  //                                       style: TextStyle(
  //                                           letterSpacing: 2,
  //                                           color: AppColors.primary,
  //                                           fontSize: SizeUtil.body(context))),
  //                                   TextSpan(
  //                                     text: item.price,
  //                                     style: TextStyle(
  //                                         color: AppColors.primary,
  //                                         fontSize: SizeUtil.body(context),
  //                                         fontFamily: "Helvetica"),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(
  //                           height: height * 0.01,
  //                         ),
  //                         Text(
  //                           'Target Date: ${item.date}',
  //                           style: TextStyle(
  //                               color: AppColors.primary,
  //                               fontSize: SizeUtil.body(context),
  //                               fontFamily: "Helvetica"),
  //                         ),
  //                         SizedBox(
  //                           height: height * 0.01,
  //                         ),
  //                       ],
  //                     ),
  //                     Icon(
  //                       Icons.arrow_right_alt_sharp,
  //                       size: SizeUtil.iconsSize(context),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
