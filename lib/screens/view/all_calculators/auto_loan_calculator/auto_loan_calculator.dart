import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/main.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/consts/textstyle.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';
import 'auto_loan_calculator_controller.dart';
import 'package:intl/src/intl/date_format.dart';

class AutoLoanCalculatorScreen extends StatefulWidget {
  AutoLoanCalculatorScreen({super.key});

  @override
  State<AutoLoanCalculatorScreen> createState() =>
      _AutoLoanCalculatorScreenState();
}

class _AutoLoanCalculatorScreenState extends State<AutoLoanCalculatorScreen> {
  final LoanController controller = Get.put(LoanController());

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: "Auto loan Calculator",
          onBackPressed: () {
            Navigator.pop(context);
            controller.clearFields();
          },
        ),
        body: Obx(() => Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Price of vehicle",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                                8.ph,
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                          controller: controller
                                              .vehiclePriceController.value,
                                          prefixIcon: Icons.attach_money_sharp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            15.ph,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const CustomText(text: "Loan term (Months)", fontWeight: FontWeight.w400, fontSize: 16,),
                                CustomRichText(
                                  title: "(Months)",
                                  titleTextColor: Colors.blue,
                                  heading: "Loan term",
                                  headingFontWeight: FontWeight.w400,
                                  titleFontWeight: FontWeight.w400,
                                  headingFontSize: 15,
                                  titleFontSIze: 15,
                                ),
                                8.ph,
                                _buildTextField(
                                    controller:
                                        controller.loanTermController.value,
                                    label: 'Month',
                                    textAlign: TextAlign.end),
                              ],
                            ),
                          ],
                        ),
                      ),
                      10.pw,
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.textFieldColor,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: () async {
                                    final DateTime? picked =
                                        await showMonthYearPicker(
                                      context: navigatorKey.currentContext!,
                                      initialDate: (controller
                                                  .selectedDate?.value
                                                  ?.isBefore(DateTime(2000)) ??
                                              false)
                                          ? DateTime.now()
                                          : (controller.selectedDate?.value ??
                                              DateTime.now()),
                                      firstDate: DateTime(2000),
                                      lastDate:
                                          DateTime(DateTime.now().year + 1),
                                    );
                                    if (picked != null &&
                                        picked !=
                                            controller.selectedDate?.value) {
                                      controller.selectedDate?.value = picked;
                                    }
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: globalTextPodkova(
                                            text: controller
                                                        .selectedDate?.value ==
                                                    null
                                                ? 'Select Date'
                                                : DateFormat("MM/yy").format(
                                                    controller.selectedDate
                                                            .value ??
                                                        DateTime.now()),
                                            textSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: controller
                                                        .selectedDate?.value !=
                                                    null
                                                ? Colors.black
                                                : AppColors.deepGray),
                                      ),
                                      10.pw,
                                      const Expanded(
                                        child: Icon(
                                            Icons.keyboard_arrow_down_sharp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  15.ph,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRichText(
                        title: "(%)",
                        titleTextColor: Colors.blue,
                        heading: "Interest Rate",
                        headingFontWeight: FontWeight.w400,
                        titleFontWeight: FontWeight.w400,
                        headingFontSize: 15,
                        titleFontSIze: 15,
                      ),
                      8.ph,
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: _buildTextField(
                                controller:
                                    controller.interestRateController.value,
                                // label: '%',
                                prefixIcon: Icons.percent,
                                textAlign: TextAlign.end),
                          ),
                          const Expanded(flex: 5, child: SizedBox())
                        ],
                      ),
                    ],
                  ),
                  15.ph,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Down Payment",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      8.ph,
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: _buildTextField(
                                controller:
                                    controller.downPaymentController.value,
                                // label: '\$',
                                prefixIcon: Icons.attach_money_sharp,
                                textAlign: TextAlign.end),
                          ),
                          const Expanded(flex: 5, child: SizedBox())
                        ],
                      ),
                    ],
                  ),
                  15.ph,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Trade-in value",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      8.ph,
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: _buildTextField(
                              controller:
                                  controller.tradeInValueController.value,
                            ),
                          ),
                          const Expanded(flex: 5, child: SizedBox())
                        ],
                      ),
                    ],
                  ),
                  15.ph,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Amount owed on trade-in",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      8.ph,
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: _buildTextField(
                              controller: controller
                                  .amountOwedOnTradeInController.value,
                            ),
                          ),
                          const Expanded(flex: 5, child: SizedBox())
                        ],
                      ),
                    ],
                  ),
                  15.ph,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Sales Tax (%)",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      8.ph,
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: _buildTextField(
                              controller: controller.salesTaxController.value,
                              prefixIcon: Icons.percent,
                            ),
                          ),
                          const Expanded(flex: 5, child: SizedBox())
                        ],
                      ),
                    ],
                  ),
                  15.ph,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Title, Registration, and Other Fees",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      8.ph,
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: _buildTextField(
                              controller: controller.feesController.value,
                              // label: 'Title, Registration, and Other Fees',
                            ),
                          ),
                          const Expanded(flex: 5, child: SizedBox())
                        ],
                      ),
                    ],
                  ),
                  15.ph,
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "Include taxes & fees in loan?",
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                        5.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio<String>(
                                  fillColor: MaterialStateProperty.all(AppColors.calculateButtonColor),
                                  groupValue: controller.selectedOption.value,
                                  onChanged: (value) {
                                    controller.selectedOption.value =
                                        value ?? '';
                                  },
                                  value: "1",
                                ),
                                globalText16(
                                    text: "Yes", fontWeight: FontWeight.w500),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio<String>(
                                  fillColor: MaterialStateProperty.all(AppColors.calculateButtonColor),
                                  groupValue: controller.selectedOption.value,
                                  onChanged: (value) {
                                    controller.selectedOption.value =
                                        value ?? '';
                                  },
                                  value: "2",
                                ),
                                globalText16(
                                    text: "No", fontWeight: FontWeight.w500),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            color: HexColor("244384"),
                            onPress: () {
                              controller.updateValues();
                            },
                            // RouteGenerator.pushNamed(context, Routes.mortgageResultPage);
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
                            onPress: () {
                              // _formKey.currentState!.reset();
                              controller.clearFields();
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
                  const SizedBox(height: 20),
                ],
              ),
            )));
  }

  Container _buildTextField({
    String? label,
    IconData? prefixIcon,
    TextAlign? textAlign,
    required TextEditingController controller,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: HexColor("#F3F6F9"), borderRadius: BorderRadius.circular(4)),
      child: TextFormField(
        controller: controller,
        textAlign: textAlign ?? TextAlign.start,
        decoration: InputDecoration(
            hintText: label ?? '',
            contentPadding:
                const EdgeInsets.only(bottom: 10, right: 10, top: 5, left: 10),
            hintStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            border: InputBorder.none,
            suffixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    size: 16,
                  )
                : null,
            suffixStyle: const TextStyle(color: Colors.red)),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
