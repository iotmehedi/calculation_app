import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/route_name.dart';
import '../../../core/routes/router.dart';
import '../../../core/utils/consts/app_assets.dart';
import '../../../core/utils/consts/app_colors.dart';
import '../../../core/utils/services/ad_services.dart';
import '../../widgets/homepage_widget/homepage_widget.dart';

class MoreCalculatorPage extends StatelessWidget {
   MoreCalculatorPage({super.key});
   // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    // Get.find<AdService>().loadBannerAd();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "More Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: adController.getNativeAdWidget(),
      //     ),
      //     10.ph,
      //     adController.getBannerAdWidget(),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.cd,
                    text: "CD\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.cdCalculatorForm);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.fd,
                    text: "FD\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.fdCalculatorHome);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.ppf,
                    text: "PPF\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.ppfCalculatorPage);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.gst,
                    text: "GST\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.gstCalculatorScreen);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.grade,
                    text: "Grade\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(context, Routes.gPAForm);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.gpa,
                    text: "GPA\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(context, Routes.courseForm);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.sales,
                    text: "Sales Tax\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.taxCalculatorPage);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.margin,
                    text: "Margin\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.marginCalculator);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.inflation,
                    text: "Inflation\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(context, Routes.inflationCalculator);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.brm,
                    text: "BMR\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(context, Routes.bMRCalculator);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.unit,
                    text: "Unit\nConverter",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.unitCalculator);
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}
