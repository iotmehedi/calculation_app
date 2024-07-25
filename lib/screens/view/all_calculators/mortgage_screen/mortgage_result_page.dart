import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/mortgage_screen/mortgage_controller.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';

class MortgageResultPage extends StatelessWidget {
  MortgageResultPage({super.key});
  var controller = Get.put(MortgageController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: HexColor("FAFAFA"),
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios)),
            title: const CustomText(
                text: "Mortgage Calculator",
                fontWeight: FontWeight.w600,
                textColor: Colors.black,
                fontSize: 20.0),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        HexColor('33743A'),
                        HexColor('FAFFFA'),
                      ],
                      stops: [
                        0.0,
                        1.0,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child:
                        globalText24(text: "Calculator", color: Colors.white),
                  ),
                ),
                20.ph,
                CustomResultMonthly(
                  title: NumberFormat('#,##0.00', 'en_US')
                      .format(controller.principalAndInterest.value),
                  heading: "Monthly Payment:",
                  headingColor: Colors.green,
                  titleColor: Colors.white,
                ),
                20.ph,
                Visibility(
                  visible: controller.isChecked.value == true ? true : false,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ContainerShadowWidget(
                      widget: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: CustomText(
                                  text: "Principal & Interest:",
                                  textColor: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                                Expanded(
                                  child: Obx(
                                    () {
                                      // Convert value to double
                                      double numericValue =
                                          controller.principalAndInterest.value;

                                      // Format the value with commas and two decimal places
                                      String formattedValue =
                                          NumberFormat('#,##0.00', 'en_US')
                                              .format(numericValue);

                                      return CustomText(
                                        text: "\$ $formattedValue",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 0.2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: CustomText(
                                  text: "Property Tax:",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                                Expanded(
                                  child: Obx(
                                    () {
                                      // Convert value to double
                                      double numericValue =
                                          controller.monthlyPropertyTax.value;

                                      // Format the value with commas and two decimal places
                                      String formattedValue =
                                          NumberFormat('#,##0.00', 'en_US')
                                              .format(numericValue);

                                      return CustomText(
                                        text: "\$ $formattedValue",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            5.ph,
                            Row(
                              children: [
                                Expanded(
                                    child: CustomText(
                                  text: "Home Insurance:",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                                Expanded(
                                  child: Obx(
                                    () {
                                      // Convert value to double
                                      double numericValue =
                                          controller.monthlyHomeInsurance.value;

                                      // Format the value with commas and two decimal places
                                      String formattedValue =
                                          NumberFormat('#,##0.00', 'en_US')
                                              .format(numericValue);

                                      return CustomText(
                                        text: "\$ $formattedValue",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            5.ph,
                            Row(
                              children: [
                                Expanded(
                                    child: CustomText(
                                  text: "PMI Fee:",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                                Expanded(
                                  child: Obx(
                                    () {
                                      // Convert value to double
                                      double numericValue =
                                          controller.monthlyPMI.value;

                                      // Format the value with commas and two decimal places
                                      String formattedValue =
                                          NumberFormat('#,##0.00', 'en_US')
                                              .format(numericValue);

                                      return CustomText(
                                        text: "\$ $formattedValue",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            5.ph,
                            Row(
                              children: [
                                Expanded(
                                    child: CustomText(
                                  text: "HOA Fee:",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                                Expanded(
                                  child: Obx(
                                    () {
                                      // Convert value to double
                                      double numericValue =
                                          controller.monthlyHOAFee.value;

                                      // Format the value with commas and two decimal places
                                      String formattedValue =
                                          NumberFormat('#,##0.00', 'en_US')
                                              .format(numericValue);

                                      return CustomText(
                                        text: "\$ $formattedValue",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 0.2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: CustomText(
                                  text: "Total Payment:",
                                  fontSize: 16,
                                  textColor: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                )),
                                Expanded(
                                  child: Obx(
                                    () {
                                      // Convert value to double
                                      double numericValue =
                                          (controller.monthlyPropertyTax.value +
                                              controller.monthlyPMI.value +
                                              controller
                                                  .monthlyHomeInsurance.value +
                                              controller.monthlyHOAFee.value);

                                      // Format the value with commas and two decimal places
                                      String formattedValue =
                                          NumberFormat('#,##0.00', 'en_US')
                                              .format(numericValue);

                                      return CustomText(
                                        text: "\$ $formattedValue",
                                        fontSize: 20,
                                        textColor: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      );
                                    },
                                  ),
                                ),
                                // Expanded(
                                //     child: CustomText(
                                //   text:
                                //       "\$ ${(controller.monthlyPropertyTax.value + controller.monthlyPMI.value + controller.monthlyHomeInsurance.value + controller.monthlyHOAFee.value).toStringAsFixed(2)}",
                                //   fontSize: 20,
                                //   textColor: Colors.blue,
                                //   fontWeight: FontWeight.w500,
                                // )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                10.ph,
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFFFAFAFA)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 140,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: PieChart(
                                  PieChartData(
                                    sections: controller.showingSections(),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 4,
                                    centerSpaceRadius: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (controller.isChecked.value == false)
                                CustomRow(
                                    color: HexColor("458EEC"),
                                    text: "Principal"),
                              if (controller.isChecked.value == false) 10.ph,
                              if (controller.isChecked.value == false)
                                CustomRow(
                                    color: Colors.green, text: "Interest"),
                              if (controller.isChecked.value == false) 10.ph,
                              if (controller.isChecked.value == true)
                                CustomRow(
                                    color: Colors.blue, text: "Principal"),
                              if (controller.isChecked.value == true) 10.ph,
                              if (controller.isChecked.value == true)
                                CustomRow(
                                    color: Colors.green,
                                    text: "Home Insurance"),
                              if (controller.isChecked.value == true) 10.ph,
                              if (controller.isChecked.value == true)
                                CustomRow(
                                    color: HexColor("99CBF7"),
                                    text: "Property Tax"),
                              if (controller.isChecked.value == true) 10.ph,
                              if (controller.isChecked.value == true)
                                CustomRow(
                                    color: HexColor("FAE15D"), text: "HOA Fee"),
                              if (controller.isChecked.value == true) 10.ph
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                10.ph,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFFFAFAFA)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: CustomText(
                                text: "House Price:",
                                textColor: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                              Expanded(
                                child: Obx(
                                  () {
                                    // Convert value to double
                                    double? numericValue = double.tryParse(
                                        controller
                                            .homePriceController.value.text);

                                    // Format the value with commas and two decimal places
                                    String formattedValue =
                                        NumberFormat('#,##0.00', 'en_US')
                                            .format(numericValue);

                                    return CustomText(
                                      text: "\$ ${formattedValue}",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomText(
                                text: "Loan Amount:",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                              Expanded(
                                  child: CustomText(
                                text: "\$ ${controller.loanAmount.value}",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                            ],
                          ),
                          5.ph,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomText(
                                text: "Down Payment:",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                              Expanded(
                                child: Obx(
                                  () {
                                    // Convert value to double
                                    double numericValue =
                                        controller.downPaymentValue.value;

                                    // Format the value with commas and two decimal places
                                    String formattedValue =
                                        NumberFormat('#,##0.00', 'en_US')
                                            .format(numericValue);

                                    return CustomText(
                                      text: "\$ $formattedValue",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          5.ph,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomText(
                                text: "Total Interest:",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                              Expanded(
                                child: Obx(
                                  () {
                                    // Convert value to double
                                    double numericValue =
                                        controller.totalInterestt.value;

                                    // Format the value with commas and two decimal places
                                    String formattedValue =
                                        NumberFormat('#,##0.00', 'en_US')
                                            .format(numericValue);

                                    return CustomText(
                                      text: "\$ $formattedValue",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          5.ph,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomText(
                                text: "Total Mortgage Payments:",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                              Expanded(
                                child: Obx(
                                  () {
                                    // Convert value to double
                                    double numericValue =
                                        controller.totalPaymentt.value;

                                    // Format the value with commas and two decimal places
                                    String formattedValue =
                                        NumberFormat('#,##0.00', 'en_US')
                                            .format(numericValue);

                                    return CustomText(
                                      text: "\$ $formattedValue",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          5.ph,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomText(
                                text: "Mortgage Payoff Date:",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                              Expanded(
                                  child: CustomText(
                                text:
                                    "\$ ${controller.mortgagePayoffDatee.value}",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                            ],
                          ),
                          5.ph,
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget CustomRow({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: color),
        ),
        5.pw,
        CustomText(
          text: text,
          fontSize: 14,
        ),
      ],
    );
  }
}
