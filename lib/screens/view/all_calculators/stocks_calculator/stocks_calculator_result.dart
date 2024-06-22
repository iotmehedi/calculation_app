import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/stocks_calculator/stocks_calculator_controller.dart';
import 'package:calculation_app/screens/widgets/common_result_heading/common_result_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';

class StocksCalculatorResultScreen extends StatelessWidget {
  StocksCalculatorResultScreen({super.key});
  var controller = Get.find<StocksCalculatorController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Stock Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => SingleChildScrollView(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonResultHeading(headingName: "Result"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHalfRow(
                        title: "Net buying price",
                        value: "\$ ${controller.netBuyingPrice.value}",
                        headingColor: HexColor("555656"),
                        valueColor: HexColor("101010"),
                      ),
                      10.ph,
                      CustomHalfRow(
                        title: "Selling Commission",
                        value:
                            "\$ ${controller.sellingCommissionController.value.text}",
                        headingColor: HexColor("555656"),
                        valueColor: HexColor("101010"),
                      ),
                      10.ph,
                      CustomHalfRow(
                        title: "Net Selling price",
                        value:
                            "\$ ${controller.netSellingPrice.toStringAsFixed(2)}",
                        headingColor: HexColor("555656"),
                        valueColor: HexColor("101010"),
                      ),
                      10.ph,
                      CustomHalfRow(
                        title: "Buying Commission",
                        value:
                            "\$ ${controller.buyingCommissionController.value.text}",
                        headingColor: HexColor("555656"),
                        valueColor: HexColor("101010"),
                      ),
                      30.ph,
                      CustomHalfRow(
                        title: "Breaking-even selling price",
                        value:
                            controller.breakEvenSellingPrice.toStringAsFixed(2),
                        headingColor: HexColor("244384"),
                        valueColor: HexColor("0F182E"),
                      ),
                      10.ph,
                      CustomHalfRow(
                        title: "Return On Investment",
                        value:
                            "${controller.returnOnInvestment.toStringAsFixed(2)}%",
                        headingColor: HexColor("244384"),
                        valueColor: HexColor("0F182E"),
                      ),
                      10.ph,
                      CustomHalfRow(
                        title: "Profit/Loss:",
                        value: "\$ ${controller.profitOrLoss.toStringAsFixed(2)}",
                        headingColor: HexColor("244384"),
                        valueColor: HexColor("0F182E"),
                      ),
                    ],
                  ),
                )
              ],
            ),
      )),
    );
  }

  Widget CustomHalfRow(
      {required String title,
      required String value,
      required HexColor headingColor,
      required HexColor valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        globalText16(
            text: title, color: headingColor, fontWeight: FontWeight.w500),
        globalText16(
            text: value, color: valueColor, fontWeight: FontWeight.w500),
      ],
    );
  }
}
