import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/gold/gold_controller.dart';
import 'package:midas/model/investments/gold/gold_model.dart';
import 'package:midas/screen/Investments/gold/add_gold_item.dart';
import 'package:midas/widgets/alert_box.dart';
import 'package:flutter/material.dart';

class GoldItemDetails extends StatefulWidget {
  final String goldPurity;
  const GoldItemDetails({super.key, required this.goldPurity});

  @override
  State<GoldItemDetails> createState() => _GoldItemDetailsState();
}

class _GoldItemDetailsState extends State<GoldItemDetails> {
  var height;
  var width;

  ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  GoldController goldController = Get.put(GoldController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    goldController.getGoldItemsList(widget.goldPurity, context);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      goldController
          .getGoldItemsList(widget.goldPurity, context, page: _currentPage + 1)
          .then((success) {
        if (success) {
          setState(() {
            _currentPage++;
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
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() => RefreshIndicator(
            onRefresh: () async {
              goldController.getGoldItemsList(widget.goldPurity, context);
              setState(() {
                _scrollController.dispose();
                _scrollController = ScrollController();
                _scrollController.addListener(_onScroll);
                _currentPage = 1;
              });
            },
            child: goldController.isLoading.value
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
                              goldController.goldItems.value.currentValue.toDouble()),
                          timeline: goldController
                                  .goldItems.value.investment.isNotEmpty
                              ? "Last Updated: ${DateFormat("hh:mm a").format(goldController.goldItems.value.lastUpdatedDate.toLocal())}"
                              : ""),
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
                                "Gold Assets",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: SizeUtil.headingMedium(context),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Helvetica",
                                ),
                              ),
                              SizedBox(
                                height: SizeUtil.verticalSpacingSmall(context),
                              ),
                              const Divider(
                                color: AppColors.grey,
                                thickness: 1.0,
                                height: 0,
                              ),
                              Expanded(
                                  child: ListView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.only(
                                    top: SizeUtil.verticalSpacingMedium(
                                        context)),
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: goldController.investments.length,
                                itemBuilder: (context, index) {
                                  Investment item =
                                      goldController.investments[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => AddGoldItem(
                                      //           isEdit: false,
                                      //           isWatch: true,
                                      //           goldId: item.id.toString(),
                                      //           shortTitle: item.data.shortTitle
                                      //               .toString(),
                                      //           weight:
                                      //               item.data.weight.toString(),
                                      //           goldPurity: item.data.goldPurity
                                      //               .toString(),
                                      //           description: item
                                      //               .data.description
                                      //               .toString())),
                                      // );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          bottom:
                                              SizeUtil.verticalSpacingMedium(
                                                  context)),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.shadow
                                                .withOpacity(0.01),
                                            offset: const Offset(0, 1),
                                            blurRadius: 1.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AppColors
                                              .lightgrey, // Border color
                                          width: 2.0, // Border width
                                        ),
                                        color: AppColors.white,
                                      ),
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            SizeUtil.verticalSpacingSmall(
                                                context)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        flex: 3,
                                                        child: Text(
                                                          item.data.shortTitle,
                                                          style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize: SizeUtil
                                                                  .bodyLarge(
                                                                      context),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  "Helvetica"),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '-',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primary,
                                                            fontSize: SizeUtil
                                                                .bodyLarge(
                                                                    context),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "Helvetica"),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "${item.data.weight.toString()} gms",
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: AppColors
                                                                .primary,
                                                            fontSize: SizeUtil
                                                                .bodyLarge(
                                                                    context),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "Helvetica"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    // GestureDetector(
                                                    //   onTap: () {
                                                    //     Navigator.push(
                                                    //       context,
                                                    //       MaterialPageRoute(
                                                    //           builder: (context) => AddGoldItem(
                                                    //               isEdit: true,
                                                    //               isWatch:
                                                    //                   false,
                                                    //               goldId: item
                                                    //                   .id
                                                    //                   .toString(),
                                                    //               shortTitle: item
                                                    //                   .data
                                                    //                   .shortTitle
                                                    //                   .toString(),
                                                    //               weight: item
                                                    //                   .data
                                                    //                   .weight
                                                    //                   .toString(),
                                                    //               goldPurity: item
                                                    //                   .data
                                                    //                   .goldPurity
                                                    //                   .toString(),
                                                    //               description: item
                                                    //                   .data
                                                    //                   .description
                                                    //                   .toString())),
                                                    //     );
                                                    //   },
                                                    //   child: Icon(
                                                    //     Icons.edit,
                                                    //     color:
                                                    //         AppColors.primary,
                                                    //     size:
                                                    //         SizeUtil.iconsSize(
                                                    //             context),
                                                    //   ),
                                                    // ),
                                                    SizedBox(
                                                      width: width * 0.02,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertBox(
                                                                  message:
                                                                      "Confirm Delete",
                                                                  onConfirm:
                                                                      () {
                                                                    goldController.deleteGoldItem(
                                                                        item.id,
                                                                        widget
                                                                            .goldPurity,
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                            },
                                                          );
                                                        },
                                                        child: Icon(
                                                          Icons.delete,
                                                          color:
                                                              AppColors.primary,
                                                          size: SizeUtil
                                                              .iconsSize(
                                                                  context),
                                                        ))
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: SizeUtil
                                                  .verticalSpacingMedium(
                                                      context),
                                            ),
                                            Text(
                                              item.data.description.toString(),
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            SizedBox(
                                              height:
                                                  SizeUtil.verticalSpacingSmall(
                                                      context),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: width * 0.08,
                                    left: width * 0.08,
                                    bottom:
                                        SizeUtil.buttonPaddingBottom(context)),
                                child: Container(
                                  color: AppColors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      LargeButton(
                                          text: "Add Gold Details",
                                          backgroundColor: AppColors.primary,
                                          textColor: AppColors.white,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddGoldItem(
                                                        goldPurity: widget
                                                            .goldPurity
                                                            .toString(),
                                                      )),
                                            );
                                            setState(() {
                                              _scrollController.dispose();
                                              _scrollController =
                                                  ScrollController();
                                              _scrollController
                                                  .addListener(_onScroll);
                                              _currentPage = 1;
                                            });
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))));
  }
}
