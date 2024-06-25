import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/brm_calculator/brm_result_screen.dart';
import 'package:calculation_app/screens/view/all_calculators/sip_calculator/sip_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/common_pie_chart/common_pie_chart_widget.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/custom_text/custom_text.dart';
import 'fd_controller.dart';

class FDResultScreen extends StatelessWidget {
   FDResultScreen({super.key});
var controller = Get.find<FDController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FAFAFA"),
      appBar: CustomAppBar(title: "FD Calculator"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Calculation"),
            20.ph,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomRow(title: "Investment Amount:", value: "\$ ${controller.investmentAmount.round()}", titleFontWeight: FontWeight.normal, headingFontWeight: FontWeight.normal),
                      10.ph,
                      CustomRow(title: "Est. Return:", value: "\$ ${controller.estimatedReturn.round()}", titleFontWeight: FontWeight.normal, headingFontWeight: FontWeight.normal),
                      Divider(
                        thickness: 0.5,
                      ),
                      CustomRow(title: "Total Value:", value: "\$ ${controller.totalValue.round()}", titleFontWeight: FontWeight.normal, headingFontWeight: FontWeight.normal, titleColor: Colors.blue, headingColor: Colors.blue),

                    ],
                  ),
                ),
              ),
            ),
            20.ph,
            CommonPieChartWidget(list: controller.list, total: controller.total.value, netPriceColor: "458EEC", taxAmountColor: "99CBF7", netTitle: "Total Investment", taxTitle: "Total Return"),
          ],
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
