import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';

import '../../../Model/profile/investerReport.dart';
import '../../../data/investerReport/investerReport.dart';

class InvestmentReportScreen extends StatefulWidget {
  const InvestmentReportScreen({super.key});

  @override
  State<InvestmentReportScreen> createState() => _InvestmentReportScreenState();
}

class _InvestmentReportScreenState extends State<InvestmentReportScreen> {
  var height;
  var width;

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
          Expanded(child: SingleChildScrollView(child: reportSection())),
        ],
      ),
    );
  }

  Widget reportSection() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const ScrollPhysics(),
      itemCount: investerReportList.length,
      itemBuilder: (context, index) {
        InvesterReportItems item = investerReportList[index];
        return Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                          fontSize: SizeUtil.headingMedium(context),
                          fontFamily: "Helvetica"),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.download,
                        color: AppColors.primary, // Customize icon color here
                        size: SizeUtil.iconsSize(context),
                      ),
                      onPressed: () {
                        print('File downloading...');
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                 Divider(
                  color: AppColors.lightgrey,
                  thickness: 1.0,
                  height: SizeUtil.verticalSpacingMedium(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
