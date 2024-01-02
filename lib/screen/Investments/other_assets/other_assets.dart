import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/other_assets/other_assets_controller.dart';
import 'package:midas/model/investments/other_assets/other_assets_model.dart';
import 'package:midas/screen/Investments/other_assets/add_other_assets.dart';
import 'package:midas/widgets/alert_box.dart';
import 'package:flutter/material.dart';

class OtherAssetsScreen extends StatefulWidget {
  const OtherAssetsScreen({super.key});

  @override
  State<OtherAssetsScreen> createState() => _OtherAssetsScreenState();
}

class _OtherAssetsScreenState extends State<OtherAssetsScreen> {
  var height;
  var width;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  OtherAssetsController otherAssetsController =
      Get.put(OtherAssetsController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      otherAssetsController.getOtherAssetsList(context);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // if (!_isLoadingMore) {
      //   setState(() {
      //     _isLoadingMore = true;
      //   });
      otherAssetsController
          .getOtherAssetsList(context, page: _currentPage + 1)
          .then((success) {
        if (success) {
          setState(() {
            _currentPage++;
            // _isLoadingMore = false;
          });
        } else {
          // Handle loading failure here
        }
      });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
      body: Obx(() => RefreshIndicator(
            onRefresh: () async {
              otherAssetsController.getOtherAssetsList(context);
            },
            child: otherAssetsController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LargeAppbar(
                          heading: "Current Value",
                          isAmount: true,
                          isbackButtonAvailable: true,
                          content: ConstantUtil.formatAmountOnHeader(
                              otherAssetsController
                                  .otherAssets.value.currentValue.toDouble()),
                          timeline: otherAssetsController
                                  .otherAssets.value.investment.isNotEmpty
                              ? "Last Updated: ${DateFormat("hh:mm a").format(otherAssetsController.otherAssets.value.lastUpdatedDate.toLocal())}"
                              : ""),
                      // timeline:
                      //     "Last Updated: ${otherAssetsController.otherAssets.value.investment.isNotEmpty ? DateFormat("hh:mm a").format(otherAssetsController.otherAssets.value.lastUpdatedDate.toLocal()) : ""}"),
                      SizedBox(
                        height: SizeUtil.verticalSpacingMedium(context),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: otherAssetsController.investments.length,
                          itemBuilder: (context, index) {
                            Investment otherAsset =
                                otherAssetsController.investments[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddOtherAssets(
                                            isEdit: false,
                                            isWatch: true,
                                            otherAssetId: otherAsset.id,
                                            assetName:
                                                otherAsset.data.assetName,
                                            purchasePrice: otherAsset
                                                .data.purchasePrice
                                                .toString(),
                                            currentValue: otherAsset
                                                .data.currentPrice
                                                .toString(),
                                            purchaseDate: otherAsset
                                                .data.purchaseDate
                                                .toLocal())),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: SizeUtil.verticalSpacingMedium(
                                          context)),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColors.shadow.withOpacity(0.01),
                                        offset: const Offset(0, 1),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color:
                                          AppColors.lightgrey, // Border color
                                      width: 2.0, // Border width
                                    ),
                                    color: AppColors.white,
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        SizeUtil.verticalSpacingSmall(context)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
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
                                                      otherAsset.data.assetName,
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color:
                                                              AppColors.primary,
                                                          fontSize: SizeUtil
                                                              .bodyLarge(
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
                                                          builder: (context) => AddOtherAssets(
                                                              isEdit: true,
                                                              isWatch: false,
                                                              otherAssetId:
                                                                  otherAsset.id,
                                                              assetName:
                                                                  otherAsset
                                                                      .data
                                                                      .assetName,
                                                              purchasePrice:
                                                                  otherAsset
                                                                      .data
                                                                      .purchasePrice
                                                                      .toString(),
                                                              currentValue:
                                                                  otherAsset
                                                                      .data
                                                                      .currentPrice
                                                                      .toString(),
                                                              purchaseDate: otherAsset
                                                                  .data
                                                                  .purchaseDate
                                                                  .toLocal())),
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
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertBox(
                                                            message:
                                                                "Confirm Delete",
                                                            onConfirm: () {
                                                              otherAssetsController
                                                                  .deleteOtherAsset(
                                                                      otherAsset
                                                                          .id,
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
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeUtil.verticalSpacingMedium(
                                                  context),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Current Value: ',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.primary,
                                                          fontSize:
                                                              SizeUtil.body(
                                                                  context),
                                                          fontFamily:
                                                              "Helvetica"),
                                                    ),
                                                    RichText(
                                                      textScaleFactor:
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                      textAlign:
                                                          TextAlign.start,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                              text: '₹',
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      2,
                                                                  color: AppColors
                                                                      .primary,
                                                                  fontSize:
                                                                      SizeUtil.body(
                                                                          context))),
                                                          TextSpan(
                                                            text: ConstantUtil
                                                                .formatAmount(
                                                                    otherAsset
                                                                        .data
                                                                        .currentPrice.toDouble()),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .primary,
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
                                                SizedBox(
                                                  height: SizeUtil
                                                      .verticalSpacingSmall(
                                                          context),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Purchase Price: ',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.primary,
                                                          fontSize:
                                                              SizeUtil.body(
                                                                  context),
                                                          fontFamily:
                                                              "Helvetica"),
                                                    ),
                                                    RichText(
                                                      textScaleFactor:
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                      textAlign:
                                                          TextAlign.start,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                              text: '₹',
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      2,
                                                                  color: AppColors
                                                                      .primary,
                                                                  fontSize:
                                                                      SizeUtil.body(
                                                                          context))),
                                                          TextSpan(
                                                            text: ConstantUtil
                                                                .formatAmount(
                                                                    otherAsset
                                                                        .data
                                                                        .purchasePrice.toDouble()),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .primary,
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
                                                SizedBox(
                                                  height: SizeUtil
                                                      .verticalSpacingSmall(
                                                          context),
                                                ),
                                                Text(
                                                  'Purchase Date: ${DateFormat("dd MMM yyyy").format(otherAsset.data.purchaseDate.toLocal())}',
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: SizeUtil.body(
                                                          context),
                                                      fontFamily: "Helvetica"),
                                                ),
                                              ],
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
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.08,
                            left: width * 0.08,
                            bottom: SizeUtil.buttonPaddingBottom(context)),
                        child: Container(
                          color: AppColors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LargeButton(
                                  text: "Add Asset Details",
                                  backgroundColor: AppColors.primary,
                                  textColor: AppColors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddOtherAssets(
                                              isEdit: false,
                                              isWatch: false,
                                              otherAssetId: "",
                                              assetName: "",
                                              purchasePrice: "",
                                              currentValue: "",
                                              purchaseDate:
                                                  DateTime.now().toLocal())),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          )),
    );
  }

  //  Widget otherAssetsSection() {
  //   return
  // }

  // Widget otherAssetsSection() {
  //   return ListView.builder(
  //     padding: EdgeInsets.zero,
  //     shrinkWrap: true,
  //     physics: const ScrollPhysics(),
  //     itemCount: otherAssetsList.length,
  //     itemBuilder: (context, index) {
  //       OtherAssets item = otherAssetsList[index];
  //       return Padding(
  //         padding: EdgeInsets.symmetric(horizontal: width * 0.04),
  //         child: GestureDetector(
  //           onTap: () {
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(builder: (context) => StocksScreen()),
  //             // );
  //           },
  //           child: Container(
  //             margin: EdgeInsets.only(
  //                 bottom: SizeUtil.verticalSpacingMedium(context)),
  //             decoration: BoxDecoration(
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: AppColors.shadow.withOpacity(0.01),
  //                   offset: const Offset(0, 1),
  //                   blurRadius: 1.0,
  //                   spreadRadius: 1.0,
  //                 ),
  //               ],
  //               borderRadius: BorderRadius.circular(5),
  //               border: Border.all(
  //                 color: AppColors.lightgrey, // Border color
  //                 width: 2.0, // Border width
  //               ),
  //               color: AppColors.white,
  //             ),
  //             width: double.infinity,
  //             child: Padding(
  //               padding: EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Image.asset(
  //                             'assets/investment_icon.png',
  //                             fit: BoxFit.fill,
  //                             height: SizeUtil.bodyLarge(context),
  //                           ),
  //                           SizedBox(
  //                             width: width * 0.02,
  //                           ),
  //                           Text(
  //                             item.name,
  //                             style: TextStyle(
  //                                 color: AppColors.primary,
  //                                 fontSize: SizeUtil.bodyLarge(context),
  //                                 fontWeight: FontWeight.w700,
  //                                 fontFamily: "Helvetica"),
  //                           ),
  //                         ],
  //                       ),
  //                       GestureDetector(
  //                         onTap: () {
  //                           confirmDelete(context);
  //                         },
  //                         child: Icon(
  //                           Icons.delete,
  //                           color: AppColors.primary,
  //                           size: SizeUtil.iconsSize(context),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: SizeUtil.verticalSpacingMedium(context),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Column(
  //                         // mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Text(
  //                                 'Current Value: ',
  //                                 style: TextStyle(
  //                                     color: AppColors.primary,
  //                                     fontSize: SizeUtil.body(context),
  //                                     fontFamily: "Helvetica"),
  //                               ),
  //                               RichText(
  //                                  textScaleFactor:MediaQuery.of(context).textScaleFactor,
  //                                 textAlign: TextAlign.start,
  //                                 text: TextSpan(
  //                                   children: [
  //                                     TextSpan(
  //                                         text: '₹',
  //                                         style: TextStyle(
  //                                             letterSpacing: 2,
  //                                             color: AppColors.primary,
  //                                             fontSize:
  //                                                 SizeUtil.body(context))),
  //                                     TextSpan(
  //                                       text: item.currentValue,
  //                                       style: TextStyle(
  //                                           color: AppColors.primary,
  //                                           fontSize: SizeUtil.body(context),
  //                                           fontFamily: "Helvetica"),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(
  //                             height: SizeUtil.verticalSpacingSmall(context),
  //                           ),
  //                           Row(
  //                             children: [
  //                               Text(
  //                                 'Purchase Price: ',
  //                                 style: TextStyle(
  //                                     color: AppColors.primary,
  //                                     fontSize: SizeUtil.body(context),
  //                                     fontFamily: "Helvetica"),
  //                               ),
  //                               RichText(
  //                                  textScaleFactor:MediaQuery.of(context).textScaleFactor,
  //                                 textAlign: TextAlign.start,
  //                                 text: TextSpan(
  //                                   children: [
  //                                     TextSpan(
  //                                         text: '₹',
  //                                         style: TextStyle(
  //                                             letterSpacing: 2,
  //                                             color: AppColors.primary,
  //                                             fontSize:
  //                                                 SizeUtil.body(context))),
  //                                     TextSpan(
  //                                       text: item.purchasePrice,
  //                                       style: TextStyle(
  //                                           color: AppColors.primary,
  //                                           fontSize: SizeUtil.body(context),
  //                                           fontFamily: "Helvetica"),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(
  //                             height: SizeUtil.verticalSpacingSmall(context),
  //                           ),
  //                           Text(
  //                             'Purchase Date: ${item.purchaseDate}',
  //                             style: TextStyle(
  //                                 color: AppColors.primary,
  //                                 fontSize: SizeUtil.body(context),
  //                                 fontFamily: "Helvetica"),
  //                           ),
  //                         ],
  //                       ),
  //                       Icon(
  //                         Icons.arrow_right_alt_sharp,
  //                         size: SizeUtil.iconsSize(context),
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> confirmDelete(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertBox(
  //         message: "Confirm Delete",
  //         onConfirm: () {},
  //       );
  //     },
  //   );
  // }
}
