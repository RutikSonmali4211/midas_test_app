import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/Widgets/buttons/small_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_buy.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_sip.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MutualFundSchemeDetails extends StatefulWidget {
  const MutualFundSchemeDetails({super.key});

  @override
  State<MutualFundSchemeDetails> createState() =>
      _MutualFundSchemeDetailsState();
}

class _MutualFundSchemeDetailsState extends State<MutualFundSchemeDetails> {
  var height;
  var width;

  List<String> timelineOptions = [
    '3 months',
    '6 months',
    '1 year',
    '3 years',
    '5 years',
    'max'
  ];

  Map<String, List<String>> dateLabelsMap = {
    '3 months': [
      'Jan 1, 2023',
      'Jan 2, 2023',
      'Jan 3, 2023',
      'Jan 4, 2023',
      'Jan 5, 2023',
      'Jan 6, 2023',
    ],
    '6 months': [
      'Jun 1, 2023',
      'Jun 2, 2023',
      'Jun 3, 2023',
      'Jun 4, 2023',
      'Jun 5, 2023',
      'Jun 6, 2023',
    ],
    '1 year': [
      'Jan 1, 2023',
      'Jan 2, 2023',
      'Jan 3, 2023',
      'Jan 4, 2023',
      'Jan 5, 2023',
      'Jan 6, 2023',
    ],
    '3 years': [
      'Jan 1, 2021',
      'Feb 2, 2021',
      'Feb 3, 2022',
      'Jan 4, 2022',
      'Jan 5, 2023',
      'Jan 6, 2023',
    ],
    '5 years': [
      'Jan 1, 2019',
      'Feb 2, 2020',
      'Jun 3, 2021',
      'Mar 4, 2022',
      'Oct 5, 2023',
      'OCt 25, 2023',
    ],
    'max': [
      'Jan 1, 2019',
      'Feb 2, 2020',
      'Jun 3, 2021',
      'Mar 4, 2022',
      'Apr 5, 2023',
      'Sep 10, 2023',
    ],
  };

  List<String> dateLabels = [];

  Map<String, List<FlSpot>> timelineData = {
    '3 months': [
      const FlSpot(0, 1),
      const FlSpot(1, 3),
      const FlSpot(2, 2),
      const FlSpot(3, 5),
      const FlSpot(4, 4),
      const FlSpot(5, 6),
    ],
    '6 months': [
      const FlSpot(0, 4),
      const FlSpot(1, 6),
      const FlSpot(2, 5),
      const FlSpot(3, 3),
      const FlSpot(4, 2),
      const FlSpot(5, 1),
    ],
    '1 year': [
      const FlSpot(0, 2),
      const FlSpot(1, 1),
      const FlSpot(2, 2),
      const FlSpot(3, 2),
      const FlSpot(4, 5),
      const FlSpot(5, 5),
    ],
    '3 years': [
      const FlSpot(0, 2),
      const FlSpot(2, 1),
      const FlSpot(2, 4),
      const FlSpot(3, 4),
      const FlSpot(4, 6),
      const FlSpot(5, 3),
    ],
    '5 years': [
      const FlSpot(0, 2),
      const FlSpot(1, 1),
      const FlSpot(2, 2),
      const FlSpot(3, 4),
      const FlSpot(4, 5),
      const FlSpot(5, 2),
    ],
    'max': [
      const FlSpot(0, 2),
      const FlSpot(1, 3),
      const FlSpot(2, 4),
      const FlSpot(3, 6),
      const FlSpot(4, 6),
      const FlSpot(5, 3),
    ],
  };
  String selectedTimeline = '3 months';

  void updateDateLabels() {
    dateLabels = dateLabelsMap[selectedTimeline] ?? [];
  }

  final double speedValue = 75.0;

