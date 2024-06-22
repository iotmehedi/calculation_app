import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class LoanCalcualtorController extends GetxController{
  var loanAmountController = TextEditingController().obs;
  var loanTermController = TextEditingController().obs;
  var interestRateController = TextEditingController().obs;
  var formKey = GlobalKey<FormState>().obs;
  var compoundOption = 'Annual'.obs;
  var paybackOption = 'Every month'.obs;
  var list = [].obs;
  var total = 0.0.obs;
  var monthlyPayment = 0.0.obs;
  var totalPayments = 0.0.obs;
  var totalInterest = 0.0.obs;

  // Mapping of compounding intervals to their respective periods per year
  final Map<String, int> compoundingPeriodsPerYear = {
    'Annual': 1,
    'Semi-Annual': 2,
    'Quarterly': 4,
    'Monthly': 12,
    'Semi-Monthly': 24,
    'Biweekly': 26,
    'Weekly': 52,
    'Daily': 365,
    'Continuously': 0, // Continuous compounding is handled separately
  };

  // Mapping of payback frequencies to their respective periods per year
  final Map<String, int> paybackPeriodsPerYear = {
    'Every day': 365,
    'Every week': 52,
    'Every 2 weeks': 26,
    'Every half month': 24,
    'Every month': 12,
    'Every quarter': 4,
    'Every 6 months': 2,
    'Every year': 1,
  };

  void calculateLoan() {
    if (formKey.value.currentState!.validate()) {
      double loanAmount = double.tryParse(loanAmountController.value.text) ??
          0.0;
      int loanTerm = int.tryParse(loanTermController.value.text) ?? 0;
      double annualInterestRate = double.tryParse(
          interestRateController.value.text) ?? 0.0;

      int compoundingPeriods = compoundingPeriodsPerYear[compoundOption]!;
      int paybackPeriods = paybackPeriodsPerYear[paybackOption]!;

      double ratePerPeriod;
      int totalNumberOfPayments = loanTerm * paybackPeriods;

      if (compoundOption.value == 'Continuously') {
        ratePerPeriod = exp(annualInterestRate / paybackPeriods / 100) - 1;
      } else {
        ratePerPeriod = (annualInterestRate / 100) / compoundingPeriods;
      }

      // Calculate the effective rate per payment period
      double effectiveRatePerPeriod;
      if (compoundOption.value == 'Continuously') {
        effectiveRatePerPeriod =
            exp(annualInterestRate / paybackPeriods / 100) - 1;
      } else {
        effectiveRatePerPeriod =
            pow(1 + ratePerPeriod, compoundingPeriods / paybackPeriods) - 1;
      }

      monthlyPayment.value = (loanAmount * effectiveRatePerPeriod) /
          (1 - pow(1 + effectiveRatePerPeriod, -totalNumberOfPayments));
      totalPayments.value = monthlyPayment * totalNumberOfPayments;
      totalInterest.value = totalPayments.value - loanAmount;
      list.clear();
      list.add(loanAmount);
      list.add(totalInterest.value);
      total.value = loanAmount + totalInterest.value;
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.loanCalculatorResult);
    }
  }

  allFieldClear(){
    loanAmountController.value.clear();
    loanTermController.value.clear();
    interestRateController.value.clear();
  }
  List<PieChartSectionData> showingSections() {
    List<HexColor> colors = [];
      colors = [
        HexColor("458EEC"),
        HexColor("99CBF7"),
        // Colors.blue,
      ];

    return List.generate(list.length, (i) {
      const isTouched = false; // you can set this dynamically if you want interactivity
      const fontSize = isTouched == true ? 25.0 : 16.0;
      const radius = isTouched == true ? 60.0 : 50.0;
      return PieChartSectionData(
        color: colors[i],
        value: list[i] / total.value * 100,
        title: '${(list[i] / total.value * 100).round()}%',
        radius: 20,
        titleStyle: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );
    });
  }
}