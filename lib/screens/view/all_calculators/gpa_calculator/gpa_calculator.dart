import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/gpa_calculator/gpa_controller.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../../main.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CourseForm(),
    );
  }
}

class CourseForm extends StatefulWidget {
  @override
  _CourseFormState createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  var controller = Get.put(GPAController());
  var adController = Get.put(AdService());
  // @override
  // void dispose() {
  //   for (var controller in controller.courseControllers) {
  //     controller.dispose();
  //   }
  //   for (var controller in controller.instructorControllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "GPA Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      bottomNavigationBar: adController.getBannerAdWidget(),
      body: Obx(
        () => Form(
          key: controller.formKey.value,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: globalText12(
                            text: "Course (Optional)",
                            fontWeight: FontWeight.w500,
                            color: Colors.blue)),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: globalText12(
                          text: "Credits",
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    )),
                    Expanded(
                        child: globalText12(
                            text: "Grade",
                            fontWeight: FontWeight.w500,
                            color: Colors.blue)),
                  ],
                ),
                10.ph,
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.courseControllers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("#F3F6F9"),
                                        borderRadius: BorderRadius.circular(12)),
                                    child: TextFormField(
                                      controller: controller.courseControllers[index],
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(right: 10, left: 10),
                                      ),
                                      validator: (value){
                                        if (value!.isEmpty) {
                                          return 'Please enter the course';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("#F3F6F9"),
                                        borderRadius: BorderRadius.circular(12)),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.instructorControllers[index],
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(right: 10, left: 10),
                                      ),
                                      validator: (value){
                                        if (value!.isEmpty) {
                                          return 'Enter ${controller.courseControllers[index]}';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: HexColor("#F3F6F9"),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: DropdownButton<String>(
                                        menuMaxHeight: 300,
                                        value: controller.selectedGrades[index],
                                        icon: const Column(
                                          children: [
                                            Icon(
                                              Icons.keyboard_arrow_up,
                                              size: 16,
                                            ),
                                            SizedBox(height: 0),
                                            Icon(
                                              Icons.keyboard_arrow_down_outlined,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            controller.selectedGrades[index] =
                                                newValue!;
                                          });
                                        },
                                        items: controller.gradeOptions
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            10.ph,
                            controller.courseControllers.length - 1 == index ?  InkWell(
                                onTap: (){
                                  controller.addCourse();
                                },
                                child: CustomText(text: "+ Add More Course", textColor: HexColor("244384"), fontSize: 18, fontWeight: FontWeight.w600,)) : SizedBox(),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                10.ph,
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomElevatedButton(
                          color: HexColor("244384"),
                          onPress: (){
                            if (controller.formKey.value.currentState?.validate() ?? false) {
                              controller.overallGPA.value = 0.0;
                              controller.totalCredit.value = 0;
                              controller.totalCreditWithoutPNP.value = 0;
                              controller.totalGrades();
                              controller.totalGPA();
                              RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.gpaCalculatorResultScreen);
                            }

                          },
                          text: const Text(
                            "Calculate",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      10.pw,

                      Expanded(
                        child: CustomElevatedButton(
                          color: HexColor("F3F6F9"),
                          onPress: (){
                            // controller.clearFields();
                          },
                          text: Text(
                            "Clear",
                            style: TextStyle(
                                color: HexColor("0F182E"),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
