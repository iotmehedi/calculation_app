import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/pregnancy_calculator/pregnancy_calculator_controller.dart';
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

class PregnancyTimeCalculatorPage extends StatefulWidget {
  @override
  _PregnancyTimeCalculatorPageState createState() =>
      _PregnancyTimeCalculatorPageState();
}

class _PregnancyTimeCalculatorPageState extends State<PregnancyTimeCalculatorPage> {
  String _timeline = '';
  String _selectedMethod = 'Last Period';
  int _cycleLength = 28;
  int _cycleWeek = 22;
  int _cycleDays = 6;
  int _selectedMonth = DateTime.now().month;
  int _selectedDay = DateTime.now().day;
  int _selectedYear = DateTime.now().year;
  String selectedOption = '1';
  var adController = Get.put(AdService());
  DateTime dueDate = DateTime.now();
  var firstTrimesterEnd = DateTime.now();
  var secondTrimesterEnd = DateTime.now();
  var thirdTrimesterStart = DateTime.now();
  // List<Tuple2<String, DateTime>>? controller.milestones;
  var controller = Get.put(PregnancyCalculatorController());
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

  void _calculateTimeline() {
    switch (_selectedMethod) {
      case 'Last Period':
        dueDate = _selectedDate.add(Duration(days: _cycleLength + 280 - 28));
        print("this is print $dueDate");
        break;
      case 'Conception Date':
        dueDate = _selectedDate.add(const Duration(days: 266));
        break;
        case 'Due Date':
        dueDate = _selectedDate.add(const Duration(days: 280));
        break;
      case 'IVF':
        dueDate = _selectedDate.add(const Duration(days: 266));
        break;
      case 'Ultra Sound':
        final int daysPregnant = (_cycleWeek * 7) + _cycleDays;
        dueDate = _selectedDate.add(Duration(days: 266 - daysPregnant));
        break;
      case 'I know my due date':
        dueDate = _selectedDate;
        break;
      default:
        dueDate = _selectedDate;
    }

    if(_selectedMethod == 'Due Date'){
      controller.lastPeriodFunction(dueDate);
controller.dueDateFunction(dueDate);
    } else if(_selectedMethod == 'Last Period'){
      controller.lastPeriodFunction(dueDate);
    }else if (_selectedMethod == 'Ultra Sound') {
      final int daysPregnant = (_cycleWeek * 7) + _cycleDays;
        dueDate = _selectedDate.add(Duration(days: 266 - daysPregnant));
        controller.ultrasoundFun(dueDate);
    } else if(_selectedMethod == "Conception Date"){
      controller.conceptionDate(dueDate);
    } else {
      if(selectedOption == "1"){
        controller.ivfFunctionSelectOne(dueDate);
      }else if(selectedOption == "2"){
        controller.ivfFunctionSelectTwo(dueDate);
      }else{
        controller.ivfFunctionSelectThree(dueDate);
      }
      
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
    timeline += controller.milestones
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
    var firstTrimesterStart = _selectedMethod == 'IVF' && selectedOption == "1" ? dueDate.subtract(const Duration(days: 38 * 7 + 3)) : _selectedMethod == 'IVF' && selectedOption == "2" ? dueDate.subtract(const Duration(days: 38 * 7 + 5)) : dueDate.subtract(const Duration(days: 38 * 7));
    var firstTrimesterEnds = firstTrimesterEnd;
    var firstTrimesterdayDifference = firstTrimesterEnds.difference(firstTrimesterStart).inDays;
    var secondTrimesterStartDate = _selectedMethod == 'Ultra Sound' ? dueDate.subtract(const Duration(days: 24 * 7)) : firstTrimesterEnd;
    var secondTrimesterEndDate = _selectedMethod == 'Ultra Sound' ? dueDate.subtract(const Duration(days: 10 * 7)) : _selectedMethod == 'IVF' && selectedOption == "1" ? dueDate.subtract(const Duration(days: 12 * 7 + 3)) : _selectedMethod == 'IVF' && selectedOption == "2" ? dueDate.subtract(const Duration(days: 12 * 7 + 5)) : dueDate.subtract(const Duration(days: 12 * 7));
    var secondTrimesterdayDifference = secondTrimesterEndDate.difference(secondTrimesterStartDate).inDays;
    var thirdTrimesterStartDate = _selectedMethod == 'Ultra Sound' ? dueDate.subtract(const Duration(days: 10 * 7)) : _selectedMethod == 'I know my due date' ? dueDate.subtract(const Duration(days: 12 * 7)) : _selectedMethod == 'IVF' && selectedOption == "1" ? dueDate.subtract(const Duration(days: 12 * 7 + 3)) : thirdTrimesterStart;
    var thirdTrimesterEndDate = _selectedMethod == 'Ultra Sound' ? dueDate.add(const Duration(days: 2 * 7)) : _selectedMethod == 'IVF' && selectedOption == "1" ? dueDate.subtract(const Duration(days: 3)) : dueDate;
    var thirdTrimesterDifference = thirdTrimesterEndDate.difference(thirdTrimesterStartDate).inDays;
    DateTime? mostRecentPastDate;
    DateTime? middleDate;
    String? associatedWeekName;
    for(var month in (controller.milestones + controller.milestones2 + controller.milestones3)){

      if((month['weeks'] as DateTime).isBefore(DateTime.now())){
        DateTime weekDate = month["weeks"] as DateTime;
      print("month['week_name'] ${month['weeks']}");
      if (mostRecentPastDate == null || weekDate.isAfter(mostRecentPastDate)) {
        mostRecentPastDate = weekDate;
        associatedWeekName = month["week_name"] as String;
      }
      }
    }
    if(_selectedMethod == "Last Period"){
     controller.lastPeriod = dueDate.toString();
    }else{
    controller.lastPeriod = '';
    }
    // for(var month in controller.milestones){
      print("First trimester days difference1 ${(controller.milestones[controller.milestones.length - 1]['weeks'] as DateTime).difference(controller.milestones[0]['weeks'] as DateTime).inDays}");
      print("First trimester days difference2 ${(controller.milestones2[controller.milestones.length - 1]['weeks'] as DateTime).difference(controller.milestones2[0]['weeks'] as DateTime).inDays}");
      print("First trimester days difference3 ${(controller.milestones3[controller.milestones.length - 1]['weeks'] as DateTime).difference(controller.milestones3[0]['weeks'] as DateTime).inDays}");
    // }
    var value = (DateTime.now()).difference(controller.milestones[0]['weeks'] as DateTime).inDays;
    print("total value $value");
    if(value <= 91){
      print("First Trimester");
    }else if(value <= 182){
      print("Second trimester");
    }else{
      print("third trimester");
    }
    
    if (mostRecentPastDate != null && associatedWeekName != null) {
      
      print('Most recent past date: ${DateFormat('MMM-d-yyyy').format(mostRecentPastDate)}');
      print('Associated week name: $associatedWeekName');
      print('last date name: ${controller.milestones[controller.milestones.length - 1]["weeks"]}');
      Duration difference = mostRecentPastDate.add(const Duration(days: 6)).difference(mostRecentPastDate);
    Duration halfDifference = Duration(days: difference.inDays ~/ 2);
    middleDate =  mostRecentPastDate.add(halfDifference);
     print("the middle date is $middleDate");
      var weekname = associatedWeekName.replaceAll(" weeks", '');
      convertWeeksToMonthsAndDays(int.parse(weekname));
      _calculateDifference();
      checkCurrentTrimester(mostRecentPastDate);
    } else {
      print('No past date found.');
    }
    
    print("difference ${firstTrimesterdayDifference}");
    print("difference ${secondTrimesterdayDifference}");
    print("difference ${thirdTrimesterDifference}");
conceivedOn();
    RouteGenerator().pushNamedSms(
        context, Routes.pregnancyResultCalculator, arguments: [
      controller.weeksDifference,
      controller.daysDifference,
      controller.months,
      controller.remainingDays - 4,
      controller.currentTrimester,
      controller.conceviedDate,
      controller.dueDate,
      controller.milestones,
      controller.milestones2,
      controller.milestones3,
    ]);
  }
 void checkCurrentTrimester(DateTime mostRecentPastDate) {
  setState(() {
    DateTime currentDate = DateTime.now();
    for (var milestone in controller.milestones) {
      if ((milestone['weeks'] as DateTime).isAtSameMomentAs(currentDate) || (mostRecentPastDate == (milestone['weeks'] as DateTime))) {
       controller.currentTrimester = 'First Trimester';
        return;
      }
    }
    
    for (var milestone in controller.milestones2) {
      if ((milestone['weeks'] as DateTime).isAtSameMomentAs(currentDate) || (mostRecentPastDate == (milestone['weeks'] as DateTime))) {
        controller.currentTrimester = 'Second Trimester';
        return;
      }
    }
    for (var milestone in controller.milestones3) {
      if ((milestone['weeks'] as DateTime).isAtSameMomentAs(currentDate) || (mostRecentPastDate == (milestone['weeks'] as DateTime))) {
        controller.currentTrimester = 'Third Trimester';
        return;
      }
    }
    
    controller.currentTrimester = 'Not currently in a defined milestone week';
  });
    
  }

  void conceivedOn(){
    if((_selectedMethod == "Due Date" || _selectedMethod == "Last Period" || _selectedMethod == "Ultra Sound")){
      print("this is hot");
   for (var milestone in controller.milestones) {
      if (milestone["week_name"] == "2 weeks") {
        controller.conceviedDate = ((milestone['weeks'] as DateTime).add(const Duration(days: 6))).toString();
        print("conceived Date ${controller.conceviedDate}");
      }
    }
    }
    if(_selectedMethod != "Due Date"){
    for (var milestone in controller.milestones3) {
      if (milestone["week_name"] ==   "40 weeks" ) {
        controller.dueDate = ((milestone['weeks'] as DateTime).add(const Duration(days: 6))).toString();
      }
    }
 }else{
  controller.dueDate = '';
 }
  }
void convertWeeksToMonthsAndDays(int weeks) {
  int days = weeks * 7;
  int months = days ~/ 30;
  int remainingDays = days % 30;
setState(() {
  controller.months = months;
  controller.remainingDays = remainingDays;
});
  print('$weeks weeks is approximately $months months and ${remainingDays} days.');
}
  String formatDate(DateTime date) {
    return DateFormat('MMM\nd yyyy').format(date);
  }
void _calculateDifference() {
    final DateTime currentDate = DateTime.now();
    final Duration difference = currentDate.difference((controller.milestones[0]['weeks'] as DateTime));
    setState(() {
      controller.weeksDifference = difference.inDays.abs() ~/ 7;
      controller.daysDifference = difference.inDays.abs() % 7;
    });
    print("this is days weeek ${difference}");
    print("this is days weeek ${controller.weeksDifference}");
    print("this is days days ${controller.daysDifference }");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: "Pregnancy Calculator", onBackPressed: (){
        Navigator.pop(context);
      },),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: adController.getNativeAdWidget(),
          ),
          10.ph,
          adController.getBannerAdWidget(),
        ],
      ),
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
                    'Due Date',
                    'Last Period',
                    'Conception Date',
                    'IVF',
                    'Ultra Sound',
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
                                    text: name, fontWeight: FontWeight.normal),
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
            if (_selectedMethod == 'Ultra Sound') ...[
              Row(
                children: [
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
                            initialValue: _cycleWeek.toString(),
                            onChanged: (val) {
                              setState(() {
                                _cycleWeek = int.tryParse(val) ?? 28;
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
                      globalText16(text: "Weeks", fontWeight: FontWeight.normal)
                    ],
                  ),
                  10.pw,
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
                            initialValue: _cycleDays.toString(),
                            onChanged: (val) {
                              setState(() {
                                _cycleDays = int.tryParse(val) ?? 28;
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
                      globalText16(text: "Weeks", fontWeight: FontWeight.normal)
                    ],
                  ),
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
              ListTile(
                title: globalText16(
                    text: "IVF 6 Day Transfer Date",
                    fontWeight: FontWeight.w500),
                leading: Radio<String>(
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value ?? '';
                      print(selectedOption);
                    });
                  },
                  value: "3",
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
                        backgroundColor:
                            MaterialStatePropertyAll<HexColor>(HexColor("0F182E")),
                        maximumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 51),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width * 0.9, 41),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      onPressed: isConnected ? _calculateTimeline : () {
                        errorToast(
                            context: context,
                            msg: "Please check your internet connection",
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
              }
            ),
            
          //   const SizedBox(height: 16.0),
          //  if(controller.milestones[0]['weeks'] != null && (controller.milestones[0]['weeks'] as DateTime).day.toString().isNotEmpty)
          // Expanded(child: ListView.builder(
          //     itemCount: controller.milestones.length,
          //     itemBuilder: (_, index){
          //       var item = controller.milestones[index];
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text("${formatDate(item['weeks'] as DateTime)}"),
          //           Text("${item['week_name']}"),
          //         ],
          //       );
          //     }))
          
          ],
        ),
      ),
    );
  }
}
