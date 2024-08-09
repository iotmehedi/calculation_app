import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/grade_calculator/grade_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../widgets/custom_text/custom_text.dart';

class LetterWidget extends StatelessWidget {
  final GradeController controller;
  const LetterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
        height: 300,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(padding: const EdgeInsets.only(right: 20), child: globalText12(
                        text: "Assignment (Optional)",
                        alignment: Alignment.center,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),)),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: globalText12(
                      text: "Grade Letter",
                      fontWeight: FontWeight.w500,
                      alignment: Alignment.center,
                      color: Colors.blue),
                )),
                Expanded(
                    child: globalText12(
                        text: "Weight",
                        fontWeight: FontWeight.w500,
                        alignment: Alignment.center,
                        color: Colors.blue)),
              ],
            ),
            10.ph,
            Expanded(
              child: ListView.builder(
                itemCount: controller.courseControllersLetter.length,
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
                                  controller:
                                      controller.courseControllersLetter[index],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(right: 10, left: 10),
                                  ),
                                  validator: (value) {
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
                                      controller.selectedGrades[index] =
                                          newValue!;
                                    },
                                    items: controller.gradeOptions
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: CustomText(text: value),
                                        ),
                                      );
                                    }).toList(),
                                  ),
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
                                  controller: controller
                                      .instructorControllersLetter[index],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(right: 10, left: 10),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter ${controller.courseControllers[index]}';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        10.ph,
                        controller.courseControllersLetter.length - 1 == index
                            ? InkWell(
                                onTap: () {
                                  controller.addCourseLetter();
                                },
                                child: CustomText(
                                  text: "+ Add More Course",
                                  textColor: HexColor("244384"),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ))
                            : SizedBox(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        )));
  }
}
