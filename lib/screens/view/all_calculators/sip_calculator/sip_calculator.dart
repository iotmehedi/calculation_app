import 'dart:math';

import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/sip_calculator/sip_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../widgets/common_custom_richText/common_custom_richText.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';

class SIPCalculatorPage extends StatefulWidget {
  @override
  _SIPCalculatorPageState createState() => _SIPCalculatorPageState();
}

class _SIPCalculatorPageState extends State<SIPCalculatorPage> {
  var controller = Get.put(SIPController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: "SIP Calculator",
      onBackPressed: (){
        Navigator.pop(context);
      },
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey.value,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: HexColor("244384"),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.selectedButton.value = true;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: controller.selectedButton.value ==
                                              true
                                          ? Colors.white
                                          : HexColor("244384"),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(
                                          child: CustomText(
                                        text: "SIP",
                                        fontSize: 20,
                                        textColor:
                                            controller.selectedButton.value ==
                                                    true
                                                ? Colors.black
                                                : Colors.white,
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                              5.pw,
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.selectedButton.value = false;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: controller.selectedButton.value ==
                                              false
                                          ? Colors.white
                                          : HexColor("244384"),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(
                                          child: CustomText(
                                        text: "Lumpsum",
                                        fontSize: 20,
                                        textColor:
                                            controller.selectedButton.value ==
                                                    false
                                                ? HexColor("244384")
                                                : Colors.white,
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    20.ph,
                    CommonTextFieldCustom(
                      headingName: 'Total Investment',
                      controller: controller.monthlyInvestmentController.value,
                      keyboardType: TextInputType.number,
                      needPadding: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter total investment';
                        }
                        return null;
                      },
                      headingFontSize: 20,
                      headingFontWeight: FontWeight.w400,
                      headingTextColor: Colors.black,
                    ),
                    10.ph,
                    CommonRichTextFieldCustom(
                      titleName: "(p.a)",
                      titleTextColor: Colors.blue,
                      titleFontSIze: 14.0,
                      headingFontSize: 16.0,
                      titleFontWeight: FontWeight.w400,
                      headingFontWeight: FontWeight.w400,
                      headingName: 'Expected Of Return ',
                      headingTextColor: Colors.black,
                      controller: controller.annualReturnController.value,
                      keyboardType: TextInputType.number,
                      needPadding: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter expected of return';
                        }
                        return null;
                      },
                    ),
                    10.ph,
                    CommonRichTextFieldCustom(
                      titleName: "(Year)",
                      titleTextColor: Colors.blue,
                      titleFontSIze: 14.0,
                      headingFontSize: 16.0,
                      titleFontWeight: FontWeight.w400,
                      headingFontWeight: FontWeight.w400,
                      headingName: 'Time Period ',
                      controller: controller.timePeriodController.value,
                      keyboardType: TextInputType.number,
                      needPadding: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter time period';
                        }
                        return null;
                      },
                    ),
                    10.ph,
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomElevatedButton(
                        color: HexColor("244384"),
                        onPress: () {
                          if (controller.selectedButton.value) {
                            controller.calculateSIP();
                          } else {
                            controller.calculateLumpsum();
                          }
                        },
                        // RouteGenerator.pushNamed(context, Routes.mortgageResultPage);
                        text: const Text(
                          "Calculate",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
