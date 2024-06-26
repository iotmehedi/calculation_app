import 'package:flutter/material.dart';
import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/core/routes/router.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:calculation_app/screens/widgets/textfield/textField_widget.dart';
import 'package:calculation_app/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class BmrCalculator extends StatefulWidget {
  @override
  _BmrCalculatorState createState() => _BmrCalculatorState();
}

class _BmrCalculatorState extends State<BmrCalculator> {
  TextEditingController ageController = TextEditingController();
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightInchesController = TextEditingController();
  TextEditingController heightCmController = TextEditingController();
  TextEditingController weightKgController = TextEditingController();
  final TextEditingController weightPoundsController = TextEditingController();
  double bmiResult = 0.0;
  String? type = 'usUnit';

  double bmr = 0.0;
  Gender selectedGender = Gender.male;
  Future<bool> calculateBmr() async {
    double height, weight, age;
    if (ageController.text.isEmpty) {
      errorToast(context: context, msg: "Please enter age");
      return false;
    } else if (heightCmController.text.isEmpty) {
      errorToast(context: context, msg: "Please enter height");
      return false;
    } else if (weightKgController.text.isEmpty) {
      errorToast(context: context, msg: "Please enter weight");
      return false;
    } else {
      height = double.parse(heightCmController.text);
      weight = double.parse(weightKgController.text);
      age = double.parse(ageController.text);

      // Formula: BMR = (10 × weight in kg) + (6.25 × height in cm) - (5 × age in years) + 5 (for men)
      // For women, subtract 161 instead of adding 5
      if (selectedGender == Gender.male) {
        bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
      } else {
        bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
      }

      setState(() {
        bmr = bmr;
      });
      return true;
    }
  }

  Future<bool> calculateBmrForUsUnit() async {
    if (ageController.text.isEmpty) {
      errorToast(context: context, msg: "Please enter age");
      return false;
    } else if (heightFeetController.text.isEmpty) {
      errorToast(context: context, msg: "Please enter height");
      return false;
    } else if (heightInchesController.text.isEmpty) {
      errorToast(context: context, msg: "Please enter inch");
      return false;
    } else if (weightPoundsController.text.isEmpty) {
      errorToast(context: context, msg: "Please enter weight");
      return false;
    } else {
      double heightFeet, heightInches, weightPounds, age;

      heightFeet = double.parse(heightFeetController.text);
      heightInches = double.parse(heightInchesController.text);
      weightPounds = double.parse(weightPoundsController.text);
      age = double.parse(ageController.text);

      // Convert height from feet/inches to centimeters
      double heightInCm = (heightFeet * 12 + heightInches) * 2.54;
      // Convert weight from pounds to kilograms
      double weightKg = weightPounds * 0.453592;

      // Calculate BMR based on selected gender
      if (selectedGender == Gender.male) {
        // Formula for males
        bmr = (10 * weightKg) + (6.25 * heightInCm) - (5 * age) + 5;
      } else {
        // Formula for females
        bmr = (10 * weightKg) + (6.25 * heightInCm) - (5 * age) - 161;
      }

      setState(() {
        bmr = bmr.roundToDouble(); // Round to the nearest whole number
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'BRM Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: CustomElevatedButton(
                    text: globalText18(
                        text: 'Us Unit',
                        color: type != 'usUnit' && (type?.isNotEmpty ?? false)
                            ? HexColor('0F182E')
                            : Colors.white,
                        alignment: Alignment.center,
                        fontWeight: FontWeight.normal),
                    color: type == 'usUnit' && (type?.isNotEmpty ?? false)
                        ? AppColors.calculateButtonColor
                        : HexColor('EEF2F6'),
                    onPress: () {
                      setState(() {
                        type = "usUnit";
                        ageController.text = '';
                        heightFeetController.text = '';
                        heightInchesController.text = '';
                        heightCmController.text = '';
                        weightKgController.text = '';
                      });
                    },
                  )),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: CustomElevatedButton(
                      onPress: () {
                        setState(() {
                          type = 'matrics';
                          ageController.text = '';
                          heightFeetController.text = '';
                          heightInchesController.text = '';
                          heightCmController.text = '';
                          weightKgController.text = '';
                        });
                      },
                      color: type == 'matrics' && (type?.isNotEmpty ?? false)
                          ? AppColors.calculateButtonColor
                          : HexColor('EEF2F6'),
                      text: globalText18(
                          text: 'Matrics Units',
                          color:
                              type != 'matrics' && (type?.isNotEmpty ?? false)
                                  ? HexColor('0F182E')
                                  : Colors.white,
                          // alignment: Alignment.center,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
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
                            paddingNeed: false,
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
              // CheckBox(),
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
                      activeColor: Colors.blue, // Set your desired color
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
                      activeColor: Colors.blue, // Set your desired color
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
                        controller: type != 'usUnit'
                            ? heightCmController
                            : heightFeetController,
                        keyboardType: TextInputType.number,
                        paddingNeed: false,
                        hint: type != 'usUnit' ? "cm" : "Feet",
                        textAlign: TextAlign.end),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Visibility(
                      visible: type == 'matrics' ? false : true,
                      child: CustomSimpleTextField(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          hexColor: HexColor('80848A'),
                          controller: heightInchesController,
                          keyboardType: TextInputType.number,
                          paddingNeed: false,
                          hint: "Inch",
                          textAlign: TextAlign.end),
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
                            controller: type != 'matrics'
                                ? weightPoundsController
                                : weightKgController,
                            keyboardType: TextInputType.number,
                            paddingNeed: false,
                            hint: type != 'usUnit' ? "kg" : "Pounds",
                            textAlign: TextAlign.end),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox())
                ],
              ),

              const SizedBox(height: 16.0),
              CustomElevatedButton(
                  text: globalText24(
                      text: "Calculate",
                      alignment: Alignment.center,
                      color: Colors.white),
                  hexColor: AppColors.calculateButtonColor,
                  onPress: () {
                    if (type == 'matrics') {
                      calculateBmr().then((value) {
                        if (value == true) {
                          RouteGenerator().pushNamedSms(
                              context, Routes.bRMResultScreen,
                              arguments: [
                                bmr,
                              ]);
                        }
                      });
                    } else {
                      calculateBmrForUsUnit().then((value) {
                        if (value == true) {
                          RouteGenerator().pushNamedSms(
                              context, Routes.bRMResultScreen,
                              arguments: [
                                bmr,
                              ]);
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

  // Widget CheckBox() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 30),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
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
  //             const SizedBox(width: 8),
  //             const Text('Male'),
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
  //             const SizedBox(width: 8),
  //             const Text('Female'),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class SquareCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const SquareCheckBox({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
          color: value ? HexColor('244384') : null,
        ),
        child: value
            ? const Icon(
                Icons.check,
                size: 18,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

enum Gender { male, female }
