import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/salary_calculator/salary_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../core/utils/consts/app_colors.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';



class SalaryCalculatorScreen extends StatefulWidget {
  @override
  _SalaryCalculatorScreenState createState() => _SalaryCalculatorScreenState();
}

class _SalaryCalculatorScreenState extends State<SalaryCalculatorScreen> {
  var controller = Get.put(SalaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Salary Calculator",
        fontFamily: "Podkova",
        onBackPressed: () {
          Navigator.pop(context);
          controller.allFieldClear();
        },
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey.value,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextFieldCustom(
                            flex: 15,
                            headingName: 'Salary Amount',
                            controller: controller.salaryController.value,
                            keyboardType: TextInputType.number,
                            needPadding: true,
                            onlyNeedSuffix: true,
                            fontFamily: true,
                            suffixIcon: const Icon(
                              Icons.attach_money_rounded,
                              size: 16,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the salary amount';
                              }
                              return null;
                            },
                          ),
                        ),
                        // 5.pw,
                        Column(
                          children: [
                            globalText16(
                                text: '',
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.start),
                            5.ph,
                            Center(
                              child: globalText18(
                                  text: "per",
                                  fontWeight: FontWeight.w400,
                                  alignment: Alignment.center),
                            ),
                          ],
                        ),
                        15.pw,
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              globalText16(
                                  text: '',
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.start),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: HexColor("EEF2F6")),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    value: controller.selectedInterval.value,
                                    items: controller.intervals
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: globalText16(
                                            text: value,
                                            fontWeight: FontWeight.w400,
                                        fontFamily: true,
                                          color: HexColor("80848A")
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        controller.selectedInterval.value =
                                            newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    10.ph,
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: globalText16(
                              text: "Hours per Week",
                              fontWeight: FontWeight.w500, alignment: Alignment.centerLeft, textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CommonTextFieldCustom(
                            flex: 2,
                            headingName: '',
                            controller: controller.hoursPerWeekController.value,
                            keyboardType: TextInputType.number,
                            needPadding: false,
                            onlyNeedSuffix: true,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the hours per week';
                              }
                              return null;
                            },
                                                    ),
                          ),)
                      ],
                    ),
                    10.ph,

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: globalText16(
                              text: "Days per week",
                              fontWeight: FontWeight.w500, alignment: Alignment.centerLeft, textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CommonTextFieldCustom(
                              flex: 2,
                              headingName: '',
                              controller: controller.daysPerWeekController.value,
                              keyboardType: TextInputType.number,
                              needPadding: false,
                              onlyNeedSuffix: true,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the days per week';
                                }
                                return null;
                              },
                            ),
                          ),)
                      ],
                    ),
                    10.ph,
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: globalText16(
                              text: "Holidays per year",
                              fontWeight: FontWeight.w500, alignment: Alignment.centerLeft, textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CommonTextFieldCustom(
                              flex: 2,
                              headingName: '',
                              controller: controller.holidaysPerYearController.value,
                              keyboardType: TextInputType.number,
                              needPadding: false,
                              onlyNeedSuffix: true,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the holidays per year';
                                }
                                return null;
                              },
                            ),
                          ),)
                      ],
                    ),
                    10.ph,
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: globalText16(
                              text: "Vacation days per year",
                              fontWeight: FontWeight.w500, alignment: Alignment.centerLeft, textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CommonTextFieldCustom(
                              flex: 2,
                              headingName: '',
                              controller: controller.vacationDaysPerYearController.value,
                              keyboardType: TextInputType.number,
                              needPadding: false,
                              onlyNeedSuffix: true,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the vacation days per year';
                                }
                                return null;
                              },
                            ),
                          ),)
                      ],
                    ),
                    10.ph,
                    const SizedBox(height: 20),

                    CustomCalculateClearWidget1(
                      clearButtonTextColor: HexColor("244384"),
                      onPressCalculate: () {
                        if (controller.formKey.value.currentState?.validate() ??
                            false) {
                          setState(() {
                            controller.calculateSalaryAdjusted();
                            controller.calculateSalaryUnadjusted();
                            controller.calculateSalaries();
                            RouteGenerator.pushNamed(context, Routes.salaryCalculatorResultScreen);
                          });
                          // controller.calculateSalary();
                        }
                      },
                      onPressClear: controller.allFieldClear,
                        clearButtonTitleFontSize: 20,
                        clearButtonFontWeight: FontWeight.w600
                    ),

                  ],
                ),
              ),
            ),
          )),
    );
  }
}
