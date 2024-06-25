import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class CDCalculatorController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;

  // Controllers for input fields
  final initialDepositController = TextEditingController().obs;
  final interestRateController = TextEditingController().obs;
  final yearsController = TextEditingController().obs;
  final monthsController = TextEditingController().obs;
  final taxRateController = TextEditingController().obs;
  var list = [].obs;
  var total = 0.0.obs;
  String compoundFrequency = 'Annually';
  List<String> compoundOptions = [
    'Annually',
    'Semiannually',
    'Quarterly',
    'Monthly',
    'Continuously'
  ];

  var totalInterest = 0.0.obs;
  var totalTax = 0.0.obs;
  var interestAfterTax = 0.0.obs;
  var endBalance = 0.0.obs;

  void calculate() {
    list.clear();
    // Retrieve values from input fields
    double initialDeposit = double.parse(initialDepositController.value.text);
    double interestRate = double.parse(interestRateController.value.text) / 100;
    int years = int.parse(yearsController.value.text);
    int months = int.parse(monthsController.value.text);
    double taxRate = double.parse(taxRateController.value.text) / 100;

    int totalMonths = years * 12 + months;
    double n = 1; // number of times interest is compounded per year
    double rate = interestRate;

    switch (compoundFrequency) {
      case 'Annually':
        n = 1;
        break;
      case 'Semiannually':
        n = 2;
        break;
      case 'Quarterly':
        n = 4;
        break;
      case 'Monthly':
        n = 12;
        break;
      case 'Continuously':
        // For continuous compounding
        endBalance.value =
            initialDeposit * (exp(interestRate * totalMonths / 12));
        totalInterest.value = endBalance.value - initialDeposit;
        totalTax.value = totalInterest * taxRate;
        interestAfterTax.value = totalInterest.value - totalTax.value;

        return;
    }

    // Formula for compound interest: A = P (1 + r/n)^(nt)
    double nt = n * totalMonths / 12;
    endBalance.value = initialDeposit * pow((1 + rate / n), nt);
    totalInterest.value = endBalance.value - initialDeposit;
    totalTax.value = totalInterest * taxRate;
    interestAfterTax.value = totalInterest.value - totalTax.value;
    list.add(initialDeposit);
    list.add(interestAfterTax.value);
    list.add(totalTax.value);
    total.value = initialDeposit + interestAfterTax.value + totalTax.value ;
    RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.cdResultScreen);
  }

  allFieldClear() {
    initialDepositController.value.clear();
    interestRateController.value.clear();
    yearsController.value.clear();
    monthsController.value.clear();
    taxRateController.value.clear();
  }
}
