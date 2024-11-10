import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../../main.dart';
import '../../../../toast/toast.dart';

class PregnancyCalculatorPage extends StatefulWidget {
  @override
  _PregnancyCalculatorPageState createState() =>
      _PregnancyCalculatorPageState();
}

class _PregnancyCalculatorPageState extends State<PregnancyCalculatorPage> {
  String _timeline = '';
  String _selectedMethod = 'Last Period';
  int _cycleLength = 28;
  int _selectedMonth = DateTime.now().month;
  int _selectedDay = DateTime.now().day;
  int _selectedYear = DateTime.now().year;
  String selectedOption = '1';
  List<Map<String, Object>> milestones = [{}];
  List<Map<String, Object>> milestones2 = [{}]; //this is value
  List<Map<String, Object>> milestones3 = [{}];
  DateTime dueDate = DateTime.now();
  var firstTrimesterEnd = DateTime.now();
  var secondTrimesterEnd = DateTime.now();
  var thirdTrimesterStart = DateTime.now();
  // List<Tuple2<String, DateTime>>? milestones;
  List<int> _daysInMonth(int year, int month) {
    return List<int>.generate(DateTime(year, month + 1, 0).day, (i) => i + 1);
  }

  List<int> _years() {
    return List<int>.generate(101, (i) => 2000 + i);
  }

  List<String> _months() {
    return [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
  }

  DateTime get _selectedDate {
    return DateTime(_selectedYear, _selectedMonth, _selectedDay);
  }

  int calculateWeekDifference(
      int selectedYear, int selectedMonth, int selectedDay) {
    // Step 1: Create the selected date
    DateTime selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);

    // Step 2: Get the current date
    DateTime currentDate = DateTime.now();

    // Step 3: Calculate the difference in days
    Duration difference = currentDate.difference(selectedDate);

    // Step 4: Convert the difference into weeks
    int weekDifference = (difference.inDays / 7).floor();

    return weekDifference;
  }

