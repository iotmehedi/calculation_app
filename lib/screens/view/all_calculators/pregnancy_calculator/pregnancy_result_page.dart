import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/core/routes/router.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/consts/textstyle.dart';
import '../../../../main.dart';
import '../../../../toast/toast.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';

class PregnancyResultCalculator extends StatefulWidget {
  final int weeksDifference, daysDifference, month, remainingDays;
  final String currentTrimester, conceviedDate, dueDate;
  final List<Map<String, Object>> milestones, milestones2, milestones3;
  const PregnancyResultCalculator({
    super.key,
    required this.weeksDifference,
    required this.daysDifference,
    required this.month,
    required this.remainingDays,
    required this.currentTrimester,
    required this.conceviedDate,
    required this.dueDate,
    required this.milestones,
    required this.milestones2,
    required this.milestones3,
  });

  @override
  State<PregnancyResultCalculator> createState() =>
      _PregnancyResultCalculatorState();
}

class _PregnancyResultCalculatorState extends State<PregnancyResultCalculator> {
  // final DateTime selectedDate = DateTime(2023, 10, 12);
  DateTime presentDate = DateTime.now();

  int get daysDifference {
    return presentDate
        .difference((widget.milestones[0]["weeks"] as DateTime))
        .inDays;
  }

  String getOrdinalSuffix(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    print("this is date ${widget.milestones[0]["weeks"]}");
    int daysDiff = daysDifference;
    int trimesterDays = 91;
    int trimesterIndex = (daysDiff / trimesterDays).floor();
    int progressInCurrentTrimester = daysDiff % trimesterDays;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Pregnancy Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexColor('33743A'),
                    HexColor('FAFFFA'),
                  ],
                  stops: [
                    0.0,
                    1.0,
                  ],
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: globalText24(text: "Calculator", color: Colors.white),
              ),
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              color: HexColor("0F182E"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/due_date_image.png",
                    height: 40,
                    width: 40,
                  ),
                  globalText16(
                      text: "Your Currently Pregnent",
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      alignment: Alignment.center),
                  globalText20(
                      text:
                          "${widget.weeksDifference} week ${widget.daysDifference} days",
                      color: HexColor("7BFF80"),
                      fontWeight: FontWeight.w700,
                      alignment: Alignment.center),
                  globalText20(
                      text: "OR",
                      color: HexColor("7BFF80"),
                      fontWeight: FontWeight.w700,
                      alignment: Alignment.center),
                  globalText20(
                      text:
                          "${widget.month} months ${widget.remainingDays} Days",
                      color: HexColor("7BFF80"),
                      fontWeight: FontWeight.w700,
                      alignment: Alignment.center),
                ],
              ),
            ),
            10.ph,
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: globalText12(
                  text: "You Are in the ${widget.currentTrimester}",
                  color: HexColor("2FAE3B"),
                  fontWeight: FontWeight.w500,
                  alignment: Alignment.centerLeft),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: globalText12(
                  text:
                      "Your baby was likely conceived on ${DateFormat("MMM d, yyyy").format(DateTime.parse(widget.conceviedDate))}",
                  color: HexColor("2FAE3B"),
                  fontWeight: FontWeight.w500,
                  alignment: Alignment.centerLeft),
            ),
            Visibility(
              visible: widget.dueDate.toString().isEmpty ? false : true,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: globalText12(
                    text:
                        "The estimated due date is ${DateFormat("MMM d, yyyy").format(DateTime.parse(widget.dueDate.toString().isEmpty ? widget.conceviedDate : widget.dueDate))}",
                    color: HexColor("2FAE3B"),
                    fontWeight: FontWeight.w500,
                    alignment: Alignment.centerLeft),
              ),
            ),
            20.ph,
            Divider(
              color: HexColor("F3F3F3"),
            ),
            10.ph,
            globalText20(
                text: "Progress",
                color: HexColor("2E2E2E"),
                fontWeight: FontWeight.w700,
                alignment: Alignment.center),
            10.ph,
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: globalText14(
                  text: "You are of the way through your pregnancy.",
                  color: HexColor("2E2E2E"),
                  fontWeight: FontWeight.normal,
                  alignment: Alignment.centerLeft),
            ),
            20.ph,
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: globalText10(
                                text:
                                    '${i + 1}${getOrdinalSuffix(i + 1)} Trimester',
                                fontWeight: FontWeight.normal),
                          ),
                          5.ph,
                          Padding(
                            padding:
                                EdgeInsets.only(right: (i + 1 == 3) ? 0 : 10),
                            child: LinearPercentIndicator(
                              backgroundColor:
                                  HexColor("2FAE3B").withOpacity(0.1),
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 3000,
                              animateFromLastPercent: true,
                              progressColor: Colors.green,
                              barRadius: Radius.circular(10),
                              percent: i < trimesterIndex
                                  ? 1.0
                                  : i == trimesterIndex
                                      ? progressInCurrentTrimester /
                                          trimesterDays
                                      : 0.0,
                            ),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
                valueListenable: connectivityService.isConnected,
                builder: (context, isConnected, child) {
                  return Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<HexColor>(
                              HexColor("0F182E")),
                          maximumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 0.6, 41),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 0.6, 35),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: isConnected
                            ? () {
                                RouteGenerator().pushNamedSms(
                                    context, Routes.pregnancyTimeTrimester,
                                    arguments: [
                                      widget.milestones,
                                      widget.milestones2,
                                      widget.milestones3,
                                    ]);
                              }
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
                        child: globalText12(
                            text: " Theremistet Chart",
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            alignment: Alignment.center)),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
