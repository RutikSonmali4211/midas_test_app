import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:midas/model/investments/mutual__funds/amc/mutual_fund_amc_model.dart';
import 'package:flutter/material.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_scheme_details.dart';
import 'package:midas/widgets/alert_box.dart';
import 'package:midas/widgets/confirmation_dialog_box.dart';
import 'package:pinput/pinput.dart';

class MutualFundsWatchList extends StatefulWidget {
  const MutualFundsWatchList({super.key});

  @override
  State<MutualFundsWatchList> createState() => _MutualFundsWatchListState();
}

class _MutualFundsWatchListState extends State<MutualFundsWatchList> {
  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());

  String _selectedFilter = "amc";

  ScrollController scrollControllerForAllAmcs = ScrollController();
  int pageforAllAmcs = 1;

  @override
  void initState() {
    super.initState();
    scrollControllerForAllAmcs.addListener(scrollMoreDataForAllAmcs);
    mutualFundsController.getUsersMutualFundAmcWatchList(context);
  }

  Future<void> scrollMoreDataForAllAmcs() async {
    if (mutualFundsController.isLoadingMoreAllAmc.value ||
        mutualFundsController.noMoreDataLoadAllAmc.value) return;
    if (scrollControllerForAllAmcs.position.pixels ==
        scrollControllerForAllAmcs.position.maxScrollExtent) {
      setState(() {
        mutualFundsController.isLoadingMoreAllAmc.value = true;
      });
      pageforAllAmcs = pageforAllAmcs + 1;
      await mutualFundsController
          .getAllAmcWatchList(
              _selectedFilter,
              mutualFundsController.mutualFundAmcSearchController.text
                  .toString(),
              context,
              pageforAllAmcs)
          .then((value) {
        setState(() {
          mutualFundsController.isLoadingMoreAllAmc.value = false;
        });
      });
    }
    mutualFundsController.update();
  }

  @override
  void dispose() {
    super.dispose();
    mutualFundsController.noMoreDataLoadAllAmc.value = false;
    mutualFundsController.mutualFundAllAmcsWatchlist.clear();
    mutualFundsController.mutualFundUsersAmcWatchlist.clear();
    mutualFundsController.mutualFundAmcSearchFocusNode.unfocus();
    mutualFundsController.mutualFundAmcSearchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: TextFormField(
                    controller:
                        mutualFundsController.mutualFundAmcSearchController,
                    focusNode:
                        mutualFundsController.mutualFundAmcSearchFocusNode,
                    onTap: () {
                      setState(() {
                        pageforAllAmcs = 1;
                        scrollControllerForAllAmcs
                            .removeListener(scrollMoreDataForAllAmcs);
                        scrollControllerForAllAmcs
                            .addListener(scrollMoreDataForAllAmcs);
                      });
                      mutualFundsController.getAllAmcWatchList(
                          _selectedFilter,
                          mutualFundsController
                              .mutualFundAmcSearchController.text
                              .toString(),
                          context,
                          1);
                    },
                    maxLength: 150,
                    onChanged: (value) {
                      setState(() {
                        if (mutualFundsController
                                .mutualFundAmcSearchController.length >=
                            3) {
                          mutualFundsController.mutualFundAllAmcsWatchlist
                              .clear();
                          // mutualFundsController.isLoadingMoreAllAmc.value=false;
                          mutualFundsController.noMoreDataLoadAllAmc.value =
                              false;
                          pageforAllAmcs = 1;
                          scrollControllerForAllAmcs
                              .removeListener(scrollMoreDataForAllAmcs);
                          scrollControllerForAllAmcs
                              .addListener(scrollMoreDataForAllAmcs);
                          mutualFundsController.getAllAmcWatchList(
                              _selectedFilter,
                              mutualFundsController
                                  .mutualFundAmcSearchController.text
                                  .toString(),
                              context,
                              1);
                        } else {
                          pageforAllAmcs = 1;
                          scrollControllerForAllAmcs
                              .removeListener(scrollMoreDataForAllAmcs);
                          scrollControllerForAllAmcs
                              .addListener(scrollMoreDataForAllAmcs);
                          mutualFundsController.getAllAmcWatchList(
                              _selectedFilter, "", context, 1);
                        }
                        // mutualFundsController.mutualFundAllAmcsWatchlist.value =
                        //     mutualFundsController.mutualFundUsersAmcWatchlist
                        //         .where((value) => value.amc
                        //             .toLowerCase()
                        //             .contains(value.amc.toLowerCase()))
                        //         .toList();
                      });
                    },
                    onEditingComplete: () {
                      mutualFundsController.getAllAmcWatchList(
                          _selectedFilter,
                          mutualFundsController
                              .mutualFundAmcSearchController.text
                              .toString(),
                          context,
                          1);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      counterText: "",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Icon(Icons.search,
                            size: SizeUtil.iconsSize(context),
                            color: AppColors.primary),
                      ),
                      prefixIconConstraints: const BoxConstraints(),
                      suffixIcon: mutualFundsController
                              .mutualFundAmcSearchController.text.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    mutualFundsController
                                        .mutualFundAmcSearchController
                                        .clear();
                                    mutualFundsController
                                        .mutualFundAmcSearchFocusNode
                                        .unfocus();
                                  });
                                },
                                child: Icon(Icons.highlight_remove_rounded,
                                    size: SizeUtil.iconsSize(context),
                                    color: AppColors.primary),
                              ),
                            )
                          : null,
                      suffixIconConstraints: const BoxConstraints(),
                      filled: true,
                      isDense: true,
                      border: InputBorder.none,
                      fillColor: TextfieldColors.background,
                    ),
                    style: TextStyle(fontSize: SizeUtil.body(context)),
                  ),
                ),
              ),
              PopupMenuButton<String>(
                enableFeedback: true,
                enabled: true,
                initialValue: _selectedFilter,
                icon: Icon(
                  Icons.filter_alt_sharp,
                  size: SizeUtil.iconsSize(context),
                  color: AppColors.primary,
                ),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<String>>[
                    const PopupMenuItem<String>(
                      value: MutualFundAmcTypes.amc,
                      child: Text('Name'),
                    ),
                    const PopupMenuItem<String>(
                      value: MutualFundAmcTypes.type,
                      child: Text('Type'),
                    ),
                    const PopupMenuItem<String>(
                      value: MutualFundAmcTypes.category,
                      child: Text('Category'),
                    ),
                  ];
                },
                onSelected: (String choice) {
                  setState(() {
                    _selectedFilter = choice;
                  });
                },
              ),
            ],
          ),
          const Divider(
            color: AppColors.lightgrey,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Expanded(
            child: SizedBox(
                child: Obx(
              () => Column(
                children: [
                  if (!mutualFundsController
                      .mutualFundAmcSearchFocusNode.hasFocus)
                    mutualFundsController.isLoading.value
                        ? const Expanded(
                            child: Center(
                            child: CircularProgressIndicator(),
                          ))
                        : Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: mutualFundsController
                                  .mutualFundUsersAmcWatchlist.length,
                              itemBuilder: (context, index) {
                                MutualFundAmcModel amcData =
                                    mutualFundsController
                                        .mutualFundUsersAmcWatchlist[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MutualFundSchemeDetails(
                                                amfiCode:
                                                    amcData.amfiCode.toString(),
                                                isinNumber: amcData
                                                    .isinPayoutOrGrowth
                                                    .toString(),
                                                    folioNumber: "",
                                              )),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(
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
                                                children: [
                                                  Text(
                                                    amcData.amc.toString(),
                                                    style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: SizeUtil
                                                          .headingMedium(
                                                              context),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "Helvetica",
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertBox(
                                                              message:
                                                                  "Confirm Delete",
                                                              onConfirm:
                                                                  () async {
                                                                setState(() {
                                                                  mutualFundsController
                                                                      .removeAmcFromUsersWatchList(
                                                                          amcData
                                                                              .id
                                                                              .toString(),
                                                                          context);
                                                                });
                                                                //   .then(
                                                                //       (value) {
                                                                // if (value) {
                                                                //   setState(
                                                                //       () {
                                                                //     mutualFundsController
                                                                //         .getUsersMutualFundAmcWatchList(context);
                                                                //     // mutualFundsController
                                                                //     //     .update();
                                                                //   });
                                                                // }
                                                                // });
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
                                              SizedBox(
                                                height: SizeUtil
                                                    .verticalSpacingSmall(
                                                        context),
                                              ),
                                              Text(
                                                amcData.category.toString(),
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: SizeUtil.verticalSpacingMedium(
                                            context),
                                        color: AppColors.lightgrey,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  if (mutualFundsController
                      .mutualFundAmcSearchFocusNode.hasFocus)
                    mutualFundsController.isLoadingAllAmc.value
                        ? const Expanded(
                            child: Center(
                            child: CircularProgressIndicator(),
                          ))
                        : mutualFundsController
                                .mutualFundAllAmcsWatchlist.isEmpty
                            ? const Expanded(
                                child: Center(child: Text("no records found")))
                            : Expanded(
                                child: ListView.builder(
                                  controller: scrollControllerForAllAmcs,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: mutualFundsController
                                          .mutualFundAllAmcsWatchlist.length +
                                      1,
                                  itemBuilder: (context, index) {
                                    if (index <
                                        mutualFundsController
                                            .mutualFundAllAmcsWatchlist
                                            .length) {
                                      MutualFundAmcModel allAmcData =
                                          mutualFundsController
                                                  .mutualFundAllAmcsWatchlist[
                                              index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MutualFundSchemeDetails(
                                                      amfiCode: allAmcData
                                                          .amfiCode
                                                          .toString(),
                                                      isinNumber: allAmcData
                                                          .isinPayoutOrGrowth
                                                          .toString(),
                                                          folioNumber: "",
                                                    )),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Padding(
                                                padding: EdgeInsets.all(SizeUtil
                                                    .verticalSpacingSmall(
                                                        context)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          allAmcData.amc,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primary,
                                                            fontSize: SizeUtil
                                                                .headingMedium(
                                                                    context),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "Helvetica",
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeUtil
                                                              .verticalSpacingSmall(
                                                                  context),
                                                        ),
                                                        Text(
                                                          allAmcData.category
                                                              .toString(),
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
                                                    if (mutualFundsController
                                                        .mutualFundAmcSearchFocusNode
                                                        .hasFocus)
                                                      Theme(
                                                        data: ThemeData(
                                                          unselectedWidgetColor:
                                                              AppColors.primary,
                                                        ),
                                                        child: Transform.scale(
                                                          scale: 1,
                                                          child: Checkbox(
                                                            activeColor:
                                                                AppColors
                                                                    .primary,
                                                            value:
                                                                allAmcData.flag,
                                                            visualDensity:
                                                                const VisualDensity(
                                                              horizontal:
                                                                  VisualDensity
                                                                      .minimumDensity,
                                                              vertical:
                                                                  VisualDensity
                                                                      .minimumDensity,
                                                            ),
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            onChanged:
                                                                (newValue) {
                                                              if (!allAmcData
                                                                  .flag!) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return ConfirmDialogBox(
                                                                        heading:
                                                                            "",
                                                                        body:
                                                                            "Do you want to add this mutual fund amc to your watchlist ?",
                                                                        message:
                                                                            "",
                                                                        onConfirm:
                                                                            () async {
                                                                          if (newValue ??
                                                                              false) {
                                                                            mutualFundsController.addAmcToUsersWatchList(allAmcData.id.toString(), context).then((value) {
                                                                              if (value) {
                                                                                mutualFundsController.mutualFundAmcSearchController.clear();
                                                                                mutualFundsController.mutualFundAmcSearchFocusNode.unfocus();
                                                                                mutualFundsController.update();
                                                                              }
                                                                            });
                                                                          }
                                                                        });
                                                                  },
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              height: SizeUtil
                                                  .verticalSpacingMedium(
                                                      context),
                                              color: AppColors.lightgrey,
                                              thickness: 1,
                                              indent: 0,
                                              endIndent: 0,
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Center(
                                            child: mutualFundsController
                                                    .noMoreDataLoadAllAmc.value
                                                ? Text(
                                                    'no more data',
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: SizeUtil.body(
                                                            context),
                                                        fontFamily:
                                                            "Helvetica"),
                                                  )
                                                : const CircularProgressIndicator()),
                                      );
                                    }
                                  },
                                ),
                              )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}


























































// SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: TextFormField(
//                       controller: _searchController,
//                       maxLength: 150,
//                       onChanged: (value) {
//                         setState(() {
//                           filteredSipDetailsList = sipDetailsList
//                               .where((sip) => sip.name
//                                   .toLowerCase()
//                                   .contains(value.toLowerCase()))
//                               .toList();
//                         });
//                       },
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       decoration: InputDecoration(
//                         counterText: "",
//                         prefixIcon: Padding(
//                           padding: const EdgeInsets.only(left: 5.0, right: 5.0),
//                           child: Icon(Icons.search,
//                               size: SizeUtil.iconsSize(context),
//                               color: AppColors.primary),
//                         ),
//                         prefixIconConstraints: const BoxConstraints(),
//                         suffixIcon: Padding(
//                           padding: const EdgeInsets.only(right: 5.0),
//                           child: Icon(Icons.highlight_remove_rounded,
//                               size: SizeUtil.iconsSize(context),
//                               color: AppColors.primary),
//                         ),
//                         suffixIconConstraints: const BoxConstraints(),
//                         filled: true,
//                         isDense: true,
//                         border: InputBorder.none,
//                         fillColor: TextfieldColors.background,
//                       ),
//                       style: TextStyle(fontSize: SizeUtil.body(context)),
//                     ),
//                   ),
//                 ),
//                 PopupMenuButton<String>(
//                   enableFeedback: true,
//                   enabled: true,
//                   initialValue: _selectedFilter,
//                   icon: Icon(
//                     Icons.filter_alt_sharp,
//                     size: SizeUtil.iconsSize(context),
//                     color: AppColors.primary,
//                   ),
//                   itemBuilder: (BuildContext context) {
//                     return <PopupMenuItem<String>>[
//                       const PopupMenuItem<String>(
//                         value: 'Name',
//                         child: Text('Name'),
//                       ),
//                       const PopupMenuItem<String>(
//                         value: 'Type',
//                         child: Text('Type'),
//                       ),
//                       const PopupMenuItem<String>(
//                         value: 'Category',
//                         child: Text('Category'),
//                       ),
//                     ];
//                   },
//                   onSelected: (String choice) {
//                     setState(() {
//                       _selectedFilter = choice;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             const Divider(
//               color: AppColors.lightgrey,
//               thickness: 1,
//               indent: 0,
//               endIndent: 0,
//             ),
//             if (_searchController.text.isEmpty)
//               ListView.builder(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 physics: const ScrollPhysics(),
//                 itemCount: sipDetailsList.length,
//                 itemBuilder: (context, index) {
//                   SIPDetails sip = sipDetailsList[index];
//                   return Column(
//                     children: [
//                       SizedBox(
//                         width: double.infinity,
//                         child: Padding(
//                           padding: EdgeInsets.all(
//                               SizeUtil.verticalSpacingSmall(context)),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     sip.name,
//                                     style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.headingMedium(context),
//                                       fontWeight: FontWeight.w700,
//                                       fontFamily: "Helvetica",
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {},
//                                     child: Icon(
//                                       Icons.delete,
//                                       color: AppColors.primary,
//                                       size: SizeUtil.iconsSize(context),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: SizeUtil.verticalSpacingSmall(context),
//                               ),
//                               Text(
//                                 'Growth | ${sip.sipType} - ${sip.sipTypeValue}',
//                                 style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: SizeUtil.body(context),
//                                     fontFamily: "Helvetica"),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Divider(
//                         height: SizeUtil.verticalSpacingMedium(context),
//                         color: AppColors.lightgrey,
//                         thickness: 1,
//                         indent: 0,
//                         endIndent: 0,
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             if (_searchController.text.isNotEmpty)
//               ListView.builder(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 physics: const ScrollPhysics(),
//                 itemCount: filteredSipDetailsList.length,
//                 itemBuilder: (context, index) {
//                   SIPDetails sip = filteredSipDetailsList[index];
//                   return Column(
//                     children: [
//                       SizedBox(
//                         width: double.infinity,
//                         child: Padding(
//                           padding: EdgeInsets.all(
//                               SizeUtil.verticalSpacingSmall(context)),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     sip.name,
//                                     style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: SizeUtil.headingMedium(context),
//                                       fontWeight: FontWeight.w700,
//                                       fontFamily: "Helvetica",
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height:
//                                         SizeUtil.verticalSpacingSmall(context),
//                                   ),
//                                   Text(
//                                     'Growth | ${sip.sipType} - ${sip.sipTypeValue}',
//                                     style: TextStyle(
//                                         color: AppColors.primary,
//                                         fontSize: SizeUtil.body(context),
//                                         fontFamily: "Helvetica"),
//                                   ),
//                                 ],
//                               ),
//                               if (_searchController.text.isNotEmpty)
//                                 Theme(
//                                   data: ThemeData(
//                                     unselectedWidgetColor: AppColors.primary,
//                                   ),
//                                   child: Transform.scale(
//                                     scale: 1,
//                                     child: Checkbox(
//                                       activeColor: AppColors.primary,
//                                       value: selectedSipDetails.contains(sip),
//                                       visualDensity: const VisualDensity(
//                                         horizontal:
//                                             VisualDensity.minimumDensity,
//                                         vertical: VisualDensity.minimumDensity,
//                                       ),
//                                       materialTapTargetSize:
//                                           MaterialTapTargetSize.shrinkWrap,
//                                       onChanged: (newValue) {
//                                         setState(() {
//                                           if (newValue ?? false) {
//                                             selectedSipDetails.add(sip);
//                                           } else {
//                                             selectedSipDetails.remove(sip);
//                                           }
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Divider(
//                         height: SizeUtil.verticalSpacingMedium(context),
//                         color: AppColors.lightgrey,
//                         thickness: 1,
//                         indent: 0,
//                         endIndent: 0,
//                       ),
//                     ],
//                   );
//                 },
//               )
//           ],
//         ),
//       ),
//     );
