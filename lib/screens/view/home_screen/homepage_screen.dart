import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/core/routes/router.dart';
import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/screens/widgets/homepage_widget/homepage_widget.dart';
import 'package:flutter/material.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Finance Type Calculator",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.mortgage,
                    text: "Mortgage\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(context, Routes.mortgagePage);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.autoLoan,
                    text: "Auto Loan\nCalculator",
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.sip,
                    text: "SIP\nCalculator",
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.emi,
                    text: "EMI\nCalculator",
                    onPress: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.salary,
                    text: "Salary\nCalculator",
                    onPress: () {
                      print("this is");
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.income,
                    text: "Income Tax\nCalculator",
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.compound,
                    text: "Compund interest\nCalculator",
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.retirement,
                    text: "Retirements\nCalculator",
                    onPress: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.loan,
                    text: "Loan\nCalculator",
                    onPress: () {
                      print("this is");
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.stocks,
                    text: "Stocks\nCalculator",
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.investment,
                    text: "Investments\nCalculator",
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.more,
                    text: "More\nCalculator",
                    onPress: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Health Calculator",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.bmi,
                    text: "BMI\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(context, Routes.bMICalculator);

                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.calories,
                    text: "Calories\nCalculator",
                    onPress: () {
                      
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.brm,
                    text: "BRM\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(context, Routes.bMRCalculator);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.bodyFat,
                    text: "Body Fat\nCalculator",
                    onPress: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.pregnant,
                    text: "Pregnancy\nCalculator",
                    onPress: () {
                      print("this is");
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.dueDate,
                    text: "Due Time\nCalculator",
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.ovulation,
                    text: "Ovulation\nCalculator",
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.period,
                    text: "Period\nCalculator",
                    onPress: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Math Type Calculator",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.scientific,
                    text: "Scientific\nCalculator",
                    onPress: () {
                      print("this is");
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.percentage,
                    text: "Percentage\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(context, Routes.percentageCalculator);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.normal,
                    text: "Normal\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.normalCalculatorScreen);
                    },
                  ),
                ),
                Expanded(
                  child: HomepageWidget(
                    images: AppAssets.fractionCalculator,
                    text: "Fraction\nCalculator",
                    onPress: () {
                      RouteGenerator.pushNamed(
                          context, Routes.fractionCalculator);
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
