import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class FDController extends GetxController{
  var formKey = GlobalKey<FormState>().obs;

  var investmentController = TextEditingController().obs;
  var rateOfReturnController = TextEditingController().obs;
  var timePeriodController = TextEditingController().obs;
var list = [].obs;
var total = 0.0.obs;
  var investmentAmount = 0.0.obs;
  var estimatedReturn = 0.0.obs;
  var totalValue = 0.0.obs;

  void calculateFD() {
    list.value.clear();
    if (formKey.value.currentState?.validate() ?? false) {
      double investment = double.parse(investmentController.value.text);
      double rateOfReturn = double.parse(rateOfReturnController.value.text) /
          100;
      int timePeriod = int.parse(timePeriodController.value.text);
      print("this is value $rateOfReturn");
      // Compound interest formula assuming annual compounding
      double totalValuee = investment * pow((1 + rateOfReturn), timePeriod);
      print("this is value ${pow((1 + rateOfReturn), 7)}");
      double estimatedReturnn = totalValuee - investment;


      investmentAmount.value = investment;
      estimatedReturn.value = estimatedReturnn;
      totalValue.value = totalValuee;
      list.add(investmentAmount.round());
      list.add(estimatedReturn.value.round());
      total.value = investmentAmount.value + estimatedReturn.value;
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.fdResult);
    }

  }
  allFieldClear(){
    investmentController.value.clear();
    rateOfReturnController.value.clear();
    timePeriodController.value.clear();
  }
}