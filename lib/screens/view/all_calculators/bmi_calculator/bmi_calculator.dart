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

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  TextEditingController ageController = TextEditingController();
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightInchesController = TextEditingController();
  TextEditingController heightCmController = TextEditingController();
  TextEditingController weightKgController = TextEditingController();
  double bmiResult = 0.0;
  String? type = 'usUnit';
  String? bmiValueName;
  bool maleChecked = false;
  bool femaleChecked = false;
  bool otherChecked = false;
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
      appBar: CustomAppBar(
        title: 'BMI Calculator',
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
                    text: globalText20(
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
                      text: globalText20(
                          text: 'Matrics Units',
                          color:
                              type != 'matrics' && (type?.isNotEmpty ?? false)
                                  ? HexColor('0F182E')
                                  : Colors.white,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CheckBox(),
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
                            textInputType: TextInputType.number,
                            paddingNeed: false,
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
                        textInputType: TextInputType.number,
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
                          textInputType: TextInputType.number,
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
                            controller: weightKgController,
                            textInputType: TextInputType.number,
                            paddingNeed: false,
                            hint: type != 'usUnit' ? "kg" : "Pounds",
                            textAlign: TextAlign.end),
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
                    } else if (heightFeetController.text.isEmpty) {
                      errorToast(context: context, msg: "Please enter feet");
                    } else if (heightInchesController.text.isEmpty) {
                      errorToast(context: context, msg: "Please enter inch");
                    } else if (weightKgController.text.isEmpty) {
                      errorToast(context: context, msg: "Please enter weight");
                    } else {
                      if (type == 'matrics') {
                        calculateMatricsBMI();
                      } else {
                        calculateUsUnitBMI();
                      }
                      RouteGenerator().pushNamedSms(
                          context, Routes.resultScreen,
                          arguments: [
                            bmiResult,
                            progressValue,
                            bmiValueName,
                          ]);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget CheckBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SquareCheckBox(
                value: maleChecked,
                onChanged: (value) {
                  setState(() {
                    maleChecked = value!;
                    if (value) {
                      femaleChecked = false;
                      otherChecked = false;
                    }
                  });
                },
              ),
              SizedBox(width: 8),
              Text('Male'),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: <Widget>[
              SquareCheckBox(
                value: femaleChecked,
                onChanged: (value) {
                  setState(() {
                    femaleChecked = value!;
                    if (value) {
                      maleChecked = false;
                      otherChecked = false;
                    }
                  });
                },
              ),
              SizedBox(width: 8),
              Text('Female'),
            ],
          ),
        ],
      ),
    );
  }
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
            ? Icon(
                Icons.check,
                size: 18,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
