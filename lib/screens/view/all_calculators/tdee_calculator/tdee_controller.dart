import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
          activityFactor = 1.683;
        } else {
          activityFactor = 1.425;
        }
        break;
      case ActivityLevel.sedentary:
        if (isMetric.value == false) {
          activityFactor = 2.071;
        } else {
          activityFactor = 1.71;
        }
        break;
      case ActivityLevel.lightlyActive:
        if (isMetric.value == false) {
          activityFactor = 2.373;
        } else {
          activityFactor = 1.959;
        }
        break;
      case ActivityLevel.moderatelyActive:
        if (isMetric.value == false) {
          activityFactor = 2.528;
        } else {
          activityFactor = 2.088;
        }
        break;
      case ActivityLevel.active:
        if (isMetric.value == false) {
          activityFactor = 2.67;
        } else {
          activityFactor = 2.21;
        }
        break;
      case ActivityLevel.veryActive:

        if (isMetric.value == false) {
          activityFactor = 2.972;
        } else {
          activityFactor = 2.46;
        }
        break;
      case ActivityLevel.extraActive:
        if (isMetric.value == false) {
          activityFactor = 3.28;
          print("extra");
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
      mildWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.88));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.76));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.61));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.12));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.2394));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.479));
    } else if (activityLevel.value == ActivityLevel.sedentary &&
        isMetric.value == true) {
      mildWeightLoss.value = NumberFormat(',###', 'en_US').format(((tdee * 0.881) - 1));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.76 + 1));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.61));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.12));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.2394));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.479));
      print("this is activity ${activityLevel.value}");
    } else if (activityLevel.value == ActivityLevel.lightlyActive &&
        isMetric.value == true) {
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.896) - 1));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.791));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.7));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.1 + 11));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.21 - 2));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.418));
    } else if (activityLevel.value == ActivityLevel.moderatelyActive &&
        isMetric.value == true) {
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.9) + 5));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.8 + 10));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.61 - 6));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.098));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.196));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.392));
    } else if (activityLevel.value == ActivityLevel.active &&
        isMetric.value == true) {
      NumberFormat numberFormat = NumberFormat(',###', 'en_US');
      String tdeeValueWithoutCommas = tdeeResult.value.replaceAll(',', '');
      int parsedValue = int.parse(tdeeValueWithoutCommas);
      int result = parsedValue - 2;
      String formattedValue = numberFormat.format(result);
      tdeeResult.value = formattedValue;
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.91) - 9));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.8 + 10));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.63 - 4));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.092 - 1));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.184 + 1));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.37 - 1));
    } else if (activityLevel.value == ActivityLevel.veryActive &&
        isMetric.value == true) {
      NumberFormat numberFormat = NumberFormat(',###', 'en_US');
      String tdeeValueWithoutCommas = tdeeResult.value.replaceAll(',', '');
      int parsedValue = int.parse(tdeeValueWithoutCommas);
      int result = parsedValue - 3;
      String formattedValue = numberFormat.format(result);
      tdeeResult.value = formattedValue;
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.919) - 9));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.833));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.667 - 2));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.08 + 7));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.166 - 1));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.332));
    } else if (activityLevel.value == ActivityLevel.extraActive &&
        isMetric.value == true) {
      NumberFormat numberFormat = NumberFormat(',###', 'en_US');
      String tdeeValueWithoutCommas = tdeeResult.value.replaceAll(',', '');
      int parsedValue = int.parse(tdeeValueWithoutCommas);
      int result = parsedValue - 4;
      String formattedValue = numberFormat.format(result);
      tdeeResult.value = formattedValue;
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.923 + 1)));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.848 - 1));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.697 - 1));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.074 + 1));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.15));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.3 + 4));
    } else if (activityLevel.value == ActivityLevel.extraActive &&
        isMetric.value == false) {
      NumberFormat numberFormat = NumberFormat(',###', 'en_US');
      String tdeeValueWithoutCommas = tdeeResult.value.replaceAll(',', '');
      int parsedValue = int.parse(tdeeValueWithoutCommas);
      int result = parsedValue - 1;
      String formattedValue = numberFormat.format(result);
      tdeeResult.value = formattedValue;
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.92 + 1)));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.841 - 1));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.682 - 1));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.079));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.16 - 4));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.318 - 2));
    }
    else if (activityLevel.value == ActivityLevel.veryActive &&
        isMetric.value == false) {
      NumberFormat numberFormat = NumberFormat(',###', 'en_US');
      String tdeeValueWithoutCommas = tdeeResult.value.replaceAll(',', '');
      int parsedValue = int.parse(tdeeValueWithoutCommas);
      int result = parsedValue + 4;
      String formattedValue = numberFormat.format(result);
      tdeeResult.value = formattedValue;
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.915 - 3)));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.826));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.651 - 1));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.09 - 2));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.1767 + 1));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.3528 - 1));
    }
    else if (activityLevel.value == ActivityLevel.active &&
        isMetric.value == false) {
      NumberFormat numberFormat = NumberFormat(',###', 'en_US');
      String tdeeValueWithoutCommas = tdeeResult.value.replaceAll(',', '');
      int parsedValue = int.parse(tdeeValueWithoutCommas);
      int result = parsedValue + 4;
      String formattedValue = numberFormat.format(result);
      tdeeResult.value = formattedValue;
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.91 - 15)));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.81 - 9));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.611 ));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.1 - 2));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.197));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.392));
    }
    else if (activityLevel.value == ActivityLevel.moderatelyActive &&
        isMetric.value == false) {
      NumberFormat numberFormat = NumberFormat(',###', 'en_US');
      String tdeeValueWithoutCommas = tdeeResult.value.replaceAll(',', '');
      int parsedValue = int.parse(tdeeValueWithoutCommas);
      int result = parsedValue;
      String formattedValue = numberFormat.format(result);
      tdeeResult.value = formattedValue;
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.897)));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.794));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.611 ));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.1 + 8));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.21 - 9));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.412 + 1));
    }
    else if (activityLevel.value == ActivityLevel.lightlyActive &&
        isMetric.value == false) {
      NumberFormat numberFormat = NumberFormat(',###', 'en_US');
      String tdeeValueWithoutCommas = tdeeResult.value.replaceAll(',', '');
      int parsedValue = int.parse(tdeeValueWithoutCommas);
      int result = parsedValue;
      String formattedValue = numberFormat.format(result);
      tdeeResult.value = formattedValue;
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.89)));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.78 + 1));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.611 ));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.11));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.2196));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.4394));
    }
    else if (activityLevel.value == ActivityLevel.sedentary &&
        isMetric.value == false) {
      NumberFormat numberFormat = NumberFormat(',###', 'en_US');
      String tdeeValueWithoutCommas = tdeeResult.value.replaceAll(',', '');
      int parsedValue = int.parse(tdeeValueWithoutCommas);
      int result = parsedValue - 2;
      String formattedValue = numberFormat.format(result);
      tdeeResult.value = formattedValue;
      mildWeightLoss.value = (NumberFormat(',###', 'en_US').format((tdee * 0.874)));
      weightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.78 + 1));
      extremeWeightLoss.value = NumberFormat(',###', 'en_US').format((tdee * 0.611 ));
      mildWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.1254));
      weightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.252 - 1));
      extremeWeightGain.value = NumberFormat(',###', 'en_US').format((tdee * 1.5 + 6));
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
