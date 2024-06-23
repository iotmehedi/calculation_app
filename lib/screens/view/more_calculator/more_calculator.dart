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
      appBar: CustomAppBar(title: "Finance Calculator", onBackPressed: (){
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
                    images: AppAssets.mortgage,
                    text: "Margin\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(context, Routes.marginCalculator);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.autoLoan,
                    text: "Salary\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.salaryCalculatorScreen);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.sip,
                    text: "SIP\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.sIPCalculatorPage);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.emi,
                    text: "EMI\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(context, Routes.emiCalculator);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
