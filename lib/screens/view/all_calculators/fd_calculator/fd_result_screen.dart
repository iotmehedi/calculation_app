import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/brm_calculator/brm_result_screen.dart';
import 'package:calculation_app/screens/view/all_calculators/sip_calculator/sip_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_divider/custom_divider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_pie_chart/common_pie_chart_widget.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';
import '../../../widgets/custom_text/custom_text.dart';
import 'fd_controller.dart';

class FDResultScreen extends StatelessWidget {
   FDResultScreen({super.key});
var controller = Get.find<FDController>();
   // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'FD Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      // bottomNavigationBar: adController.getBannerAdWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Calculation", gradiantColorNeed: true,),
            20.ph,
            ContainerShadowWidget(
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomRow(title: "Investment Amount:", value: "₹ ${NumberFormat('#,##,##', 'en_US')
                    .format(controller.investmentAmount.round())}", titleFontWeight: FontWeight.w500, headingFontWeight: FontWeight.normal, titleColor: AppColors.deepGray1),
                    10.ph,
                    CustomRow(title: "Est. Return:", value: "₹ ${NumberFormat('#,##,##', 'en_US')
                        .format(controller.estimatedReturn.round())}", titleFontWeight: FontWeight.w500, headingFontWeight: FontWeight.normal, titleColor: AppColors.deepGray1),
                    const CustomDivider(),
                    CustomRow(title: "Total Value:", value: "\$ ${NumberFormat('#,##,##', 'en_US')
                        .format(controller.totalValue.round())}", titleFontWeight: FontWeight.w500, headingFontWeight: FontWeight.w500, titleColor: Colors.blue, headingColor: Colors.blue),

                  ],
                ),
              ),
            ),
            20.ph,
            CommonPieChartWidget(list: controller.list, total: controller.total.value, netPriceColor: "458EEC", taxAmountColor: "99CBF7", netTitle: "Total Investment", taxTitle: "Total Return", badgeWidgetVisibleOrNot: true,),
            70.ph,
            // adController.getNativeAdWidget(),
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
