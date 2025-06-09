import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Sizer {
  // h = 729.599
  // w = 1536


  static double Pad = 14.sp;

  static double radius_10 =  2.77.w;
// static double h = Dtyp(context)
  static double  h_50 = 6.853.h;
  static double h_10 = 1.37.h;
  static double h_full = 100.h;

  static double icn_50 = 6.377.h;

  static double w_full = 100.w;
  static double w_20 = 1.302.w;
  static double w_10 = 0.651.w;
  static double w_50 = 3.255.w;

  static double fnt_big = 19;
  static double fnt_big2 = 18;

  static var a = ScreenType.desktop;
}

Dtyp(context) {
  if (MediaQuery.of(context).size.width < 850) {
    return "mobile";
  } else if (MediaQuery.of(context).size.width >= 850 &&
      MediaQuery.of(context).size.width < 1100) {
    return "tablet";
  } else {
    return "desktop";
  }
}
