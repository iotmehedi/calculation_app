import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/consts/textstyle.dart';
import 'auto_loan_calculator_controller.dart';

class AutoLoanCalculatorResult extends StatelessWidget {
  AutoLoanCalculatorResult({super.key});
  var controller = Get.find<LoanController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FAFAFA"),
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const CustomText(
            text: "Auto loan Calculator",
            fontWeight: FontWeight.w800,
            textColor: Colors.black,
            fontSize: 20.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                child: globalText24(text: "Calculation", color: Colors.white),
              ),
            ),
            20.ph,
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: CustomText(
                text: "Your loan estimate:",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            10.ph,
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: HexColor("0F182E"),
              child: Center(
                child: CustomRichText(
                  title: "\$" +
                      controller.monthlyPaymentt.value
                          .toStringAsFixed(2)
                          .toString(),
                  titleTextColor: HexColor("FFFFFFFF"),
                  heading: "Monthly Payment: ",
                  headingTextColor: HexColor("6BDF74"),
                ),
              ),
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomRow(
                                      title: "Loan Amount",
                                      value: controller.loanAmount
                                          .toStringAsFixed(2)
                                          .toString()),
                                  10.ph,
                                  CustomRow(
                                      title: "Sales Tax",
                                      value: controller.salesTaxAmount
                                          .toStringAsFixed(2)
                                          .toString()),
                                          10.ph,
                                  CustomRow(
                                      title: "Upfront Payment",
                                      value: controller.upfrontPayment
                                          .toStringAsFixed(2)
                                          .toString()),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 0.5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomRow(
                                      title: "Total Interest Cost",
                                      value: controller.totalLoanInterest
                                          .toStringAsFixed(2)
                                          .toString()),
                                          10.ph,
                                  CustomRow(
                                      title: "Total Loan Payments",
                                      value: controller.totalLoanPayments
                                          .toStringAsFixed(2)
                                          .toString()),
                                          10.ph,
                                  CustomRow(
                                    title: "Pay Of Date",
                                    value:
                                        '${DateFormat("MM/yyyy").format(controller.payOutDate.toLocal())}'
                                            .split(' ')[0],
                                    valueColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 0.5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomRow(
                                  title: "Total All Cost:",
                                  value:
                                      "${(controller.loanAmount + controller.salesTaxAmount + controller.upfrontPayment + controller.totalLoanInterest + controller.totalLoanPayments).toStringAsFixed(2)}",
                                  titleColor: Colors.blue),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CustomRow(
      {required String title,
      required String value,
      MaterialColor? valueColor,
      MaterialColor? titleColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: CustomText(
          text: title,
          textColor: titleColor,
          fontSize: 14,
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CustomText(
            text: "\$ " + value,
            textColor: valueColor,
            fontSize: 14,
          ),
        )),
      ],
    );
  }
}
