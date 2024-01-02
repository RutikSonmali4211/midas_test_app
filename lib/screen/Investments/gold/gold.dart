// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/gold_types/gold_types_controller.dart';
import 'package:midas/model/gold_types/gold_types_model.dart';
import 'package:midas/screen/Investments/gold/gold_item_details.dart';
import 'package:flutter/material.dart';

class GoldScreen extends StatefulWidget {
  const GoldScreen({super.key});

  @override
  State<GoldScreen> createState() => _DepositsScreenState();
}

class _DepositsScreenState extends State<GoldScreen> {
  var height;
  var width;

  GoldTypesController goldTypesController = Get.put(GoldTypesController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      goldTypesController.getGoldTypesWithCurrentValueAndQuantity(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
        body: Obx(
      () => goldTypesController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LargeAppbar(
                    heading: "Current Value",
                    isAmount: true,
                    isbackButtonAvailable: true,
                    content: ConstantUtil.formatAmountOnHeader(
                        goldTypesController.goldDetails.value.totalValue.toDouble()),
                    timeline: goldTypesController
                                .goldDetails.value.totalValue !=
                            0
                        ? "Last Updated: ${DateFormat("hh:mm a").format(goldTypesController.goldDetails.value.lastUpdatedDate.toLocal())}"
                        : ""),
                // timeline:
                //     "Last Updated: ${goldTypesController.goldDetails.value.totalValue != 0 ? DateFormat("hh:mm a").format(goldTypesController.goldDetails.value.lastUpdatedDate.toLocal()) : ""}"),
                SizedBox(
                  height: SizeUtil.verticalSpacingMedium(context),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.04, right: width * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Gold Prices (per gm)",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: SizeUtil.headingMedium(context),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Helvetica",
                          ),
                        ),
                        SizedBox(
                          height: SizeUtil.verticalSpacingMedium(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '24K: ',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: SizeUtil.bodyLarge(context),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                                RichText(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '₹',
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontFamily: "helvetica",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ConstantUtil.formatAmount(
                                            goldTypesController
                                                .gold24kprice.value.toDouble()),
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Helvetica",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '22K: ',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: SizeUtil.bodyLarge(context),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                                RichText(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '₹',
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ConstantUtil.formatAmount(
                                            goldTypesController
                                                .gold22kprice.value.toDouble()),
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Helvetica",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '18K: ',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: SizeUtil.bodyLarge(context),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                                RichText(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '₹',
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ConstantUtil.formatAmount(
                                            goldTypesController
                                                .gold18kprice.value.toDouble()),
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Helvetica",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeUtil.verticalSpacingSmall(context),
                        ),
                        const Divider(
                          color: AppColors.grey,
                          thickness: 1.0,
                          height: 0,
                        ),
                        SizedBox(
                          height: SizeUtil.verticalSpacingMedium(context),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const ScrollPhysics(),
                          itemCount: goldTypesController
                              .goldDetails.value.goldData.length,
                          itemBuilder: (context, index) {
                            GoldData item = goldTypesController
                                .goldDetails.value.goldData[index];
                            return GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GoldItemDetails(
                                            goldPurity:
                                                item.goldType.toString(),
                                          )),
                                );
                                goldTypesController
                                    .getGoldTypesWithCurrentValueAndQuantity(
                                        context);
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
                                    color: AppColors.lightgrey,
                                    width: 2.0,
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
                                          Text(
                                            "Gold ${item.goldType}",
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize:
                                                    SizeUtil.bodyLarge(context),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Helvetica"),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: SizeUtil.verticalSpacingMedium(
                                            context),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Current Value: ',
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
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: SizeUtil.body(
                                                            context))),
                                                TextSpan(
                                                  text:
                                                      ConstantUtil.formatAmount(
                                                          item.currentValue.toDouble()),
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: SizeUtil.body(
                                                          context),
                                                      fontFamily: "Helvetica"),
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
                                            'Qty: ${ConstantUtil.formatAmount(item.qty.toDouble())} gms',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          ),
                                          Icon(
                                            Icons.arrow_right_alt_sharp,
                                            size: SizeUtil.iconsSize(context),
                                          )
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
    ));
  }
}
