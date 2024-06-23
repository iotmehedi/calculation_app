import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class VatController extends GetxController{
  var vatRateController = TextEditingController().obs;
  var netPriceController = TextEditingController().obs;
  var formKey = GlobalKey<FormState>().obs;
  var grossPrice = 0.0.obs;
  var taxAmount = 0.0.obs;
  var list = [].obs;
  var total = 0.0.obs;

  void calculateVAT() {
    list.clear();
    if (formKey.value.currentState!.validate()) {
      final double vatRate = double.tryParse(vatRateController.value.text) ??
          0.0;
      final double netPrice = double.tryParse(netPriceController.value.text) ??
          0.0;


      taxAmount.value = netPrice * vatRate / 100;
      grossPrice.value = netPrice + taxAmount.value;
      list.add(taxAmount.value);
      list.add(netPrice);
      total.value = taxAmount.value + netPrice;
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.vatResultScreen);
    }
  }
  void allFieldClear(){
    vatRateController.value.clear();
    netPriceController.value.clear();
  }
  @override
  void dispose() {
    vatRateController.value.dispose();
    netPriceController.value.dispose();
    super.dispose();
  }
}