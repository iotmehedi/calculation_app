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
      backgroundColor: HexColor("FAFAFA"),
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
                    onlyNeedSuffix: true,
                    suffixIcon: Icon(
                      Icons.attach_money_sharp,
                      size: 16,
                      color: HexColor("80848A"),
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
                    titleTextColor: HexColor("437AFF"),
                    titleName: "(%)",
                    titleFontWeight: FontWeight.normal,
                    titleFontSize: 16,
                    controller: controller.interestRateController.value,
                    keyboardType: TextInputType.number,
                    needPadding: true,
                    onlyNeedSuffix: true,
                    suffixIcon: Icon(
                      Icons.percent,
                      size: 16,
                      color: HexColor("80848A"),
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
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                  color: HexColor("EEF2F6")
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: DropdownButtonFormField(
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  value: controller.compoundFrequency,
                                  decoration: const InputDecoration(
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
                            ),
                          ),
                          const Expanded(child: SizedBox()),
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
                                  hintText: "Year",
                                    hintTextDirection: TextDirection.rtl,
                                    hintStyle: globalTextStyle(),
                                    contentPadding: const EdgeInsets.only(right: 10, left: 10),
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
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor("#F3F6F9"), borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                controller: controller.monthsController.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Months",
                                  border: InputBorder.none,
                                  hintTextDirection: TextDirection.rtl,
                                  hintStyle: globalTextStyle(),
                                  contentPadding: const EdgeInsets.only(right: 10, left: 10),

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
                  10.ph,
                  CommonTextFieldCustom(
                    headingName: 'Marginal Tax Rate ?',
                    controller: controller.taxRateController.value,
                    keyboardType: TextInputType.number,
                    needPadding: true,
                    onlyNeedSuffix: true,
                    suffixIcon: Icon(
                      Icons.percent,
                      size: 16,
                      color: HexColor("80848A"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the tax rate';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  CustomCalculateClearWidget(
                    onPressCalculate: () {
                      if (controller.formKey.value.currentState?.validate() ?? false) {
                        controller.calculate();
                      }
                    },
                    onPressClear: controller.allFieldClear,
                    clearButtonTextColor: HexColor("244384"),
                    clearButtonFontWeight: FontWeight.w500,
                    clearButtonTitleFontSize: 20,
                  ),

                  const SizedBox(height: 20),

                ],
              ),
            )),
      ),
    );
  }
}
