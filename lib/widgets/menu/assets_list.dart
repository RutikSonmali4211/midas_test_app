import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';

class Asset {
  final Widget content;
  final String text;

  Asset(this.content, this.text);
}

List<Asset> generateAssetsList(BuildContext context) {
  final double iconSize = SizeUtil.scallingFactor(context)*35;
  final double imageSize =SizeUtil.scallingFactor(context)*30;

  return [
    // Asset(
    //   Icon(
    //     Icons.account_balance,
    //     size: iconSize,
    //     color: AppColors.primary,
    //   ),
    //   'Bank\nAccounts',
    // ),
    // Asset(
    //   Icon(
    //     Icons.account_balance_wallet,
    //     size: iconSize,
    //     color: AppColors.primary,
    //   ),
    //   'Deposits',
    // ),
    // Asset(
    //   Icon(
    //     Icons.trending_up,
    //     size: iconSize,
    //     color: AppColors.primary,
    //   ),
    //   'Stocks',
    // ),
    Asset(
      Icon(
        Icons.trending_up,
        size: iconSize,
        color: AppColors.primary,
      ),
      'Mutual\nFunds',
    ),
    // Asset(
    //   Icon(
    //     Icons.account_balance_wallet,
    //     size: iconSize,
    //     color: AppColors.primary,
    //   ),
    //   'PPF',
    // ),
    // Asset(
    //   Icon(
    //     Icons.account_balance_wallet,
    //     size: iconSize,
    //     color: AppColors.primary,
    //   ),
    //   'EPF',
    // ),
    // Asset(
    //   Icon(
    //     Icons.account_balance_wallet,
    //     size: iconSize,
    //     color: AppColors.primary,
    //   ),
    //   'NPS',
    // ),
    Asset(
      Image.asset(
        "assets/gold_icon.png",
        height: imageSize,
        color: AppColors.primary,
      ),
      'Gold',
    ),
    Asset(
      Image.asset(
        "assets/others_icon.png",
        height: imageSize,
        color: AppColors.primary,
      ),
      'Others',
    ),
  ];
}
