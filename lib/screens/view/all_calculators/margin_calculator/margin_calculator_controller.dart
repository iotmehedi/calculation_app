import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class MarginCalculatorController extends GetxController{
  var costController = TextEditingController().obs;
  var revenueController = TextEditingController().obs;
  var formKey = GlobalKey<FormState>().obs;
  var margin = 0.0.obs;
  var profit = 0.0.obs;
  var markup = 0.0.obs;
var list = [].obs;
var total = 0.0.obs;
  void calculateValues() {
    list.clear();
    double cost = double.tryParse(costController.value.text) ?? 0;
    double revenue = double.tryParse(revenueController.value.text) ?? 0;


      profit.value = revenue - cost;
      margin.value = (profit.value / revenue) * 100;
      markup.value = (profit.value / cost) * 100;
      list.add(cost);
      list.add(profit.value);
      total.value = cost + profit.value;
    RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.marginCalculatorResultScreen);
  }
  void allFieldClear(){
    costController.value.clear();
    revenueController.value.clear();
  }
}