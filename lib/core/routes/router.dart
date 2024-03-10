import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/screens/view/all_calculators/fractio_calculator/fraction_calculator.dart';
import 'package:calculation_app/screens/view/all_calculators/normal_calculator/normal_calculator_screen.dart';
import 'package:calculation_app/screens/view/home_screen/homepage_screen.dart';
import 'package:calculation_app/screens/view/mortgage_screen/mortgage_screen.dart';
import 'package:calculation_app/screens/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteGenerator {
  Future<dynamic> pushNamedSms(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushNamed(context, pageName, arguments: arguments);
  }

  static pushNamed(BuildContext context, String pageName) {
    return Navigator.of(context).pushNamed(pageName);
  }

  static pushReplacementNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushReplacementNamed(context, pageName,
        arguments: arguments);
  }

  static pushNamedAndRemoveAll(String pageName, {List arguments = const []}) {
    Get.offAllNamed(pageName, arguments: arguments);
  }
  // static pushNamedAndRemoveAll(BuildContext context, String pageName,
  //     {List arguments = const []}) {
  //   return Navigator.pushNamedAndRemoveUntil(
  //       context, pageName, (route) => false,
  //       arguments: arguments);
  // }

  static pop(BuildContext context) {
    return Navigator.of(context).pop();
  }

  static popAndPushNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.popAndPushNamed(context, pageName, arguments: arguments);
  }

  static popAll(BuildContext context) {
    return Navigator.of(context).popUntil((route) => false);
  }

  static popUntil(BuildContext context, String pageName) {
    return Navigator.of(context).popUntil(ModalRoute.withName(pageName));
  }

  // ================================== Routing =============================================

  static Route<dynamic>? onRouteGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.homepage:
        return MaterialPageRoute(
          builder: (context) => const HomepageScreen(),
        );
      case Routes.mortgagePage:
        return MaterialPageRoute(
          builder: (context) => const MortgageScreen(),
        );
      case Routes.normalCalculatorScreen:
        return MaterialPageRoute(
          builder: (context) => NormalCalculatorScreen(),
        );
      case Routes.fractionCalculator:
        return MaterialPageRoute(
          builder: (context) => FractionCalculatorApp(),
        );
    }
    return null;
  }
}
