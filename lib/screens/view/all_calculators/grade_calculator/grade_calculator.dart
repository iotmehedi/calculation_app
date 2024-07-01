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
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../widgets/custom_text/custom_text.dart';
import 'letter_widget.dart';



class GPAForm extends StatefulWidget {
  @override
  _GPAFormState createState() => _GPAFormState();
}

class _GPAFormState extends State<GPAForm> {

  var controller = Get.put(GradeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Grade Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => Form(
        key: controller.formKey.value,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 56,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: HexColor("244384"),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.selectedButton.value = true;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: controller.selectedButton.value ==
                                    true
                                    ? Colors.white
                                    : HexColor("244384"),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                    child: CustomText(
                                      text: "Grade",
                                      fontSize: 20,
                                      textColor:
                                      controller.selectedButton.value ==
                                          true
                                          ? Colors.black
                                          : Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        5.pw,
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.selectedButton.value = false;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: controller.selectedButton.value ==
                                    false
                                    ? Colors.white
                                    : HexColor("244384"),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                    child: CustomText(
                                      text: "Final Grade",
                                      fontSize: 20,
                                      textColor:
                                      controller.selectedButton.value ==
                                          false
                                          ? HexColor("244384")
                                          : Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              20.ph,

              globalText16(text: "Select grade type", fontWeight: FontWeight.w500),

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
              // Text('Average Grade: ${controller.averageGrade.toStringAsFixed(2)}%'),
              // Text('Average Letter Grade: ${controller.averageLetterGrade}'),

            ],
          ),
        ),
      )),
    );
  }
}
