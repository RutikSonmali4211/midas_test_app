import 'package:midas/screen/Investments/gold/gold.dart';
import 'package:midas/screen/Investments/mutual_funds/mutual_funds.dart';
import 'package:midas/screen/Investments/other_assets/other_assets.dart';
import 'package:midas/screen/cards/card.dart';
import 'package:midas/screen/goals/goals.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:midas/widgets/menu/assets_list.dart';
import 'package:midas/widgets/menu/liabilities_list.dart';
import 'package:midas/widgets/menu/others_list.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/sizeConstant.dart';
import '../../constant/size_util.dart';

class Menu extends StatefulWidget {
  final Function(int) onTabChange;

  const Menu({Key? key, required this.onTabChange}) : super(key: key);
  // const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<Asset> assetsList = generateAssetsList(context);
    final List<Liabilities> liabilitiesList = generateLiabilitiesList(context);
    final List<Others> othersList = generateOthersList(context);
    return Scaffold(
      body: Column(children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                offset: Offset(0, 4),
                blurRadius: 4.0,
                spreadRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(DefaultSizes.appheadercircularborder),
              bottomRight:
                  Radius.circular(DefaultSizes.appheadercircularborder),
            ),
            color: AppColors.primary,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: SizeUtil.getStatusBarHeight(context),
                  right: 20,
                  bottom: DefaultSizes.bottemspaceofheader,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      color: AppColors.white,
                      iconSize: SizeUtil.iconsSize(context),
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notifications()),
                        );
                      },
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      color: AppColors.white,
                      icon: const Icon(Icons.account_circle),
                      iconSize: SizeUtil.iconsSize(context),
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
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: SizeUtil.verticalSpacingMedium(context),
                left: size.height * 0.02,
                right: size.height * 0.02,
              ),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeUtil.verticalSpacingMedium(context),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Text(
                        'Explore Simplifin',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: "Helvetica",
                          fontSize: SizeUtil.headingMedium(context),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.33074989914894104,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
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
                  child: Padding(
                    padding:
                        EdgeInsets.all(SizeUtil.scallingFactor(context) * 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assets',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.headingMedium(context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: SizeUtil.verticalSpacingMedium(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 28,
                            runSpacing: 20,
                            children: [
                              for (var assets in assetsList)
                                GestureDetector(
                                  onTap: () {
                                    assetsSectionNavigations(assets.text);
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.white,
                                          border: Border.all(
                                            color: AppColors.primary,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.white,
                                          radius: size.width * 0.07,
                                          child: assets.content,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        assets.text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontFamily: "Helvetica",
                                          fontSize: SizeUtil.body(context),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeUtil.verticalSpacingMedium(context),
                ),
                Container(
                  width: double.infinity,
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
                      color: AppColors.lightgrey,
                      width: 2.0,
                    ),
                    color: AppColors.white,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.all(SizeUtil.scallingFactor(context) * 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Perks and Benefits',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.headingMedium(context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: SizeUtil.verticalSpacingMedium(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 28,
                            runSpacing: 20,
                            children: [
                              for (var liabilities in liabilitiesList)
                                GestureDetector(
                                  onTap: () async {
                                    if (liabilities.text == "Credit\nCards") {
                                      widget.onTabChange(1);
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Cards()),
                                      );
                                      widget.onTabChange(4);
                                    }
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.white,
                                          border: Border.all(
                                            color: AppColors.primary,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.white,
                                          radius: size.width * 0.07,
                                          child: liabilities.content,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        liabilities.text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontFamily: "Helvetica",
                                          fontSize: SizeUtil.body(context),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeUtil.verticalSpacingMedium(context),
                ),
                Container(
                  width: double.infinity,
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
                  child: Padding(
                    padding:
                        EdgeInsets.all(SizeUtil.scallingFactor(context) * 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Others',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.headingMedium(context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: SizeUtil.verticalSpacingMedium(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 28,
                            runSpacing: 20,
                            children: [
                              for (var others in othersList)
                                GestureDetector(
                                  onTap: () async {
                                    if (others.text == "Goals") {
                                      widget.onTabChange(3);
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Goals()),
                                      );
                                      widget.onTabChange(4);
                                    }
                                    // if (others.text == "Insurance") {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const InsuranceScreen()),
                                    //   );
                                    // }
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.white,
                                          border: Border.all(
                                            color: AppColors.primary,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.white,
                                          radius: size.width * 0.07,
                                          child: others.content,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        others.text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontFamily: "Helvetica",
                                          fontSize: SizeUtil.body(context),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }

  assetsSectionNavigations(String title) async {
    switch (title) {
      case 'Mutual\nFunds':
        widget.onTabChange(2);
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MutualFundsScreen()));
        widget.onTabChange(4);
        break;
      case 'Gold':
        widget.onTabChange(2);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GoldScreen()),
        );
        widget.onTabChange(4);
        break;
      case 'Others':
        widget.onTabChange(2);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OtherAssetsScreen()),
        );
        widget.onTabChange(4);
        break;
      default:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Container()));
        break;
    }
  }
}
