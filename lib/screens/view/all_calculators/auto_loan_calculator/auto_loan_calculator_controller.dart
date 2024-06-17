import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class LoanController extends GetxController {
  var vehiclePrice = 0.0.obs;
  var loanTerm = 0.obs;
  var interestRate = 0.0.obs;
  var downPayment = 0.0.obs;
  var tradeInValue = 0.0.obs;
  var amountOwedOnTradeIn = 0.0.obs;
  var salesTax = 0.0.obs;
  var fees = 0.0.obs;
  var selectedOption = ''.obs;
  // var includeTaxesFeesInLoan = false.obs;
  var startDate = DateTime.now().obs;
  Rx<DateTime>? selectedDate = DateTime.now().obs;
  double get loanAmount {
    final baseAmount = vehiclePrice.value - downPayment.value - tradeInValue.value + amountOwedOnTradeIn.value;
    final taxAmount = baseAmount * (salesTax.value / 100);
    if (selectedOption.value == "1") {
      return baseAmount + taxAmount + fees.value ;
    } else {
      return baseAmount;
    }
  }

  double get salesTaxAmount {
    return (vehiclePrice.value - tradeInValue.value + amountOwedOnTradeIn.value) * (salesTax.value / 100);
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
  allFieldClear(){
    fees.value = 0.0;
    update();
  }
}