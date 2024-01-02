import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds_transaction.dart';
import 'package:midas/screen/Investments/mutual_funds/sip/mutual_funds_sip.dart';
import 'package:flutter/material.dart';

class MutualFundsOrders extends StatefulWidget {
  const MutualFundsOrders({super.key});

  @override
  State<MutualFundsOrders> createState() => _MutualFundsOrdersState();
}

class _MutualFundsOrdersState extends State<MutualFundsOrders> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MutualFundsOrdersSIP()),
                );
              },
              child: Container(
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
                    color: AppColors.lightgrey, // Border color
                    width: 2.0, // Border width
                  ),
                  color: AppColors.white,
                ),
                width: double.infinity,
                child: Padding(
                  padding:
                      EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SIP Details",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: SizeUtil.headingMedium(context),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Helvetica",
                        ),
                      ),
                      const SizedBox(
                        height:DefaultSizes.spacingBetweenTexts,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '3 Active SIPs',
                            style: TextStyle(
                                color: AppColors.grey,
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.arrow_right_alt_sharp,
                              size: SizeUtil.iconsSize(context),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeUtil.verticalSpacingMedium(context),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MutualFundTransactionScreen(isSeeSingleTransaction: false,isinNumber: "",)),
                );
              },
              child: Container(
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
                    color: AppColors.lightgrey, // Border color
                    width: 2.0, // Border width
                  ),
                  color: AppColors.white,
                ),
                width: double.infinity,
                child: Padding(
                  padding:
                      EdgeInsets.all(SizeUtil.verticalSpacingSmall(context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transaction Details",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: SizeUtil.headingMedium(context),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Helvetica",
                        ),
                      ),
                      const SizedBox(
                        height: DefaultSizes.spacingBetweenTexts,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Processing | Complete',
                            style: TextStyle(
                                color: AppColors.grey,
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.arrow_right_alt_sharp,
                              size: SizeUtil.iconsSize(context),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
