import 'dart:math';

import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/cd_calculator/cd_calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';

class CDCalculatorForm extends StatefulWidget {
  @override
  _CDCalculatorFormState createState() => _CDCalculatorFormState();
}

class _CDCalculatorFormState extends State<CDCalculatorForm> {
  var controller = Get.put(CDCalculatorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "CD Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Form(
              key: controller.formKey.value,
              child: ListView(
                children: <Widget>[
                  CommonTextFieldCustom(
                    headingName: 'Initial Deposit',
                    controller: controller.initialDepositController.value,
                    keyboardType: TextInputType.number,
                    needPadding: true,
                    // onlyNeedSuffix: true,
                    prefixIcon: Icon(
                      Icons.attach_money_outlined,
                      size: 16,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter initial deposit';
                      }
                      return null;
                    },
                  ),
                  10.ph,
                  CommonTextFieldCustom(
                    headingName: 'Interest Rate',
                    controller: controller.interestRateController.value,
                    keyboardType: TextInputType.number,
                    needPadding: true,
                    onlyNeedSuffix: true,
                    suffixIcon: Icon(
                      Icons.percent,
                      size: 16,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the interest rate';
                      }
                      return null;
                    },
                  ),
                  10.ph,
                  Column(
                    children: [
                      globalText16(text: "Compound", fontWeight: FontWeight.normal),
                      5.ph,
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField(
                              icon: Icon(Icons.keyboard_arrow_down),
                              value: controller.compoundFrequency,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              items: controller.compoundOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(child: globalText14(text: value, fontWeight: FontWeight.normal, textAlign: TextAlign.center),),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  controller.compoundFrequency = newValue!;
                                });
                              },
                            ),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                  10.ph,

                  Column(
                    children: [
                      globalText16(text: "Deposit length", fontWeight: FontWeight.normal),
                      5.ph,
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor("#F3F6F9"), borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                controller: controller.yearsController.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: globalTextStyle(),
                                    contentPadding: const EdgeInsets.only(right: 10, left: 10),
                                  suffixText: "years",
                                  suffixStyle: TextStyle(color: HexColor("8E8E8E"), fontSize: 12, fontWeight: FontWeight.normal),
                                  ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the number of years';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor("#F3F6F9"), borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                controller: controller.monthsController.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "months",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: HexColor("8E8E8E"), fontSize: 12, fontWeight: FontWeight.normal),
                                  contentPadding: const EdgeInsets.only(right: 10, left: 10),
                                  suffixText: "months",
                                  suffixStyle: TextStyle(color: HexColor("8E8E8E"), fontSize: 12, fontWeight: FontWeight.normal),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the number of months';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CommonTextFieldCustom(
                    headingName: 'Marginal Tax Rate',
                    controller: controller.taxRateController.value,
                    keyboardType: TextInputType.number,
                    needPadding: true,
                    onlyNeedSuffix: true,
                    suffixIcon: Icon(
                      Icons.percent,
                      size: 16,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the tax rate';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),
                  CustomCalculateClearWidget(
                    onPressCalculate: () {
                      if (controller.formKey.value.currentState?.validate() ?? false) {
                        controller.calculate();
                      }
                    },
                    onPressClear: controller.allFieldClear,
                  ),

                  SizedBox(height: 20),
                  Text(
                      'Total Interest: \$${controller.totalInterest.toStringAsFixed(2)}'),
                  Text(
                      'Total Tax: \$${controller.totalTax.toStringAsFixed(2)}'),
                  Text(
                      'Interest After Tax: \$${controller.interestAfterTax.toStringAsFixed(2)}'),
                  Text(
                      'End Balance: \$${controller.endBalance.toStringAsFixed(2)}'),
                ],
              ),
            )),
      ),
    );
  }
}
