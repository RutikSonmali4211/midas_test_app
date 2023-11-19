import 'package:midas/constant/layout_type.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout {
  static LayoutType getLayout(BuildContext context) {
    // Get the device's width from the MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return LayoutType.Mobile;
    } else if (screenWidth < 1200) {
      return LayoutType.Tablet;
    } else {
      return LayoutType.Website;
    }
  }

  static bool isMobileLayout(BuildContext context) {
    return getLayout(context) == LayoutType.Mobile;
  }

  static bool isTabletLayout(BuildContext context) {
    return getLayout(context) == LayoutType.Tablet;
  }

  static bool isWebsiteLayout(BuildContext context) {
    return getLayout(context) == LayoutType.Website;
  }
}
