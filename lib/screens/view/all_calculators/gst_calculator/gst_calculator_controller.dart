import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class GSTCalculatorController extends GetxController{
  var radioButtonStatus = "".obs;
  var amountController = TextEditingController().obs;
  var taxSlabController = TextEditingController().obs;
  var formKey = GlobalKey<FormState>().obs;
  var gstTotal = 0.0.obs;
  var postGstAmount = 0.0.obs;

  void calculateGSTExclusive() {
    if (formKey.value.currentState?.validate() ?? false){
      final double amount = double.tryParse(amountController.value.text) ?? 0.0;
      final double taxSlab = double.tryParse(taxSlabController.value.text) ?? 0.0;

      gstTotal.value = amount * (taxSlab / 100);
      postGstAmount.value = amount + gstTotal.value;
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.gstResult);
    }
  }

  void calculateGSTInclusive() {
    if (formKey.value.currentState?.validate() ?? false){
      final double totalAmount = double.tryParse(amountController.value.text) ?? 0.0;
      final double taxSlab = double.tryParse(taxSlabController.value.text) ?? 0.0;

      gstTotal.value = (totalAmount * taxSlab) / (100 + taxSlab);
      postGstAmount.value = totalAmount - gstTotal.value;
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.gstResult);
    }
  }
  clearFields(){
    amountController.value.clear();
    taxSlabController.value.clear();
  }
}