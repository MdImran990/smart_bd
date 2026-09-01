import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static double width(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double height(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static bool isSmall(BuildContext context) {
    return width(context) < 360;
  }

  static bool isTablet(BuildContext context) {
    return width(context) >= 600;
  }

  static EdgeInsets pagePadding(BuildContext context) {
    if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 40);
    }

    if (isSmall(context)) {
      return const EdgeInsets.symmetric(horizontal: 16);
    }

    return const EdgeInsets.symmetric(horizontal: 20);
  }
}