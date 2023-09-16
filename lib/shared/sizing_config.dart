import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? textScaleFactor;
  // static double? blockSizeHorizontal;
  // static double? blockSizeVertical;

  // static double? _safeAreaHorizontal;
  // static double? _safeAreaVertical;
  // static double? safeBlockHorizontal;
  // static double? safeBlockVertical;
  double relativeHeight(double h) => screenHeight! * (h / 800);
  double relativeWidth(double w) => screenWidth! * (w / 375);

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    textScaleFactor = _mediaQueryData!.textScaleFactor;

    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;

    // blockSizeHorizontal = screenWidth! / 100;
    // blockSizeVertical = screenHeight! / 100;

    // _safeAreaHorizontal =
    //     _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    // _safeAreaVertical =
    //     _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    // safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    // safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}

int getHeight() {
  return SizeConfig.screenWidth!.toInt();
}

int getWidth() {
  return SizeConfig.screenWidth!.toInt();
}

bool get getmobile => isMobileDimensions();

bool isMobileDimensions() {
  // SizeConfig? data;
  if (SizeConfig.screenWidth! < 600) {
    return true;
  } else {
    return false;
  }
}
