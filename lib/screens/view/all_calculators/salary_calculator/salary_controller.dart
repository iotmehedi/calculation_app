import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class SalaryController extends GetxController {
  var formKey = GlobalKey<FormState>().obs;

  var selectedInterval = 'Hourly'.obs;
  var salaryController = TextEditingController().obs;
  var hoursPerWeekController = TextEditingController().obs;
  var daysPerWeekController = TextEditingController().obs;
  var holidaysPerYearController = TextEditingController().obs;
  var vacationDaysPerYearController = TextEditingController().obs;

  var intervals = [
    'Hourly',
    'Daily',
    'Weekly',
    'Biweekly',
    'Semi-monthly',
    'Monthly',
    'Quarterly',
    'Yearly'
  ].obs;

  var unadjustedSalaries = {}.obs;
  var adjustedSalaries = {}.obs;
  var salary = 0.0.obs;
  var hoursPerWeek = 0.0.obs;
  var daysPerWeek = 0.0.obs;
  var holidaysPerYear = 0.0.obs;
  var vacationDaysPerYear = 0.0.obs;
  var weeksPerYear = 0.0.obs;
  var workDaysPerYear = 0.0.obs;
  var workHoursPerYear = 0.0.obs;
  var totalNonWorkingDays = 0.0.obs;
  var adjustedWorkDaysPerYear = 0.0.obs;
  var adjustedWorkHoursPerYear = 0.0.obs;
  var annualAdjustedSalary = 0.0.obs;
  var adjustedHourlySalary = 0.0.obs;
  void calculateSalaries() {
    if (formKey.value.currentState!.validate()) {
      salary.value = double.parse(salaryController.value.text);
      hoursPerWeek.value = double.parse(hoursPerWeekController.value.text);
      daysPerWeek.value = double.parse(daysPerWeekController.value.text);
      holidaysPerYear.value = double.parse(holidaysPerYearController.value.text);
      vacationDaysPerYear.value = double.parse(vacationDaysPerYearController.value.text);
      weeksPerYear.value = 52;
      workDaysPerYear.value = daysPerWeek * weeksPerYear.value;
      workHoursPerYear.value = hoursPerWeek * weeksPerYear.value;
      totalNonWorkingDays.value = holidaysPerYear.value + vacationDaysPerYear.value;
      adjustedWorkDaysPerYear.value = workDaysPerYear.value - totalNonWorkingDays.value;
      adjustedWorkHoursPerYear.value = adjustedWorkDaysPerYear * (hoursPerWeek / daysPerWeek.value);

      // Convert the input salary to hourly if it's not hourly
      switch (selectedInterval.value) {
        case 'Daily':
          salary.value /= (hoursPerWeek.value / daysPerWeek.value);
          break;
        case 'Weekly':
          salary.value /= hoursPerWeek.value;
          break;
        case 'Biweekly':
          salary.value /= (hoursPerWeek * 2);
          break;
        case 'Semi-monthly':
          salary.value /= (hoursPerWeek * weeksPerYear.value / 24);
          break;
        case 'Monthly':
          salary.value /= (hoursPerWeek * weeksPerYear.value / 12);
          break;
        case 'Quarterly':
          salary.value /= (hoursPerWeek * weeksPerYear.value / 4);
          break;
        case 'Yearly':
          salary.value /= (hoursPerWeek * weeksPerYear.value);
          break;
        default:
          break;
      }

      // Unadjusted Salaries Calculation
      unadjustedSalaries.value = {
        'Hourly': salary,
        'Daily': salary * hoursPerWeek.value / daysPerWeek.value,
        'Weekly': salary * hoursPerWeek.value,
        'Biweekly': salary * hoursPerWeek.value * 2,
        'Semi-monthly': salary * hoursPerWeek.value * weeksPerYear.value / 24,
        'Monthly': salary * hoursPerWeek.value * weeksPerYear.value / 12,
        'Quarterly': salary * hoursPerWeek.value * weeksPerYear.value / 4,
        'Yearly': salary * hoursPerWeek.value * weeksPerYear.value,
      };

      // Adjusted Salaries Calculation
      annualAdjustedSalary.value = salary.value * adjustedWorkHoursPerYear.value;
      adjustedHourlySalary.value = annualAdjustedSalary.value / workHoursPerYear.value;

      adjustedSalaries.value = {
        'Hourly': adjustedHourlySalary.value,
        'Daily': adjustedHourlySalary.value * (hoursPerWeek / daysPerWeek.value),
        'Weekly': adjustedHourlySalary.value * hoursPerWeek.value,
        'Biweekly': adjustedHourlySalary.value * hoursPerWeek.value * 2,
        'Semi-monthly': annualAdjustedSalary.value / 24,
        'Monthly': annualAdjustedSalary.value / 12,
        'Quarterly': annualAdjustedSalary.value / 4,
        'Yearly': annualAdjustedSalary.value,
      };
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.salaryCalculatorResultScreen);
    }
  }



  void allFieldClear(){
    salaryController.value.clear();
    hoursPerWeekController.value.clear();
    daysPerWeekController.value.clear();
    holidaysPerYearController.value.clear();
    vacationDaysPerYearController.value.clear();
  }
}
