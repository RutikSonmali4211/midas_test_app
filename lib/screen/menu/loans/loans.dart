import 'package:midas/constant/colors.dart';
import 'package:midas/data/loans_list.dart';
import 'package:midas/model/menu/loans_model.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:flutter/material.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> {
  var height;
  var width;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: screenSize.width,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  offset: Offset(0, 4),
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                ),
              ],
              color: AppColors
                  .primary, // You can change this to the desired card color
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(33.0),
                bottomRight: Radius.circular(33.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding:
                      EdgeInsets.only(top: height * 0.03, left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Row(
                        children: [
                          IconButton(
                            color: AppColors.white,
                            icon: const Icon(Icons.notifications_outlined),
                            iconSize: height * 0.030,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Notifications()),
                              );
                            },
                          ),
                          const SizedBox(width: 8.0),
                          IconButton(
                            color: AppColors.white,
                            icon: const Icon(Icons.account_circle),
                            iconSize: height * 0.030,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProfileAndSettings()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.02,
                      right: width * 0.02,
                      bottom: height * 0.02),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: height * 0.030,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Active Loans',
                            style: TextStyle(
                              color: AppTextColors.white,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w400,
                              fontSize: height * 0.025,
                            ),
                          ),
                          Text(
                            '2 Active',
                            style: TextStyle(
                              color: AppTextColors.white,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w700,
                              fontSize: height * 0.044,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                'Last Updated: 5:00 pm',
                                style: TextStyle(
                                  color: AppTextColors.white,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w400,
                                  fontSize: height * 0.018,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: height * 0.02,
                right: height * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: Text(
                      "Loans Granted",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: height * 0.025,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Helvetica",
                        shadows: const [
                          Shadow(
                            color: AppColors.shadow,
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Expanded(
                      child: SingleChildScrollView(child: loansListSection())),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loansListSection() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: loanList.length,
      itemBuilder: (context, index) {
        LoansData item = loanList[index];
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.1),
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
          margin: EdgeInsets.only(bottom: height * 0.03),
          child: Padding(
            padding: EdgeInsets.all(height * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: height * 0.024,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Helvetica",
                      ),
                    ),
                    Text(
                      item.isActive ? "Active" : "Closed",
                      style: TextStyle(
                        color: item.isActive ? AppColors.green : AppColors.red,
                        fontSize: height * 0.022,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Helvetica",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  'Loan Policy Number: ${item.policyNo}',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: height * 0.022,
                      fontFamily: "Helvetica"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Text(
                      'EMI: ',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: height * 0.022,
                          fontFamily: "Helvetica"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.currency_rupee_outlined,
                          color: AppColors.primary,
                          size: height * 0.022,
                        ),
                        Text(
                          '${item.emi}',
                          style: TextStyle(
                            color: AppTextColors.primary,
                            fontFamily: "Helvetica",
                            fontSize: height * 0.022,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Expiry Date: ${item.expiryDate}',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: height * 0.022,
                      fontFamily: "Helvetica"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Loan Provider: ${item.loanProvider}',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: height * 0.022,
                      fontFamily: "Helvetica"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
