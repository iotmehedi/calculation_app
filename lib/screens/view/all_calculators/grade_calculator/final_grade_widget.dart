import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/grade_calculator/grade_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../core/utils/consts/textstyle.dart';
import '../../../../main.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';

class FinalGradeWidget extends StatelessWidget {
  final GradeController controller;
  const FinalGradeWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextFieldCustom(
              headingName: 'Current Grade',
              controller: controller.currentGradeController.value,
              keyboardType: TextInputType.number,
              needPadding: true,
              onlyNeedSuffix: true,
              suffixIcon: Icon(Icons.percent,size: 16, color: AppColors.deepGray1,),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the current grade';
                }
                return null;
              },
            ),

            SizedBox(height: 16),
            CommonTextFieldCustom(
              headingName: 'Target grade you want to \nget in class',
              controller: controller.targetGradeController.value,
              keyboardType: TextInputType.number,
              needPadding: true,
              onlyNeedSuffix: true,
              suffixIcon: Icon(Icons.percent,size: 16, color: AppColors.deepGray1,),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the target grade';
                }
                return null;
              },
            ),



            SizedBox(height: 16),
            CommonTextFieldCustom(
              headingName: 'Final exam weight',
              controller: controller.finalExamWeightController.value,
              keyboardType: TextInputType.number,
              needPadding: true,
              onlyNeedSuffix: true,
              suffixIcon: Icon(Icons.percent,size: 16, color: AppColors.deepGray1,),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the final exam weight';
                }
                return null;
              },
            ),

            SizedBox(height: 16),


            CustomCalculateClearWidget(
              onPressCalculate: () {
                if (controller.formKey.value.currentState?.validate() ?? false) {
                  controller.calculateFinalExamGrade();
                  RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.gradeResultScreen);
                }
              },
              onPressClear: controller.allFieldClear,
              clearButtonTextColor: HexColor("244384"),
              clearButtonFontWeight: FontWeight.w500,
              clearButtonTitleFontSize: 20,
            ),
            SizedBox(height: 16),

          ],
        ),
      ),
    ));
  }
  }


