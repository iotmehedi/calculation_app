import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/retirement_calculator/time_calculator_controller.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';

void main() {
  runApp(TimeCalculatorApp());
}

class TimeCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimeCalculatorScreen(),
    );
  }
}

class TimeCalculatorScreen extends StatefulWidget {
  @override
  _TimeCalculatorScreenState createState() => _TimeCalculatorScreenState();
}

class _TimeCalculatorScreenState extends State<TimeCalculatorScreen> {
  var controller = Get.put(TimeCalculatorController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Time Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _buildTimeInputRow(
                    controller.daysController1.value,
                    controller.hoursController1.value,
                    controller.minutesController1.value,
                    controller.secondsController1.value),
                25.ph,
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: HexColor("D9D9D9"))
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Padding(
                              padding:  EdgeInsets.only(left: controller.selectedOperation.value == '+ Add' || controller.selectedOperation.value == '- Subtract'? 40 : 10),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isDense: false,
                                    isExpanded: true,
                                    value: controller.selectedOperation.value,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        controller.selectedOperation.value = newValue!;
                                      });
                                    },
                                    icon: Icon(Icons.keyboard_arrow_down_sharp),
                                    items: <String>[
                                      '+ Add',
                                      '- Subtract',
                                      '× Multiply by a number',
                                      '÷ Divide by a number',
                                      '÷ Divide by time'
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, textAlign: TextAlign.start,textDirection: TextDirection.ltr,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Positioned(
                          // top: 13,
                          //     right: 70,
                          //     // left: 40,
                          //     child: Icon(Icons.keyboard_arrow_down_sharp))
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                if (controller.selectedOperation.value == '+ Add' ||
                    controller.selectedOperation.value == '- Subtract' ||
                    controller.selectedOperation.value == '÷ Divide by time')
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: _buildTimeInputRow(
                        controller.daysController2.value,
                        controller.hoursController2.value,
                        controller.minutesController2.value,
                        controller.secondsController2.value),
                  ),
                if (controller.selectedOperation.value ==
                        '× Multiply by a number' ||
                    controller.selectedOperation.value == '÷ Divide by a number')
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      height: 32,
                      width: 62,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: HexColor("D9D9D9"))),
                      child: TextField(
                        controller: controller.numberController.value,
                        keyboardType: TextInputType.number,
                        cursorHeight: 20,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            contentPadding:
                            EdgeInsets.only(bottom: 15, left: 10, right: 10),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                const SizedBox(height: 40),

                CustomCalculateClearWidget(
                  onPressCalculate: controller.calculate,
                  onPressClear: controller.allFieldClear,
                  clearButtonTextColor: HexColor("244384"),
                  clearButtonFontWeight: FontWeight.w500,
                  clearButtonTitleFontSize: 20,
                ),
                const SizedBox(height: 20),
                Text(
                  controller.result.value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildTimeInputRow(
      TextEditingController daysController,
      TextEditingController hoursController,
      TextEditingController minutesController,
      TextEditingController secondsController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: CustomText(
                text: "Days",
                fontSize: 16,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              ),
            )),
            Expanded(
                child: CustomText(
              text: "Hours",
              fontSize: 16,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
            )),
            Expanded(
                child: CustomText(
              text: "Minutes",
              fontSize: 16,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
            )),
            Expanded(
                child: CustomText(
              text: "Seconds",
              fontSize: 16,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
            )),
          ],
        ),
        10.ph,
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: HexColor("D9D9D9"))),
                child: TextField(
                  controller: daysController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: HexColor("D9D9D9"))),
                child: TextField(
                  controller: hoursController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: HexColor("D9D9D9"))),
                child: TextField(
                  controller: minutesController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: HexColor("D9D9D9"))),
                child: TextField(
                  controller: secondsController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      border: InputBorder.none),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
