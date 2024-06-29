
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class PPFCalculatorController extends GetxController{
  final formKey = GlobalKey<FormState>().obs;
  var investmentController = TextEditingController().obs;
  var tenureController = TextEditingController().obs;
  var interestRateController = TextEditingController().obs;
  var list = [].obs;
  var total = 0.0.obs;
  var investedAmount = 0.0.obs;
  var totalInterest = 0.0.obs;
  var maturityValue = 0.0.obs;

  void calculatePPF() {
    list.clear();
    if (formKey.value.currentState!.validate()) {
      double investmentt = double.parse(investmentController.value.text);
      int tenuree = int.parse(tenureController.value.text);
      double interestRatee = double.parse(interestRateController.value.text) / 100;

      double maturityValuee = 0.0;
      double investedAmountt = investmentt * tenuree;

      for (int year = 1; year <= tenuree; year++) {
        maturityValuee = (maturityValuee + investmentt) * (1 + interestRatee);
      }

      double totalInterestt = maturityValuee - investedAmountt;


      investedAmount.value = investedAmountt;
      totalInterest.value = totalInterestt;
      maturityValue.value = maturityValuee;
      list.add(investedAmount.value);
      list.add(totalInterest.value);
      total.value = investedAmountt + totalInterestt;
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.ppfCalculatorResult);
    }
  }
  allFieldClear(){
    investmentController.value.clear();
        tenureController.value.clear();
    interestRateController.value.clear();
  }
}