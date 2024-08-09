import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/src/intl/date_format.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../main.dart';
import '../../../../toast/toast.dart';

class OvulationInputPage extends StatefulWidget {
  @override
  _OvulationInputPageState createState() => _OvulationInputPageState();
}

class _OvulationInputPageState extends State<OvulationInputPage> {
  final _formKey = GlobalKey<FormState>();
  int _selectedMonth = DateTime.now().month;
  int _selectedDay = DateTime.now().day;
  int _selectedYear = DateTime.now().year;
  int _cycleLength = 28;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Ovulation Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              globalText16(
                  text: "First Day of Your Last Period:",
                  fontWeight: FontWeight.normal),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      // Adjust padding here
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor("F3F6F9")),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
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
                                  _selectedDay =
                                      _daysInMonth(_selectedYear, _selectedMonth)
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
                                    text: DateFormat('MMM').format(DateTime(0, index + 1)), fontWeight: FontWeight.normal),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor("F3F6F9")),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: DropdownButton<int>(
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                             isExpanded: true,
                            value: _selectedDay,
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
                                    text: "$day", fontWeight: FontWeight.normal),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor("F3F6F9")),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: DropdownButton<int>(
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                             isExpanded: true,
                            value: _selectedYear,
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedYear = newValue!;
                                if (_selectedDay >
                                    _daysInMonth(_selectedYear, _selectedMonth)
                                        .length) {
                                  _selectedDay =
                                      _daysInMonth(_selectedYear, _selectedMonth)
                                          .length;
                                }
                              });
                            },
                            items: _years().map((year) {
                              return DropdownMenuItem(
                                value: year,
                                child: globalText16(
                                    text: "$year", fontWeight: FontWeight.normal),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 30),
              ValueListenableBuilder<bool>(
                  valueListenable: connectivityService.isConnected,
                  builder: (context, isConnected, child) {

                    return Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<HexColor>(HexColor("0F182E")),
                        maximumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width * 0.8, 61),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      onPressed: isConnected ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OvulationCalendarPage(
                                startDate: _selectedDate,
                                cycleLength: _cycleLength,
                              ),
                            ),
                          );
                        }
                      } : () {
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
                          globalText24(
                              text: "Get The Date",
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OvulationCalendarPage extends StatefulWidget {
  final DateTime startDate;
  final int cycleLength;

  OvulationCalendarPage({required this.startDate, required this.cycleLength});

  @override
  State<OvulationCalendarPage> createState() => _OvulationCalendarPageState();
}

class _OvulationCalendarPageState extends State<OvulationCalendarPage> {
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<DateTime>> calculateOvulationDays(
      DateTime startDate, int cycleLength) {
    Map<DateTime, List<DateTime>> ovulationDays = {};
    DateTime nextDate = startDate;

    for (int i = 0; i < 4; i++) {
      nextDate = nextDate.add(Duration(days: cycleLength));
      DateTime ovulationDay =
          nextDate.subtract(Duration(days: cycleLength - 14));
      List<DateTime> ovulationPeriod = List.generate(
          5, (index) => ovulationDay.add(Duration(days: index - 2)));
      ovulationDays[ovulationDay] = ovulationPeriod;
    }
    return ovulationDays;
  }

  @override
  void initState() {
    _focusedDay = widget.startDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<DateTime>> ovulationDays =
        calculateOvulationDays(widget.startDate, widget.cycleLength);
    List<DateTime> allOvulationDates =
        ovulationDays.values.expand((dates) => dates).toList();

    DateTime mostProbableOvulationDate =
        allOvulationDates[2]; // The middle day of the first ovulation period
    DateTime intercourseStart =
        mostProbableOvulationDate.subtract(const Duration(days: 2));
    DateTime intercourseEnd =
        mostProbableOvulationDate.add(const Duration(days: 2));
    DateTime pregnancyTestDate =
        mostProbableOvulationDate.add(const Duration(days: 9));
    DateTime nextPeriodStart =
        mostProbableOvulationDate.add(const Duration(days: 14));
    DateTime dueDate = mostProbableOvulationDate.add(
        const Duration(days: 266)); // Average pregnancy duration is 266 days

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: 'Ovulation Calendar', onBackPressed: (){
        Navigator.pop(context);
      },),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: DateTime(
                  _focusedDay.year, _focusedDay.month, _focusedDay.day),
              firstDay: widget.startDate.subtract(const Duration(days: 0)),
              lastDay: DateTime(
                      _focusedDay.year, _focusedDay.month + 3, _focusedDay.day)
                  .add(const Duration(days: 1)),
              rowHeight: 40,
              calendarStyle: const CalendarStyle(
                cellMargin: EdgeInsets.zero,
                cellAlignment: Alignment.center,
                cellPadding: EdgeInsets.zero,
                defaultTextStyle: TextStyle(fontSize: 16),
                outsideDaysVisible: false,
              ),
              onPageChanged: (focusedDate) {
                _focusedDay = focusedDate;
                ovulationDays =
                    calculateOvulationDays(focusedDate, widget.cycleLength);
              },
              headerStyle: const HeaderStyle(
                // Month text color
                formatButtonVisible: false, // Hide the default format button
                titleCentered: true, // Center the title
                leftChevronIcon: Icon(Icons.chevron_left),
                rightChevronIcon: Icon(Icons.chevron_right),
                leftChevronPadding: EdgeInsets.all(0),
                rightChevronPadding: EdgeInsets.all(0),

                formatButtonShowsNext: false,
                headerMargin:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                headerPadding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  for (DateTime ovulationDay in allOvulationDates) {
                    if (day.year == ovulationDay.year &&
                        day.month == ovulationDay.month &&
                        day.day == ovulationDay.day) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 15),
                        alignment: Alignment.center,
                        height: 58,
                        width: 38,
                        decoration: BoxDecoration(
                          color: HexColor("FABEE2"),
                          borderRadius: BorderRadius.circular(900.0),
                        ),
                        child: globalText16(
                            text: "${day.day}",
                            alignment: Alignment.center,
                            fontWeight: FontWeight.normal),
                      );
                    }
                  }
                  return null;
                },
              ),
            ),
            // SizedBox(height: 20),
            const Divider(
              thickness: 0.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: HexColor("FABEE2"),
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      globalText12(
                          text: "Ovalution Days",
                          color: HexColor("777777"),
                          fontWeight: FontWeight.normal)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //     "Ovulation Window: ${formatDate(intercourseStart)} - ${formatDate(intercourseEnd)}"),
                  // Text(
                  //     "Most Probable Ovulation Date: ${formatDate(mostProbableOvulationDate)}"),
                  // Text(
                  //     "Intercourse Window for Pregnancy: ${formatDate(intercourseStart)} - ${formatDate(intercourseEnd)}"),
                  // Text("Pregnancy Test: ${formatDate(pregnancyTestDate)}"),
                  // Text("Next Period Start: ${formatDate(nextPeriodStart)}"),
                  CustomRow(
                      text: "Ovulation Window",
                      value:
                          "${formatDate(intercourseStart)} - ${formatDate(intercourseEnd)}"),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomRow(
                      text: "Likely Ovulation Date",
                      value: "${formatDate(mostProbableOvulationDate)}"),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomRow(
                      text: "Next Period Days",
                      value: "${formatDate(nextPeriodStart)}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CustomRow({required String text, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: globalText16(text: text, color: HexColor("534C4C")),
        ),
        Container(
          margin: const EdgeInsets.only(right: 35),
          height: 24,
          width: 1,
          color: HexColor("DDDADA"),
        ),
        Expanded(
          flex: 3,
          child: globalText16(
              text: value,
              alignment: Alignment.centerLeft,
              color: HexColor("534C4C")),
        ),
      ],
    );
  }

  String formatDate(DateTime date) {
    return "${_months()[date.month - 1]} ${date.day}";
  }

  List<String> _months() {
    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
  }
}
