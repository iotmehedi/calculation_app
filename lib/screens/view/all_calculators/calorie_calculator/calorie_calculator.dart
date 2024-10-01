import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/core/routes/router.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/bmi_calculator/bmi_calculator.dart';
import 'package:calculation_app/screens/view/all_calculators/normal_calculator/Colors.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:calculation_app/screens/widgets/textfield/textField_widget.dart';
import 'package:calculation_app/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/custom_text/custom_text.dart';

enum ActivityLevel {
  basalMetabolicRate,
  sedentary,
  lightlyActive,
  moderatelyActive,
  active,
  veryActive,
  extraActive,
}

enum Gender {
  male,
  female,
}

class CalorieCalculatorScreen extends StatefulWidget {
  @override
  _CalorieCalculatorScreenState createState() =>
      _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  TextEditingController ageController = TextEditingController();
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightInchesController = TextEditingController();
  TextEditingController heightCmController = TextEditingController();
  TextEditingController weightKgController = TextEditingController();
  Gender selectedGender = Gender.male;
  late ActivityLevel activityLevel;
  var selectedButton = true;
  late int calculatedCalories;
  late Map<String, int> weightLossCalories;
  var adController = Get.put(AdService());

  @override
  void initState() {
    super.initState();
    activityLevel = ActivityLevel.sedentary;
    calculatedCalories = 0;
    weightLossCalories = {
      'Maintain weight': 0,
      'Mild weight loss (0.5 kg/week)': 0,
      'Weight loss (1 kg/week)': 0,
      'Extreme weight loss (2 kg/week)': 0,
    };
    selectedButton = true; // Default to US units
  }

