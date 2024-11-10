import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../core/ad_manager/add_manager.dart';
import '../../../core/routes/route_name.dart';
import '../../../core/routes/router.dart';
import '../../../core/utils/services/ad_services.dart';

class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({super.key});

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> with WidgetsBindingObserver{
  // final AppOpenAdManager _appOpenAdManager = AppOpenAdManager();
  // var adController = Get.put(AdService());


  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // Show the App Open Ad when the app is resumed from the background
  //   if (state == AppLifecycleState.resumed) {
  //     _appOpenAdManager.showAdIfAvailable();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      // appBar: AppBar(
      //   title: adController.getBannerAdWidget(),
      // ),
      body: Center(
        child: Image.asset(
          AppAssets.splashLogoTwo,
          height: 434,
          // width: 327,
        ),
      ),

      floatingActionButton: SizedBox(
        height: 40,
        width: 40,
        child: FloatingActionButton(
          backgroundColor: HexColor("2B2E63"),

          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {
            // AppOpenAdManager().showAdIfAvailable();
            RouteGenerator.pushNamedAndRemoveAll(Routes.homepage);
          },
          child: Image.asset(AppAssets.floatingArrow, width: 12, height: 17.05,),
        ),
      ),
    );
  }
}
