import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/grade_calculator/grade_controller.dart';
import 'package:calculation_app/screens/view/all_calculators/grade_calculator/percentage_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../core/utils/consts/textstyle.dart';
import '../../../../main.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';
import 'letter_widget.dart';

class GradeWidget extends StatelessWidget {
  final GradeController controller;
  const GradeWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: SingleChildScrollView(
        child: Column(
          children: [
            globalText16(text: "Select grade type", fontWeight: FontWeight.w500),
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio<String>(
                      fillColor: MaterialStateProperty.resolveWith ((Set  states) {
                        if (states.contains(MaterialState.disabled)) {
                          return HexColor("244384");
                        }
                        return HexColor("244384");
                      }),
                      groupValue: controller.radioButtonStatus.value,
                      onChanged: (value) {
                        controller.radioButtonStatus.value = value ?? '';
                      },
                      value: "1",
                    ),
                    globalText16(
                        text: "Percentage",
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<String>(
                      fillColor: MaterialStateProperty.resolveWith ((Set  states) {
                        if (states.contains(MaterialState.disabled)) {
                          return HexColor("244384");
                        }
                        return HexColor("244384");
                      }),
                      groupValue: controller.radioButtonStatus.value,
                      onChanged: (value) {
                        // controller.instructorControllers.clear();
                        controller.radioButtonStatus.value = value ?? '';
                        // controller.addCourseLetter();
                        // controller.initialCourse();
                      },
                      value: "2",
                    ),
                    globalText16(
                        text: "Letters",
                        fontWeight: FontWeight.w500),
                  ],
                ),

              ],
            ),
            20.ph,

            controller.radioButtonStatus.value == "1" ? PercentageWidget(controller: controller) : LetterWidget(controller: controller),
            // ElevatedButton(
            //   onPressed: controller.calculateAdditionalGrade,
            //   child: Text('Calculate Additional Grade Needed'),
            // ),
            10.ph,
            SizedBox(
              height: 45,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomElevatedButton(
                      color: HexColor("244384"),
                      onPress: (){
                        if (controller.formKey.value.currentState?.validate() ?? false) {
                          if(controller.radioButtonStatus.value == "1"){
                            controller.calculateAdditionalGrade();
                          }else{
                            controller.overallGPA.value = 0.0;
                            controller.totalCredit.value = 0;
                            controller.totalCreditWithoutPNP.value = 0;
                            controller.totalGrades();
                            controller.totalGPA();
                          }

                          RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.gradeResultScreen);
                        }
                      },
                      text: globalText20(text: "Calculate", color: Colors.white, alignment: Alignment.center, fontWeight: FontWeight.w500),
                    ),
                  ),
                  10.pw,

                  Expanded(
                    child: CustomElevatedButton(
                      color: HexColor("F3F6F9"),
                      onPress: (){
                        // controller.clearFields();
                      },
                      text: globalText20(text: "Clear", color: HexColor("0F182E"), alignment: Alignment.center, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
