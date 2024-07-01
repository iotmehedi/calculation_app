import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/grade_calculator/grade_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../widgets/custom_text/custom_text.dart';

class PercentageWidget extends StatelessWidget {
  final GradeController controller;
   PercentageWidget({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: globalText12(
                      text: "Assignment (Optional)",
                      fontWeight: FontWeight.w500,
                      color: Colors.blue)),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: globalText12(
                        text: "Grade %",
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  )),
              Expanded(
                  child: globalText12(
                      text: "Weight",
                      fontWeight: FontWeight.w500,
                      color: Colors.blue)),
            ],
          ),
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
                                controller.weightControllers[index],
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
                            child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor("#F3F6F9"),
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller:
                                controller.gradeControllers[index],
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
                        ],
                      ),
                      10.ph,
                      controller.courseControllers.length - 1 == index ?  InkWell(
                          onTap: (){
                            controller.addCourse();
                          },
                          child: CustomText(text: "+ Add More Course", textColor: HexColor("244384"), fontSize: 18, fontWeight: FontWeight.w600,)) : const SizedBox(),
                    ],
                  ),
                );
              },
            ),
          ),
          const CustomText(text: "Find additional grade needed to get average grade of (assumes weights in %)", fontSize: 14, fontWeight: FontWeight.normal,),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: HexColor("#F3F6F9"),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller:
                    controller.additionalWeightController.value,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                        suffixIcon: Icon(Icons.percent, size: 14, color: HexColor("80848A"),)
                    ),
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'Enter additional needed';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const Expanded(child: SizedBox())
            ],
          ),
        ],
      ),
    ));
  }
}
