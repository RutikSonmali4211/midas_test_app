import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/controller/mutual_fund_recommondation/mutual_fund_recommondation_controller.dart';
import 'package:midas/model/mutual_fund_recommondation/mutual_fund_recommondation_model.dart';

class MutualFundRecommondationStrategyScreen extends StatefulWidget {
  const MutualFundRecommondationStrategyScreen({super.key});

  @override
  State<MutualFundRecommondationStrategyScreen> createState() =>
      _MutualFundRecommondationStrategyScreenState();
}

class _MutualFundRecommondationStrategyScreenState
    extends State<MutualFundRecommondationStrategyScreen> {
  dynamic height;
  dynamic width;

  MutualfundRecommondationControlller mutualfundRecommondationControlller =
      Get.put(MutualfundRecommondationControlller());

  ScrollController scrollControllerForMfRecommondation = ScrollController();
  int pageforRecommondation = 1;

  @override
  void initState() {
    super.initState();
    scrollControllerForMfRecommondation
        .addListener(scrollMoreRecommondationStrategies);
    mutualfundRecommondationControlller.getMutualFundRecommondationStrategies(
        pageforRecommondation, context);
  }

  Future<void> scrollMoreRecommondationStrategies() async {
    if (mutualfundRecommondationControlller
            .isLoadingMoreMfRecommondation.value ||
        mutualfundRecommondationControlller.noMoreLoadMfRecommondation.value)
      return;
    if (scrollControllerForMfRecommondation.position.pixels ==
        scrollControllerForMfRecommondation.position.maxScrollExtent) {
      setState(() {
        mutualfundRecommondationControlller
            .isLoadingMoreMfRecommondation.value = true;
      });
      pageforRecommondation = pageforRecommondation + 1;
      await mutualfundRecommondationControlller
          .getMutualFundRecommondationStrategies(pageforRecommondation, context)
          .then((value) {
        setState(() {
          mutualfundRecommondationControlller
              .isLoadingMoreMfRecommondation.value = false;
        });
      });
    }
    mutualfundRecommondationControlller.update();
  }

  @override
  void dispose() {
    super.dispose();
    mutualfundRecommondationControlller.noMoreLoadMfRecommondation.value =
        false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Column(
      children: [
        Expanded(
            child: Obx(
          () => mutualfundRecommondationControlller
                  .isLoadingMfRecommondation.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: ListView.builder(
                    controller: scrollControllerForMfRecommondation,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: mutualfundRecommondationControlller
                        .mutualFundRecommondationStrategiesList.length,
                    itemBuilder: (context, index) {
                      if (index <
                          mutualfundRecommondationControlller
                              .mutualFundRecommondationStrategiesList.length) {
                        MutualFundRecommondationModel recommondedFundDetails =
                            mutualfundRecommondationControlller
                                .mutualFundRecommondationStrategiesList[index];
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
                                            height: SizeUtil.bodyLarge(context),
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          Expanded(
                                            child: Text(
                                              recommondedFundDetails.goalName
                                                  .toString(),
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: AppColors.primary,
                                                  fontSize: SizeUtil.bodyLarge(
                                                      context),
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
                                      height: SizeUtil.verticalSpacingSmall(
                                          context),
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'The goal has a ${recommondedFundDetails.goalTerm.toString()} So, the strategy should focus on investing in ${recommondedFundDetails.fundType.toString()}  based instruments. Mutual Funds suited to achieve this goal are:',
                                            style: TextStyle(
                                                letterSpacing: 0.2,
                                                color: AppColors.primary,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          SizeUtil.scallingFactor(context) * 12,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.01),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: recommondedFundDetails
                                            .recommendations!.length,
                                        itemBuilder: (context, index) {
                                          Recommendation recommondedMf =
                                              recommondedFundDetails
                                                  .recommendations![index];
                                          return Row(
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  textScaleFactor:
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '•',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primary,
                                                            fontFamily:
                                                                "Helvetica",
                                                            fontSize: SizeUtil
                                                                .headingMedium2(
                                                                    context)),
                                                      ),
                                                      const TextSpan(text: " "),
                                                      TextSpan(
                                                          text: recommondedMf
                                                              .fundName
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize:
                                                                  SizeUtil.body(
                                                                      context),
                                                              fontFamily:
                                                                  "Helvetica")),
                                                      TextSpan(
                                                          text: " - ",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize:
                                                                  SizeUtil.body(
                                                                      context),
                                                              fontFamily:
                                                                  "Helvetica")),
                                                      TextSpan(
                                                          text:
                                                              "${recommondedMf.sipAmount!.toStringAsFixed(0)} monthly SIP",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize:
                                                                  SizeUtil.body(
                                                                      context),
                                                              fontFamily:
                                                                  "Helvetica")),
                                                    ],
                                                  ),
                                                ),
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
                      } else {
                        return Center(
                          child: mutualfundRecommondationControlller
                                  .noMoreLoadMfRecommondation.value
                              ? Text(
                                  'no more data',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                )
                              : const CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
        )),
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