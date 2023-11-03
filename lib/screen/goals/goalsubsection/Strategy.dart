import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/data/goal_strategy_data.dart';
import 'package:midas/model/goals/goal_strategy_model.dart';

class StrategySection extends StatefulWidget {
  const StrategySection({super.key});

  @override
  State<StrategySection> createState() => _StrategySectionState();
}

class _StrategySectionState extends State<StrategySection> {
  var height;
  var width;
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: goalStrategyList.length,
                itemBuilder: (context, index) {
                  GoalStrategyModel goal = goalStrategyList[index];
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: SizeUtil.verticalSpacingMedium(context)),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/investment_icon.png',
                                      fit: BoxFit.fill,
                                      height: SizeUtil.bodyLarge(context),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Expanded(
                                      child: Text(
                                        goal.name,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColors.primary,
                                            fontSize:
                                                SizeUtil.bodyLarge(context),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Helvetica"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtil.scallingFactor(context) * 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: SizeUtil.verticalSpacingSmall(context),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      goal.fundDetails,
                                      style: TextStyle(
                                          letterSpacing: 0.2,
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeUtil.scallingFactor(context) * 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.02),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: goal.mutualFundList.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Text('•',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontFamily: "Helvetica",
                                                fontSize:
                                                    SizeUtil.headingMedium2(
                                                        context)),
                                            textAlign: TextAlign.left),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                              goal.mutualFundList[index]
                                                  .fundName,
                                              textAlign: TextAlign.left,style: TextStyle(
                                                color: AppColors.primary,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"
                                              ),),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        ),
      ],
    );
  }
}





// SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.shadow.withOpacity(0.01),
//                     offset: Offset(0, 1),
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
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Text(
//                   'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum!',
//                   style: TextStyle(
//                     fontSize: SizeUtil.body(context),
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );