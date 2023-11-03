// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/goals/goals_controller.dart';
import 'package:midas/model/goals/goals_model.dart';

import 'package:midas/screen/goals/add_goals.dart';
import 'package:midas/widgets/alert_box.dart';
import 'package:flutter/material.dart';

class GoalsSection extends StatefulWidget {
  const GoalsSection({super.key});

  @override
  State<GoalsSection> createState() => _GoalsSectionState();
}

class _GoalsSectionState extends State<GoalsSection> {
  var height;
  var width;
  final ScrollController _scrollController = ScrollController();
  // bool _isLoadingMore = false;
  int _currentPage = 1;

  GoalsController goalsController = Get.put(GoalsController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      goalsController.getGoalsList(context, page: 1);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // if (!_isLoadingMore) {
      //   setState(() {
      //     _isLoadingMore = true;
      //   });
      // Load the next page of data
      goalsController
          .getGoalsList(context, page: _currentPage + 1)
          .then((success) {
        if (success) {
          setState(() {
            _currentPage++;
            // _isLoadingMore = false;
          });
        } else {}
      });
      // }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Obx(() => RefreshIndicator(
                  onRefresh: () async {
                    goalsController.getGoalsList(context);
                  },
                  child: goalsController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: goalsController.goalsList.length,
                          itemBuilder: (context, index) {
                            GoalsModel goal = goalsController.goalsList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddGoalItem(
                                            goalId: goal.id.toString(),
                                            goalName: goal.goalName.toString(),
                                            goalValue: goal.value.toString(),
                                            goalTargetDate:
                                                goal.targetDate.toLocal(),
                                            description:
                                                goal.description.toString(),
                                            isWatch: true,
                                            isEdit: false,
                                          )),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: SizeUtil.verticalSpacingMedium(
                                        context)),
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
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      SizeUtil.verticalSpacingSmall(context)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/investment_icon.png',
                                                  fit: BoxFit.fill,
                                                  height: SizeUtil.bodyLarge(
                                                      context),
                                                ),
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    goal.goalName,
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color:
                                                            AppColors.primary,
                                                        fontSize:
                                                            SizeUtil.bodyLarge(
                                                                context),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            "Helvetica"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddGoalItem(
                                                              goalId: goal.id
                                                                  .toString(),
                                                              goalName: goal
                                                                  .goalName
                                                                  .toString(),
                                                              goalValue: goal
                                                                  .value
                                                                  .toString(),
                                                              goalTargetDate: goal
                                                                  .targetDate
                                                                  .toLocal(),
                                                              description: goal
                                                                  .description
                                                                  .toString(),
                                                              isWatch: false,
                                                              isEdit: true,
                                                            )),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppColors.primary,
                                                  size: SizeUtil.iconsSize(
                                                      context),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.02,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertBox(
                                                          message:
                                                              "Confirm Delete",
                                                          onConfirm: () {
                                                            goalsController
                                                                .deleteGoal(
                                                                    goal.id,
                                                                    context);
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                    },
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: AppColors.primary,
                                                  size: SizeUtil.iconsSize(
                                                      context),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            SizeUtil.scallingFactor(context) *
                                                8,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height:
                                                SizeUtil.verticalSpacingSmall(
                                                    context),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Goal Value:      ',
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                              RichText(
                                                textScaleFactor:
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: '₹',
                                                        style: TextStyle(
                                                            letterSpacing: 2,
                                                            color: AppColors
                                                                .primary,
                                                            fontSize:
                                                                SizeUtil.body(
                                                                    context))),
                                                    TextSpan(
                                                      text: ConstantUtil
                                                          .formatAmount(
                                                              goal.value),
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.primary,
                                                          fontSize:
                                                              SizeUtil.body(
                                                                  context),
                                                          fontFamily:
                                                              "Helvetica"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Target Date:     ${DateFormat("dd MMM yyyy").format(goal.targetDate.toLocal())}',
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                              Icon(
                                                Icons.arrow_right_alt_sharp,
                                                size:
                                                    SizeUtil.iconsSize(context),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: size.width * 0.10,
              left: size.width * 0.10,
              bottom: SizeUtil.buttonPaddingBottom(context)),
          child: Visibility(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LargeButton(
                    text: "Add Goal",
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddGoalItem(
                                  goalId: '',
                                  goalName: "",
                                  goalValue: "",
                                  goalTargetDate: DateTime.now(),
                                  description: "",
                                  isWatch: false,
                                  isEdit: false,
                                )),
                      );
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
