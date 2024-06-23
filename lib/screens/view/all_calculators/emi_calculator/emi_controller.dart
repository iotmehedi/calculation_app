import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class EMIController extends GetxController{
  var formKey = GlobalKey<FormState>().obs;
  var loanAmountController = TextEditingController().obs;
  var interestRateController = TextEditingController().obs;
  var loanTenureController = TextEditingController().obs;

  var monthlyEmi = 0.0.obs;
  var totalInterest = 0.0.obs;
  var totalPayment = 0.0.obs;
  var list = [].obs;
  var total = 0.0.obs;
  void calculateEmi() {
list.clear();
    double loanAmount = double.parse(loanAmountController.value.text);
    double interestRate = double.parse(interestRateController.value.text) / 12 / 100;
    int loanTenure = int.parse(loanTenureController.value.text) * 12;

    double emi = (loanAmount * interestRate * pow((1 + interestRate), loanTenure)) /
        (pow((1 + interestRate), loanTenure) - 1);


      monthlyEmi.value = emi;
      totalPayment.value = emi * loanTenure;
      totalInterest.value = totalPayment.value - loanAmount;
      list.add(loanAmount);
      list.add(totalInterest.value);
      total.value = loanAmount + totalInterest.value;
RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.eMIResultScreen);
  }

  allFieldClear(){
    loanAmountController.value.clear();
    interestRateController.value.clear();
    loanTenureController.value.clear();
  }


}