  void _calculateTimeline() {
    switch (_selectedMethod) {
      case 'Last Period':
        dueDate = _selectedDate.add(Duration(days: _cycleLength + 280 - 28));
        print("this is print $dueDate");
        break;
      case 'Conception Date':
        dueDate = _selectedDate.add(const Duration(days: 266));
        break;
      case 'IVF':
        dueDate = _selectedDate.add(const Duration(days: 266));
        break;
      case 'Ultra Sound':
        final int daysPregnant = (6 * 7) + 0;
        dueDate = _selectedDate.add(Duration(days: 266 - daysPregnant));
        break;
      case 'I know my due date':
        dueDate = _selectedDate;
        break;
      default:
        dueDate = _selectedDate;
    }

    if (_selectedMethod == 'Ultra Sound') {
      milestones = [
        {
          "week_name": '2 weeks',
          "weeks": dueDate.subtract(const Duration(days: 36 * 7)),
          "line1": "Your baby is",
          "line2": "conceive",
          "line3": ""
        },
        {
          "week_name": '4 weeks',
          "weeks": dueDate.subtract(const Duration(days: 34 * 7)),
          "line1": "You'll have a positive",
          "line2": "pregnancy test",
          "line3": ""
        },
        {
          "week_name": '6 weeks',
          "weeks": dueDate.subtract(const Duration(days: 32 * 7)),
          "line1": "Cells in your",
          "line2": " baby's future heart",
          "line3": "are flickering"
        },
        {
          "week_name": '6 - 8 weeks',
          "weeks": dueDate.subtract(const Duration(days: 32 * 7)),
          "line1": "you may have your ",
          "line2": "first prenatal visit",
          "line3": ""
        },
        {
          "week_name": '10 weeks',
          "weeks": dueDate.subtract(const Duration(days: 28 * 7)),
          "line1": "you'll be offered ",
          "line2": "NIPT ",
          "line3": "(Noninvasive prenantal test)"
        },
        {
          "week_name": '10 - 13 weeks',
          "weeks": dueDate.subtract(const Duration(days: 28 * 7)),
          "line1": "You can choose to have ",
          "line2": "CVS",
          "line3": " (Chorionic villus sampling)"
        },
        {
          "week_name": '11 - 14 weeks',
          "weeks": dueDate.subtract(const Duration(days: 28 * 7 - 7)),
          "line1": "You may have an ",
          "line2": "NT scan and blood test",
          "line3": ""
        },
        {
          "week_name": '12 weeks',
          "weeks": dueDate.subtract(const Duration(days: 26 * 7)),
          "line1": "You may ",
          "line2": "hear your baby's heartbeat",
          "line3": " with a Doppler"
        },
      ];
      milestones2 = [
        {
          "week_name": '15 - 20 weeks',
          "weeks": dueDate.subtract(const Duration(days: 23 * 7)),
          "line1": "You may have ",
          "line2": "anamniocentesis",
          "line3": ""
        },
        {
          "week_name": '16 - 18 weeks',
          "weeks": dueDate.subtract(const Duration(days: 22 * 7)),
          "line1": "You may have a ",
          "line2": "quad scan",
          "line3": " test"
        },
        {
          "week_name": '16 - 22 weeks',
          "weeks": dueDate.subtract(const Duration(days: 22 * 7)),
          "line1": "You can ",
          "line2": "feel your baby kick",
          "line3": ""
        },
        {
          "week_name": '18 - 22 weeks',
          "weeks": dueDate.subtract(const Duration(days: 21 * 7 - 7)),
          "line1": "You'll have a mid-pregnancy",
          "line2": " ultrasound",
          "line3": ""
        },
        {
          "week_name": '23 weeks',
          "weeks": dueDate.subtract(const Duration(days: 15 * 7)),
          "line1": "Your baby can ",
          "line2": "hear you talk",
          "line3": ""
        },
        {
          "week_name": '24 - 28 weeks',
          "weeks": dueDate.subtract(const Duration(days: 14 * 7)),
          "line1": "",
          "line2": "glucose screeing",
          "line3": ""
        },
        {
          "week_name": '27 weeks',
          "weeks": dueDate.subtract(const Duration(days: 11 * 7)),
          "line1": "You baby will ",
          "line2": "open their eyes",
          "line3": ""
        },
      ];
      milestones3 = [
        {
          "week_name": '28 weeks',
          "weeks": dueDate.subtract(const Duration(days: 10 * 7)),
          "line1": "You'll have ",
          "line2": "prenatal visits ",
          "line3": "every two weeks until 36 weeks, then weekly"
        },
        {
          "week_name": '28 weeks',
          "weeks": dueDate.subtract(const Duration(days: 10 * 7)),
          "line1": "If you're",
          "line2": " Rh negative, ",
          "line3": "you'll have a shot of Rh immune globulin (RhoGAM)"
        },
        {
          "week_name": '34 weeks',
          "weeks": dueDate.subtract(const Duration(days: 4 * 7)),
          "line1": "Your baby has ",
          "line2": "fingernails",
          "line3": ""
        },
        {
          "week_name": '36 - 37 weeks',
          "weeks": dueDate.subtract(const Duration(days: 2 * 7)),
          "line1": "You'll be screened for ",
          "line2": "Group B strep",
          "line3": ""
        },
        {
          "week_name": '37 weeks',
          "weeks": dueDate.subtract(const Duration(days: 1 * 7)),
          "line1": "Your baby is ",
          "line2": "early term",
          "line3": ""
        },
        {
          "week_name": '39 weeks',
          "weeks": dueDate.add(const Duration(days: 1 * 7)),
          "line1": "Your baby is ",
          "line2": "full term",
          "line3": ""
        },
        {
          "week_name": '40 weeks',
          "weeks": dueDate.add(const Duration(days: 2 * 7)),
          "line1": "Your ",
          "line2": "baby is due!",
          "line3": ""
        },
        {
          "week_name": '41 weeks',
          "weeks": dueDate.add(const Duration(days: 3 * 7)),
          "line1": "If your labor doesn't start, you may be",
          "line2": " induced",
          "line3": ""
        },
      ];
    } else if (_selectedMethod == 'IVF') {
      if (selectedOption == "1") {
        print("Calculation start");
        milestones = [
          {
            "week_name": '2 weeks',
            "weeks": dueDate.subtract(const Duration(days: 38 * 7 + 3)),
            "line1": "Your baby is",
            "line2": "conceive",
            "line3": ""
          },
          {
            "week_name": '4 weeks',
            "weeks": dueDate.subtract(const Duration(days: 36 * 7 + 3)),
            "line1": "You'll have a positive",
            "line2": "pregnancy test",
            "line3": ""
          },
          {
            "week_name": '6 weeks',
            "weeks": dueDate.subtract(const Duration(days: 34 * 7 + 3)),
            "line1": "Cells in your",
            "line2": " baby's future heart",
            "line3": "are flickering"
          },
          {
            "week_name": '6 - 8 weeks',
            "weeks": dueDate.subtract(const Duration(days: 34 * 7 + 3)),
            "line1": "you may have your ",
            "line2": "first prenatal visit",
            "line3": ""
          },
          {
            "week_name": '10 weeks',
            "weeks": dueDate.subtract(const Duration(days: 30 * 7 + 3)),
            "line1": "you'll be offered ",
            "line2": "NIPT ",
            "line3": "(Noninvasive prenantal test)"
          },
          {
            "week_name": '10 - 13 weeks',
            "weeks": dueDate.subtract(const Duration(days: 30 * 7 + 3)),
            "line1": "You can choose to have ",
            "line2": "CVS",
            "line3": " (Chorionic villus sampling)"
          },
          {
            "week_name": '11 - 14 weeks',
            "weeks": dueDate.subtract(const Duration(days: 29 * 7 + 3)),
            "line1": "You may have an ",
            "line2": "NT scan and blood test",
            "line3": ""
          },
          {
            "week_name": '12 weeks',
            "weeks": dueDate.subtract(const Duration(days: 28 * 7 + 3)),
            "line1": "You may ",
            "line2": "hear your baby's heartbeat",
            "line3": " with a Doppler"
          },
        ];
        milestones2 = [
          {
            "week_name": '15 - 20 weeks',
            "weeks": dueDate.subtract(const Duration(days: 25 * 7 + 3)),
            "line1": "You may have ",
            "line2": "anamniocentesis",
            "line3": ""
          },
          {
            "week_name": '16 - 18 weeks',
            "weeks": dueDate.subtract(const Duration(days: 24 * 7 + 3)),
            "line1": "You may have a ",
            "line2": "quad scan",
            "line3": " test"
          },
          {
            "week_name": '16 - 22 weeks',
            "weeks": dueDate.subtract(const Duration(days: 24 * 7 + 3)),
            "line1": "You can ",
            "line2": "feel your baby kick",
            "line3": ""
          },
          {
            "week_name": '18-22 weeks',
            "weeks": dueDate.subtract(const Duration(days: 22 * 7 + 3)),
            "line1": "You'll have a mid-pregnancy",
            "line2": " ultrasound",
            "line3": ""
          },
          {
            "week_name": '23 weeks',
            "weeks": dueDate.subtract(const Duration(days: 16 * 7 + 7 + 3)),
            "line1": "Your baby can ",
            "line2": "hear you talk",
            "line3": ""
          },
          {
            "week_name": '24 - 28 weeks',
            "weeks": dueDate.subtract(const Duration(days: 16 * 7 + 3)),
            "line1": "",
            "line2": "glucose screeing",
            "line3": ""
          },
          {
            "week_name": '27 weeks',
            "weeks": dueDate.subtract(const Duration(days: 13 * 7 + 3)),
            "line1": "You baby will ",
            "line2": "open their eyes",
            "line3": ""
          },
        ];
        milestones3 = [
          {
            "week_name": '28 weeks',
            "weeks": dueDate.subtract(const Duration(days: 12 * 7 + 3)),
            "line1": "You'll have ",
            "line2": "prenatal visits ",
            "line3": "every two weeks until 36 weeks, then weekly"
          },
          {
            "week_name": '28 weeks',
            "weeks": dueDate.subtract(const Duration(days: 12 * 7 + 3)),
            "line1": "If you're",
            "line2": " Rh negative, ",
            "line3": "you'll have a shot of Rh immune globulin (RhoGAM)"
          },
          {
            "week_name": '34 weeks',
            "weeks": dueDate.subtract(const Duration(days: 6 * 7 + 3)),
            "line1": "Your baby has ",
            "line2": "fingernails",
            "line3": ""
          },
          {
            "week_name": '36 - 37 weeks',
            "weeks": dueDate.subtract(const Duration(days: 4 * 7 + 3)),
            "line1": "You'll be screened for ",
            "line2": "Group B strep",
            "line3": ""
          },
          {
            "week_name": '37 weeks',
            "weeks": dueDate.subtract(const Duration(days: 3 * 7 + 3)),
            "line1": "Your baby is ",
            "line2": "early term",
            "line3": ""
          },
          {
            "week_name": '39 weeks',
            "weeks": dueDate.subtract(const Duration(days: 1 * 7 + 3)),
            "line1": "Your baby is ",
            "line2": "full term",
            "line3": ""
          },
          {
            "week_name": '40 weeks',
            "weeks": dueDate.subtract(const Duration(days: 0 - 7 + 7 + 3)),
            "line1": "Your ",
            "line2": "baby is due!",
            "line3": ""
          },
          {
            "week_name": '41 weeks',
            "weeks": dueDate.subtract(const Duration(days: 0 - 7 + 3)),
            "line1": "If your labor doesn't start, you may be",
            "line2": " induced",
            "line3": ""
          },
        ];
      } else {
        milestones = [
          {
            "week_name": '2 weeks',
            "weeks": dueDate.subtract(const Duration(days: 38 * 7 + 5)),
            "line1": "Your baby is",
            "line2": "conceive",
            "line3": ""
          },
          {
            "week_name": '4 weeks',
            "weeks": dueDate.subtract(const Duration(days: 36 * 7 + 5)),
            "line1": "You'll have a positive",
            "line2": "pregnancy test",
            "line3": ""
          },
          {
            "week_name": '6 weeks',
            "weeks": dueDate.subtract(const Duration(days: 34 * 7 + 5)),
            "line1": "Cells in your",
            "line2": " baby's future heart",
            "line3": "are flickering"
          },
          {
            "week_name": '6 - 8 weeks',
            "weeks": dueDate.subtract(const Duration(days: 34 * 7 + 5)),
            "line1": "you may have your ",
            "line2": "first prenatal visit",
            "line3": ""
          },
          {
            "week_name": '10 weeks',
            "weeks": dueDate.subtract(const Duration(days: 30 * 7 + 5)),
            "line1": "you'll be offered ",
            "line2": "NIPT ",
            "line3": "(Noninvasive prenantal test)"
          },
          {
            "week_name": '10 - 13 weeks',
            "weeks": dueDate.subtract(const Duration(days: 30 * 7 + 5)),
            "line1": "You can choose to have ",
            "line2": "CVS",
            "line3": " (Chorionic villus sampling)"
          },
          {
            "week_name": '11 - 14 weeks',
            "weeks": dueDate.subtract(const Duration(days: 29 * 7 + 5)),
            "line1": "You may have an ",
            "line2": "NT scan and blood test",
            "line3": ""
          },
          {
            "week_name": '12 weeks',
            "weeks": dueDate.subtract(const Duration(days: 28 * 7 + 5)),
            "line1": "You may ",
            "line2": "hear your baby's heartbeat",
            "line3": " with a Doppler"
          },
        ];
        milestones2 = [
          {
            "week_name": '15 - 20 weeks',
            "weeks": dueDate.subtract(const Duration(days: 25 * 7 + 5)),
            "line1": "You may have ",
            "line2": "anamniocentesis",
            "line3": ""
          },
          {
            "week_name": '16 - 18 weeks',
            "weeks": dueDate.subtract(const Duration(days: 24 * 7 + 5)),
            "line1": "You may have a ",
            "line2": "quad scan",
            "line3": " test"
          },
          {
            "week_name": '16 - 22 weeks',
            "weeks": dueDate.subtract(const Duration(days: 24 * 7 + 5)),
            "line1": "You can ",
            "line2": "feel your baby kick",
            "line3": ""
          },
          {
            "week_name": '18-22 weeks',
            "weeks": dueDate.subtract(const Duration(days: 22 * 7 + 5)),
            "line1": "You'll have a mid-pregnancy",
            "line2": " ultrasound",
            "line3": ""
          },
          {
            "week_name": '23 weeks',
            "weeks": dueDate.subtract(const Duration(days: 16 * 7 + 7 + 5)),
            "line1": "Your baby can ",
            "line2": "hear you talk",
            "line3": ""
          },
          {
            "week_name": '24 - 28 weeks',
            "weeks": dueDate.subtract(const Duration(days: 16 * 7 + 5)),
            "line1": "",
            "line2": "glucose screeing",
            "line3": ""
          },
          {
            "week_name": '27 weeks',
            "weeks": dueDate.subtract(const Duration(days: 13 * 7 + 5)),
            "line1": "You baby will ",
            "line2": "open their eyes",
            "line3": ""
          },
        ];
        milestones3 = [
          {
            "week_name": '28 weeks',
            "weeks": dueDate.subtract(const Duration(days: 12 * 7 + 5)),
            "line1": "You'll have ",
            "line2": "prenatal visits ",
            "line3": "every two weeks until 36 weeks, then weekly"
          },
          {
            "week_name": '28 weeks',
            "weeks": dueDate.subtract(const Duration(days: 12 * 7 + 5)),
            "line1": "If you're",
            "line2": " Rh negative, ",
            "line3": "you'll have a shot of Rh immune globulin (RhoGAM)"
          },
          {
            "week_name": '34 weeks',
            "weeks": dueDate.subtract(const Duration(days: 6 * 7 + 5)),
            "line1": "Your baby has ",
            "line2": "fingernails",
            "line3": ""
          },
          {
            "week_name": '36 - 37 weeks',
            "weeks": dueDate.subtract(const Duration(days: 4 * 7 + 5)),
            "line1": "You'll be screened for ",
            "line2": "Group B strep",
            "line3": ""
          },
          {
            "week_name": '37 weeks',
            "weeks": dueDate.subtract(const Duration(days: 3 * 7 + 5)),
            "line1": "Your baby is ",
            "line2": "early term",
            "line3": ""
          },
          {
            "week_name": '39 weeks',
            "weeks": dueDate.subtract(const Duration(days: 1 * 7 + 5)),
            "line1": "Your baby is ",
            "line2": "full term",
            "line3": ""
          },
          {
            "week_name": '40 weeks',
            "weeks": dueDate.subtract(const Duration(days: 0 - 7 + 7 + 5)),
            "line1": "Your ",
            "line2": "baby is due!",
            "line3": ""
          },
          {
            "week_name": '41 weeks',
            "weeks": dueDate.subtract(const Duration(days: 0 - 7 + 5)),
            "line1": "If your labor doesn't start, you may be",
            "line2": " induced",
            "line3": ""
          },
        ];
      }
    } else {
      milestones = [
        {
          "week_name": '2 weeks',
          "weeks": dueDate.subtract(const Duration(days: 38 * 7)),
          "line1": "Your baby is",
          "line2": "conceive",
          "line3": ""
        },
        {
          "week_name": '4 weeks',
          "weeks": dueDate.subtract(const Duration(days: 36 * 7)),
          "line1": "You'll have a positive",
          "line2": "pregnancy test",
          "line3": ""
        },
        {
          "week_name": '6 weeks',
          "weeks": dueDate.subtract(const Duration(days: 34 * 7)),
          "line1": "Cells in your",
          "line2": " baby's future heart",
          "line3": "are flickering"
        },
        {
          "week_name": '6 - 8 weeks',
          "weeks": dueDate.subtract(const Duration(days: 34 * 7)),
          "line1": "you may have your ",
          "line2": "first prenatal visit",
          "line3": ""
        },
        {
          "week_name": '10 weeks',
          "weeks": dueDate.subtract(const Duration(days: 30 * 7)),
          "line1": "you'll be offered ",
          "line2": "NIPT ",
          "line3": "(Noninvasive prenantal test)"
        },
        {
          "week_name": '10 - 13 weeks',
          "weeks": dueDate.subtract(const Duration(days: 30 * 7)),
          "line1": "You can choose to have ",
          "line2": "CVS",
          "line3": " (Chorionic villus sampling)"
        },
        {
          "week_name": '11 - 14 weeks',
          "weeks": dueDate.subtract(const Duration(days: 29 * 7)),
          "line1": "You may have an ",
          "line2": "NT scan and blood test",
          "line3": ""
        },
        {
          "week_name": '12 weeks',
          "weeks": dueDate.subtract(const Duration(days: 28 * 7)),
          "line1": "You may ",
          "line2": "hear your baby's heartbeat",
          "line3": " with a Doppler"
        },
      ];
      milestones2 = [
        {
          "week_name": '15 - 20 weeks',
          "weeks": dueDate.subtract(const Duration(days: 25 * 7)),
          "line1": "You may have ",
          "line2": "anamniocentesis",
          "line3": ""
        },
        {
          "week_name": '16 - 18 weeks',
          "weeks": dueDate.subtract(const Duration(days: 24 * 7)),
          "line1": "You may have a ",
          "line2": "quad scan",
          "line3": " test"
        },
        {
          "week_name": '16 - 22 weeks',
          "weeks": dueDate.subtract(const Duration(days: 24 * 7)),
          "line1": "You can ",
          "line2": "feel your baby kick",
          "line3": ""
        },
        {
          "week_name": '18-22 weeks',
          "weeks": dueDate.subtract(const Duration(days: 22 * 7)),
          "line1": "You'll have a mid-pregnancy",
          "line2": " ultrasound",
          "line3": ""
        },
        {
          "week_name": '23 weeks',
          "weeks": dueDate.subtract(const Duration(days: 16 * 7 + 7)),
          "line1": "Your baby can ",
          "line2": "hear you talk",
          "line3": ""
        },
        {
          "week_name": '24 - 28 weeks',
          "weeks": dueDate.subtract(const Duration(days: 16 * 7)),
          "line1": "",
          "line2": "glucose screeing",
          "line3": ""
        },
        {
          "week_name": '27 weeks',
          "weeks": dueDate.subtract(const Duration(days: 13 * 7)),
          "line1": "You baby will ",
          "line2": "open their eyes",
          "line3": ""
        },
      ];
      milestones3 = [
        {
          "week_name": '28 weeks',
          "weeks": dueDate.subtract(const Duration(days: 12 * 7)),
          "line1": "You'll have ",
          "line2": "prenatal visits ",
          "line3": "every two weeks until 36 weeks, then weekly"
        },
        {
          "week_name": '28 weeks',
          "weeks": dueDate.subtract(const Duration(days: 12 * 7)),
          "line1": "If you're",
          "line2": " Rh negative, ",
          "line3": "you'll have a shot of Rh immune globulin (RhoGAM)"
        },
        {
          "week_name": '34 weeks',
          "weeks": dueDate.subtract(const Duration(days: 6 * 7)),
          "line1": "Your baby has ",
          "line2": "fingernails",
          "line3": ""
        },
        {
          "week_name": '36 - 37 weeks',
          "weeks": dueDate.subtract(const Duration(days: 4 * 7)),
          "line1": "You'll be screened for ",
          "line2": "Group B strep",
          "line3": ""
        },
        {
          "week_name": '37 weeks',
          "weeks": dueDate.subtract(const Duration(days: 3 * 7)),
          "line1": "Your baby is ",
          "line2": "early term",
          "line3": ""
        },
        {
          "week_name": '39 weeks',
          "weeks": dueDate.subtract(const Duration(days: 1 * 7)),
          "line1": "Your baby is ",
          "line2": "full term",
          "line3": ""
        },
        {
          "week_name": '40 weeks',
          "weeks": dueDate.subtract(const Duration(days: 0 - 7 + 7)),
          "line1": "Your ",
          "line2": "baby is due!",
          "line3": ""
        },
        {
          "week_name": '41 weeks',
          "weeks": dueDate.subtract(const Duration(days: 0 - 7)),
          "line1": "If your labor doesn't start, you may be",
          "line2": " induced",
          "line3": ""
        },
      ];
    }

    firstTrimesterEnd = dueDate.subtract(_selectedMethod == 'Ultra Sound'
        ? const Duration(days: 26 * 7)
        : _selectedMethod == 'IVF' && selectedOption == "1"
            ? const Duration(days: 27 * 7 - 4)
            : _selectedMethod == 'IVF' && selectedOption == "2"
                ? const Duration(days: 27 * 7 - 2)
                : const Duration(days: 26 * 7));
    secondTrimesterEnd = _selectedMethod == 'I know my due date'
        ? dueDate.subtract(const Duration(days: 13 * 7))
        : _selectedMethod == 'IVF' && selectedOption == "1"
            ? dueDate.subtract(const Duration(days: 13 * 7 + 3))
            : _selectedMethod == 'IVF' && selectedOption == "2"
                ? dueDate.subtract(const Duration(days: 13 * 7 + 5))
                : dueDate.subtract(const Duration(days: 11 * 7));
    thirdTrimesterStart = secondTrimesterEnd;

    String timeline = 'Pregnancy timeline\n';
    timeline +=
        '\nThird Trimester\n${formatDate(_selectedMethod == 'Ultra Sound' ? dueDate.subtract(const Duration(days: 10 * 7)) : _selectedMethod == 'I know my due date' ? dueDate.subtract(const Duration(days: 12 * 7)) : _selectedMethod == 'IVF' && selectedOption == "1" ? dueDate.subtract(const Duration(days: 12 * 7 + 3)) : thirdTrimesterStart)} to ${formatDate(_selectedMethod == 'Ultra Sound' ? dueDate.add(const Duration(days: 2 * 7)) : _selectedMethod == 'IVF' && selectedOption == "1" ? dueDate.subtract(const Duration(days: 3)) : dueDate)}\n';
    timeline += milestones
            ?.where((milestone) =>
                ((milestone["weeks"] as DateTime).isAfter(_selectedMethod ==
                            'Ultra Sound'
                        ? dueDate.subtract(const Duration(days: 11 * 7))
                        : _selectedMethod == 'IVF' && selectedOption == "1"
                            ? dueDate.subtract(const Duration(days: 13 * 7 + 3))
                            : _selectedMethod == 'IVF' && selectedOption == "1"
                                ? dueDate
                                    .subtract(const Duration(days: 13 * 7 + 5))
                                : thirdTrimesterStart) &&
                    (milestone["weeks"] as DateTime)
                        .isBefore(dueDate.add(const Duration(days: 4 * 7)))) ||
                (milestone["weeks"] as DateTime)
                    .isAtSameMomentAs(dueDate.add(const Duration(days: 4 * 7))))
            .map((milestone) =>
                '${formatDate((milestone["weeks"] as DateTime))}\n${milestone["week_name"]}\n')
            .join('\n') ??
        '';

    setState(() {
      _timeline = timeline;
    });
    var firstTrimesterStart = _selectedMethod == 'IVF' && selectedOption == "1"
        ? dueDate.subtract(const Duration(days: 38 * 7 + 3))
        : _selectedMethod == 'IVF' && selectedOption == "2"
            ? dueDate.subtract(const Duration(days: 38 * 7 + 5))
            : dueDate.subtract(const Duration(days: 38 * 7));
    var firstTrimesterEnds = firstTrimesterEnd;
    var firstTrimesterdayDifference =
        firstTrimesterEnds.difference(firstTrimesterStart).inDays;
    var secondTrimesterStartDate = _selectedMethod == 'Ultra Sound'
        ? dueDate.subtract(const Duration(days: 24 * 7))
        : firstTrimesterEnd;
    var secondTrimesterEndDate = _selectedMethod == 'Ultra Sound'
        ? dueDate.subtract(const Duration(days: 10 * 7))
        : _selectedMethod == 'IVF' && selectedOption == "1"
            ? dueDate.subtract(const Duration(days: 12 * 7 + 3))
            : _selectedMethod == 'IVF' && selectedOption == "2"
                ? dueDate.subtract(const Duration(days: 12 * 7 + 5))
                : dueDate.subtract(const Duration(days: 12 * 7));
    var secondTrimesterdayDifference =
        secondTrimesterEndDate.difference(secondTrimesterStartDate).inDays;
    var thirdTrimesterStartDate = _selectedMethod == 'Ultra Sound'
        ? dueDate.subtract(const Duration(days: 10 * 7))
        : _selectedMethod == 'I know my due date'
            ? dueDate.subtract(const Duration(days: 12 * 7))
            : _selectedMethod == 'IVF' && selectedOption == "1"
                ? dueDate.subtract(const Duration(days: 12 * 7 + 3))
                : thirdTrimesterStart;
    var thirdTrimesterEndDate = _selectedMethod == 'Ultra Sound'
        ? dueDate.add(const Duration(days: 2 * 7))
        : _selectedMethod == 'IVF' && selectedOption == "1"
            ? dueDate.subtract(const Duration(days: 3))
            : dueDate;
    var thirdTrimesterDifference =
        thirdTrimesterEndDate.difference(thirdTrimesterStartDate).inDays;
    DateTime? mostRecentPastDate;
    String? associatedWeekName;
    for (var month in milestones) {
      if ((month['weeks'] as DateTime).isBefore(DateTime.now())) {
        DateTime weekDate = month["weeks"] as DateTime;
        print("month['week_name'] ${month['weeks']}");
        if (mostRecentPastDate == null ||
            weekDate.isAfter(mostRecentPastDate)) {
          mostRecentPastDate = weekDate;
          associatedWeekName = calculateWeekDifference(
                  _selectedYear, _selectedMonth, _selectedDay)
              .toString();
          print(
              "month difference of ${calculateWeekDifference(_selectedYear, _selectedMonth, _selectedDay)}");
        }
      }
    }
    if (mostRecentPastDate != null && associatedWeekName != null) {
      print(
          'Most recent past date: ${DateFormat('MMM-d-yyyy').format(mostRecentPastDate)}');
      print('Associated week name: $associatedWeekName');
      print('last date name: ${milestones[milestones.length - 1]["weeks"]}');
    } else {
      print('No past date found.');
    }
    print("difference ${firstTrimesterdayDifference}");
    print("difference ${secondTrimesterdayDifference}");
    print("difference ${thirdTrimesterDifference}");

    RouteGenerator()
        .pushNamedSms(context, Routes.pregnancyDueDateResult, arguments: [
      milestones3[milestones3.length - 1]["weeks"],
      firstTrimesterdayDifference,
      secondTrimesterdayDifference,
      thirdTrimesterDifference,
      DateFormat('MMM-d-yyyy').format(mostRecentPastDate ?? DateTime.now()),
      associatedWeekName,
      milestones,
      _selectedMethod,
      selectedOption,
      firstTrimesterEnd,
      thirdTrimesterStart,
      milestones2,
      milestones3,
    ]);
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM\nd').format(date);
  }
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Due Date",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: adController.getNativeAdWidget(),
      //     ),
      //     10.ph,
      //     adController.getBannerAdWidget(),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            globalText16(
                text: "Estimate Based On :", fontWeight: FontWeight.w400),
            6.ph,
            Container(
              // Adjust padding here
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: HexColor("F3F6F9")),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  value: _selectedMethod,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedMethod = newValue!;
                    });
                  },
                  items: <String>[
                    'Last Period',
                    'Conception Date',
                    'IVF',
                    'Ultra Sound',
                    'I know my due date'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: globalText16(
                            text: value, fontWeight: FontWeight.w400),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            globalText16(
                text: "$_selectedMethod Date:", fontWeight: FontWeight.w400),
            6.ph,
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      // Adjust padding here
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor("F3F6F9")),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: DropdownButton<int>(
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            isExpanded: true,
                            value: _selectedMonth,
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedMonth = newValue!;
                                if (_selectedDay >
                                    _daysInMonth(_selectedYear, _selectedMonth)
                                        .length) {
                                  _selectedDay = _daysInMonth(
                                          _selectedYear, _selectedMonth)
                                      .length;
                                }
                              });
                            },
                            items: _months().asMap().entries.map((entry) {
                              int index = entry.key;
                              String name = entry.value;
                              return DropdownMenuItem(
                                value: index + 1,
                                child: globalText16(
                                    text: DateFormat('MMM')
                                        .format(DateTime(0, index + 1)),
                                    fontWeight: FontWeight.normal),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor("F3F6F9")),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: DropdownButton<int>(
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            value: _selectedDay,
                            isExpanded: true,
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedDay = newValue!;
                              });
                            },
                            items: _daysInMonth(_selectedYear, _selectedMonth)
                                .map((day) {
                              return DropdownMenuItem(
                                value: day,
                                child: globalText16(
                                    text: "$day",
                                    fontWeight: FontWeight.normal),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor("F3F6F9")),
                          child: Center(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                // labelText: 'Cycle Length (days)',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              initialValue: _selectedYear.toString(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedYear = int.parse(val);
                                  if (_selectedDay >
                                      _daysInMonth(
                                              _selectedYear, _selectedMonth)
                                          .length) {
                                    _selectedDay = _daysInMonth(
                                            _selectedYear, _selectedMonth)
                                        .length;
                                  }
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your cycle length';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        10.pw,
                        Icon(
                          Icons.calendar_month,
                          color: HexColor("437AFF"),
                          size: 22,
                        )
                        // Expanded(
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width * 0.2,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(8),
                        //         color: HexColor("F3F6F9")),
                        //     child: DropdownButtonHideUnderline(
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //             horizontal: 8, vertical: 2),
                        //         child: DropdownButton<int>(
                        //           icon: const Icon(Icons.keyboard_arrow_down_sharp),
                        //           value: _selectedYear,
                        //           onChanged: (int? newValue) {
                        //             setState(() {
                        //               _selectedYear = newValue!;
                        //               if (_selectedDay >
                        //                   _daysInMonth(_selectedYear, _selectedMonth)
                        //                       .length) {
                        //                 _selectedDay = _daysInMonth(
                        //                     _selectedYear, _selectedMonth)
                        //                     .length;
                        //               }
                        //             });
                        //           },
                        //           items: _years().map((year) {
                        //             return DropdownMenuItem(
                        //               value: year,
                        //               child: globalText16(
                        //                   text: "$year",
                        //                   fontWeight: FontWeight.normal),
                        //             );
                        //           }).toList(),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            globalText16(
                text: "Average Length of Cycles:", fontWeight: FontWeight.w400),
            6.ph,
            if (_selectedMethod == 'Last Period') ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor("F3F6F9")),
                    child: Center(
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          // labelText: 'Cycle Length (days)',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: _cycleLength.toString(),
                        onChanged: (val) {
                          setState(() {
                            _cycleLength = int.tryParse(val) ?? 28;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your cycle length';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  globalText16(text: "Days", fontWeight: FontWeight.normal)
                ],
              ),
            ],
            if (_selectedMethod == 'IVF') ...[
              ListTile(
                title: globalText16(
                    text: "IVF 3 Day Transfer Date",
                    fontWeight: FontWeight.w500),
                leading: Radio<String>(
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value ?? '';
                    });
                  },
                  value: "1",
                ),
              ),
              ListTile(
                title: globalText16(
                    text: "IVF 5 Day Transfer Date",
                    fontWeight: FontWeight.w500),
                leading: Radio<String>(
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value ?? '';
                    });
                  },
                  value: "2",
                ),
              ),
            ],
            const SizedBox(height: 16.0),
            ValueListenableBuilder<bool>(
                valueListenable: connectivityService.isConnected,
                builder: (context, isConnected, child) {
                  return Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<HexColor>(
                              HexColor("0F182E")),
                          maximumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 51),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 0.9, 41),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        onPressed: isConnected
                            ? _calculateTimeline
                            : () {
                                errorToast(
                                    context: context,
                                    msg:
                                        "Please check your internet connection",
                                    color: Colors.grey,
                                    iconColor: Colors.red,
                                    headingTextColor: Colors.red,
                                    valueTextColor: Colors.red);
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            globalText18(
                                text: "Get The Date",
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                            10.pw,
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        )),
                  );
                }),

            const SizedBox(height: 16.0),
            //  if(milestones[0]['weeks'] != null && (milestones[0]['weeks'] as DateTime).day.toString().isNotEmpty)
          ],
        ),
      ),
    );
  }
}
