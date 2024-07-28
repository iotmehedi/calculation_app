import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/loan_calculator/loan_calculator_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_dropdown/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';



class LoanCalculatorScreen extends StatefulWidget {
  @override
  _LoanCalculatorScreenState createState() => _LoanCalculatorScreenState();
}

class _LoanCalculatorScreenState extends State<LoanCalculatorScreen> {
  var controller = Get.put(LoanCalcualtorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: "Loan Calculator", onBackPressed: (){
        Navigator.pop(context);
        controller.allFieldClear();
      },),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey.value,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.ph,
                      CommonTextFieldCustom(
                        headingName: 'Loan Amount',
                        controller: controller.loanAmountController.value,
                        keyboardType: TextInputType.number,
                        needPadding: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter loan amount';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.attach_money, size: 16,)
                      ),
                      10.ph,
                      CommonTextFieldCustom(
                        headingName: 'Loan Term (years)',
                        controller: controller.loanTermController.value,
                        keyboardType: TextInputType.number,
                        needPadding: true,
                        onlyNeedSuffix: true,

                        hint: "Year",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter loan term';
                          }
                          return null;
                        },
                      ),
                      10.ph,
                      CommonTextFieldCustom(
                        headingName: 'Interest Rate (%)',
                        controller: controller.interestRateController.value,
                        needPadding: true,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter interest rate';
                          }
                          return null;
                        },

                        suffixIcon: Icon(Icons.percent, size: 16,color: HexColor("80848A"),)
                      ),
                      10.ph,
                      CustomDropdownbutton(value: controller.compoundOption.value, onChanged: (String? newValue) {
                          controller.compoundOption.value = newValue!;
                      }, items: controller.compoundingPeriodsPerYear.keys, headingName: "Compound",),
                      10.ph,
                      CustomDropdownbutton(value: controller.paybackOption.value, onChanged: (String? newValue) {
                        controller.paybackOption.value = newValue!;
                      }, items: controller.paybackPeriodsPerYear.keys, headingName: "Pay Back",),
                      10.ph,
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                color: HexColor("244384"),
                                onPress: controller.calculateLoan,
                                // RouteGenerator.pushNamed(context, Routes.mortgageResultPage);
                                text: const Text(
                                  "Calculate",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            10.pw,
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


                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
