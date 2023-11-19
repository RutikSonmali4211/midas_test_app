import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import '../../data/transection_data/sell_list.dart';
import '../../data/transection_data/top_selling_list.dart';

class AccoundDetails extends StatefulWidget {
  const AccoundDetails({super.key});

  @override
  State<AccoundDetails> createState() => _AccoundDetailsState();
}

class _AccoundDetailsState extends State<AccoundDetails> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
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
                  padding: EdgeInsets.only(
                      top: size.height * 0.03, left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Row(
                        children: [
                          IconButton(
                            color: AppColors.white,
                            icon: const Icon(Icons.notifications_outlined),
                            iconSize: size.height * 0.030,
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
                            iconSize: size.height * 0.030,
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
                      left: size.width * 0.02,
                      right: size.width * 0.02,
                      bottom: size.height * 0.03),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: size.height * 0.030,
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
                            'Balance',
                            style: TextStyle(
                              color: AppTextColors.white,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.025,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.currency_rupee_outlined,
                                color: Colors.white,
                                size: size.height * 0.044,
                              ),
                              Text(
                                '10,53,270',
                                style: TextStyle(
                                  color: AppTextColors.white,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.height * 0.044,
                                ),
                              ),
                            ],
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
                                  fontSize: size.height * 0.018,
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
              padding: EdgeInsets.only(
                  left: size.height * 0.02,
                  right: size.height * 0.02,
                  top: size.height * 0.02,
                  bottom: size.height * 0.02),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
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
                          color: AppColors.lightgrey, // Border color
                          width: 2.0, // Border width
                        ),
                        color: AppColors.white,
                      ),
                      width: screenSize.width,
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.01),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Top Spending Categories',
                                style: TextStyle(
                                  color: AppTextColors.primary,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.height * 0.020,
                                  letterSpacing: 0.33,
                                  shadows: [
                                    const Shadow(
                                      color: AppTextColors.shadowcolour,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 20,
                              color: AppTextColors.primary,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Container(
                              height: size.height * 0.14,
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: topSellingList.length,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: AppColors.lightgrey,
                                    thickness: 1.0,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  final topSpending = topSellingList[index];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Text(topSpending.catagory,
                                            style: TextStyle(
                                                fontSize: size.height * 0.020,
                                                color: AppTextColors.primary,
                                                fontFamily: "Helvetica",
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.start),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '₹',
                                                style: TextStyle(
                                                  letterSpacing: 2,
                                                  fontFamily: 'NotoSans',
                                                  color: AppTextColors.primary,
                                                  fontSize: size.height * 0.022,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              TextSpan(
                                                text: topSpending.amount,
                                                style: TextStyle(
                                                  fontFamily: "Helvetica",
                                                  color: AppTextColors.primary,
                                                  fontSize: size.height * 0.022,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(topSpending.percentage,
                                            style: TextStyle(
                                                fontSize: size.height * 0.016,
                                                color: AppTextColors.grey,
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
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      height: size.height * 0.6,
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
                          color: AppColors.lightgrey, // Border color
                          width: 2.0, // Border width
                        ),
                        color: AppColors.white,
                      ),
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transactions',
                              style: TextStyle(
                                color: AppTextColors.primary,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w700,
                                fontSize: size.height * 0.020,
                                letterSpacing: 0.33,
                                shadows: [
                                  const Shadow(
                                    color: AppTextColors.shadowcolour,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 20,
                              color: AppTextColors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: size.height * 0.5,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: sellingList.length,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        color: AppColors.lightgrey,
                                        thickness: 1.0,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      final selling = sellingList[index];
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(selling.name,
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.022,
                                                    color:
                                                        AppTextColors.primary,
                                                    fontFamily: "Helvetica",
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.start),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(selling.date,
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.016,
                                                    color: AppTextColors.grey,
                                                    fontFamily: "Helvetica",
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.start),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '₹',
                                                    style: TextStyle(
                                                      letterSpacing: 2,
                                                      fontFamily: 'NotoSans',
                                                      color:
                                                          AppTextColors.primary,
                                                      fontSize:
                                                          size.height * 0.016,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: selling.amount,
                                                    style: TextStyle(
                                                      fontFamily: "Helvetica",
                                                      color:
                                                          AppTextColors.primary,
                                                      fontSize:
                                                          size.height * 0.016,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(selling.des,
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.016,
                                                    color: selling.des == "Cr"
                                                        ? AppTextColors.green
                                                        : AppTextColors.red,
                                                    fontFamily: "Helvetica",
                                                    fontWeight:
                                                        FontWeight.w400),
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
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
