import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/data/mutual_funds/mutual_fund_transaction_list.dart';
import 'package:midas/model/investments/mutual__funds/mutual_fund_transaction.dart';
import 'package:flutter/material.dart';

class MutualFundTransactionScreen extends StatefulWidget {
  const MutualFundTransactionScreen({super.key});

  @override
  State<MutualFundTransactionScreen> createState() =>
      _MutualFundTransactionScreenState();
}

class _MutualFundTransactionScreenState
    extends State<MutualFundTransactionScreen> {
  var height;
  var width;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // const LargeAppbar(heading: "", isAmount: false, isbackButtonAvailable: true, content: "Transactions", timeline: "Last Updated: Aug 6, 2023 | 5:00 pm"),
          // SizedBox(
          //   height: SizeUtil.verticalSpacingMedium(context),
          // ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: width * 0.04,
                right: width * 0.04,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: mutualFundTransactionList.length,
                    itemBuilder: (context, index) {
                      MutualFundTransaction transaction =
                          mutualFundTransactionList[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
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
                              color: AppColors.lightgrey,
                              width: 2.0,
                            ),
                            color: AppColors.white,
                          ),
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              bottom: SizeUtil.verticalSpacingMedium(context)),
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
                                    Text(
                                      'Date: ${transaction.date}',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    Text(
                                      transaction.isComplete
                                          ? "Complete"
                                          : "Processing",
                                      style: TextStyle(
                                        color: transaction.isComplete
                                            ? AppColors.green
                                            : AppColors.grey,
                                        fontSize: SizeUtil.body(context),
                                        fontFamily: "Helvetica",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      SizeUtil.verticalSpacingSmall(context),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      transaction.name,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize:
                                            SizeUtil.headingMedium(context),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Helvetica",
                                      ),
                                    ),
                                    Text(
                                      transaction.paymentType.toString(),
                                      style: TextStyle(
                                        color: transaction.paymentType
                                                    .toString() ==
                                                "Buy"
                                            ? AppColors.green
                                            : AppColors.red,
                                        fontSize: SizeUtil.body(context),
                                        fontFamily: "Helvetica",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      SizeUtil.verticalSpacingSmall(context),
                                ),
                                Text(
                                  'Amount: ${transaction.amount}',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                ),
                                SizedBox(
                                  height:
                                      SizeUtil.verticalSpacingSmall(context),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Units: ${transaction.units}',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    Text(
                                      'NAV: ${transaction.nav}',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