  @override
  void initState() {
    super.initState();
    updateDateLabels();
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
          const LargeAppbar(
              heading: "",
              isAmount: false,
              isbackButtonAvailable: true,
              content: "UTI AMC",
              timeline: "Last Updated: Aug 6, 2023 | 5:00 pm"),
          SizedBox(
            height: SizeUtil.verticalSpacingMedium(context),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: height * 0.02, right: height * 0.02),
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
                                'UTI Nifty 50 Index Fund',
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
                                'Regular | Growth',
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
                                'Others - Index Funds/ETFs',
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
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '₹',
                                      style: TextStyle(
                                          letterSpacing: 2,
                                          color: AppColors.grey,
                                          fontSize: SizeUtil.body(context)),
                                    ),
                                    TextSpan(
                                      text: "2700.72",
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
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '₹',
                                      style: TextStyle(
                                          letterSpacing: 2,
                                          color: AppColors.grey,
                                          fontSize: SizeUtil.body(context)),
                                    ),
                                    TextSpan(
                                      text: "1000",
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
                                "0.50%",
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
                                '1.25%',
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
                                "NA",
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
                             style:  TextStyle(
                                    color: AppColors.primary,
                                   fontSize: SizeUtil.headingMedium(context),
                                  ),
                            value: selectedTimeline,
                            onChanged: (newValue) {
                              setState(() {
                                selectedTimeline = newValue!;
                                updateDateLabels();
                              });
                            },
                            items: timelineOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style:  TextStyle(
                                    color: AppColors.primary,
                                   fontSize: SizeUtil.headingMedium(context),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Text(
                            "+31.08%",
                            style: TextStyle(
                                color: AppColors.green,
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                          ),
                          Container(
                            width: width,
                            height: height * 0.15,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: LineChart(
                                LineChartData(
                                  titlesData: const FlTitlesData(show: false),
                                  borderData: FlBorderData(show: false),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots:
                                          timelineData[selectedTimeline] ?? [],
                                      isCurved: true,
                                      color: AppColors.primary,
                                      shadow: const Shadow(
                                        color: AppTextColors.shadowcolour,
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                      belowBarData: BarAreaData(show: false),
                                      dotData: const FlDotData(show: false),
                                      show: true,
                                    ),
                                  ],
                                  gridData: const FlGridData(show: false),
                                  lineTouchData: LineTouchData(
                                    
                                    touchTooltipData: LineTouchTooltipData(
                                      tooltipBgColor: Colors.transparent,
                                      getTooltipItems:
                                          (List<LineBarSpot> touchedSpots) {
                                        return touchedSpots
                                            .map((LineBarSpot spot) {
                                          final dateIndex = spot.x.toInt();
                                          final date = dateLabels[dateIndex];
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmallButton(
                  text: "Buy",
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MutualFundSchemeBuy()),
                    );
                  }),
              SmallButton(
                  text: "SIP",
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MutualFundSchemeSIP(isUpdate: false,)),
                    );
                  }),
            ],
          )
        ],
      ),
    );
  }

  List<FlSpot> getTimelineData(String timeline) {
    switch (timeline) {
      case '3 months':
        return [
          const FlSpot(0, 1),
          const FlSpot(1, 3),
          const FlSpot(2, 2),
          const FlSpot(3, 5),
          const FlSpot(4, 4),
          const FlSpot(5, 6),
        ];
      case '6 months':
        return [
          const FlSpot(0, 4),
          const FlSpot(1, 6),
          const FlSpot(2, 5),
          const FlSpot(3, 3),
          const FlSpot(4, 2),
          const FlSpot(5, 1),
        ];
      case '1 year':
        return [
          const FlSpot(0, 2),
          const FlSpot(1, 1),
          const FlSpot(3, 4),
          const FlSpot(3, 1),
          const FlSpot(4, 5),
          const FlSpot(5, 5),
        ];
      case '3 years':
        return [
          const FlSpot(0, 2),
          const FlSpot(2, 1),
          const FlSpot(2, 4),
          const FlSpot(3, 4),
          const FlSpot(4, 6),
          const FlSpot(5, 3),
        ];
      case '5 years':
        return [
          const FlSpot(0, 2),
          const FlSpot(1, 1),
          const FlSpot(2, 2),
          const FlSpot(3, 4),
          const FlSpot(4, 5),
          const FlSpot(5, 2),
        ];
      case 'max':
        return [
          const FlSpot(0, 2),
          const FlSpot(1, 3),
          const FlSpot(2, 4),
          const FlSpot(3, 6),
          const FlSpot(4, 6),
          const FlSpot(5, 3),
        ];
      default:
        return [];
    }
  }
}
