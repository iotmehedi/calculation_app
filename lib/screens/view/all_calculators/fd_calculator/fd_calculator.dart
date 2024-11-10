import 'dart:math';

import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/fd_calculator/fd_controller.dart';
import 'package:calculation_app/screens/view/all_calculators/sip_calculator/sip_controller.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_custom_richText/common_custom_richText.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';

class FDCalculatorHome extends StatefulWidget {
  @override
  _FDCalculatorHomeState createState() => _FDCalculatorHomeState();
}

class _FDCalculatorHomeState extends State<FDCalculatorHome> {
  var controller = Get.put(FDController());
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'FD Calculator',
        onBackPressed: () {
          Navigator.pop(context);
          controller.allFieldClear();
        },
      ),
      // bottomNavigationBar: adController.getBannerAdWidget(),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey.value,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    20.ph,
                    CommonTextFieldCustom(
                      headingName: 'Total Investment',
                      controller: controller.investmentController.value,
                      keyboardType: TextInputType.number,
                      hint: "₹",
                      needPadding: true,
                      onlyNeedSuffix: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter total investment';
                        }
                        return null;
                      },
                    ),
                    10.ph,
                    CommonRichTextFieldCustom(
                      titleName: "(p.a)",
                      titleTextColor: Colors.blue,
                      titleFontSIze: 14.0,
                      headingFontSize: 16.0,
                      titleFontWeight: FontWeight.w400,
                      headingFontWeight: FontWeight.w400,
                      headingName: 'Expected Of Return ',
                      headingTextColor: Colors.black,
                      controller: controller.rateOfReturnController.value,
                      keyboardType: TextInputType.number,
                      needPadding: true,
                      suffixIcon: Icon(Icons.percent, color: AppColors.deepGray1, size: 14,),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter expected of return';
                        }
                        return null;
                      },
                    ),
                    10.ph,
                    CommonRichTextFieldCustom(
                      titleName: "(Year)",
                      titleTextColor: Colors.blue,
                      titleFontSIze: 14.0,
                      headingFontSize: 16.0,
                      titleFontWeight: FontWeight.w400,
                      headingFontWeight: FontWeight.w400,
                      headingName: 'Time Period ',
                      controller: controller.timePeriodController.value,
                      keyboardType: TextInputType.number,
                      needPadding: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter time period';
                        }
                        return null;
                      },
                    ),
                    10.ph,
                    const SizedBox(height: 20),

                    CustomCalculateClearWidget(
                      onPressCalculate: () {
                        if (controller.formKey.value.currentState!
                            .validate()) {
                          controller.calculateFD();
                        }
                      },
                      onPressClear: controller.allFieldClear,
                      clearButtonTextColor: HexColor("244384"),
                      clearButtonFontWeight: FontWeight.w500,
                      clearButtonTitleFontSize: 20,
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
            ),
          )),
    );
  }
}
