import 'package:midas/constant/colors.dart';
import 'package:midas/screen/Investments/investment.dart';
import 'package:midas/screen/cards/card.dart';
import 'package:midas/screen/goals/goals.dart';
import 'package:midas/screen/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:midas/screen/home/home.dart';

class BottomNevbar extends StatefulWidget {
  const BottomNevbar({Key? key}) : super(key: key);

  @override
  State<BottomNevbar> createState() => _BottomNevbarState();
}

class _BottomNevbarState extends State<BottomNevbar> {
  int currentIndex = 0;
  int activeTabIndex = 0;
  late List<Widget> screens;
  late List<Widget> _screenInstances;

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Key generateKey() => UniqueKey();

  @override
  void initState() {
    super.initState();
    _screenInstances = [
      HomeScreen(key: generateKey()),
      Cards(key: generateKey()),
      Investment(key: generateKey()),
      Goals(key: generateKey()),
      Menu(key: generateKey(), onTabChange: updateActiveTab),
    ];
    screens = List.from(_screenInstances);
  }

  void updateActiveTab(int newIndex) {
    setState(() {
      activeTabIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
           final NavigatorState? currentNavigator =
              navigatorKeys[currentIndex].currentState;
          if (currentNavigator != null && currentNavigator.canPop()) {
            currentNavigator.pop();
            return false;
          } else if (currentIndex != 0) {
            // If not on the home screen, navigate to the home screen
            setState(() {
              currentIndex = 0;
              activeTabIndex=0;
            });
            return false;
          }
          return true;
        },
        child: IndexedStack(
          index: currentIndex,
          children: List.generate(screens.length, (index) {
            return _buildOffstageNavigator(index);
          }),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.primary,
          iconSize: 28,
          unselectedItemColor: AppColors.grey,
          currentIndex: activeTabIndex, // Use activeTabIndex to set the active tab
          onTap: (index) {
            setState(() {
              activeTabIndex = index; // Update the activeTabIndex
              if (currentIndex == index) {
                navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
              } else {
                currentIndex = index;
                if (_screenInstances[currentIndex].key == null) {
                  _screenInstances[currentIndex] = screens[currentIndex];
                }
                navigatorKeys[currentIndex] = GlobalKey<NavigatorState>();
                screens[currentIndex] = _screenInstances[currentIndex];
              }
            });
          },
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'),
            const BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Invest'),
            BottomNavigationBarItem(
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Image.asset(
                      "assets/goal_icon.png",
                      height: 22,
                      color: activeTabIndex == 3 ? AppColors.primary : AppColors.grey,
                    ),
                  ),
                ],
              ),
              label: 'Goals',
            ),
            const BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
          ],
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: currentIndex != index,
      child: _buildNavigator(index),
    );
  }

  Widget _buildNavigator(int index) {
    return Navigator(
      key: navigatorKeys[index],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => screens[index],
        );
      },
    );
  }
}