  void calculateCalories() {
    double bmr;
    double result;
    // Mifflin-St Jeor Equation

    double weightKg = double.tryParse(weightKgController.text) ?? 0.0;
    double height = double.tryParse(heightFeetController.text) ?? 0.0;
    double heightInch = double.tryParse(heightInchesController.text) ?? 0.0;
    double heightCm;
    if (selectedButton == true) {
      heightCm = double.tryParse(heightCmController.text) ?? 0.0;
      // weightKg = weightKg * 2.20462;
    } else {
      heightCm = (height * 12) + heightInch;
      weightKg = weightKg * 0.453592;
    }

    int age = int.tryParse(ageController.text) ?? 0;
    print("heightCm $heightCm $heightInch");
    if (selectedGender == Gender.male) {
      if (selectedButton == true) {
        bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
      } else {
        bmr = (9 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
      }

      print(10 * weightKg);
      print(heightCm);
      print(6.25 * heightCm);
      print(5 * age);
      print(bmr);
      // bmr = 13.397 * weightKg + 4.799 * heightCm - 5.677 * age + 88.362;
    } else {
      bmr = 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
    }

    switch (activityLevel) {
      case ActivityLevel.basalMetabolicRate:
        result = bmr * 1.1; // Basal Metabolic Rate
        break;
      case ActivityLevel.sedentary:
        result = bmr * 1.2; // little or no exercise
        break;
      case ActivityLevel.lightlyActive:
        result = bmr * 1.375; // exercise 1-3 times/weeks
        break;
      case ActivityLevel.moderatelyActive:
        result = bmr * 1.465; // Exercise 4-5 times/week
        break;
      case ActivityLevel.active:
        result =
            bmr * 1.55; // daily exercise or intense exercise 3-4 times/week
        break;
      case ActivityLevel.veryActive:
        result = bmr * 1.725; // intese exercise 6-7 times/week
        break;
      case ActivityLevel.extraActive:
        result = bmr * 1.9; // very intense exercise daily or physical job
        break;
    }
     // Calculate percentage of BMR
    setState(() {
      calculatedCalories = result.round();
      // Calculate weight loss calories
      weightLossCalories['Maintain weight'] = calculatedCalories;
      weightLossCalories['Mild weight loss (0.5 kg/week)'] =
          (calculatedCalories * 0.84).round();
      weightLossCalories['Weight loss (1 kg/week)'] =
          (calculatedCalories * 0.67).round();
      weightLossCalories['Extreme weight loss (2 kg/week)'] =
          (calculatedCalories * 0.35).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.find<AdService>().loadBannerAd();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Calorie Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      bottomNavigationBar: adController.getBannerAdWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                          controller: ageController,
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
                    value: selectedGender == Gender.male,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value! ? Gender.male : selectedGender;
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
                      controller: selectedButton == true
                          ? heightCmController
                          : heightFeetController,
                      keyboardType: TextInputType.number,
                      paddingNeed: true,
                      hint: selectedButton == true ? "Feet" : "cm",
                      textAlign: TextAlign.start),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Visibility(
                    visible: selectedButton == true ? true : false,
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
                      globalText16(text: "Weight", fontWeight: FontWeight.w500),
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
                  value: activityLevel,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      activityLevel = value!;
                    });
                  },
                  items: ActivityLevel.values.map((activity) {
                    String activityText;
                    switch (activity) {
                      case ActivityLevel.basalMetabolicRate:
                        activityText = 'Basal Metabolic Rate';
                        break;
                      case ActivityLevel.sedentary:
                        activityText = 'Sedentary: little or no exercise';
                        break;
                      case ActivityLevel.lightlyActive:
                        activityText = 'Light: exercise 1-3 times/week';
                        break;
                      case ActivityLevel.moderatelyActive:
                        activityText = 'Moderate: Exercise 4-5 times/week';
                        break;
                      case ActivityLevel.active:
                        activityText =
                            'Active: daily exercise or intense exercise 3-4 times/week';
                        break;
                      case ActivityLevel.veryActive:
                        activityText =
                            'Very Active: intense exercise 6-7 times/week';
                        break;
                      case ActivityLevel.extraActive:
                        activityText =
                            'Extra Active: very intense exercise daily or physical job';
                        break;
                    }
                    return DropdownMenuItem<ActivityLevel>(
                      value: activity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: globalText12(
                            text: activityText, fontWeight: FontWeight.normal),
                      ),
                    );
                  }).toList(),
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
                  if (ageController.text.isEmpty) {
                    errorToast(context: context, msg: "Please enter age");
                  } else if (heightFeetController.text.isEmpty &&
                      selectedButton == false) {
                    errorToast(context: context, msg: "Please enter feet");
                  } else if (heightInchesController.text.isEmpty &&
                      selectedButton == false) {
                    errorToast(context: context, msg: "Please enter inch");
                  } else if (selectedButton == true &&
                      heightCmController.text.isEmpty) {
                  } else if (weightKgController.text.isEmpty) {
                    errorToast(context: context, msg: "Please enter weight");
                  } else {
                    calculateCalories();
                    RouteGenerator().pushNamedSms(
                        context, Routes.calorieResultScreen,
                        arguments: [
                          weightLossCalories['Maintain weight'],
                          weightLossCalories['Mild weight loss (0.5 kg/week)'],
                          weightLossCalories['Weight loss (1 kg/week)'],
                          weightLossCalories['Extreme weight loss (2 kg/week)'],
                          selectedButton
                        ]);
                  }
                }),

            // SizedBox(height: 16.0),
            // Text(
            //   'Calculated Calories:',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // Text(
            //     'Maintain weight: ${weightLossCalories['Maintain weight']} Calories/day'),
            // Text(
            //     'Mild weight loss (0.5 kg/week): ${weightLossCalories['Mild weight loss (0.5 kg/week)']} Calories/day'),
            // Text(
            //     'Weight loss (1 kg/week): ${weightLossCalories['Weight loss (1 kg/week)']} Calories/day'),
            // Text(
            //     'Extreme weight loss (2 kg/week): ${weightLossCalories['Extreme weight loss (2 kg/week)']} Calories/day'),
          ],
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
