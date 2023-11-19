import 'package:flutter/widgets.dart';

class SizeUtil {
  static double calculateScalingFactor(BuildContext context) {
    double figmaHeight = 844;
    double figmaWidth = 390;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double heightScaleFactor = screenHeight / figmaHeight;
    double widthScaleFactor = screenWidth / figmaWidth;
    return (heightScaleFactor + widthScaleFactor) / 2;
  }

  static double scaleFontSize(BuildContext context, double originalFontSize) {
    double scalingFactor = calculateScalingFactor(context);
    return originalFontSize * scalingFactor;
  }

  static double scallingFactor(BuildContext context) =>
      calculateScalingFactor(context);
  static double verticalSpacingSmall(BuildContext context) =>
      scaleFontSize(context, 10);
  static double verticalSpacingMedium(BuildContext context) =>
      scaleFontSize(context, 20);
  static double verticalSpacingLarge(BuildContext context) =>
      scaleFontSize(context, 30);
  static double horizontalSpacingSmall(BuildContext context) =>
      scaleFontSize(context, 10);

  static double headingMedium(BuildContext context) =>
      scaleFontSize(context, 18);

  static double headingLarge(BuildContext context) =>
      scaleFontSize(context, 34);

  static double headingMedium2(BuildContext context) =>
      scaleFontSize(context, 22);
      

  static double headingLarge2(BuildContext context) =>
      scaleFontSize(context, 24);

  static double headingSmall(BuildContext context) =>
      scaleFontSize(context, 12);

  static double bodyLarge(BuildContext context) => scaleFontSize(context, 16);

  static double body(BuildContext context) => scaleFontSize(context, 14);

  static double bodySmall(BuildContext context) => scaleFontSize(context, 10);

  static double iconsSize(BuildContext context) => scaleFontSize(context, 24);

  static double getStatusBarHeight(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return mediaQuery.viewPadding.top;
  }

  static double getsideSpace(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return size.width * 0.0512;
  }

  static double gettopandbottomspaceofscreen(BuildContext context) {
    return scallingFactor(context) * 30;
  }

  static double buttonPaddingBottom(BuildContext context) =>
      scaleFontSize(context, 15);
}