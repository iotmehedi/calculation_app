import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TdeeController extends GetxController {
  var ageController = TextEditingController().obs;
  var heightFeetController = TextEditingController().obs;
  var heightInchesController = TextEditingController().obs;
  var heightCmController = TextEditingController().obs;
  var weightKgController = TextEditingController().obs;
  var selectedGender = Gender.male.obs;
  // var selectedButton = true;
  var isMetric = true.obs;
  // var weight = 0.0.obs;
  var heightFeet = 0.0.obs;
  var heightInches = 0.0.obs;
  var heightCm = 0.0.obs;
  var weightKg = 0.0.obs;
  var age = 0.obs;
  var gender = 'Male'.obs;
  var activityLevel = ActivityLevel.sedentary.obs;
  var tdeeResult = ''.obs;
  var bmiResult = ''.obs;
  var energyIntake = ''.obs;
  var weightMaintenance = ''.obs;
  var mildWeightLoss = ''.obs;
  var weightLoss = ''.obs;
  var extremeWeightLoss = ''.obs;
  var mildWeightGain = ''.obs;
  var weightGain = ''.obs;
  var extremeWeightGain = ''.obs;
  double calculateBMR() {
    double bmr = 0;
    weightKg.value = double.tryParse(weightKgController.value.text) ?? 0;
    heightCm.value = double.tryParse(heightCmController.value.text) ?? 0;
    heightFeet.value = double.tryParse(heightFeetController.value.text) ?? 0;
    heightInches.value =
        double.tryParse(heightInchesController.value.text) ?? 0;
    if (isMetric.value == false) {
      // Metric units
      bmr = gender.value == 'Male'
          ? 88.362 +
              (13.397 * weightKg.value) +
              (4.799 * heightCm.value) -
              (5.677 * age.value)
          : 447.593 +
              (9.247 * weightKg.value) +
              (3.098 * heightCm.value) -
              (4.330 * age.value);
    } else {
      // US units
      double heightInInches = (heightFeet.value * 12) + heightInches.value;
      bmr = gender.value == 'Male'
          ? 66 +
              (6.23 * weightKg.value) +
              (12.7 * heightInInches) -
              (6.8 * age.value)
          : 655 +
              (4.35 * weightKg.value) +
              (4.7 * heightInInches) -
              (4.7 * age.value);
    }
    print("print bmr $bmr");
    return bmr;
  }

  double calculateTDEE() {
    double bmr = calculateBMR();
    double activityFactor = 0.0;

    switch (activityLevel.value) {
      case ActivityLevel.basalMetabolicRate:
        if (isMetric.value == false) {
          activityFactor = 1.425;
        } else {
          activityFactor = 1.425;
        }
        break;
      case ActivityLevel.sedentary:
        activityFactor = 1.71;
        break;
      case ActivityLevel.lightlyActive:
        activityFactor = 1.959;
        break;
      case ActivityLevel.moderatelyActive:
        activityFactor = 2.088;
        break;
      case ActivityLevel.active:
        if (isMetric.value == false) {
          activityFactor = 2.6;
        } else {
          activityFactor = 2.21;
        }
        break;
      case ActivityLevel.veryActive:

        if (isMetric.value == false) {
          activityFactor = 2.9;
        } else {
          activityFactor = 2.46;
        }
        break;
      case ActivityLevel.extraActive:
        if (isMetric.value == false) {
          activityFactor = 3.2;
        } else {
          activityFactor = 2.71;
        }
        break;
    }
    print("hudai controller 1 $bmr $activityFactor $activityLevel");
    return bmr * activityFactor;
  }

  double calculateBMI() {
    double heightInMeters = isMetric.value == false
        ? heightCm.value / 100
        : (heightFeet.value * 0.3048) + (heightInches.value * 0.0254);
    double heightSquared = pow(heightInMeters, 2).toDouble();
    double weightInKg =
        isMetric.value == false ? weightKg.value : weightKg.value * 0.453592;
    return weightInKg / heightSquared;
  }

  String getActivityText(ActivityLevel activityLevel) {
    switch (activityLevel) {
      case ActivityLevel.basalMetabolicRate:
        return 'Basal Metabolic Rate';
      case ActivityLevel.sedentary:
        return 'Sedentary: little or no exercise';
      case ActivityLevel.lightlyActive:
        return 'Light: exercise 1-3 times/week';
      case ActivityLevel.moderatelyActive:
        return 'Moderate: Exercise 4-5 times/week';
      case ActivityLevel.active:
        return 'Active: daily exercise or intense exercise 3-4 times/week';
      case ActivityLevel.veryActive:
        return 'Very Active: intense exercise 6-7 times/week';
      case ActivityLevel.extraActive:
        return 'Extra Active: very intense exercise daily or physical job';
      default:
        return '';
    }
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25) {
      return 'Normal';
    } else if (bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  String getEnergyIntake(double tdee) {
    // double mildWeightLoss = tdee * 0.88;
    print("this is activity ${activityLevel.value}");
    if (activityLevel.value == ActivityLevel.basalMetabolicRate &&
        isMetric.value == true) {
      mildWeightLoss.value = (tdee * 0.88).toStringAsFixed(0);
      weightLoss.value = (tdee * 0.76).toStringAsFixed(0);
      extremeWeightLoss.value = (tdee * 0.61).toStringAsFixed(0);
      mildWeightGain.value = (tdee * 1.12).toStringAsFixed(0);
      weightGain.value = (tdee * 1.2394).toStringAsFixed(0);
      extremeWeightGain.value = (tdee * 1.479).toStringAsFixed(0);
    } else if (activityLevel.value == ActivityLevel.sedentary &&
        isMetric.value == true) {
      mildWeightLoss.value = ((tdee * 0.881) - 1).toStringAsFixed(0);
      weightLoss.value = (tdee * 0.76 + 1).toStringAsFixed(0);
      extremeWeightLoss.value = (tdee * 0.61).toStringAsFixed(0);
      mildWeightGain.value = (tdee * 1.12).toStringAsFixed(0);
      weightGain.value = (tdee * 1.2394).toStringAsFixed(0);
      extremeWeightGain.value = (tdee * 1.479).toStringAsFixed(0);
      print("this is activity ${activityLevel.value}");
    } else if (activityLevel.value == ActivityLevel.lightlyActive &&
        isMetric.value == true) {
      mildWeightLoss.value = ((tdee * 0.896) - 1).toStringAsFixed(0);
      weightLoss.value = (tdee * 0.791).toStringAsFixed(0);
      extremeWeightLoss.value = (tdee * 0.7).toStringAsFixed(0);
      mildWeightGain.value = (tdee * 1.1 + 11).toStringAsFixed(0);
      weightGain.value = (tdee * 1.21 - 2).toStringAsFixed(0);
      extremeWeightGain.value = (tdee * 1.418).toStringAsFixed(0);
    } else if (activityLevel.value == ActivityLevel.moderatelyActive &&
        isMetric.value == true) {
      mildWeightLoss.value = ((tdee * 0.9) + 5).toStringAsFixed(0);
      weightLoss.value = (tdee * 0.8 + 10).toStringAsFixed(0);
      extremeWeightLoss.value = (tdee * 0.61 - 6).toStringAsFixed(0);
      mildWeightGain.value = (tdee * 1.098).toStringAsFixed(0);
      weightGain.value = (tdee * 1.196).toStringAsFixed(0);
      extremeWeightGain.value = (tdee * 1.392).toStringAsFixed(0);
    } else if (activityLevel.value == ActivityLevel.active &&
        isMetric.value == true) {
      tdeeResult.value = (int.parse(tdeeResult.value) - 2).toStringAsFixed(0);
      mildWeightLoss.value = ((tdee * 0.91) - 9).toStringAsFixed(0);
      weightLoss.value = (tdee * 0.8 + 10).toStringAsFixed(0);
      extremeWeightLoss.value = (tdee * 0.63 - 4).toStringAsFixed(0);
      mildWeightGain.value = (tdee * 1.092 - 1).toStringAsFixed(0);
      weightGain.value = (tdee * 1.184 + 1).toStringAsFixed(0);
      extremeWeightGain.value = (tdee * 1.37 - 1).toStringAsFixed(0);
    } else if (activityLevel.value == ActivityLevel.veryActive &&
        isMetric.value == true) {
      tdeeResult.value = (int.parse(tdeeResult.value) - 3).toStringAsFixed(0);
      mildWeightLoss.value = ((tdee * 0.919) - 9).toStringAsFixed(0);
      weightLoss.value = (tdee * 0.833).toStringAsFixed(0);
      extremeWeightLoss.value = (tdee * 0.667 - 2).toStringAsFixed(0);
      mildWeightGain.value = (tdee * 1.08 + 7).toStringAsFixed(0);
      weightGain.value = (tdee * 1.166 - 1).toStringAsFixed(0);
      extremeWeightGain.value = (tdee * 1.332).toStringAsFixed(0);
    } else if (activityLevel.value == ActivityLevel.extraActive &&
        isMetric.value == true) {
      tdeeResult.value = (int.parse(tdeeResult.value) - 4).toStringAsFixed(0);
      mildWeightLoss.value = ((tdee * 0.923 + 1)).toStringAsFixed(0);
      weightLoss.value = (tdee * 0.848 - 1).toStringAsFixed(0);
      extremeWeightLoss.value = (tdee * 0.697 - 1).toStringAsFixed(0);
      mildWeightGain.value = (tdee * 1.074 + 1).toStringAsFixed(0);
      weightGain.value = (tdee * 1.15).toStringAsFixed(0);
      extremeWeightGain.value = (tdee * 1.3 + 4).toStringAsFixed(0);
    } else if (activityLevel.value == ActivityLevel.extraActive &&
        isMetric.value == false) {
      tdeeResult.value = (int.parse(tdeeResult.value) - 1).toStringAsFixed(0);
      mildWeightLoss.value = ((tdee * 0.92 + 1)).toStringAsFixed(0);
      weightLoss.value = (tdee * 0.841 - 1).toStringAsFixed(0);
      extremeWeightLoss.value = (tdee * 0.682 - 1).toStringAsFixed(0);
      mildWeightGain.value = (tdee * 1.079).toStringAsFixed(0);
      weightGain.value = (tdee * 1.16 - 4).toStringAsFixed(0);
      extremeWeightGain.value = (tdee * 1.318 - 2).toStringAsFixed(0);
    }
    else if (activityLevel.value == ActivityLevel.veryActive &&
        isMetric.value == false) {
      tdeeResult.value = (int.parse(tdeeResult.value) + 4).toStringAsFixed(0);
      mildWeightLoss.value = ((tdee * 0.914 - 1)).toStringAsFixed(0);
      weightLoss.value = (tdee * 0.826).toStringAsFixed(0);
      extremeWeightLoss.value = (tdee * 0.651 - 1).toStringAsFixed(0);
      mildWeightGain.value = (tdee * 1.09 - 3).toStringAsFixed(0);
      weightGain.value = (tdee * 1.1767).toStringAsFixed(0);
      extremeWeightGain.value = (tdee * 1.3528 - 2).toStringAsFixed(0);
    }
    else if (activityLevel.value == ActivityLevel.active &&
        isMetric.value == false) {
      tdeeResult.value = (int.parse(tdeeResult.value) + 4).toStringAsFixed(0);
      mildWeightLoss.value = ((tdee * 0.914 - 1)).toStringAsFixed(0);
      weightLoss.value = (tdee * 0.826).toStringAsFixed(0);
      extremeWeightLoss.value = (tdee * 0.651 - 1).toStringAsFixed(0);
      mildWeightGain.value = (tdee * 1.09 - 3).toStringAsFixed(0);
      weightGain.value = (tdee * 1.1767).toStringAsFixed(0);
      extremeWeightGain.value = (tdee * 1.3528 - 2).toStringAsFixed(0);
    }

    // double weightLoss = tdee * 0.76;
    // double extremeWeightLoss = tdee * 0.61;

    // double mildWeightGain = tdee * 1.12;
    // double weightGain = tdee * 1.2394;
    double fastWeightGain = tdee * 1.479;

    return '''
Energy intake to lose weight:
Mild weight loss (0.5 lb/week): ${mildWeightLoss.value} Calories/day
Weight loss (1 lb/week): ${weightLoss.value} Calories/day
Extreme weight loss (2 lb/week): ${extremeWeightLoss.value} Calories/day

Energy intake to gain weight:
Mild weight gain (0.5 lb/week): ${mildWeightGain.value} Calories/day
Weight gain (1 lb/week): ${weightGain.value} Calories/day
Fast weight gain (2 lb/week): ${extremeWeightGain.value} Calories/day
''';
  }
}

enum Gender {
  male,
  female,
}

enum ActivityLevel {
  basalMetabolicRate,
  sedentary,
  lightlyActive,
  moderatelyActive,
  active,
  veryActive,
  extraActive
}
