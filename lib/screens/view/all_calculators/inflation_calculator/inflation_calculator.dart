import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/routes/router.dart';
import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../../main.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../widgets/custom_text/custom_text.dart';
import 'inflation_controller.dart';


class InflationCalculatorPage extends StatelessWidget {
  final InflationCalculatorController controller = Get.put(InflationCalculatorController());
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: "Inflation Calculator",
        onBackPressed: (){
        controller.setAmount('');
          Navigator.pop(context);
        },
      ),
      // bottomNavigationBar: adController.getBannerAdWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: globalText16(
                      text: "Amount", fontWeight: FontWeight.w500,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  20.pw,
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 44,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: controller.textController.value,
                            decoration: InputDecoration(
                              isDense: false,
                              isCollapsed: false,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor("EDEBEB"), width: 1.5),
                              ),
                              filled: true,
                              fillColor: HexColor("#FFFFFFF"),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor("#EDEBEB"), width: 1.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onChanged: (value) => controller.setAmount(value),
                          ),
                        ),
                      )),
                ],
              ),

              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: globalText16(
                      text: "In", fontWeight: FontWeight.w500,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  20.pw,
                  MonthDropdown('From'),
                  SizedBox(width: 16),
                  YearDropdown('From'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: globalText16(
                      text: "In", fontWeight: FontWeight.w500,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  20.pw,
                  MonthDropdown('To'),
                  SizedBox(width: 16),
                  YearDropdown('To'),
                ],
              ),
              SizedBox(height: 55),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomElevatedButton(
                  color: HexColor("244384"),
                  onPress: controller.calculateInflation,
                  // RouteGenerator.pushNamed(context, Routes.mortgageResultPage);
                  text: const Text(
                    "Calculate",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),
    ));
  }
}

class MonthDropdown extends StatelessWidget {
  final String label;

  MonthDropdown(this.label);

  @override
  Widget build(BuildContext context) {
    final InflationCalculatorController controller = Get.find();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Obx(() => DropdownButtonHideUnderline(
          child: Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: HexColor("EDEBEB"), width: 1.5)),
            child: DropdownButton<String>(
              icon: Image.asset(AppAssets.arrowDown, height: 4, width: 10,),
              value: controller.getMonthValue(label),
              onChanged: (value) => controller.setMonthValue(label, value!),
              items: controller.monthItems,
            ),
          ),
        )),
      ],
    );
  }
}

class YearDropdown extends StatelessWidget {
  final String label;

  YearDropdown(this.label);

  @override
  Widget build(BuildContext context) {
    final InflationCalculatorController controller = Get.find();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => DropdownButtonHideUnderline(
          child: Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: HexColor("EDEBEB"), width: 1.5)),
            child: DropdownButton<String>(
              icon: Image.asset(AppAssets.arrowDown, height: 4, width: 10,),
              value: controller.getYearValue(label),
              onChanged: (value) => controller.setYearValue(label, value!),
              items: controller.yearItems,
            ),
          ),
        )),
      ],
    );
  }
}




