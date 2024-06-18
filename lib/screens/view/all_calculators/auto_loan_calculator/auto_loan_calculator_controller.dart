import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';
class LoanController extends GetxController {
  var vehiclePrice = 0.0.obs;
  var loanTerm = 0.obs;
  var interestRate = 0.0.obs;
  var downPayment = 0.0.obs;
  var tradeInValue = 0.0.obs;
  var amountOwedOnTradeIn = 0.0.obs;
  var salesTax = 0.0.obs;
  var fees = 0.0.obs;
  var salesTaxAmountt = 0.0.obs;
  var monthlyPaymentt = 0.0.obs;
  Rx<DateTime>? selectedDate = DateTime.now().obs;
  var selectedOption = ''.obs;
  var startDate = DateTime.now().obs;
  // Rx<DateTime>? selectedDate = DateTime.now().obs;
  var vehiclePriceController = TextEditingController().obs;
  var loanTermController = TextEditingController().obs;
  var interestRateController = TextEditingController().obs;
  var downPaymentController = TextEditingController().obs;
  var tradeInValueController = TextEditingController().obs;
  var amountOwedOnTradeInController = TextEditingController().obs;
  var salesTaxController = TextEditingController().obs;
  var feesController = TextEditingController().obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   vehiclePriceController = TextEditingController();
  //   loanTermController = TextEditingController();
  //   interestRateController = TextEditingController();
  //   downPaymentController = TextEditingController();
  //   tradeInValueController = TextEditingController();
  //   amountOwedOnTradeInController = TextEditingController();
  //   salesTaxController = TextEditingController();
  //   feesController = TextEditingController();
  // }

  @override
  void onClose() {
    vehiclePriceController.value.dispose();
    loanTermController.value.dispose();
    interestRateController.value.dispose();
    downPaymentController.value.dispose();
    tradeInValueController.value.dispose();
    amountOwedOnTradeInController.value.dispose();
    salesTaxController.value.dispose();
    feesController.value.dispose();
    super.onClose();
  }

  void updateValues() {
    vehiclePrice.value = double.tryParse(vehiclePriceController.value.text) ?? 0.0;
    loanTerm.value = int.tryParse(loanTermController.value.text) ?? 0;
    interestRate.value = double.tryParse(interestRateController.value.text) ?? 0.0;
    downPayment.value = double.tryParse(downPaymentController.value.text) ?? 0.0;
    tradeInValue.value = double.tryParse(tradeInValueController.value.text) ?? 0.0;
    amountOwedOnTradeIn.value = double.tryParse(amountOwedOnTradeInController.value.text) ?? 0.0;
    salesTax.value = double.tryParse(salesTaxController.value.text) ?? 0.0;
    fees.value = double.tryParse(feesController.value.text) ?? 0.0;
    salesTaxAmountt.value = salesTaxAmount;
    monthlyPaymentt.value = monthlyPayment;
    RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.autoLoanCalculatorResult);
    print(monthlyPaymentt.value);
  }

  double get baseAmount {
    return vehiclePrice.value - downPayment.value - tradeInValue.value + amountOwedOnTradeIn.value;
  }

  double get salesTaxAmount {
    print("dasdaf");
    return (vehiclePrice.value - tradeInValue.value + amountOwedOnTradeIn.value) * (salesTax.value / 100);
  }

  double get loanAmount {
    if (selectedOption.value == "1") {
      return baseAmount + salesTaxAmount + fees.value;
    } else {
      return baseAmount;
    }
  }

  double get upfrontPayment {
    if (selectedOption.value == "1") {
      return downPayment.value;
    } else {
      return salesTaxAmount + fees.value;
    }
  }

  double get totalLoanPayments {
    return monthlyPayment * loanTerm.value;
  }

  double get totalLoanInterest {
    return totalLoanPayments - loanAmount;
  }

  DateTime get payOutDate {
    return DateTime(startDate.value.year, startDate.value.month + loanTerm.value, startDate.value.day);
  }

  double get monthlyPayment {
    final monthlyRate = (interestRate.value / 100) / 12;
    final numPayments = loanTerm.value.toDouble();
    return (loanAmount * monthlyRate) / (1 - pow(1 + monthlyRate, -numPayments));
  }

  void updateStartDate(DateTime date) {
    startDate.value = date;
    update();
  }

  void clearFields() {
    vehiclePriceController.value.clear();
    loanTermController.value.clear();
    interestRateController.value.clear();
    downPaymentController.value.clear();
    tradeInValueController.value.clear();
    amountOwedOnTradeInController.value.clear();
    salesTaxController.value.clear();
    feesController.value.clear();
    startDate.value = DateTime.now();
    update();
  }
}