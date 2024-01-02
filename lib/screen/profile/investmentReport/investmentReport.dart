import 'package:get/get.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/controller/investor_report/investor_report_controller.dart';
import 'package:midas/controller/kyc/kyc_controller.dart';
import 'package:midas/model/Dto/ImageData.dart';
import 'package:midas/screen/profile/kyc/esign_required_screen.dart';
import 'package:midas/screen/profile/kyc/kycBankDetailsPage.dart';
import 'package:midas/screen/profile/kyc/kyc_done_screen.dart';
import 'package:midas/screen/profile/kyc/kyc_rejected_screen.dart';
import 'package:midas/screen/profile/kyc/kyc_submitted.dart';
import 'package:midas/screen/profile/kyc/start_kyc.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';
import 'package:midas/widgets/buttons/small_button.dart';

import '../../../model/profile/investerReport.dart';
import '../../../data/investerReport/investerReport.dart';

class InvestmentReportScreen extends StatefulWidget {
  const InvestmentReportScreen({super.key});

  @override
  State<InvestmentReportScreen> createState() => _InvestmentReportScreenState();
}

class _InvestmentReportScreenState extends State<InvestmentReportScreen> {
  var height;
  var width;

  InvestorReportController investorReportController =
      Get.put(InvestorReportController());

  KYCController kycController = Get.put(KYCController());

  bool isKycCompleted = false;

  @override
  void initState() {
    super.initState();
    checkKycStatus();
  }

  checkKycStatus() async {
    ImageData data = await kycController.fetchKycStatus(context);
    if (data.value == "successful") {
      setState(() {
        isKycCompleted = true;
      });
    } else {
      isKycCompleted = false;
    }
  }

  switchKycScreen() async {
    ImageData data = await kycController.fetchKycStatus(context);
    if (data.value == "pending") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KycRejected()),
      );
    }
    if (data.value == "esign_required") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EsignRequired()),
      );
    }
    if (data.value == "submitted") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KycSubmittedPhase()),
      );
    }
    if (data.value == "successful") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KycDone()),
      );
    }
    if (data.value == "expired") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KycRejected()),
      );
    }
    if (data.value == "rejected") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KycRejected()),
      );
    }
    if (data.value == "" ||
        data.value == "remaining" ||
        data.value == "Incompleted") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KycDetailsPhase()),
      );
    }
    if (data.value == "bank_details_required") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KycBankDetailsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SmallAppbar(heading: "Investment Reports"),
          SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
          Expanded(
            child: Obx(() => kycController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.04,
                          right: size.width * 0.04,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const ScrollPhysics(),
                          itemCount: investerReportList.length,
                          itemBuilder: (context, index) {
                            InvesterReportItems item =
                                investerReportList[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.02, right: width * 0.02),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w400,
                                            fontSize: SizeUtil.headingMedium(
                                                context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.download,
                                          color: isKycCompleted
                                              ? AppColors.primary
                                              : null, // Customize icon color here
                                          size: SizeUtil.iconsSize(context),
                                        ),
                                        onPressed: isKycCompleted
                                            ? () {
                                                downloadSelectedReport(
                                                    item.name);
                                              }
                                            : null,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    color: AppColors.lightgrey,
                                    thickness: 1.0,
                                    height: SizeUtil.verticalSpacingMedium(
                                        context),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      if(!isKycCompleted)
                      SizedBox(
                        height: SizeUtil.verticalSpacingMedium(context),
                      ),
                      if(!isKycCompleted)
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.error_outline,
                                size: SizeUtil.bodyLarge(context)),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "Seems like your KYC is not completed yet, so please complete your Kyc first",
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: SizeUtil.body(context),
                                    fontFamily: "Helvetica"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(!isKycCompleted)
                      SizedBox(
                        height: SizeUtil.verticalSpacingLarge(context),
                      ),
                      if(!isKycCompleted)
                      SmallButton(
                          text: "Continue",
                          onPressed: () {
                            switchKycScreen();
                          },
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white),
                    ],
                  )),
          ),
        ],
      ),
    );
  }

  downloadSelectedReport(String name) async {
    switch (name) {
      case 'Holdings Report':
        investorReportController.downloadHoldingReport(context);
        break;
      case 'Capital Gains Report':
        investorReportController.downloadCapitalGainReport(context);
        break;
      case 'Scheme Wise Returns Report':
        investorReportController.downloadSchemeWiseReport(context);
        break;
      case 'Account Wise Returns Report':
        investorReportController.downloadInvestmentAccountWiseReport(context);
        break;
      default:
        break;
    }
  }
}
