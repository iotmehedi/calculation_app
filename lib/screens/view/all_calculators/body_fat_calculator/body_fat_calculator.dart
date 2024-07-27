import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/core/routes/router.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/calorie_calculator/calorie_calculator.dart';
import 'package:calculation_app/screens/widgets/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:calculation_app/screens/widgets/textfield/textField_widget.dart';
import 'package:calculation_app/toast/toast.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/custom_text/custom_text.dart';

class BodyFatCalculator extends StatefulWidget {
  @override
  _BodyFatCalculatorState createState() => _BodyFatCalculatorState();
}

class _BodyFatCalculatorState extends State<BodyFatCalculator> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightInchesController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String gender = 'Male';
  double result = 0.0;
  bool isUSCUnit = true;
  // String? type = 'usUnit';
  var selectedButton = true;
  Gender selectedGender = Gender.male;
  Future<bool> calculateBodyFat() async {
    if (_validateInputs()) {
      double weight = double.tryParse(weightController.text) ?? 0;
      if (weight <= 0) {
        _showErrorDialog('Invalid weight');
        return false;
      } else {
        setState(() {
          double heightFeet = double.tryParse(heightFeetController.text) ?? 0;
          double heightInches =
              double.tryParse(heightInchesController.text) ?? 0;
          double age = double.tryParse(ageController.text) ?? 0;
          double neck = double.tryParse(neckController.text) ?? 0;
          double waist = double.tryParse(waistController.text) ?? 0;
          double hip = double.tryParse(hipController.text) ?? 0;

          // Convert height to inches
          double height = (heightFeet * 12) + heightInches;

          // Convert to metric if necessary
          if (!isUSCUnit) {
            weight *= 0.453592; // pounds to kg
            height *= 2.54; // inches to cm
            neck *= 2.54; // inches to cm
            waist *= 2.54; // inches to cm
            hip *= 2.54; // inches to cm
          }

          // Calculate body fat percentage
          double bodyFatPercentage = 0.0;
          if (gender == 'Male') {
            if (isUSCUnit) {
              bodyFatPercentage = (86.010 * log10(waist - neck)) -
                  (70.041 * log10(height)) +
                  36.76;
            } else {
              bodyFatPercentage = (495 /
                      (1.0324 -
                          (0.19077 * log10(waist - neck)) +
                          (0.15456 * log10(height))) -
                  450);
            }
          } else {
            if (isUSCUnit) {
              bodyFatPercentage = (163.205 * log10(waist + hip - neck)) -
                  (97.684 * log10(height)) -
                  78.387;
            } else {
              bodyFatPercentage = (495 /
                      (1.29579 -
                          (0.35004 * log10(waist + hip - neck)) +
                          (0.22100 * log10(height))) -
                  450);
            }
          }

          result = bodyFatPercentage;
        });
        print("this is result of the body fat $result");
        return true;
      }
    } else {
      return false;
    }
  }

  double log10(num value) {
    return log(value) / log(10);
  }

  bool _validateInputs() {
    if (weightController.text.isEmpty ||
        heightFeetController.text.isEmpty ||
        heightInchesController.text.isEmpty ||
        neckController.text.isEmpty ||
        waistController.text.isEmpty ||
        ageController.text.isEmpty ||
        (gender == 'Female' && hipController.text.isEmpty)) {
      _showErrorDialog('Missing Information');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Body Fat Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                selectedButton = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: selectedButton ==
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
                                      selectedButton ==
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
                                selectedButton = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: selectedButton ==
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
                                      selectedButton ==
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
              const SizedBox(
                height: 20,
              ),
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
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            paddingNeed: true,
                            hint: "Age",
                            textAlign: TextAlign.start),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox())
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
                      value: selectedGender == Gender.male,
                      onChanged: (value) {
                        setState(() {
                          selectedGender =
                              value! ? Gender.male : selectedGender;
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
                      value: selectedGender == Gender.female,
                      onChanged: (value) {
                        setState(() {
                          selectedGender =
                              value! ? Gender.female : selectedGender;
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
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        globalText16(
                            text: "Weight", fontWeight: FontWeight.w500),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomSimpleTextField(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            hexColor: HexColor('80848A'),
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            paddingNeed: true,
                            hint: selectedButton == false ? "kg" : "Pounds",
                            textAlign: TextAlign.start),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox())
                ],
              ),
              10.ph,
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
                        controller: heightFeetController,
                        keyboardType: TextInputType.number,
                        paddingNeed: true,
                        hint: selectedButton == false ? "cm" : "Feet",
                        textAlign: TextAlign.start),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Visibility(
                      visible: selectedButton == false ? false : true,
                      child: CustomSimpleTextField(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          hexColor: HexColor('80848A'),
                          controller: heightInchesController,
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
                        globalText16(text: "Neck", fontWeight: FontWeight.w500),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomSimpleTextField(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            hexColor: HexColor('80848A'),
                            controller: neckController,
                            keyboardType: TextInputType.number,
                            paddingNeed: true,
                            hint: selectedButton == false ? "cm" : "inchs",
                            textAlign: TextAlign.start),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox())
                ],
              ),
              10.ph,
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
                        globalText16(
                            text: "Waist", fontWeight: FontWeight.w500),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomSimpleTextField(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            hexColor: HexColor('80848A'),
                            controller: waistController,
                            keyboardType: TextInputType.number,
                            paddingNeed: true,
                            hint: selectedButton == false ? "cm" : "inchs",
                            textAlign: TextAlign.start),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox())
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if (selectedGender == Gender.female)
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          globalText16(
                              text: "Hip", fontWeight: FontWeight.w500),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomSimpleTextField(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              hexColor: HexColor('80848A'),
                              controller: hipController,
                              keyboardType: TextInputType.number,
                              paddingNeed: true,
                              hint: selectedButton == false ? "cm" : "inchs",
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
              10.ph,
              const SizedBox(height: 20),
              CustomElevatedButton(
                  text: globalText24(
                      text: "Calculate",
                      alignment: Alignment.center,
                      color: Colors.white),
                  hexColor: AppColors.calculateButtonColor,
                  onPress: () {
                    if (ageController.text.isEmpty) {
                      errorToast(context: context, msg: "Please enter age");
                    } else if (heightFeetController.text.isEmpty) {
                      errorToast(context: context, msg: "Please enter feet");
                    } else if (heightInchesController.text.isEmpty &&
                        selectedButton == true) {
                      errorToast(context: context, msg: "Please enter inch");
                    } else if (weightController.text.isEmpty) {
                      errorToast(context: context, msg: "Please enter weight");
                    } else if (hipController.text.isEmpty && selectedButton == false && selectedGender == Gender.female) {
                      errorToast(context: context, msg: "Please enter hip");
                    } else {
                      calculateBodyFat().then((value) {
                        if (value == true) {
                          RouteGenerator().pushNamedSms(
                              context, Routes.bodyfatResultScreen, arguments: [
                            result.toStringAsFixed(0),
                            selectedButton,
                            weightController.text
                          ]);
                          print("this is result $result");
                        }
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
