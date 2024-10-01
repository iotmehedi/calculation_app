import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/tdee_calculator/tdee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../../toast/toast.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../widgets/custom_text/custom_text.dart';
import '../../../widgets/textfield/textField_widget.dart';
import '../normal_calculator/Colors.dart';
class TDEECalculator extends StatefulWidget {
  @override
  _TDEECalculatorState createState() => _TDEECalculatorState();
}

class _TDEECalculatorState extends State<TDEECalculator> {


var controller = Get.put(TdeeController());
var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      appBar: AppBar(title: Text('TDEE Calculator')),
      bottomNavigationBar: adController.getBannerAdWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  setState(() {
                                    controller.isMetric.value = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: controller.isMetric.value ==
                                        true
                                        ? Colors.white
                                        : HexColor("244384"),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Center(
                                        child: CustomText(
                                          text: "Us Unit",
                                          fontSize: 20,
                                          textColor:
                                          controller.isMetric.value ==
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
                                  setState(() {
                                    controller.isMetric.value = false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: controller.isMetric.value ==
                                        false
                                        ? Colors.white
                                        : HexColor("244384"),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Center(
                                        child: CustomText(
                                          text: "Matrics Units",
                                          fontSize: 20,
                                          textColor:
                                          controller.isMetric.value ==
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

                  const SizedBox(height: 16.0),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            globalText16(text: "Age", fontWeight: FontWeight.w500),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomSimpleTextField(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                hexColor: HexColor('80848A'),
                                controller: controller.ageController.value,
                                keyboardType: TextInputType.number,
                                paddingNeed: true,
                                hint: "Age",
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          value: controller.selectedGender.value == Gender.male,
                          onChanged: (value) {
                            setState(() {
                              controller.selectedGender.value = value! ? Gender.male : controller.selectedGender.value;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: HexColor("244384"), // Set your desired color
                        ),
                      ),
                      const Text('Male'),
                      const SizedBox(
                        width: 10,
                      ),
                      Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          value: controller.selectedGender.value == Gender.female,
                          onChanged: (value) {
                            setState(() {
                              controller.selectedGender.value =
                              value! ? Gender.female : controller.selectedGender.value;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: HexColor("244384"), // Set your desired color
                        ),
                      ),
                      const Text('Female'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  globalText16(text: "Height", fontWeight: FontWeight.w500),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomSimpleTextField(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            hexColor: HexColor('80848A'),
                            controller: controller.isMetric.value == true
                                ? controller.heightCmController.value
                                : controller.heightFeetController.value,
                            keyboardType: TextInputType.number,
                            paddingNeed: true,
                            hint: controller.isMetric.value == true ? "Feet" : "cm",
                            textAlign: TextAlign.start),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Visibility(
                          visible: controller.isMetric.value == true ? true : false,
                          child: CustomSimpleTextField(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              hexColor: HexColor('80848A'),
                              controller: controller.heightInchesController.value,
                              keyboardType: TextInputType.number,
                              paddingNeed: true,
                              hint: "Inch",
                              textAlign: TextAlign.start),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            globalText16(text: "Weight", fontWeight: FontWeight.w500),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomSimpleTextField(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                hexColor: HexColor('80848A'),
                                controller: controller.weightKgController.value,
                                keyboardType: TextInputType.number,
                                paddingNeed: true,
                                hint: controller.isMetric.value == false ? "kg" : "Pounds",
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                  10.ph,
                  globalText16(
                      text: "Level of Activity", fontWeight: FontWeight.normal),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AssetColor.calculationButtonColor.withOpacity(0.05)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ActivityLevel>(
                        value: controller.activityLevel.value,
                        isExpanded: true,
                        items: ActivityLevel.values.map((ActivityLevel value) {
                          return DropdownMenuItem<ActivityLevel>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: globalText12(
                                  text: controller.getActivityText(value), fontWeight: FontWeight.normal),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            controller.activityLevel.value = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                      text: globalText24(
                          text: "Calculate",
                          alignment: Alignment.center,
                          color: Colors.white),
                      hexColor: AppColors.calculateButtonColor,
                      onPress: () {
                        // if (controller.ageController.value.text.isEmpty) {
                        //   errorToast(context: context, msg: "Please enter age");
                        // } else if (controller.heightFeetController.value.text.isEmpty &&
                        //     controller.isMetric.value == false) {
                        //   errorToast(context: context, msg: "Please enter feet");
                        // } else if (controller.heightInchesController.value.text.isEmpty &&
                        //     controller.isMetric.value == false) {
                        //   errorToast(context: context, msg: "Please enter inch");
                        // } else if (controller.isMetric.value == true &&
                        //     controller.heightCmController.value.text.isEmpty) {
                        // } else if (controller.weightKgController.value.text.isEmpty) {
                        //   errorToast(context: context, msg: "Please enter weight");
                        // } else {
                          setState(() {
                            double tdee = controller.calculateTDEE();
                            print("Hudai kaj kam $tdee");
                            double bmi = controller.calculateBMI();
                            double weightInPounds =
                            controller.isMetric.value == false ? controller.weightKg.value * 2.20462 : controller.weightKg.value;
                            double heightInInches = controller.isMetric.value == false
                                ? controller.heightCm.value / 2.54
                                : (controller.heightFeet.value * 12) + controller.heightInches.value;
                            double heightInMeters = heightInInches * 0.0254;
                            double bmiScore = weightInPounds / pow(heightInMeters, 2);

                            controller.tdeeResult.value = NumberFormat(',###', 'en_US').format(tdee);
                            controller.bmiResult.value =
                            'BMI Score: ${bmiScore.toStringAsFixed(1)} kg/m2 (${controller.getBMICategory(bmi)})';
                            controller.energyIntake.value = controller.getEnergyIntake(tdee);
                            RouteGenerator.pushNamed(context, Routes.tdeeCalculatorResult);
                          });
                          // RouteGenerator().pushNamedSms(
                          //     context, Routes.calorieResultScreen,
                          //     arguments: [
                          //       weightLossCalories['Maintain weight'],
                          //       weightLossCalories['Mild weight loss (0.5 kg/week)'],
                          //       weightLossCalories['Weight loss (1 kg/week)'],
                          //       weightLossCalories['Extreme weight loss (2 kg/week)'],
                          //       selectedButton
                          //     ]);
                        // }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }


}
