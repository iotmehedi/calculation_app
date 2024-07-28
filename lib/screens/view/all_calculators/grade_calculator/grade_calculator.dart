import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/grade_calculator/grade_controller.dart';
import 'package:calculation_app/screens/view/all_calculators/grade_calculator/grade_widget.dart';
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
import 'final_grade_widget.dart';
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
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Grade Calculator",
        onBackPressed: () {
          Navigator.pop(context);
          controller.allFieldClear();
        },
      ),
      body: Obx(() => Form(
        key: controller.formKey.value,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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

                controller.selectedButton.value == true ?  GradeWidget(controller: controller) : FinalGradeWidget(controller:controller)
                // Text('Average Grade: ${controller.averageGrade.toStringAsFixed(2)}%'),
                // Text('Average Letter Grade: ${controller.averageLetterGrade}'),

              ],
            ),
          ),
        ),
      )),
    );
  }
}
