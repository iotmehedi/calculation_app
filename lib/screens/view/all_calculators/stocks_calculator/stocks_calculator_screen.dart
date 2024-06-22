import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/stocks_calculator/stocks_calculator_controller.dart';
import 'package:calculation_app/screens/widgets/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/textfield/textField_widget.dart';

void main() {
  runApp(StockCalculatorApp());
}

class StockCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StockCalculatorPage(),
    );
  }
}

class StockCalculatorPage extends StatefulWidget {
  @override
  _StockCalculatorPageState createState() => _StockCalculatorPageState();
}

class _StockCalculatorPageState extends State<StockCalculatorPage> {


var controller = Get.put(StocksCalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Stock Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey.value,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  globalText16(text: "Number of Share", fontWeight: FontWeight.normal),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("#F3F6F9"),
                                borderRadius:
                                BorderRadius.circular(12)),
                            child: CustomSimpleTextField(
                              paddingNeed: false,
                              controller: controller.sharesController.value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter number of shares';
                                }
                                return null;
                              },
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),
             5.ph,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  globalText16(text: "Buying Price", fontWeight: FontWeight.normal),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("#F3F6F9"),
                                borderRadius:
                                BorderRadius.circular(12)),
                            child: CustomSimpleTextField(
                              paddingNeed: false,
                              controller: controller.buyingPriceController.value,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter buying price';
                                }
                                return null;
                              },
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),

              5.ph,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  globalText16(text: "Selling Price", fontWeight: FontWeight.normal),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("#F3F6F9"),
                                borderRadius:
                                BorderRadius.circular(12)),
                            child: CustomSimpleTextField(
                              paddingNeed: false,
                              controller: controller.sellingPriceController.value,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter selling price';
                                }
                                return null;
                              },
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),
              5.ph,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  globalText16(text: "Buying Commission", fontWeight: FontWeight.normal),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("#F3F6F9"),
                                borderRadius:
                                BorderRadius.circular(12)),
                            child: CustomSimpleTextField(
                              paddingNeed: false,
                              controller: controller.buyingCommissionController.value,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter buying commission';
                                }
                                return null;
                              },
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),
              5.ph,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  globalText16(text: "Selling Commission", fontWeight: FontWeight.normal),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("#F3F6F9"),
                                borderRadius:
                                BorderRadius.circular(12)),
                            child: CustomSimpleTextField(
                              paddingNeed: false,
                              controller: controller.sellingCommissionController.value,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter selling commission';
                                }
                                return null;
                              },
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),
              5.ph,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  globalText16(text: "CGT Rate (%)", fontWeight: FontWeight.normal),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("#F3F6F9"),
                                borderRadius:
                                BorderRadius.circular(12)),
                            child: CustomSimpleTextField(
                              paddingNeed: false,
                              controller: controller.cgtRateController.value,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter CGT rate';
                                }
                                return null;
                              },
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomElevatedButton(
                        color: HexColor("0F182E"),
                        onPress: controller.calculate,
                        // RouteGenerator.pushNamed(context, Routes.mortgageResultPage);
                        text: const Text(
                          "Calculate",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    15.pw,
                    Expanded(
                      child: CustomElevatedButton(
                        color: HexColor("F3F6F9"),
                        onPress: controller.allFieldClear,
                        text: Text(
                          "Clear",
                          style: TextStyle(
                              color: HexColor("0F182E"),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Net Buying Price: \$${controller.netBuyingPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Buying Commission: \$${controller.buyingCommissionController.value.text}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Net Selling Price: \$${controller.netSellingPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Selling Commission: \$${controller.sellingCommissionController.value.text}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Break-even Selling Price: \$${controller.breakEvenSellingPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Return on Investment: ${controller.returnOnInvestment.toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Profit/Loss: \$${controller.profitOrLoss.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
