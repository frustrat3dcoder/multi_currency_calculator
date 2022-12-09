import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  static late double carosuleSliderHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    carosuleSliderHeight = 600.0;
  }

  static bool isSmallDevices() => screenWidth < 360;

  // static bool isMediumDevices() => ((screenWidth < 414 && screenWidth >= 360) &&
  //     (screenHeight > 655 && screenHeight < 820));

  static bool isMediumDevices() =>
      (screenWidth < 420 && screenWidth >= 360) && (screenHeight > 820);

  static bool isLargeDevices() => screenWidth >= 414 && (screenHeight > 820);

  static bool isMediumSmallDevices() =>
      (screenWidth < 420 && screenWidth >= 360) &&
      (screenHeight < 820 && screenHeight >= 700);
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
