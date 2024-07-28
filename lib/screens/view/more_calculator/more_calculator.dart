import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/route_name.dart';
import '../../../core/routes/router.dart';
import '../../../core/utils/consts/app_assets.dart';
import '../../widgets/homepage_widget/homepage_widget.dart';

class MoreCalculatorPage extends StatelessWidget {
  const MoreCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "More Calculator", onBackPressed: (){
        Navigator.pop(context);
      },
      ),
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
                      RouteGenerator.pushNamed(context, Routes.cdCalculatorForm);
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
                      RouteGenerator.pushNamed(context, Routes.gstCalculatorScreen);
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
                      RouteGenerator.pushNamed(
                          context, Routes.courseForm);
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
                      RouteGenerator.pushNamed(context, Routes.marginCalculator);
                    },
                  ),
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
