import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:midas/model/investments/mutual__funds/sip/sip_details_model.dart';
import 'package:midas/screen/Investments/mutual_funds/sip/sip_details.dart';
import 'package:flutter/material.dart';

class MutualFundsOrdersSIP extends StatefulWidget {
  const MutualFundsOrdersSIP({super.key});

  @override
  State<MutualFundsOrdersSIP> createState() => _MutualFundsOrdersSIPState();
}

class _MutualFundsOrdersSIPState extends State<MutualFundsOrdersSIP> {
  var height;
  var width;

  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());

  ScrollController scrollControllerForSipDetails = ScrollController();
  int pageforSIPDetails = 1;

  @override
  void initState() {
    super.initState();
    mutualFundsController.getSIPDetails(context, 1);
    scrollControllerForSipDetails.addListener(scrollMoreSipDetails);
    if (mutualFundsController.mutualFundAmcSearchFocusNode.hasFocus) {
      mutualFundsController.mutualFundAmcSearchFocusNode.unfocus();
      mutualFundsController.update();
    }
  }

  Future<void> scrollMoreSipDetails() async {
    if (mutualFundsController.isLoadingMoreSipDetails.value ||
        mutualFundsController.noMoreDataLoadSipDetails.value) return;
    if (scrollControllerForSipDetails.position.pixels ==
        scrollControllerForSipDetails.position.maxScrollExtent) {
      setState(() {
        mutualFundsController.isLoadingMoreSipDetails.value = true;
      });
      pageforSIPDetails = pageforSIPDetails + 1;
      await mutualFundsController
          .getSIPDetails(context, pageforSIPDetails)
          .then((value) {
        setState(() {
          mutualFundsController.isLoadingMoreSipDetails.value = false;
        });
      });
    }
    mutualFundsController.update();
  }

  @override
  void dispose() {
    super.dispose();
    mutualFundsController.noMoreDataLoadSipDetails.value = false;
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
                      child: mutualFundsController.isLoadingSipDetails.value
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              controller: scrollControllerForSipDetails,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount:
                                  mutualFundsController.sipDetailsList.length +
                                      1,
                              itemBuilder: (context, index) {
                                if (index <
                                    mutualFundsController
                                        .sipDetailsList.length) {
                                  SipDetailsModel sipDetail =
                                      mutualFundsController
                                          .sipDetailsList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SIPDetailsScreen(
                                              amfiCode: sipDetail
                                                  .masterData!.amfiCode
                                                  .toString(),
                                              isinNumber: "",
                                              sipId: sipDetail.sip!.sipId
                                                  .toString(),
                                              currentValue: sipDetail
                                                  .currentValue!
                                                  .toDouble(),
                                            ),
                                          ));
                                    },
                                    child: Container(
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
                                          color: AppColors.lightgrey,
                                          width: 2.0,
                                        ),
                                        color: AppColors.white,
                                      ),
                                      width: double.infinity,
                                      margin: EdgeInsets.only(
                                          bottom:
                                              SizeUtil.verticalSpacingMedium(
                                                  context)),
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
                                                  sipDetail.masterData!.amc
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize:
                                                        SizeUtil.headingMedium(
                                                            context),
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Helvetica",
                                                  ),
                                                ),
                                                Text(
                                                  sipDetail.sip!.state
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: sipDetail.sip!.state
                                                                .toString() ==
                                                            "active"
                                                        ? AppColors.green
                                                        : AppColors.grey,
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica",
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  SizeUtil.verticalSpacingSmall(
                                                      context),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  sipDetail.masterData!.type
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: SizeUtil.body(
                                                          context),
                                                      fontFamily: "Helvetica"),
                                                ),
                                                Text(
                                                  sipDetail.sip!.frequency
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: SizeUtil.body(
                                                          context),
                                                      fontFamily: "Helvetica"),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  SizeUtil.verticalSpacingSmall(
                                                      context),
                                            ),
                                            Text(
                                              'Amount: ${sipDetail.sip!.amount ?? ""}',
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
                                            Text(
                                              'Next SIP Installment: ${sipDetail.sip!.nextInstallmentDate != null ? DateFormat('d MMM y').format(sipDetail.sip!.nextInstallmentDate!) : ""}',
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
                                  );
                                } else {
                                  return Center(
                                    child: mutualFundsController
                                            .noMoreDataLoadSipDetails.value
                                        ? Text(
                                            'no more data',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize:
                                                    SizeUtil.body(context),
                                                fontFamily: "Helvetica"),
                                          )
                                        : const CircularProgressIndicator(),
                                  );
                                }
                              },
                            ))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
