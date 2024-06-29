import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/mortgage_screen/mortgage_controller.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class MortgageResultPage extends StatelessWidget {
  MortgageResultPage({super.key});
  var controller = Get.put(MortgageController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios)),
            title: const CustomText(
                text: "Mortgage Calculator",
                fontWeight: FontWeight.w800,
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
                40.ph,
                Row(
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
                              color: HexColor("458EEC"), text: "Principal"),
                          if (controller.isChecked.value == false)
                          10.ph,
                          if (controller.isChecked.value == false)
                            CustomRow(color: Colors.green, text: "Interest"),
                          if (controller.isChecked.value == false) 10.ph,
                          if (controller.isChecked.value == true)
                            CustomRow(color: Colors.blue, text: "Principal & Interest"),
                          if (controller.isChecked.value == true) 10.ph,
                          if (controller.isChecked.value == true)
                            CustomRow(color: Colors.green, text: "Home Insurance"),
                          if (controller.isChecked.value == true) 10.ph,
                          if (controller.isChecked.value == true)
                            CustomRow(color: HexColor("99CBF7"), text: "Property Taxes"),
                          if (controller.isChecked.value == true) 10.ph,
                          if (controller.isChecked.value == true)
                            CustomRow(color: HexColor("80848A"), text: "HOA Fee"),
                          if (controller.isChecked.value == true) 10.ph
                        ],
                      ),
                    ),
                  ],
                ),
                40.ph,
                Visibility(
                  visible: controller.isChecked.value == true ? true : false,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
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
                                  text: "Principal Interest:",
                                  textColor: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                )),
                                Expanded(
                                    child: CustomText(
                                        text:
                                            "\$ ${controller.principalAndInterest.value.toStringAsFixed(2)}")),
                              ],
                            ),
                            Divider(
                              thickness: 0.2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: CustomText(text: "Property Tax:")),
                                Expanded(
                                    child: CustomText(
                                        text:
                                            "\$ ${controller.monthlyPropertyTax.value.toStringAsFixed(2)}")),
                              ],
                            ),
                            5.ph,
                            Row(
                              children: [
                                Expanded(
                                    child: CustomText(text: "Home Insurance:")),
                                Expanded(
                                    child: CustomText(
                                        text:
                                            "\$ ${controller.monthlyHomeInsurance.value.toStringAsFixed(2)}")),
                              ],
                            ),
                            5.ph,
                            Row(
                              children: [
                                Expanded(child: CustomText(text: "PMI Fee:")),
                                Expanded(
                                    child: CustomText(
                                        text:
                                            "\$ ${controller.monthlyPMI.value.toStringAsFixed(2)}")),
                              ],
                            ),
                            5.ph,
                            Row(
                              children: [
                                Expanded(child: CustomText(text: "HOA Fee:")),
                                Expanded(
                                    child: CustomText(
                                        text:
                                            "\$ ${controller.monthlyHOAFee.value.toStringAsFixed(2)}")),
                              ],
                            ),
                            5.ph,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.isChecked.value == true ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: CustomText(
                          text: "Total Amount:",
                          fontSize: 20,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w500,
                        )),
                        Expanded(
                            child: CustomText(
                          text:
                              "\$ ${(controller.monthlyPropertyTax.value + controller.monthlyPMI.value + controller.monthlyHomeInsurance.value + controller.monthlyHOAFee.value).toStringAsFixed(2)}",
                          fontSize: 20,
                          textColor: Colors.blue,
                          fontWeight: FontWeight.w500,
                        )),
                      ],
                    ),
                  ),
                ),
                10.ph,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
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
                                fontWeight: FontWeight.bold,
                              )),
                              Expanded(
                                  child: CustomText(
                                      text:
                                          "\$ ${controller.homePriceController.value.text}")),
                            ],
                          ),
                          Divider(
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              Expanded(child: CustomText(text: "Loan Amount:")),
                              Expanded(
                                  child: CustomText(
                                      text:
                                          "\$ ${controller.loanAmount.value}")),
                            ],
                          ),
                          5.ph,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomText(text: "Down Payment:")),
                              Expanded(
                                  child: CustomText(
                                      text:
                                          "\$ ${controller.downPaymentValue.value}")),
                            ],
                          ),
                          5.ph,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomText(text: "Total Interest:")),
                              Expanded(
                                  child: CustomText(
                                      text:
                                          "\$ ${controller.totalInterestt.value.toStringAsFixed(2)}")),
                            ],
                          ),
                          5.ph,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomText(
                                      text: "Total Mortgage Payments:")),
                              Expanded(
                                  child: CustomText(
                                      text:
                                          "\$ ${controller.totalPaymentt.value.toStringAsFixed(2)}")),
                            ],
                          ),
                          5.ph,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomText(
                                      text: "Mortgage Payoff Date:")),
                              Expanded(
                                  child: CustomText(
                                      text:
                                          "\$ ${controller.mortgagePayoffDatee.value}")),
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
