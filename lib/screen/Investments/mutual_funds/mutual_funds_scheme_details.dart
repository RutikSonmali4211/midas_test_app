import 'package:get/get.dart';
import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/Widgets/buttons/small_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:midas/data/mutual_funds/mutual_fund_graph_timeline_list.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_buy.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_sip.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MutualFundSchemeDetails extends StatefulWidget {
  final String amfiCode;
  final String isinNumber;
  final String folioNumber;
  const MutualFundSchemeDetails(
      {super.key, required this.amfiCode, required this.isinNumber,required this.folioNumber});

  @override
  State<MutualFundSchemeDetails> createState() =>
      _MutualFundSchemeDetailsState();
}

class _MutualFundSchemeDetailsState extends State<MutualFundSchemeDetails> {
  var height;
  var width;

  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());

  List<String> dateLabels = [];

  Map<String, List<FlSpot>> timelineData = {
    '90': [
      const FlSpot(0, 1),
      const FlSpot(1, 3),
      const FlSpot(2, 2),
      const FlSpot(3, 5),
      const FlSpot(4, 4),
      const FlSpot(5, 6),
    ],
    '180': [
      const FlSpot(0, 4),
      const FlSpot(1, 6),
      const FlSpot(2, 5),
      const FlSpot(3, 3),
      const FlSpot(4, 2),
      const FlSpot(5, 1),
    ],
    '365': [
      const FlSpot(0, 2),
      const FlSpot(1, 1),
      const FlSpot(2, 2),
      const FlSpot(3, 2),
      const FlSpot(4, 5),
      const FlSpot(5, 5),
    ],
    '1095': [
      const FlSpot(0, 2),
      const FlSpot(2, 1),
      const FlSpot(2, 4),
      const FlSpot(3, 4),
      const FlSpot(4, 6),
      const FlSpot(5, 3),
    ],
    '1825': [
      const FlSpot(0, 2),
      const FlSpot(1, 1),
      const FlSpot(2, 2),
      const FlSpot(3, 4),
      const FlSpot(4, 5),
      const FlSpot(5, 2),
    ],
    '10000': [
      const FlSpot(0, 2),
      const FlSpot(1, 3),
      const FlSpot(2, 4),
      const FlSpot(3, 6),
      const FlSpot(4, 6),
      const FlSpot(5, 3),
    ],
  };
  String selectedTimeline = '90';

  // void updateDateLabels() {
  //   dateLabels = dateLabelsMap[selectedTimeline] ?? [];
  // }

  @override
  void initState() {
    super.initState();
    // updateDateLabels();
    if (widget.amfiCode.isNotEmpty) {
      mutualFundsController.getMutualFundSchemeDetailsByAmfiCode(
          widget.amfiCode, selectedTimeline, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           LargeAppbar(
              heading: "",
              isAmount: false,
              isbackButtonAvailable: true,
              content: "UTI AMC",
              timeline:  "Last Updated: ${mutualFundsController.schedularLastUpdatedDate} | ${mutualFundsController.schedularLastUpdatedTime}"),
          SizedBox(
            height: SizeUtil.verticalSpacingMedium(context),
          ),
          Expanded(
              child: Obx(
            () => mutualFundsController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.only(
                        left: height * 0.02, right: height * 0.02),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Scheme',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    const SizedBox(
                                      height: DefaultSizes.spacingBetweenTexts,
                                    ),
                                    Text(
                                      mutualFundsController.schemeName
                                          .toString(),
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Type',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    const SizedBox(
                                      height: DefaultSizes.spacingBetweenTexts,
                                    ),
                                    Text(
                                      mutualFundsController.schemeType
                                          .toString(),
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtil.verticalSpacingMedium(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Category',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    const SizedBox(
                                      height: DefaultSizes.spacingBetweenTexts,
                                    ),
                                    Text(
                                      mutualFundsController.schemeCategory
                                          .toString(),
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Current NAV',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    const SizedBox(
                                      height: DefaultSizes.spacingBetweenTexts,
                                    ),
                                    RichText(
                                      textScaleFactor: MediaQuery.of(context)
                                          .textScaleFactor,
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '₹',
                                            style: TextStyle(
                                                letterSpacing: 2,
                                                color: AppColors.grey,
                                                fontSize:
                                                    SizeUtil.body(context)),
                                          ),
                                          TextSpan(
                                            text: (mutualFundsController
                                                .currentNav
                                                .toString()),
                                            style: TextStyle(
                                                color: AppColors.grey,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtil.verticalSpacingMedium(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Minimum Investment',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    const SizedBox(
                                      height: DefaultSizes.spacingBetweenTexts,
                                    ),
                                    RichText(
                                      textScaleFactor: MediaQuery.of(context)
                                          .textScaleFactor,
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        children: [
                                          if (mutualFundsController
                                              .minimumInvestment.isNotEmpty)
                                            TextSpan(
                                              text: '₹',
                                              style: TextStyle(
                                                  letterSpacing: 2,
                                                  color: AppColors.grey,
                                                  fontSize:
                                                      SizeUtil.body(context)),
                                            ),
                                          TextSpan(
                                            text: mutualFundsController
                                                    .minimumInvestment.isEmpty
                                                ? "-"
                                                : mutualFundsController
                                                    .minimumInvestment
                                                    .toString(),
                                            style: TextStyle(
                                                color: AppColors.grey,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Exit Load',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    const SizedBox(
                                      height: DefaultSizes.spacingBetweenTexts,
                                    ),
                                    Text(
                                      "-",
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtil.verticalSpacingMedium(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Expense Ratio',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    const SizedBox(
                                      height: DefaultSizes.spacingBetweenTexts,
                                    ),
                                    Text(
                                      '-',
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lock-in-period',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: SizeUtil.bodyLarge(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                    const SizedBox(
                                      height: DefaultSizes.spacingBetweenTexts,
                                    ),
                                    Text(
                                      mutualFundsController.lockInPeriod.isEmpty
                                          ? "NA"
                                          : mutualFundsController.lockInPeriod
                                              .toString(),
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: SizeUtil.body(context),
                                          fontFamily: "Helvetica"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtil.verticalSpacingMedium(context),
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                SizeUtil.verticalSpacingSmall(context)),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadow.withOpacity(0.01),
                                  offset: const Offset(0, 1),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.lightgrey, // Border color
                                width: 2.0, // Border width
                              ),
                              color: AppColors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButton<String>(
                                  padding: EdgeInsets.zero,
                                  underline: const SizedBox(),
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: SizeUtil.headingMedium(context),
                                  ),
                                  value: selectedTimeline,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedTimeline = newValue!;
                                      mutualFundsController
                                          .getMutualFundSchemeDetailsByAmfiCode(
                                              widget.amfiCode,
                                              selectedTimeline,
                                              context);
                                      // updateDateLabels();
                                    });
                                  },
                                  items: mutulaFundGraphTimelineList
                                      .map((valueItem) {
                                    return DropdownMenuItem<String>(
                                        value: valueItem.value.toString(),
                                        child: Text(
                                            valueItem.timeSlot.toString()));
                                  }).toList(),
                                  // items: mutulaFundGraphTimelineList.map((String value) {
                                  //   return DropdownMenuItem<String>(
                                  //     value: value.na,
                                  //     child: Text(
                                  //       value,
                                  //       style:  TextStyle(
                                  //         color: AppColors.primary,
                                  //        fontSize: SizeUtil.headingMedium(context),
                                  //       ),
                                  //     ),
                                  //   );
                                  // }).toList(),
                                ),
                                Text(
                                  (mutualFundsController.growthPercentage >= 0)
                                      ? "+${mutualFundsController.growthPercentage}%"
                                      : "-${mutualFundsController.growthPercentage}%",
                                  style: TextStyle(
                                      color: (mutualFundsController
                                                  .growthPercentage >=
                                              0)
                                          ? AppColors.green
                                          : AppColors.red,
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                ),
                                Container(
                                  width: width,
                                  height: height * 0.15,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: LineChart(
                                      LineChartData(
                                        clipData: const FlClipData.all(),
                                        minX: 0,
                                        maxX: mutualFundsController
                                                .mutualFundGraphNavList.length
                                                .toDouble() -
                                            1,
                                        minY: mutualFundsController.minY.value,
                                        maxY: mutualFundsController.maxY.value,
                                        titlesData:
                                            const FlTitlesData(show: false),
                                        borderData: FlBorderData(show: false),
                                        lineBarsData: [
                                          LineChartBarData(
                                            spots: mutualFundsController
                                                .mutualFundGraphNavList,
                                            isCurved: true,
                                            color: AppColors.primary,
                                            shadow: const Shadow(
                                              color: AppTextColors.shadowcolour,
                                              blurRadius: 8,
                                              offset: Offset(0, 4),
                                            ),
                                            belowBarData:
                                                BarAreaData(show: false),
                                            dotData:
                                                const FlDotData(show: false),
                                            show: true,
                                          ),
                                        ],
                                        gridData: const FlGridData(show: false),
                                        lineTouchData: LineTouchData(
                                          touchTooltipData:
                                              LineTouchTooltipData(
                                            tooltipBgColor: Colors.transparent,
                                            getTooltipItems: (List<LineBarSpot>
                                                touchedSpots) {
                                              return touchedSpots
                                                  .map((LineBarSpot spot) {
                                                final dateIndex =
                                                    spot.x.toInt();
                                                final date = mutualFundsController
                                                        .mutualFundGraphDateList[
                                                    dateIndex];
                                                final value = spot.y.toString();
                                                return LineTooltipItem(
                                                  '$date\n$value',
                                                  const TextStyle(
                                                      color: Colors.black),
                                                );
                                              }).toList();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeUtil.verticalSpacingMedium(context),
                          ),
                        ],
                      ),
                    ),
                  ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmallButton(
                  text: "Buy",
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MutualFundSchemeBuy(
                                amfiCode: widget.amfiCode,
                                isinNumber: widget.isinNumber,
                              )),
                    );
                    setState(() {
                      mutualFundsController
                          .getMutualFundSchemeDetailsByAmfiCode(
                              widget.amfiCode, selectedTimeline, context);
                    });
                  }),
              SmallButton(
                  text: "SIP",
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MutualFundSchemeSIP(
                              isUpdate: false,
                              amfiCode: widget.amfiCode.toString(),
                              isinNumber: widget.isinNumber.toString(),
                              folioNumber: widget.folioNumber.toString(),
                              sipid: "")),
                    );
                    setState(() {
                      mutualFundsController
                          .getMutualFundSchemeDetailsByAmfiCode(
                              widget.amfiCode, selectedTimeline, context);
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }

  // List<FlSpot> getTimelineData(String timeline) {
  //   switch (timeline) {
  //     case '90':
  //       return [
  //         const FlSpot(0, 1),
  //         const FlSpot(1, 3),
  //         const FlSpot(2, 2),
  //         const FlSpot(3, 5),
  //         const FlSpot(4, 4),
  //         const FlSpot(5, 6),
  //       ];
  //     case '180':
  //       return [
  //         const FlSpot(0, 4),
  //         const FlSpot(1, 6),
  //         const FlSpot(2, 5),
  //         const FlSpot(3, 3),
  //         const FlSpot(4, 2),
  //         const FlSpot(5, 1),
  //       ];
  //     case '365':
  //       return [
  //         const FlSpot(0, 2),
  //         const FlSpot(1, 1),
  //         const FlSpot(3, 4),
  //         const FlSpot(3, 1),
  //         const FlSpot(4, 5),
  //         const FlSpot(5, 5),
  //       ];
  //     case '1095':
  //       return [
  //         const FlSpot(0, 2),
  //         const FlSpot(2, 1),
  //         const FlSpot(2, 4),
  //         const FlSpot(3, 4),
  //         const FlSpot(4, 6),
  //         const FlSpot(5, 3),
  //       ];
  //     case '1825':
  //       return [
  //         const FlSpot(0, 2),
  //         const FlSpot(1, 1),
  //         const FlSpot(2, 2),
  //         const FlSpot(3, 4),
  //         const FlSpot(4, 5),
  //         const FlSpot(5, 2),
  //       ];
  //     case '10000':
  //       return [
  //         const FlSpot(0, 2),
  //         const FlSpot(1, 3),
  //         const FlSpot(2, 4),
  //         const FlSpot(3, 6),
  //         const FlSpot(4, 6),
  //         const FlSpot(5, 3),
  //       ];
  //     default:
  //       return [];
  //   }
  // }
}
