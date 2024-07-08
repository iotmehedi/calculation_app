import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';

class SalaryController extends GetxController {
  var formKey = GlobalKey<FormState>().obs;

  var selectedInterval = 'Hour'.obs;
  var salaryController = TextEditingController().obs;
  var hoursPerWeekController = TextEditingController().obs;
  var daysPerWeekController = TextEditingController().obs;
  var holidaysPerYearController = TextEditingController().obs;
  var vacationDaysPerYearController = TextEditingController().obs;

  var intervals = [
    'Hour',
    'Day',
    'Week',
    'Biweek',
    'Semi-month',
    'Month',
    'Quarter',
    'Year'
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
  var hourlySalary = 0.0.obs;
  var dailySalary = 0.0.obs;
  var weeklySalary = 0.0.obs;
  var biweeklySalary = 0.0.obs;
  var semimonthlySalary = 0.0.obs;
  var monthlySalary = 0.0.obs;
  var quarterlySalary = 0.0.obs;
  var annualSalary = 0.0.obs;
  var hourlyRateUnadjusted = 0.0.obs;
  var dailyRateUnadjusted = 0.0.obs;
  var weeklyRateUnadjusted = 0.0.obs;
  var biweeklyRateUnadjusted = 0.0.obs;
  var semimonthlyRateUnadjusted = 0.0.obs;
  var monthlyRateUnadjusted = 0.0.obs;
  var quarterlyRateUnadjusted = 0.0.obs;
  var annuallyUnadjusted = 0.0.obs;
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
        case 'Day':
          salary.value /= (hoursPerWeek.value / daysPerWeek.value);
          break;
        case 'Week':
          salary.value /= hoursPerWeek.value;
          break;
        case 'Biweek':
          salary.value /= (hoursPerWeek * 2);
          break;
        case 'Semi-month':
          salary.value /= (hoursPerWeek * weeksPerYear.value / 24);
          break;
        case 'Month':
          salary.value /= (hoursPerWeek * weeksPerYear.value / 12);
          break;
        case 'Quarter':
          salary.value /= (hoursPerWeek * weeksPerYear.value / 4);
          break;
        case 'Year':
          salary.value /= (hoursPerWeek * weeksPerYear.value);
          break;
        default:
          break;
      }

      // Unadjusted Salaries Calculation
      unadjustedSalaries.value = {
        'Hour': salary,
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

    }
  }
  void calculateSalaryAdjusted() {
    final double salaryAmount = double.tryParse(salaryController.value.text) ?? 0.0;
    final int hoursPerWeek = int.tryParse(hoursPerWeekController.value.text) ?? 0;
    final int daysPerWeek = int.tryParse(daysPerWeekController.value.text) ?? 0;
    final int holidaysPerYear = int.tryParse(holidaysPerYearController.value.text) ?? 0;
    final int vacationDaysPerYear = int.tryParse(vacationDaysPerYearController.value.text) ?? 0;

    const int totalWeeksInYear = 52;
    const int workingDaysPerWeek = 5;

    final int totalWorkingDaysPerYear = (totalWeeksInYear * workingDaysPerWeek) ;
    final double totalWorkingHoursPerYear = (totalWorkingDaysPerYear * hoursPerWeek) / daysPerWeek;



    switch (selectedInterval.value) {
      case 'Hour':
        annualSalary.value = totalWorkingHoursPerYear * salaryAmount;
        break;
      case 'Day':
        annualSalary.value = totalWorkingDaysPerYear * salaryAmount;
        break;
      case 'Week':
        annualSalary.value = totalWeeksInYear * salaryAmount;
        break;
      case 'Biweek':
        annualSalary.value = (totalWeeksInYear / 2) * salaryAmount;
        break;
      case 'Semi-month':
        annualSalary.value = 24 * salaryAmount;
        break;
      case 'Month':
        annualSalary.value = 12 * salaryAmount;
        break;
      case 'Quarter':
        annualSalary.value = 4 * salaryAmount;
        break;
      case 'Year':
        annualSalary.value = salaryAmount;
        break;
      default:
        break;
    }

    hourlySalary.value = annualSalary / totalWorkingHoursPerYear;
    dailySalary.value = annualSalary / totalWorkingDaysPerYear;
    weeklySalary.value = annualSalary / totalWeeksInYear;
    biweeklySalary.value = annualSalary / (totalWeeksInYear / 2);
    semimonthlySalary.value = annualSalary / 24;
    monthlySalary.value = annualSalary / 12;
    quarterlySalary.value = annualSalary / 4;

  }

  void calculateSalaryUnadjusted() {
    final double salary = double.tryParse(salaryController.value.text) ?? 0.0;
    final double hoursPerWeek = double.tryParse(hoursPerWeekController.value.text) ?? 0.0;
    final double daysPerWeek = double.tryParse(daysPerWeekController.value.text) ?? 0.0;

    double annualSalaryUnadjusted = 0;

    switch (selectedInterval.value) {
      case 'Hour':
        annualSalaryUnadjusted = (salary) * hoursPerWeek * 52;
        break;
      case 'Day':
        annualSalaryUnadjusted = salary * daysPerWeek * 52;
        break;
      case 'Week':
        annualSalaryUnadjusted = (salary / 100) * 52;
        break;
      case 'Biweek':
        annualSalaryUnadjusted = salary * 26;
        break;
      case 'Semi-month':
        annualSalaryUnadjusted = salary * 24;
        break;
      case 'Month':
        annualSalaryUnadjusted = salary * 12;
        break;
      case 'Quarter':
        annualSalaryUnadjusted = salary * 4;
        break;
      case 'Year':
        annualSalaryUnadjusted = salary;
        break;
      default:
        annualSalaryUnadjusted = 0;
        break;
    }

    hourlyRateUnadjusted.value = annualSalaryUnadjusted / (hoursPerWeek * 52);
    dailyRateUnadjusted.value = annualSalaryUnadjusted / (daysPerWeek * 52);
    weeklyRateUnadjusted.value = annualSalaryUnadjusted / 52;
    biweeklyRateUnadjusted.value = annualSalaryUnadjusted / 26;
    semimonthlyRateUnadjusted.value = annualSalaryUnadjusted / 24;
    monthlyRateUnadjusted.value = annualSalaryUnadjusted / 12;
    quarterlyRateUnadjusted.value = annualSalaryUnadjusted / 4;
    annuallyUnadjusted.value = annualSalaryUnadjusted;
  }



  void allFieldClear(){
    salaryController.value.clear();
    hoursPerWeekController.value.clear();
    daysPerWeekController.value.clear();
    holidaysPerYearController.value.clear();
    vacationDaysPerYearController.value.clear();
  }
}
