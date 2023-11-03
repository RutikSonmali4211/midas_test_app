import 'package:midas/constant/colors.dart';
import 'package:midas/data/stocks_list.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:flutter/material.dart';

class StocksScreen extends StatefulWidget {
  const StocksScreen({super.key});

  @override
  State<StocksScreen> createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  int selectedIndex = 0;
  var height;
  var width;
  // String currentTab = "investment";

  List<String> sectionTitles = ['Holdings', 'Positions', 'Watchlist'];
  List<String> sectionContents = [
    'This is content for Section 1.',
    'This is content for Section 2.',
    'This is content for Section 3.',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save references to ancestor widgets here if needed.
  }

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
                    getProfitAndLossSection(selectedIndex),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text(
                        "Stocks",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: height * 0.021,
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
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    getStocksSection(selectedIndex),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavbar(
      //   onTabSelected: _onTabSelected,
      //   currentTab: currentTab,
      // ),
    );
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
                    ? Shadow(
                        color: AppColors.shadow,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      )
                    : Shadow(),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.007,
          ),
          if (isActive)
            Container(
              decoration: BoxDecoration(
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
              width: width * 0.2,
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

  Widget getProfitAndLossSection(int index) {
    switch (selectedIndex) {
      case 0:
        return holdingSection();
      case 1:
        return positionSection();
      case 2:
        return wishListSection();
      default:
        return Container();
    }
  }

  Widget getStocksSection(int index) {
    switch (selectedIndex) {
      case 0:
        return stocksSection();
      case 1:
        return stocksSection();
      case 2:
        return stocksSection();
      default:
        return Container();
    }
  }

  Widget holdingSection() {
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
                      'Investment',
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
                            text: '1,00,000',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: height * 0.021,
                                fontFamily: "Helvetica"),
                          ),
                        ],
                      ),
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
                            text: '1,10,000',
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
              height: height * 0.01,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'P&L',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: height * 0.022,
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(
                          color: AppColors.shadow,
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                      fontFamily: "Helvetica"),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                       textScaleFactor:MediaQuery.of(context).textScaleFactor,
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '₹',
                              style: TextStyle(
                                letterSpacing: 2,
                                color: AppColors.green,
                                fontSize: height * 0.021,
                              )),
                          TextSpan(
                            text: '10,000',
                            style: TextStyle(
                                color: AppColors.green,
                                fontSize: height * 0.021,
                                fontFamily: "Helvetica"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      shadowColor: AppColors.black,
                      child: Container(
                        height: height * 0.029,
                        width: width * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.lightgreen,
                        ),
                        child: Center(
                          child: Text(
                            "10.0 %",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.green,
                              fontSize: height * 0.017,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget stocksSection() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: stocksList.length,
      itemBuilder: (context, index) {
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
              color: AppColors.lightgrey,
              width: 2.0,
            ),
            color: AppColors.white,
          ),
          width: double.infinity,
          margin: EdgeInsets.only(bottom: height * 0.015),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Qty. ${stocksList[index]['qty']}',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: height * 0.022,
                            fontFamily: "Helvetica",
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '|',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: height * 0.022,
                            fontFamily: "Helvetica",
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   margin:
                        //       EdgeInsets.symmetric(horizontal: width * 0.02),
                        //   height: height *0.018,
                        //   width: width * 0.002,
                        //   color: AppColors.primary,
                        // ),
                        Text(
                          'Avg. ${stocksList[index]['avg']}',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: height * 0.022,
                            fontFamily: "Helvetica",
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'LTP. ${stocksList[index]['ltp']}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: height * 0.022,
                        fontFamily: "Helvetica",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${stocksList[index]['name']}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: height * 0.021,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Helvetica",
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '+9,325.00',
                          style: TextStyle(
                              color: AppColors.green,
                              fontSize: height * 0.021,
                              fontFamily: "Helvetica"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '+31.08%',
                          style: TextStyle(
                              color: AppColors.green,
                              fontSize: height * 0.013,
                              fontFamily: "Helvetica"),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'Invested: ${stocksList[index]['invested']}',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: height * 0.022,
                      fontFamily: "Helvetica"),
                ),
                Text(
                  'Current Value: ${stocksList[index]['currentValue']}',
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

  positionSection() {}
  wishListSection() {}
}
