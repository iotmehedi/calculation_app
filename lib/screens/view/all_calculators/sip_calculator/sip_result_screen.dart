import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/brm_calculator/brm_result_screen.dart';
import 'package:calculation_app/screens/view/all_calculators/sip_calculator/sip_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/custom_text/custom_text.dart';

class SIPResultScreen extends StatelessWidget {
   SIPResultScreen({super.key});
var controller = Get.find<SIPController>();
   // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: "SIP Calculator"),
    //     bottomNavigationBar: Column(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Calculation"),
            20.ph,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: Color(0xFFFAFAFA)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x07101010),
                      blurRadius: 45,
                      offset: Offset(0, 8),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomRow(title: "Investment Amount:", value: "\₹ ${NumberFormat('#,##,##0.00', 'en_US').format(controller.investmentAmount.round()).replaceAll(".00", "")}", titleFontWeight: FontWeight.w500, headingFontWeight: FontWeight.w500,titleColor: AppColors.deepGray1),
                      10.ph,
                      CustomRow(title: "Est. Return:", value: "\₹ ${NumberFormat('#,##,##0.00', 'en_US').format(controller.estReturn.round()).replaceAll(".00", "")}", titleFontWeight: FontWeight.w500, headingFontWeight: FontWeight.normal,titleColor: AppColors.deepGray1),
                      Divider(
                        thickness: 0.5,
                      ),
                      CustomRow(title: "Total Value:", value: "\₹ ${NumberFormat('#,##,##0.00', 'en_US').format(controller.totalValue.round()).replaceAll(".00", "")}", titleFontWeight: FontWeight.w500, headingFontWeight: FontWeight.w500, titleColor: AppColors.blue, headingColor: Colors.blue),

                    ],
                  ),
                ),
              ),
            ),
            20.ph,
            SizedBox(
              height: 150,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: Color(0xFFFAFAFA)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x07101010),
                      blurRadius: 45,
                      offset: Offset(0, 8),
                      spreadRadius: 0,
                    )
                  ],
                ),
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
                                sections: controller.showingSections(),
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
                              color: HexColor("458EEC"), text: "Investment Amount"),
                          10.ph,
                          CustomRoww(
                              color: HexColor("99CBF7"), text: "Est.Return"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
           fontWeight: FontWeight.w400,
         ),
       ],
     );
   }
}
