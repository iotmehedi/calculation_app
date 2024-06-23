import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class DiscountController extends GetxController{
  var originalPriceController = TextEditingController().obs;
  var discountRateController = TextEditingController().obs;
  var formKey = GlobalKey<FormState>().obs;
  var payableAmount = 0.0.obs;
  var discountAmount = 0.0.obs;
  var list = [].obs;
  var total = 0.0.obs;
  void calculateDiscount() {
list.clear();
      final double originalPrice = double.tryParse(
          originalPriceController.value.text) ?? 0.0;
      final double discountRate = double.tryParse(
          discountRateController.value.text) ?? 0.0;

      if (originalPrice > 0 && discountRate > 0) {
        discountAmount.value = originalPrice * (discountRate / 100);
        payableAmount.value = originalPrice - discountAmount.value;
        list.add(payableAmount.value);
        list.add(discountAmount.value);
        total.value = payableAmount.value + discountAmount.value;
      } else {
        discountAmount.value = 0.0;
        payableAmount.value = originalPrice;
        list.add(payableAmount.value);
        list.add(discountAmount.value);
        total.value = payableAmount.value + discountAmount.value;
      }
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.discountResultScreen);
  }
void allFieldClear(){
  originalPriceController.value.clear();
  discountRateController.value.clear();
}
}