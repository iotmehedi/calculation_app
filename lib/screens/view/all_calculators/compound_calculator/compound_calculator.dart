import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/compound_calculator/compound_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';


class CalculatorForm extends StatefulWidget {
  @override
  _CalculatorFormState createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  var controller = Get.put(CompoundController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Compound Calculator",
        onBackPressed: () {
          Navigator.pop(context);
          controller.allFieldClear();
        },
      ),
      body: Obx(() => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey.value,
                child: Column(
                  children: <Widget>[
                    CommonTextFieldCustom(
                      headingName: 'Initial Investment:',
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
                          return 'Please enter the initial Investment';
                        }
                        return null;
                      },
                    ),
                    10.ph,
                    CommonTextFieldCustom(
                      headingName: 'Monthly Deposit',
                      controller: controller.contributionAmountController.value,
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
                          return 'Please enter the monthly deposit';
                        }
                        return null;
                      },
                    ),
                    10.ph,
                    globalText16(text: "Contribution frequency", fontWeight: FontWeight.w400, fontSize: 16),
                    5.ph,
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.contributionFrequency.value =
                                  "Monthly";
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: HexColor("EEF2F6"),
                                  border: Border.all(
                                      color: controller.contributionFrequency
                                                  .value ==
                                              "Monthly"
                                          ? HexColor("244384")
                                          : Colors.transparent)),
                              child: globalText16(
                                  text: "Monthly",
                                  fontWeight: FontWeight.normal,
                                  alignment: Alignment.center,
                              fontFamily: true,
                              ),
                            ),
                          ),
                        ),
                        10.pw,
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.contributionFrequency.value = "Yearly";
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: HexColor("EEF2F6"),
                                  border: Border.all(
                                      color: controller.contributionFrequency
                                                  .value ==
                                              "Yearly"
                                          ? HexColor("244384")
                                          : Colors.transparent)),
                              child: globalText16(
                                  text: "Yearly",
                                  fontWeight: FontWeight.normal,
                                  alignment: Alignment.center,
                              fontFamily: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    10.ph,
                    // DropdownButtonFormField<String>(
                    //   value: controller.contributionFrequency.value,
                    //   decoration: const InputDecoration(
                    //       labelText: 'Contribution Frequency'),
                    //   items: <String>['Monthly', 'Yearly'].map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       controller.contributionFrequency.value = newValue!;
                    //     });
                    //   },
                    // ),
                    CommonTextFieldCustom(
                      headingName: 'Years to grow',
                      controller: controller.yearsOfGrowthController.value,
                      keyboardType: TextInputType.number,
                      needPadding: true,
                      onlyNeedSuffix: true,
                      hint: "Year",

                      // suffixIcon: Icon(
                      //   Icons.percent,
                      //   size: 16,
                      // ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the years of growth';
                        }
                        return null;
                      },
                    ),
                    10.ph,
                    CommonTextFieldCustom(
                      headingName: 'Annual Interest Rate %',
                      controller: controller.rateOfReturnController.value,
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
                          return 'Please enter the annual interest rate';
                        }
                        return null;
                      },
                    ),
                    10.ph,
                    globalText16(
                        text: "Compounding", fontWeight: FontWeight.normal, fontFamily: true),
                    5.ph,
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("EEF2F6"),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Expanded(child: SizedBox()),
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: controller.compoundFrequency.value,
                                      items: <String>[
                                        'Daily',
                                        'Monthly',
                                        'Annually'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: globalText16(
                                              text: value,
                                              fontWeight: FontWeight.normal,
                                          fontFamily: true,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          controller.compoundFrequency.value =
                                              newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox())
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomCalculateClearWidget(
                      onPressCalculate: () {
                        if (controller.formKey.value.currentState!.validate()) {
                          controller.calculateCompoundInterest();
                        }
                      },
                      onPressClear: controller.allFieldClear,
                    ),

                    const SizedBox(height: 20),
                    // Text(
                    //   'Total Balance: \$${controller.result.value.toStringAsFixed(2)}',
                    //   style: const TextStyle(fontSize: 20),
                    // ),
                    // Text(
                    //   'Total Principal: \$${controller.totalPrincipal.value.toStringAsFixed(2)}',
                    //   style: const TextStyle(fontSize: 20),
                    // ),
                    // Text(
                    //   'Total Interest: \$${controller.totalInterest.value.toStringAsFixed(2)}',
                    //   style: const TextStyle(fontSize: 20),
                    // ),
                    // const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
