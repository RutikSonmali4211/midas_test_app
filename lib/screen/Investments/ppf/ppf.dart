import 'package:midas/constant/colors.dart';
import 'package:midas/data/ppf_transaction_list.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:flutter/material.dart';

class PpfScreen extends StatefulWidget {
  const PpfScreen({super.key});

  @override
  State<PpfScreen> createState() => _PpfScreenState();
}

class _PpfScreenState extends State<PpfScreen> {
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
            decoration: BoxDecoration(
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
                      SizedBox(),
                      Row(
                        children: [
                          IconButton(
                            color: AppColors.white,
                            icon: Icon(Icons.notifications_outlined),
                            iconSize: height * 0.030,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Notifications()),
                              );
                            },
                          ),
                          SizedBox(width: 8.0),
                          IconButton(
                            color: AppColors.white,
                            icon: Icon(Icons.account_circle),
                            iconSize: height * 0.030,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileAndSettings()),
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
                            'Current Value',
                            style: TextStyle(
                              color: AppTextColors.white,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w400,
                              fontSize: height * 0.025,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.currency_rupee_outlined,
                                color: Colors.white,
                                size: height * 0.044,
                              ),
                              Text(
                                '3,30,000',
                                style: TextStyle(
                                  color: AppTextColors.white,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w700,
                                  fontSize: height * 0.044,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: height * 0.02, vertical: height * 0.02),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    accountDetailsSection(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    getTransactionDetails(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget accountDetailsSection() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            offset: Offset(0, 1),
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
        padding: EdgeInsets.all(height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A/c Number',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: height * 0.022,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Helvetica",
                        shadows: [
                          Shadow(
                            color: AppColors.shadow,
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'xxxxxxxx9382',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: height * 0.021,
                          fontFamily: "Helvetica"),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Value',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: height * 0.022,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Helvetica",
                        shadows: [
                          Shadow(
                            color: AppColors.shadow,
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    RichText(
                       textScaleFactor:MediaQuery.of(context).textScaleFactor,
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '₹',
                              style: TextStyle(
                                letterSpacing: 2,
                                color: AppColors.primary,
                                fontSize: height * 0.021,
                              )),
                          TextSpan(
                            text: '3,30,000',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: height * 0.021,
                                fontFamily: "Helvetica"),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Divider(
              color: AppColors.lightgrey,
              thickness: 1.0,
              height: height * 0.02,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A/c Opening Date',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: height * 0.022,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Helvetica",
                        shadows: [
                          Shadow(
                            color: AppColors.shadow,
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      '29 Jul 2029',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: height * 0.021,
                          fontFamily: "Helvetica"),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A/c Maturity Date',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: height * 0.022,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Helvetica",
                        shadows: [
                          Shadow(
                            color: AppColors.shadow,
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      '31 Mar 2035',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: height * 0.021,
                          fontFamily: "Helvetica"),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getTransactionDetails() {
    return Container(
      height: height * 0.6,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            offset: Offset(0, 1),
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
      width: width,
      child: Padding(
        padding: EdgeInsets.all(height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transactions',
              style: TextStyle(
                color: AppTextColors.primary,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w700,
                fontSize: height * 0.020,
                letterSpacing: 0.33,
                shadows: [
                  Shadow(
                    color: AppTextColors.shadowcolour,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: AppTextColors.grey,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Column(
              children: [
                Container(
                  height: height * 0.5,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: ppfList.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.lightgrey,
                        thickness: 1.0,
                      );
                    },
                    itemBuilder: (context, index) {
                      final transaction = ppfList[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(transaction.name,
                                style: TextStyle(
                                    fontSize: height * 0.022,
                                    color: AppTextColors.primary,
                                    fontFamily: "Helvetica",
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(transaction.date,
                                style: TextStyle(
                                    fontSize: height * 0.016,
                                    color: AppTextColors.grey,
                                    fontFamily: "Helvetica",
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                               textScaleFactor:MediaQuery.of(context).textScaleFactor,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '₹',
                                    style: TextStyle(
                                      letterSpacing: 2,
                                      fontFamily: 'NotoSans',
                                      color: AppTextColors.primary,
                                      fontSize: height * 0.016,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: transaction.amount,
                                    style: TextStyle(
                                      fontFamily: "Helvetica",
                                      color: AppTextColors.primary,
                                      fontSize: height * 0.016,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(transaction.des,
                                style: TextStyle(
                                    fontSize: height * 0.016,
                                    color: transaction.des == "Cr"
                                        ? AppTextColors.green
                                        : AppTextColors.red,
                                    fontFamily: "Helvetica",
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
