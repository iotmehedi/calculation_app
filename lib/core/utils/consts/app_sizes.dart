import 'package:flutter/material.dart';
import 'package:get/get.dart';

Orientation currentOrientation = MediaQuery.of(Get.context!).orientation;

var screenSize =
    currentOrientation == Orientation.portrait ? Get.height : Get.width;

class AppSizes {
  static final size10 = 1.2 * screenSize / 100;
  static final size11 = 1.3 * screenSize / 100;
  static final size12 = 1.5 * screenSize / 100;
  static final size13 = 1.6 * screenSize / 100;
  static final size14 = 1.8 * screenSize / 100;
  static final size15 = 1.9 * screenSize / 100;
  static final size16 = 2.0 * screenSize / 100;
  static final size17 = 2.15 * screenSize / 100;
  static final size18 = 2.3 * screenSize / 100;
  static final size20 = 2.5 * screenSize / 100;
  static final size22 = 2.8 * screenSize / 100;
  static final size24 = 3 * screenSize / 100;
  static final size27 = 4 * screenSize / 100;

  static newSize(percentage) {
    return percentage * screenSize / 100;
  }
}
