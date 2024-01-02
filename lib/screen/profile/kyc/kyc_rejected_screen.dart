// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/controller/kyc/kyc_controller.dart';
import 'package:midas/screen/profile/kyc/kyc_request_form.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';

class KycRejected extends StatefulWidget {
  const KycRejected({super.key});

  @override
  State<KycRejected> createState() => _KycRejectedState();
}

class _KycRejectedState extends State<KycRejected> {
  // ignore: prefer_typing_uninitialized_variables
  var height;
  // ignore: prefer_typing_uninitialized_variables
  var width;
  // ignore: non_constant_identifier_names
  var kyc_status = "Rejected";
  KYCController kycController = Get.put(KYCController());
  @override
  void initState() {
    super.initState();
    fetchError();
  }

  fetchError() async {
    try {
      final Map<String, dynamic> data =
          await kycController.fetchKycDetails(context);
      kyc_status=data["result"]["status"] ?? "Rejected";
      if (data.containsKey('result') && data['result'] != null) {
        kycController.setVerificationDetails(
            data['result']['verification']['details_verbose']);
      } else {
        print("Missing or null 'result' key in the response");
      }
    } catch (e) {
      print("Error fetching data: $e");
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
          const SmallAppbar(heading: "KYC Details"),
          SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "KYC $kyc_status",
                  style: TextStyle(
                      fontSize: SizeUtil.headingMedium(context),
                      color: AppColors.primary),
                ),
                Expanded(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Field')),
                      DataColumn(label: Text('Error')),
                    ],
                    rows: kycController.verificationDetails
                        .map(
                          (detail) => DataRow(
                            cells: [
                              DataCell(Text(detail['field'])),
                              DataCell(Text(detail['error'])),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: size.width * 0.10,
                left: size.width * 0.10,
                bottom: SizeUtil.buttonPaddingBottom(context)),
            child: Visibility(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LargeButton(
                      text: "Edit KYC",
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const KYCRequestForm()),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
