import 'package:calculation_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';

class StocksCalculatorController extends GetxController{

  var formKey = GlobalKey<FormState>().obs;
  var sharesController = TextEditingController().obs;
  var buyingPriceController = TextEditingController().obs;
  var sellingPriceController = TextEditingController().obs;
  var buyingCommissionController = TextEditingController().obs;
  var sellingCommissionController = TextEditingController().obs;
  var cgtRateController = TextEditingController().obs;

  var netBuyingPrice = 0.0.obs;
  var netSellingPrice = 0.0.obs;
  var breakEvenSellingPrice = 0.0.obs;
  var returnOnInvestment = 0.0.obs;
  var profitOrLoss = 0.0.obs;
  // var breakEvenSellingPrice = 0.0.obs;


  void calculate() {
    if (formKey.value.currentState!.validate()) {
      final double shares = double.parse(sharesController.value.text);
      final double buyingPrice = double.parse(buyingPriceController.value.text);
      final double sellingPrice = double.parse(sellingPriceController.value.text);
      final double buyingCommission = double.parse(buyingCommissionController.value.text);
      final double sellingCommission = double.parse(sellingCommissionController.value.text);
      final double cgtRate = double.parse(cgtRateController.value.text) / 100;

      final double totalBuyingCost = (shares * buyingPrice) + buyingCommission;
      final double totalSellingCost = (shares * sellingPrice) - sellingCommission;
      final double profitBeforeTax = totalSellingCost - totalBuyingCost;
      final double cgt = profitBeforeTax * cgtRate;
      final double netProfitOrLoss = profitBeforeTax - cgt;

       breakEvenSellingPrice.value = (totalBuyingCost + sellingCommission) / shares;
       returnOnInvestment.value = (netProfitOrLoss / totalBuyingCost) * 100;
        netBuyingPrice.value = totalBuyingCost;
        netSellingPrice.value = totalSellingCost;
        breakEvenSellingPrice = breakEvenSellingPrice;
        returnOnInvestment = returnOnInvestment;
        profitOrLoss.value = netProfitOrLoss;
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.stocksCalculatorResultScreen);
    }
  }
void allFieldClear(){
  sharesController.value.clear();
  buyingPriceController.value.clear();
  sellingPriceController.value.clear();
  buyingCommissionController.value.clear();
  sellingCommissionController.value.clear();
  cgtRateController.value.clear();
}
}