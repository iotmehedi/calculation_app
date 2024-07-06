import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class CompoundController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;
  var initialDepositController = TextEditingController().obs;
  var contributionAmountController = TextEditingController().obs;
  var yearsOfGrowthController = TextEditingController().obs;
  var rateOfReturnController = TextEditingController().obs;

  var contributionFrequency = 'Monthly'.obs;
  var compoundFrequency = 'Annually'.obs;

  var result = 0.0.obs;
  var totalPrincipal = 0.0.obs;
  var totalInterest = 0.0.obs;
  var principalSpots = [const FlSpot(0, 0)].obs;
  var interestSpots = [const FlSpot(0, 0)].obs;
  var maxY = 0.0.obs;
  var list = [].obs;
  void calculateCompoundInterest() {
    if (formKey.value.currentState!.validate()) {
      list.clear();
      double P = double.parse(initialDepositController.value.text);
      double PMT = double.parse(contributionAmountController.value.text);
      int t = int.parse(yearsOfGrowthController.value.text);
      double r = double.parse(rateOfReturnController.value.text) / 100;

      int n;
      switch (compoundFrequency.value) {
        case 'Daily':
          n = 365;
          break;
        case 'Monthly':
          n = 12;
          break;
        case 'Annually':
        default:
          n = 1;
          break;
      }

      int m;
      switch (contributionFrequency.value) {
        case 'Yearly':
          m = 1;
          break;
        case 'Monthly':
        default:
          m = 12;
          break;
      }

      double A = P * pow((1 + r / n), n * t);
      totalPrincipal.value = P;
      for (int i = 1; i <= t * m; i++) {
        A += PMT * pow((1 + r / n), n * (t - i / m));
        totalPrincipal.value += PMT;
      }
      result.value = A;

      maxY.value = result.value;

      principalSpots.value = [];
      interestSpots.value = [];

      for (int i = 0; i <= t; i++) {
        double xValue = i.toDouble();
        double principalAtPoint = P + (PMT * i * m);
        double amountAtPoint = P * pow((1 + r / n), n * i);

        for (int j = 1; j <= i * m; j++) {
          amountAtPoint +=
              PMT * pow((1 + r / n), n * ((i * m - j) / m.toDouble()));
        }

        principalSpots.add(FlSpot(xValue, principalAtPoint));
        interestSpots.add(FlSpot(xValue, amountAtPoint));
      }

      totalInterest.value = result.value - totalPrincipal.value;
      RouteGenerator.pushNamed(
          navigatorKey.currentContext!, Routes.compoundScreenResult);
    }
  }
  String formatNumber(double value) {
    if (value >= 1e12) {
      return '${(value / 1e14).toStringAsFixed(0)}t';
    } else if (value >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(0)}b';
    } else if (value >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(0)}m';
    } else if (value >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(0)}k';
    } else {
      return value.toStringAsFixed(0);
    }
  }
  void allFieldClear(){
    initialDepositController.value.clear();
    contributionAmountController.value.clear();
    yearsOfGrowthController.value.clear();
    rateOfReturnController.value.clear();
  }
}
