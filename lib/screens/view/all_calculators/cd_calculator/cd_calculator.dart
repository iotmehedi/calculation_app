import 'dart:math';

import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/cd_calculator/cd_calculator_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';

class CDCalculatorForm extends StatefulWidget {
  @override
  _CDCalculatorFormState createState() => _CDCalculatorFormState();
}

class _CDCalculatorFormState extends State<CDCalculatorForm> {
  var controller = Get.put(CDCalculatorController());
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    // Get.find<AdService>().loadBannerAd();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "CD Calculator",
        onBackPressed: () {
          Navigator.pop(context);
          controller.allFieldClear();
        },
      ),
      // bottomNavigationBar: adController.getBannerAdWidget(),
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
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: CommonTextFieldCustom(
                              isInRow: "need",
                              flex: 1,
                              headingName: '',
                              titleTextColor: HexColor("437AFF"),
                              titleName: "",
                              titleFontWeight: FontWeight.normal,
                              titleFontSize: 16,
                              controller: controller.yearsController.value,
                              keyboardType: TextInputType.number,
                              needPadding: true,
                              onlyNeedSuffix: true,
                              hint: "Year",
                              textAlign: TextAlign.start,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter year';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            flex: 1,
                            child: CommonTextFieldCustom(
                              isInRow: "need",
                              flex: 1,
                              headingName: '',
                              titleTextColor: HexColor("437AFF"),
                              titleName: "",
                              titleFontWeight: FontWeight.normal,
                              titleFontSize: 16,
                              controller: controller.monthsController.value,
                              keyboardType: TextInputType.number,
                              needPadding: true,
                              onlyNeedSuffix: true,
                              hint: "Month",
                              textAlign: TextAlign.start,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter month';
                                }
                                return null;
                              },
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
