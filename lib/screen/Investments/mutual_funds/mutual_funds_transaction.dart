import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:flutter/material.dart';
import 'package:midas/model/investments/mutual__funds/orders/mutual_fund_orders_model.dart';
import 'package:midas/widgets/appbar/large_appbar.dart';

class MutualFundTransactionScreen extends StatefulWidget {
  final bool isSeeSingleTransaction;
  final String isinNumber;
  const MutualFundTransactionScreen(
      {super.key,
      required this.isSeeSingleTransaction,
      required this.isinNumber});

  @override
  State<MutualFundTransactionScreen> createState() =>
      _MutualFundTransactionScreenState();
}

class _MutualFundTransactionScreenState
    extends State<MutualFundTransactionScreen> {
  var height;
  var width;

  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());

  ScrollController scrollControllerForOrders = ScrollController();
  int pageforOrders = 1;

  @override
  void initState() {
    super.initState();
    if (!widget.isSeeSingleTransaction) {
      mutualFundsController.getAllMutualFundOrders(pageforOrders, context);
      scrollControllerForOrders.addListener(scrollMoreOrders);
    } else {
      mutualFundsController.getMutualFundOrdersByISINNumber(
          widget.isinNumber, context);
    }
    if (mutualFundsController.mutualFundAmcSearchFocusNode.hasFocus) {
      mutualFundsController.mutualFundAmcSearchFocusNode.unfocus();
      mutualFundsController.update();
    }
  }

  Future<void> scrollMoreOrders() async {
    if (mutualFundsController.isLoadingMoreOrders.value ||
        mutualFundsController.noMoreLoadOrders.value) return;
    if (scrollControllerForOrders.position.pixels ==
        scrollControllerForOrders.position.maxScrollExtent) {
      setState(() {
        mutualFundsController.isLoadingMoreOrders.value = true;
      });
      pageforOrders = pageforOrders + 1;
      await mutualFundsController
          .getAllMutualFundOrders(pageforOrders, context)
          .then((value) {
        setState(() {
          mutualFundsController.isLoadingMoreOrders.value = false;
        });
      });
    }
    mutualFundsController.update();
  }

  @override
  void dispose() {
    super.dispose();
    mutualFundsController.noMoreLoadOrders.value = false;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
        body: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.isSeeSingleTransaction)
             LargeAppbar(
                heading: "",
                isAmount: false,
                isbackButtonAvailable: true,
                content: "Transactions",
                timeline: "Last Updated: ${mutualFundsController.schedularLastUpdatedDate} | ${mutualFundsController.schedularLastUpdatedTime}"),
          if (widget.isSeeSingleTransaction)
            SizedBox(
              height: SizeUtil.verticalSpacingMedium(context),
            ),
          Expanded(
            child: mutualFundsController.isLoadingOrders.value
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.04,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ListView.builder(
                          controller: scrollControllerForOrders,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: mutualFundsController
                                  .mutualFundOrdersList.length +
                              1,
                          itemBuilder: (context, index) {
                            if (index <
                                mutualFundsController
                                    .mutualFundOrdersList.length) {
                              MutualFundOrdersModel order =
                                  mutualFundsController
                                      .mutualFundOrdersList[index];
                              return Container(
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
                                    bottom: SizeUtil.verticalSpacingMedium(
                                        context)),
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
                                          Text(
                                            'Date: ${DateFormat('d\'th\' MMM y').format(order.createdAt!.toLocal())}',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          ),
                                          Text(
                                            order.status.toString(),
                                            style: TextStyle(
                                              color: order.status == "confirmed"
                                                  ? AppColors.green
                                                  : AppColors.grey,
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: SizeUtil.verticalSpacingSmall(
                                            context),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            order.fund.toString(),
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: SizeUtil.headingMedium(
                                                  context),
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Helvetica",
                                            ),
                                          ),
                                          Text(
                                            order.orderType.toString(),
                                            style: TextStyle(
                                              color:
                                                  order.orderType.toString() ==
                                                          "buy"
                                                      ? AppColors.green
                                                      : AppColors.red,
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: SizeUtil.verticalSpacingSmall(
                                            context),
                                      ),
                                      Text(
                                        'Amount: ${order.amount.toString()}',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: SizeUtil.body(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      SizedBox(
                                        height: SizeUtil.verticalSpacingSmall(
                                            context),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Units: ${order.units! !=0.0 ? order.units.toString() :""}',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          ),
                                          Text(
                                            'NAV: ${order.nav! !=0.0 ? order.nav.toString() :"NA"}',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return !widget.isSeeSingleTransaction
                                  ? Center(
                                      child: mutualFundsController
                                              .noMoreLoadOrders.value
                                          ? Text(
                                              'no more data',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            )
                                          : const CircularProgressIndicator(),
                                    )
                                  : null;
                            }
                          },
                        )),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    ));
  }
}
