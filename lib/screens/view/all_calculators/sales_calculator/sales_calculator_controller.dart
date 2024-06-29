import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class SalesCalculatorController extends GetxController{
  final formKey = GlobalKey<FormState>().obs;
  var priceController = TextEditingController().obs;
  var taxRateController = TextEditingController().obs;

  var beforeTaxPrice = 0.0.obs;
  var salesTax = 0.0.obs;
  var afterTaxPrice = 0.0.obs;

  void calculateTax() {
    if (formKey.value.currentState!.validate()) {

        beforeTaxPrice.value = double.parse(priceController.value.text);
        double taxRate = double.parse(taxRateController.value.text) / 100;
        salesTax.value = beforeTaxPrice * taxRate;
        afterTaxPrice.value = beforeTaxPrice.value + salesTax.value;
        RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.salesCalculatorResultScreen);
    }
  }
  allFieldClear(){
    priceController.value.clear();
    taxRateController.value.clear();
  }
}