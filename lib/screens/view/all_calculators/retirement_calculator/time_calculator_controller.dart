import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../../toast/toast.dart';

class TimeCalculatorController extends GetxController {
  var daysController1 = TextEditingController().obs;
  var hoursController1 = TextEditingController().obs;
  var minutesController1 = TextEditingController().obs;
  var secondsController1 = TextEditingController().obs;
  var daysController2 = TextEditingController().obs;
  var hoursController2 = TextEditingController().obs;
  var minutesController2 = TextEditingController().obs;
  var secondsController2 = TextEditingController().obs;
  var numberController = TextEditingController().obs;
  var selectedOperation = '+ Add'.obs;
  var result = ''.obs;

  void calculate() {
    if (daysController1.value.text.isEmpty &&
        hoursController1.value.text.isEmpty &&
        minutesController1.value.text.isEmpty &&
        secondsController1.value.text.isEmpty &&
        daysController2.value.text.isEmpty &&
        hoursController2.value.text.isEmpty &&
        minutesController2.value.text.isEmpty &&
        secondsController2.value.text.isEmpty &&
        (selectedOperation.value == '+ Add' ||
            selectedOperation.value == '- Subtract' ||
            selectedOperation.value == '÷ Divide by time')) {
      errorToast(context: navigatorKey.currentContext!, msg: "Please fill up all field");
    }else if(numberController.value.text.isEmpty && (selectedOperation.value ==
        '× Multiply by a number' ||
        selectedOperation.value == '÷ Divide by a number')){
      errorToast(context: navigatorKey.currentContext!, msg: "Please fill up all field");
    }else {
      int days1 = int.tryParse(daysController1.value.text) ?? 0;
      int hours1 = int.tryParse(hoursController1.value.text) ?? 0;
      int minutes1 = int.tryParse(minutesController1.value.text) ?? 0;
      int seconds1 = int.tryParse(secondsController1.value.text) ?? 0;

      Duration duration1 = Duration(
        days: days1,
        hours: hours1,
        minutes: minutes1,
        seconds: seconds1,
      );

      Duration resultDuration;
      String resultText = '';

      switch (selectedOperation.value) {
        case '+ Add':
          int days2 = int.tryParse(daysController2.value.text) ?? 0;
          int hours2 = int.tryParse(hoursController2.value.text) ?? 0;
          int minutes2 = int.tryParse(minutesController2.value.text) ?? 0;
          int seconds2 = int.tryParse(secondsController2.value.text) ?? 0;

          Duration duration2 = Duration(
            days: days2,
            hours: hours2,
            minutes: minutes2,
            seconds: seconds2,
          );

          resultDuration = duration1 + duration2;
          resultText = formatDuration(resultDuration);
          break;
        case '- Subtract':
          int days2 = int.tryParse(daysController2.value.text) ?? 0;
          int hours2 = int.tryParse(hoursController2.value.text) ?? 0;
          int minutes2 = int.tryParse(minutesController2.value.text) ?? 0;
          int seconds2 = int.tryParse(secondsController2.value.text) ?? 0;

          Duration duration2 = Duration(
            days: days2,
            hours: hours2,
            minutes: minutes2,
            seconds: seconds2,
          );

          resultDuration = duration1 - duration2;
          resultText = formatDuration(resultDuration);
          break;
        case '× Multiply by a number':
          int multiplier = int.tryParse(numberController.value.text) ?? 1;
          resultDuration = duration1 * multiplier;
          resultText = formatDuration(resultDuration);
          break;
        case '÷ Divide by a number':
          int divisor = int.tryParse(numberController.value.text) ?? 1;
          resultDuration = duration1 ~/ divisor;
          resultText = formatDuration(resultDuration);
          break;
        case '÷ Divide by time':
          int days2 = int.tryParse(daysController2.value.text) ?? 0;
          int hours2 = int.tryParse(hoursController2.value.text) ?? 0;
          int minutes2 = int.tryParse(minutesController2.value.text) ?? 0;
          int seconds2 = int.tryParse(secondsController2.value.text) ?? 0;

          Duration duration2 = Duration(
            days: days2,
            hours: hours2,
            minutes: minutes2,
            seconds: seconds2,
          );

          double divisionResult = duration1.inSeconds / duration2.inSeconds;
          int wholeTimes = duration1.inSeconds ~/ duration2.inSeconds;
          Duration remainderDuration =
          Duration(seconds: duration1.inSeconds % duration2.inSeconds);

          resultText =
              formatDivisionResult(
                  divisionResult, wholeTimes, remainderDuration);
          break;
        default:
          resultText = 'Invalid operation';
      }

      result.value = resultText;
    }
  }

  String formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    double totalDays = duration.inSeconds / (24 * 3600);
    double totalHours = duration.inSeconds / 3600;
    double totalMinutes = duration.inSeconds / 60;
    double totalSeconds = duration.inSeconds.toDouble();

    return '''
Answer:

$days days $hours hours $minutes minutes $seconds seconds

= ${totalDays.toStringAsFixed(5)} total days
= ${totalHours.toStringAsFixed(5)} total hours
= ${totalMinutes.toStringAsFixed(5)} total minutes
= ${totalSeconds.toStringAsFixed(0)} total seconds

Alternative Total:
${days ~/ 7} weeks ${days % 7} days $hours hours $minutes minutes $seconds seconds
    ''';
  }

  String formatDivisionResult(
      double divisionResult, int wholeTimes, Duration remainderDuration) {
    int days = remainderDuration.inDays;
    int hours = remainderDuration.inHours.remainder(24);
    int minutes = remainderDuration.inMinutes.remainder(60);
    int seconds = remainderDuration.inSeconds.remainder(60);

    return '''
Answer:
= ${divisionResult.toStringAsFixed(4)} times
or
= $wholeTimes times with a remainder of
$days days $hours hours $minutes minutes $seconds seconds
    ''';
  }

  allFieldClear() {}
}
