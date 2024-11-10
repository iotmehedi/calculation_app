import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/uint_calculator/unit_controller.dart';
import 'package:calculation_app/screens/widgets/container_shadow_widget/container_shadow_widget.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/custom_text/custom_text.dart';
import '../../../widgets/textfield/textField_widget.dart';

class UnitConverter extends StatefulWidget {
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  var controller = Get.put(UnitController());
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          appBar: CustomAppBar(
            title: "Unit Converter",
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
          // bottomNavigationBar: adController.getBannerAdWidget(),
          body: Padding(
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
                                controller.selectedButton.value = "Length";
                                controller.convertedValue.value = 0.0;
                                controller.updateUnits();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: controller.selectedButton.value ==
                                          "Length"
                                      ? Colors.white
                                      : HexColor("244384"),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                      child: CustomText(
                                    text: "Length",
                                    fontSize: 20,
                                    textColor:
                                        controller.selectedButton.value ==
                                                "Length"
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
                                controller.selectedButton.value = "Weight";
                                controller.convertedValue.value = 0.0;
                                controller.updateUnits();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: controller.selectedButton.value ==
                                          "Weight"
                                      ? Colors.white
                                      : HexColor("244384"),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                      child: CustomText(
                                    text: "Weight",
                                    fontSize: 20,
                                    textColor:
                                        controller.selectedButton.value ==
                                                "Weight"
                                            ? HexColor("244384")
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
                                controller.selectedButton.value = "Area";
                                controller.convertedValue.value = 0.0;
                                controller.updateUnits();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color:
                                      controller.selectedButton.value == "Area"
                                          ? Colors.white
                                          : HexColor("244384"),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                      child: CustomText(
                                    text: "Area",
                                    fontSize: 20,
                                    textColor:
                                        controller.selectedButton.value ==
                                                "Area"
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: globalText16(
                          text: "Amount", fontWeight: FontWeight.w500),
                    ),
                    20.pw,
                    Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: 49,
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
                            onChanged: (value){
                              if (controller.selectedButton.value == "Length") {
                                controller.convert(value: value, from: "textfield");
                              } else if (controller.selectedButton.value ==
                                  "Weight") {
                                controller.convertWeight(value: value, from: "textfield");
                              } else {
                                controller.convertArea(value: value, from: "textfield");
                              }
                            },
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: globalText16(
                          text: "From", fontWeight: FontWeight.w500),
                    ),
                    20.pw,
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: HexColor("EDEBEB"), width: 1.5)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                AppAssets.twoArrow,
                                height: 24,
                              ),
                            ),
                            value: controller.fromUnit.value,
                            onChanged: (newValue) {
                              controller.fromUnit.value = newValue!;
                              if (controller.selectedButton.value == "Length") {
                                controller.convert(from: '', value: '');
                              } else if (controller.selectedButton.value ==
                                  "Weight") {
                                controller.convertWeight(from: '', value: '');
                              } else {
                                controller.convertArea(from: '', value: '');
                              }
                            },
                            items: controller
                                .unitFactors[controller.selectedButton.value]!
                                .keys
                                .map((String unit) {
                              return DropdownMenuItem<String>(
                                alignment: AlignmentDirectional.center,
                                value: unit,
                                child: CustomText(
                                  text: unit,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                16.ph,
                Row(
                  children: [
                    Expanded(
                      child:
                          globalText16(text: "To", fontWeight: FontWeight.w500),
                    ),
                    20.pw,
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: HexColor("EDEBEB"), width: 1.5)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                AppAssets.twoArrow,
                                height: 24,
                              ),
                            ),
                            value: controller.toUnit.value,
                            onChanged: (newValue) {
                              controller.toUnit.value = newValue!;
                              if (controller.selectedButton.value == "Length") {
                                controller.convert(from: '', value: '');
                              } else if (controller.selectedButton.value ==
                                  "Weight") {
                                controller.convertWeight(from: '', value: '');
                              } else {
                                controller.convertArea(from: '', value: '');
                              }
                            },
                            items: controller
                                .unitFactors[controller.selectedButton.value]!
                                .keys
                                .map((String unit) {
                              return DropdownMenuItem<String>(
                                alignment: AlignmentDirectional.center,
                                value: unit,
                                child: CustomText(
                                  text: unit,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (controller.convertedValue.value != 0.0)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ContainerShadowWidget(
                      margin: 0.0,
                      widget: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Answer:",
                              fontSize: 16,
                              textColor: HexColor("2FAE3B"),
                              fontWeight: FontWeight.w500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 60, top: 5),
                              child: CustomText(
                                text:
                                    "${controller.textController.value.text} ${controller.fromUnit.value} = ${double.tryParse(controller.convertedValue.value.toString().replaceAll(".0", '').replaceAll(".00", '').replaceAll(".000", ''))} ${controller.toUnit.value}",
                                fontSize: 14,
                                textColor: HexColor("2B2E63"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
