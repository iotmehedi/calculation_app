import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../core/utils/consts/common_method.dart';
import '../custom_text/custom_text.dart';

class CommonPieChartWidget extends StatelessWidget {
final RxList list;
  final double total;
  final String netPriceColor,taxAmountColor;
  const CommonPieChartWidget({super.key, required this.total, required this.list, required this.netPriceColor, required this.taxAmountColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 150,
        child: Card(
          color: Colors.white,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 140,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PieChart(
                        PieChartData(
                          sections: CommonMethod().showingSections(
                              list: list,
                              total: total,
                              principalColor: netPriceColor,
                              interestColor: taxAmountColor),
                          borderData: FlBorderData(
                            show: true,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRoww(
                        color: HexColor("FF9466"), text: "Loan Amount"),
                    CustomRoww(
                        color: HexColor("0F182E"),
                        text: "Total Interest"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget CustomRoww({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: color),
        ),
        5.pw,
        CustomText(
          text: text,
          fontSize: 14,
        ),
      ],
    );
  }
}
