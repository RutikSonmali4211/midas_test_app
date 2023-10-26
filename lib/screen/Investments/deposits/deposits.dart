import 'package:midas/constant/colors.dart';
import 'package:midas/data/deposits_list.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:flutter/material.dart';

class DepositsScreen extends StatefulWidget {
  const DepositsScreen({super.key});

  @override
  State<DepositsScreen> createState() => _DepositsScreenState();
}

class _DepositsScreenState extends State<DepositsScreen> {
  int selectedIndex = 0;
  var height;
  var width;
  // String currentTab = "investment";

  List<String> sectionTitles = ['Existing Deposits', 'Create FD'];

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
                                '1,10,000',
                                style: TextStyle(
                                  color: AppTextColors.white,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w700,
                                  fontSize: height * 0.044,
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
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                sectionTitles.length,
                (index) => GestureDetector(
                  onTap: () {
                    if (index == 0 || index == 1) {
                      setState(() {
                        selectedIndex = index;
                      });
                    }
                  },
                  child: showTabs(
                    sectionTitles[index],
                    index == selectedIndex,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: height * 0.02, right: height * 0.02),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text(
                        "Fixed Deposits",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w700,
                          fontFamily: "San Francisco",
                          shadows: [
                            const Shadow(
                              color: AppColors.shadow,
                              offset: Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    getFixedDepositsSection(selectedIndex),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFixedDepositsSection(int index) {
    switch (selectedIndex) {
      case 0:
        return depositsSection();
      case 1:
        return depositsSection();
      case 2:
        return depositsSection();
      default:
        return Container();
    }
  }

  Widget showTabs(String title, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (title == 'Section 1') {
          setState(() {
            selectedIndex = sectionTitles.indexOf(title);
          });
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isActive ? AppColors.primary : Colors.grey,
              fontSize: height * 0.021,
              fontWeight: FontWeight.w700,
              fontFamily: "Helvetica",
              shadows: [
                isActive
                    ? const Shadow(
                        color: AppColors.shadow,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      )
                    : const Shadow(),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.007,
          ),
          if (isActive)
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 4), // Adjust the shadow's position
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: AppColors.primary,
              ),
              height: height * 0.009,
              width: width * 0.35,
            ),
          if (!isActive)
            Text('Coming Soon',
                style: TextStyle(
                    fontSize: height * 0.01,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget depositsSection() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: depositsList.length,
      itemBuilder: (context, index) {
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
                Image.asset('${depositsList[index]['bankLogo']}'),
                SizedBox(
                  height: height * 0.015,
                ),
                Text(
                  'FD A/C Number: ${depositsList[index]['accountNo']}',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: height * 0.022,
                      fontFamily: "Helvetica"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'FD Opening Amount: ${depositsList[index]['openingAmount']}',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: height * 0.022,
                      fontFamily: "Helvetica"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'FD Maturity Amount: ${depositsList[index]['maturityAmount']}',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: height * 0.022,
                      fontFamily: "Helvetica"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Maturity Date: ${depositsList[index]['maturityDate']}',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: height * 0.022,
                      fontFamily: "Helvetica"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Interest Rate: ${depositsList[index]['interestRate']}',
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
