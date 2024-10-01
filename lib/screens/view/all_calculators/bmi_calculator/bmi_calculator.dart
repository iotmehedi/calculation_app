import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/core/routes/router.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/calorie_calculator/calorie_calculator.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:calculation_app/screens/widgets/textfield/textField_widget.dart';
import 'package:calculation_app/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/custom_text/custom_text.dart';

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  TextEditingController ageController = TextEditingController();
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightInchesController = TextEditingController(text: '0');
  TextEditingController heightCmController = TextEditingController();
  TextEditingController weightKgController = TextEditingController();
  double bmiResult = 0.0;
  var adController = Get.put(AdService());
  // String? type = 'usUnit';
  String? bmiValueName;
  var selectedButton = true;
  Gender selectedGender = Gender.male;
  double progressValue = 0.0; // Initial value for progress indicator
  void calculateUsUnitBMI() {
    double weight = double.tryParse(weightKgController.text) ?? 0.0;
    double feet = double.tryParse(heightFeetController.text) ?? 0.0;
    double inches = double.tryParse(heightInchesController.text) ?? 0.0;

    if (weight > 0 && feet > 0 && inches >= 0) {
      double totalHeightInches = (feet * 12) + inches;
      setState(() {
        bmiResult = (weight / (totalHeightInches * totalHeightInches)) * 703;
        _updateProgressValue();
      });
    }
  }

  void calculateMatricsBMI() {
    double heightCm = double.parse(heightCmController.text);
    double weightKg = double.parse(weightKgController.text);
    setState(() {
      bmiResult = weightKg / ((heightCm / 100) * (heightCm / 100));
      _updateProgressValue();
    });
  }

  void _updateProgressValue() {
    if (bmiResult < 18.5) {
      bmiValueName = "Underweight";
      progressValue = 0.2; // Underweight
    } else if (bmiResult >= 18.5 && bmiResult < 24.9) {
      bmiValueName = "Normal Weight";
      progressValue = 0.4; // Normal weight
    } else if (bmiResult >= 25 && bmiResult < 29.9) {
      bmiValueName = "Overweight";
      progressValue = 0.6; // Overweight
    } else {
      bmiValueName = "Obese";
      progressValue = 0.8; // Obese
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'BMI Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      bottomNavigationBar: adController.getBannerAdWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                            onlyNeedSuffix: true,
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
                        controller: selectedButton == false
                            ? heightCmController
                            : heightFeetController,
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
                        globalText16(
                            text: "Weight", fontWeight: FontWeight.w500),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomSimpleTextField(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            hexColor: HexColor('80848A'),
                            controller: weightKgController,
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
                    } else if (heightFeetController.text.isEmpty &&
                        selectedButton == true) {
                      errorToast(context: context, msg: "Please enter feet");
                    } else if (heightInchesController.text.isEmpty &&
                        selectedButton == false) {
                      errorToast(context: context, msg: "Please enter height");
                    } else if (weightKgController.text.isEmpty) {
                      errorToast(context: context, msg: "Please enter weight");
                    } else {
                      if (selectedButton == false) {
                        calculateMatricsBMI();
                      } else {
                        calculateUsUnitBMI();
                      }
                      RouteGenerator().pushNamedSms(
                          context, Routes.resultScreen, arguments: [
                        bmiResult,
                        progressValue,
                        bmiValueName,
                        selectedButton
                      ]);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // Widget CheckBox() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 30),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Row(
  //           children: <Widget>[
  //             SquareCheckBox(
  //               value: maleChecked,
  //               onChanged: (value) {
  //                 setState(() {
  //                   maleChecked = value!;
  //                   if (value) {
  //                     femaleChecked = false;
  //                     otherChecked = false;
  //                   }
  //                 });
  //               },
  //             ),
  //             SizedBox(width: 8),
  //             Text('Male'),
  //           ],
  //         ),
  //         const SizedBox(
  //           width: 10,
  //         ),
  //         Row(
  //           children: <Widget>[
  //             SquareCheckBox(
  //               value: femaleChecked,
  //               onChanged: (value) {
  //                 setState(() {
  //                   femaleChecked = value!;
  //                   if (value) {
  //                     maleChecked = false;
  //                     otherChecked = false;
  //                   }
  //                 });
  //               },
  //             ),
  //             SizedBox(width: 8),
  //             Text('Female'),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

// class SquareCheckBox extends StatelessWidget {
//   final bool value;
//   final ValueChanged<bool?> onChanged;

//   const SquareCheckBox({
//     required this.value,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onChanged(!value);
//       },
//       child: Container(
//         width: 24,
//         height: 24,
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: value ? Colors.transparent : Colors.black,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(4),
//           color: value ? HexColor('244384') : null,
//         ),
//         child: value
//             ? Icon(
//                 Icons.check,
//                 size: 18,
//                 color: Colors.white,
//               )
//             : null,
//       ),
//     );
//   }
// }
