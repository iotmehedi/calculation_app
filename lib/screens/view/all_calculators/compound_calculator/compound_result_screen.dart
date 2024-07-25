import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/compound_calculator/compound_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';

class CompoundResultScreen extends StatelessWidget {
  CompoundResultScreen({super.key});
  var controller = Get.find<CompoundController>();
  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    int maxYears = int.parse(
        controller.yearsOfGrowthController.value.text.isEmpty
            ? '5'
            : controller.yearsOfGrowthController.value.text);
    double maxX = maxYears.toDouble();
    return Scaffold(
      backgroundColor: HexColor("FAFAFA"),
      appBar: CustomAppBar(
        title: "Compound Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CommonResultHeading(headingName: "Results"),
                20.ph,
                ContainerShadowWidget(
                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      20.ph,
                      globalText16(
                          text: "Total Balance",
                          alignment: Alignment.center,
                          fontWeight: FontWeight.w600),
                      10.ph,
                      globalText20(
                          text:
                              "\$ ${NumberFormat('#,##0.00', 'en_US').format(controller.result.value)}",
                          alignment: Alignment.center,
                          color: HexColor("437AFF"),
                          fontWeight: FontWeight.w600),
                      20.ph,
                    ],
                  ),
                ),
                20.ph,
                ContainerShadowWidget(
                  widget: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 20, top: 20, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white),
                    height: 251,
                    child: LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipColor: (spot) => Colors.white,
                            tooltipRoundedRadius: 4,
                            tooltipHorizontalAlignment:
                                FLHorizontalAlignment.left,
                            fitInsideHorizontally: true,
                              tooltipHorizontalOffset: 0.0,
                              fitInsideVertically:true,
                            getTooltipItems: (touchedSpots) {
                              if (touchedSpots.isEmpty) {
                                return [];
                              }

                              final touchedSpot = touchedSpots[0];
                              final x = touchedSpot.x.toInt();
                              final balance = touchedSpot.y;
                              double principalUpToYear = double.parse(controller
                                  .initialDepositController.value.text);
                              double PMT = double.parse(controller
                                  .contributionAmountController.value.text);

                              for (int i = 1;
                                  i <=
                                      x *
                                          ((controller.contributionFrequency
                                                      .value ==
                                                  'Monthly')
                                              ? 12
                                              : 1);
                                  i++) {
                                principalUpToYear += PMT;
                              }

                              final interest = balance - principalUpToYear;
                              return touchedSpots.map((spot) {
                                return const LineTooltipItem(
                                  '',
                                  TextStyle(color: Colors.white),
                                );
                              }).toList()
                                ..[0] = LineTooltipItem(
                                  'Year: ${currentYear + x}\nBalance: \$${balance.toInt()}\nPrincipal: \$${principalUpToYear.toInt()}\nInterest: \$${interest.toInt()}',
                                  const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                      wordSpacing: 5,
                                      overflow: TextOverflow.clip,
                                      fontSize: 10),
                                  textAlign: TextAlign.start,
                                );
                            },
                          ),
                          handleBuiltInTouches: true,
                          touchCallback:
                              (FlTouchEvent event, barTouchResponse) {},
                        ),
                        gridData: FlGridData(
                          drawHorizontalLine:
                              true, // Show horizontal grid lines
                          drawVerticalLine: true,
                          show: true,
                          horizontalInterval: (controller.maxY.value) / 5,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: HexColor("FAFAFA"),
                              strokeWidth: 1,
                            );
                          },
                          getDrawingVerticalLine: (value) {
                            if (value == (maxX) / 2) {
                              // Adjust the condition as needed for the middle line
                              return FlLine(
                                color: HexColor("FAFAFA"), // Middle line color
                                strokeWidth: 1, // Middle line width
                              );
                            }
                            return FlLine(
                              color: HexColor("FAFAFA"),
                              strokeWidth: 1,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: (controller.maxY.value + 3000) / 6,
                              getTitlesWidget: (value, meta) {
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  space: 2,
                                  child: Text(controller.formatNumber(value),
                                      style: const TextStyle(fontSize: 10)),
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: bottomTitleWidgets,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            left:
                                BorderSide(color: HexColor("E5E5E5"), width: 1),
                            bottom:
                                BorderSide(color: HexColor("E5E5E5"), width: 1),
                            top: BorderSide.none,
                            right: BorderSide.none,
                          ),
                        ),
                        minX: 0,
                        maxX: maxX,
                        minY: 0,
                        maxY: controller.maxY.value,
                        lineBarsData: [
                          LineChartBarData(
                            spots: controller.principalSpots.value,
                            isCurved: true,
                            color: HexColor("244384"),
                            dotData: const FlDotData(show: true),
                          ),
                          LineChartBarData(
                            spots: controller.interestSpots.value,
                            isCurved: true,
                            color: HexColor("2FAE3B"),
                            dotData: const FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                10.ph,
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 12,
                            width: 12,
                            color: HexColor("2FAE3B"),
                          ),
                          10.pw,
                          globalText10(
                              text: "Total Interest",
                              fontWeight: FontWeight.w400)
                        ],
                      ),
                      20.pw,
                      Row(
                        children: [
                          Container(
                            height: 12,
                            width: 12,
                            color: HexColor("244384"),
                          ),
                          10.pw,
                          globalText10(
                              text: "Principal Value",
                              fontWeight: FontWeight.w400
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.normal, fontSize: 10, fontFamily: "Poppins");
    Widget text = const Text('', style: style);
    print("this is the value $value");
    if (!controller.list.contains(value)) {
      controller.list.add(value);
    }
    print(controller.list);
    var middleValue = (controller.list.length / 2).round();
    print("this is middle value $middleValue");
    if (value == 0.0) {
      text = const Text('Now', style: style);
    } else if (value ==
        double.tryParse(
            (int.parse(controller.yearsOfGrowthController.value.text) / 2)
                .round()
                .toString())) {
      text = Text(
          "${(DateTime.now().year + (int.parse(controller.yearsOfGrowthController.value.text) / 2)).round()}",
          style: style);
    } else if (value ==
        double.tryParse(
            (int.parse(controller.yearsOfGrowthController.value.text))
                .round()
                .toString())) {
      text = Text(
          "${DateTime.now().year + int.parse(controller.yearsOfGrowthController.value.text)}",
          style: style);
    } else {
      text = const SizedBox.shrink();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: text,
    );
  }
}
