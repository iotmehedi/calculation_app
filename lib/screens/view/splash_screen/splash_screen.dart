import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/core/routes/router.dart';
import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      RouteGenerator.pushNamedAndRemoveAll(Routes.splashScreenTwo);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.splashLogo,
                      height: 218.03,
                      // width: 327.00,
                    ),
                    globalText201(text: "By Solves Inc", fontWeight: FontWeight.w500, alignment: Alignment.center)
                  ],
                ),
              ),
            ),
            // Center(
            //   child: SizedBox(
            //     height: 30,
            //     width: 30,
            //     child: CircularProgressIndicator(
            //       backgroundColor: AppColors.off_white_color,
            //       valueColor:  AlwaysStoppedAnimation<Color>(HexColor("3F73F4")),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
