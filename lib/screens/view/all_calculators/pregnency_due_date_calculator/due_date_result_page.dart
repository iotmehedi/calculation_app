import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/core/routes/router.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../../main.dart';
import '../../../../toast/toast.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';

class DueDateResultCalculator extends StatefulWidget {
  final DateTime lastMonthName, firstTrimesterEnd, thirdTrimesterStart;
  final String mostRecentPastDate,
      associatedWeekName,
      selectedMethod,
      selectedOption;
  final int firstTrimesterDayDifference,
      secondTrimesterDayDifference,
      thirdTrimesterDayDifference;
  final List<Map<String, Object>> milestones, milestones2, milestones3;
  const DueDateResultCalculator(
      {super.key,
      required this.lastMonthName,
      required this.firstTrimesterDayDifference,
      required this.secondTrimesterDayDifference,
      required this.thirdTrimesterDayDifference,
      required this.mostRecentPastDate,
      required this.associatedWeekName,
      required this.milestones,
      required this.selectedMethod,
      required this.selectedOption,
      required this.firstTrimesterEnd,
      required this.thirdTrimesterStart,
      required this.milestones2,
      required this.milestones3});

  @override
  State<DueDateResultCalculator> createState() =>
      _DueDateResultCalculatorState();
}

class _DueDateResultCalculatorState extends State<DueDateResultCalculator> {
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
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    print("this is date ${widget.milestones[0]["weeks"]}");
    int daysDiff = daysDifference;
    int trimesterDays = 91;
    int trimesterIndex = (daysDiff / trimesterDays).floor();
    int progressInCurrentTrimester = daysDiff % trimesterDays;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Due date Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      // bottomNavigationBar: adController.getBannerAdWidget(),
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
              height: 140,
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
                      text: "Your Due Date",
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      alignment: Alignment.center),
                  globalText24(
                      text:
                          "${DateFormat('d MMMM, yyyy').format(widget.lastMonthName.subtract(const Duration(days: 7)))}",
                      color: HexColor("7BFF80"),
                      fontWeight: FontWeight.w700,
                      alignment: Alignment.center),
                ],
              ),
            ),
            10.ph,
            globalText20(
                text: "You Are Current",
                color: HexColor("000000"),
                fontWeight: FontWeight.w600,
                alignment: Alignment.center),
            10.ph,
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: HexColor("0F182E")),
              child: Center(
                child: globalText24(
                    text: widget.associatedWeekName.replaceAll("weeks", ""),
                    color: HexColor("7BFF80"),
                    fontWeight: FontWeight.w700,
                    alignment: Alignment.center),
              ),
            ),
            10.ph,
            globalText20(
                text: "Week pregnant",
                color: HexColor("2FAE3B"),
                fontWeight: FontWeight.w600,
                alignment: Alignment.center),
            10.ph,
            Divider(
              color: HexColor("F3F3F3"),
            ),
            10.ph,

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

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(left: 15, bottom: 5),
            //             child: globalText10(
            //                 text: "1st Trimester",
            //                 color: HexColor("2FAE3B"),
            //                 fontWeight: FontWeight.w400,
            //                 alignment: Alignment.centerLeft),
            //           ),
            //           Align(
            //             alignment: Alignment.centerLeft,
            //             child: LinearPercentIndicator(
            //               backgroundColor: HexColor("2FAE3B").withOpacity(0.1),
            //               animation: true,
            //               lineHeight: 20.0,
            //               animationDuration: 3000,
            //               percent: widget.secondTrimesterDayDifference / 100,
            //               animateFromLastPercent: true,
            //               progressColor: Colors.green,
            //               barRadius: Radius.circular(10),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(left: 15, bottom: 5),
            //             child: globalText10(
            //                 text: "2nd Trimester",
            //                 color: HexColor("2FAE3B"),
            //                 fontWeight: FontWeight.w400,
            //                 alignment: Alignment.centerLeft),
            //           ),
            //           LinearPercentIndicator(
            //             backgroundColor: HexColor("2FAE3B").withOpacity(0.1),
            //             animation: true,
            //             lineHeight: 20.0,
            //             animationDuration: 3000,
            //             percent: widget.thirdTrimesterDayDifference / 100,
            //             animateFromLastPercent: true,
            //             progressColor: Colors.green,
            //             barRadius: Radius.circular(10),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(left: 15, bottom: 5),
            //             child: globalText10(
            //                 text: "3rd Trimester",
            //                 color: HexColor("2FAE3B"),
            //                 fontWeight: FontWeight.w400,
            //                 alignment: Alignment.centerLeft),
            //           ),
            //           LinearPercentIndicator(
            //             backgroundColor: HexColor("2FAE3B").withOpacity(0.1),
            //             animation: true,
            //             lineHeight: 20.0,
            //             animationDuration: 3000,
            //             percent: widget.firstTrimesterDayDifference / 100,
            //             animateFromLastPercent: true,
            //             progressColor: Colors.green,
            //             barRadius: Radius.circular(10),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            20.ph,
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
                                    context, Routes.pregnancyTrimester,
                                    arguments: [
                                      widget.milestones,
                                      widget.selectedMethod,
                                      widget.selectedOption,
                                      widget.firstTrimesterEnd,
                                      widget.thirdTrimesterStart,
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
