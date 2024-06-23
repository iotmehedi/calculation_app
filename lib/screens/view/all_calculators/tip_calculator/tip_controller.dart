import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class TipController extends GetxController{
  var priceController = TextEditingController().obs;
  var tipController = TextEditingController().obs;
  var peopleController = TextEditingController().obs;
  var formKey = GlobalKey<FormState>().obs;
  var tipAmount = 0.0.obs;
  var totalAmount = 0.0.obs;
  var tipPerPerson = 0.0.obs;
  var totalPerPerson = 0.0.obs;

  void calculateTip() {
    final double price = double.tryParse(priceController.value.text) ?? 0;
    final double tipPercent = double.tryParse(tipController.value.text) ?? 0;
    final int numberOfPeople = int.tryParse(peopleController.value.text) ?? 1;


      tipAmount.value = price * tipPercent / 100;
      totalAmount.value = price + tipAmount.value;
      tipPerPerson.value = tipAmount / numberOfPeople;
      totalPerPerson.value = totalAmount / numberOfPeople;
    RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.tipCalculatorResultScreen);
  }
  void allFieldClear(){
    priceController.value.clear();
    tipController.value.clear();
    peopleController.value.clear();
  }
}