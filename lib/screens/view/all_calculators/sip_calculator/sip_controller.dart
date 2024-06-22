import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class SIPController extends GetxController{
  var formKey = GlobalKey<FormState>().obs;
  var monthlyInvestmentController = TextEditingController().obs;
  var annualReturnController = TextEditingController().obs;
  var timePeriodController = TextEditingController().obs;
  var selectedButton = false.obs;
  var investmentAmount = 0.0.obs;
  var estReturn = 0.0.obs;
  var totalValue = 0.0.obs;
var list = [].obs;
  var total = 0.0.obs;
  void calculateSIP() {
    list.clear();
    if (formKey.value.currentState!.validate()) {
      double monthlyInvestment =
      double.parse(monthlyInvestmentController.value.text);
      double annualReturn = double.parse(annualReturnController.value.text) / 100;
      int timePeriod = int.parse(timePeriodController.value.text);

      double monthlyReturn = annualReturn / 12;
      int totalMonths = timePeriod * 12;

      investmentAmount.value = monthlyInvestment * totalMonths;
      totalValue.value = monthlyInvestment *
          (pow(1 + monthlyReturn, totalMonths) - 1) /
          monthlyReturn *
          (1 + monthlyReturn);
      estReturn.value = totalValue.value - investmentAmount.value;
      list.add(investmentAmount.round());
      list.add(estReturn.round());
      total.value = investmentAmount.value + estReturn.value;
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.sIPResultScreen);
    }
  }
  List<PieChartSectionData> showingSections() {
    List<HexColor> colors = [];
    colors = [
      HexColor("458EEC"),
      HexColor("99CBF7"),
      // Colors.blue,
    ];

    return List.generate(list.length, (i) {
      const isTouched = false; // you can set this dynamically if you want interactivity
      const fontSize = isTouched == true ? 25.0 : 16.0;
      const radius = isTouched == true ? 60.0 : 50.0;
      return PieChartSectionData(
        color: colors[i],
        value: list[i] / total.value * 100,
        title: '${(list[i] / total.value * 100).round()}%',
        radius: 20,
        titleStyle: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );
    });
  }
}