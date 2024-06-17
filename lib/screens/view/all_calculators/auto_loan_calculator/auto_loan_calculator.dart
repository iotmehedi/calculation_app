import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/main.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';
import 'auto_loan_calculator_controller.dart';
import 'package:intl/src/intl/date_format.dart';

class AutoLoanCalculatorScreen extends StatefulWidget {

  AutoLoanCalculatorScreen({super.key});

  @override
  State<AutoLoanCalculatorScreen> createState() => _AutoLoanCalculatorScreenState();
}

class _AutoLoanCalculatorScreenState extends State<AutoLoanCalculatorScreen> {
  final LoanController controller = Get.put(LoanController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Price of vehicle", fontSize: 16, fontWeight: FontWeight.w400,),
                5.ph,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        onChanged: (value) =>
                            controller.vehiclePrice.value = double.parse(value),
                        prefixIcon: Icons.attach_money_sharp
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
              ],
            ),
            10.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Loan term (Months)"),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        label: 'Month',
                        onChanged: (value) =>
                            controller.loanTerm.value = int.parse(value),
                        textAlign: TextAlign.end
                      ),
                    ),
                    Expanded(child: ListTile(
                      title: Text(
                        controller.selectedDate?.value == null
                            ? 'Start Date'
                            : DateFormat("yyyy/MM")
                            .format(controller.selectedDate!.value),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: selectDate,
                    ),)
                  ],
                ),

              ],
            ),
            10.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Interest Rate %"),
                5.ph,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        label: '%',
                        onChanged: (value) =>
                            controller.interestRate.value = double.parse(value),
                        textAlign: TextAlign.end
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
              ],
            ),
            10.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Down Payment"),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        label: '\$',
                        onChanged: (value) =>
                            controller.downPayment.value = double.parse(value),
                          textAlign: TextAlign.end
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
              ],
            ),
            10.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Trade-in value"),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        onChanged: (value) =>
                            controller.tradeInValue.value = double.parse(value),
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
              ],
            ),
            10.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Amount owed on trade-in"),
                5.ph,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        onChanged: (value) =>
                            controller.amountOwedOnTradeIn.value = double.parse(value),
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Sales Tax (%)"),
                5.ph,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        onChanged: (value) =>
                            controller.salesTax.value = double.parse(value),
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Title, Registration, and Other Fees"),
                5.ph,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        // label: 'Title, Registration, and Other Fees',
                        onChanged: (value) => controller.fees.value = double.parse(value),
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
              ],
            ),
            10.ph,
            Obx(()=>Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Include taxes & fees in loan?"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                    globalText16(
                    text: "Yes",
                        fontWeight: FontWeight.w500),
                          Radio<String>(
                            groupValue: controller.selectedOption.value,
                            onChanged: (value) {

                              controller.selectedOption.value = value ?? '';

                            },
                            value: "1",
                          ),
                        ],
                      ),

                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                    globalText16(
                    text: "No",
                        fontWeight: FontWeight.w500),
                          Radio<String>(
                            groupValue: controller.selectedOption.value,
                            onChanged: (value) {

                              controller.selectedOption.value = value ?? '';

                            },
                            value: "2",
                          ),
                        ],
                      ),

                  ],
                ),
              ],
            ),),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.update();
                }
              },
              child: Text('Calculate Monthly Payment'),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      color: HexColor("244384"),
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          controller.update();
                        }
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
                      onPress: (){
                        setState(() {
                          controller.fees.value = 0.0;
                        });
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
            SizedBox(height: 20),
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Monthly Payment: \$${controller.monthlyPayment.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 24)),
                    Text(
                        'Loan Amount: \$${controller.loanAmount.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18)),
                    Text(
                        'Sales Tax Amount: \$${controller.salesTaxAmount.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18)),
                    Text(
                        'Upfront Payment: \$${controller.upfrontPayment.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18)),
                    Text(
                        'Total of Loan Payments: \$${controller.totalLoanPayments.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18)),
                    Text(
                        'Total Loan Interest: \$${controller.totalLoanInterest.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18)),
                    Text(
                        'Pay Out Date: ${controller.payOutDate.toLocal()}'
                            .split(' ')[0],
                        style: TextStyle(fontSize: 18)),
                  ],
                )),
          ],
        ),
      ),
    ));
  }

  Container _buildTextField(
      { String? label, required Function(String) onChanged,  IconData? prefixIcon,  TextAlign? textAlign,}) {
    return Container(
      decoration: BoxDecoration(
          color: HexColor("#F3F6F9"),
          borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
          textAlign: textAlign ??  TextAlign.start,
        decoration: InputDecoration(
            hintText: label ?? '',
            hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            border: InputBorder.none, prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 16,) : null, suffixText: "sdf", suffixStyle: TextStyle(color: Colors.red)),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
      ),
    );
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showMonthYearPicker(
      context: navigatorKey.currentContext!,

      initialDate:
      (controller.selectedDate?.value.isBefore(DateTime(2000)) ?? false)
          ? DateTime.now()
          : (controller.selectedDate?.value ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != controller.selectedDate?.value) {
      controller.selectedDate?.value = picked;
    }
  }
}
