import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../core/routes/route_name.dart';
import '../../../core/routes/router.dart';

class SplashScreenTwo extends StatelessWidget {
  const SplashScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
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
              RouteGenerator.pushNamedAndRemoveAll(Routes.homepage);
            },
        child: Image.asset(AppAssets.floatingArrow, width: 12, height: 17.05,),
        ),
      ),
    );
  }
}
