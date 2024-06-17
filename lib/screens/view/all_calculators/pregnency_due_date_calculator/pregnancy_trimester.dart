import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/src/intl/date_format.dart';

class PregnancyTrimester extends StatelessWidget {
  final List<Map<String, Object>> milestones, milestones2,milestones3;
  final String selectedMethod, selectedOption;
  final DateTime firstTrimesterEnd, thirdTrimesterStart;
   PregnancyTrimester({super.key, required this.milestones, required this.selectedMethod, required this.selectedOption, required this.firstTrimesterEnd, required this.thirdTrimesterStart, required this.milestones2, required this.milestones3});
  String formatDate(DateTime date) {
    return DateFormat('MMM\nd').format(date);
  }
  String formatDate1(DateTime date) {
    return DateFormat('d MMM, yyyy').format(date);
  }
DateTime dueDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pregnancy Trimester',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                          itemCount: milestones.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var item = milestones[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (item["week_name"] == "2 weeks")
                                  Column(
                                    children: [
                                      globalText16(
                                      text:
                                          "First Trimester",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black, alignment: Alignment.centerLeft, textAlign: TextAlign.start),
                                      globalText14(
                                      text:
                                          "${formatDate1(item['weeks'] as DateTime)}  to  ${DateFormat('MMM d, yyyy').format(firstTrimesterEnd)}\n",
                                      fontWeight: FontWeight.w400,
                                      color: HexColor("8E8E8E"), alignment: Alignment.centerLeft, textAlign: TextAlign.start),
                                    ],
                                  ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    globalText16(
                                        text:
                                            "${formatDate(item['weeks'] as DateTime)}",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    20.pw,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(padding: EdgeInsets.only(top: 3), child: globalText12(
                                              text: "${item['week_name']}",
                                              fontWeight: FontWeight.normal,
                                              color: HexColor("838383")),),
                                          8.ph,
                                          RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              text: '${item["line1"]}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: ' ${item["line2"]}',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                        color: HexColor("2FAE3B"))),
                                                TextSpan(text: ' ${item["line3"]}'),
                                              ],
                                            ),
                                          ),
                                          5.ph,
                                          Divider(
                                            color: HexColor("F3F3F3"),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
              ListView.builder(
                          itemCount: milestones2.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var item = milestones2[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (item["week_name"] == "15 - 20 weeks")
                                  Column(
                                    children: [
                                      globalText16(
                                      text:
                                          "Second Trimester",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black, alignment: Alignment.centerLeft, textAlign: TextAlign.start),
                                      globalText14(
                                      text:
                                          "${DateFormat('MMM d, yyyy').format(firstTrimesterEnd)} to ${formatDate1(milestones2[milestones2.length - 1]['weeks'] as DateTime)}\n",
                                      fontWeight: FontWeight.w400,
                                      color: HexColor("8E8E8E"), alignment: Alignment.centerLeft, textAlign: TextAlign.start),
                                    ],
                                  ),
              
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    globalText16(
                                        text:
                                            "${formatDate(item['weeks'] as DateTime)}",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    20.pw,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(padding: EdgeInsets.only(top: 3), child: globalText12(
                                              text: "${item['week_name']}",
                                              fontWeight: FontWeight.normal,
                                              color: HexColor("838383")),),
                                          8.ph,
                                          RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              text: '${item["line1"]}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: ' ${item["line2"]}',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                        color: HexColor("2FAE3B"))),
                                                TextSpan(text: ' ${item["line3"]}'),
                                              ],
                                            ),
                                          ),
                                          5.ph,
                                          Divider(
                                            color: HexColor("F3F3F3"),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
              ListView.builder(
                          itemCount: milestones3.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var item = milestones3[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(index == 0)
                                  Column(
                                    children: [
                                      globalText16(
                                      text:
                                          "Third Trimester",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black, alignment: Alignment.centerLeft, textAlign: TextAlign.start),
                                      globalText14(
                                      text:
                                          "${formatDate1(item['weeks'] as DateTime)} to ${formatDate1(milestones3[milestones3.length - 1]['weeks'] as DateTime)}\n",
                                      fontWeight: FontWeight.w400,
                                      color: HexColor("8E8E8E"), alignment: Alignment.centerLeft, textAlign: TextAlign.start),
                                    ],
                                  ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    globalText16(
                                        text:
                                            "${formatDate(item['weeks'] as DateTime)}",
                                        fontWeight: FontWeight.w500,
                                        color: formatDate(item['weeks'] as DateTime) == formatDate(milestones3[milestones3.length - 1]['weeks'] as DateTime) ? Colors.green: Colors.black),
                                    20.pw,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(padding: EdgeInsets.only(top: 3), child: globalText12(
                                              text: "${item['week_name']}",
                                              fontWeight: FontWeight.normal,
                                              color: HexColor("838383")),),
                                          8.ph,
                                          RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              text: '${item["line1"]}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: ' ${item["line2"]}',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                        color: HexColor("2FAE3B"))),
                                                TextSpan(text: ' ${item["line3"]}'),
                                              ],
                                            ),
                                          ),
                                          5.ph,
                                          Divider(
                                            color: HexColor("F3F3F3"),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
            ],
          ),
        ),
      ),
            
    );
  }
}