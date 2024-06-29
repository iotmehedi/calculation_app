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

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Obx(()=> Padding(
          padding: const EdgeInsets.all(16.0),
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
                        child: _buildTextField(
                            controller: controller.vehiclePriceController.value,
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
                        
                        child: _buildTextField(
                            controller: controller.loanTermController.value,
                            label: 'Month',
                            textAlign: TextAlign.end
                        ),
                      ),
                      Expanded(child: ListTile(
                        title: Text(
                          controller.selectedDate?.value == null
                              ? 'Start Date'
                              : DateFormat("yyyy/MM")
                              .format(controller.selectedDate!.value),
                          style:  TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal, fontFamily: "Podkova", color: HexColor("80848A")),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_down),
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
                        
                        child: _buildTextField(
                            controller: controller.interestRateController.value,
                            label: '%',
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
                        
                        child: _buildTextField(
                            controller: controller.downPaymentController.value,
                            label: '\$',
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
                        
                        child: _buildTextField(
                          controller: controller.tradeInValueController.value,
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
                       
                        child: _buildTextField(
                          controller: controller.amountOwedOnTradeInController.value,
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
                        
                        child: _buildTextField(
                          controller: controller.salesTaxController.value,
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
                        
                        child: _buildTextField(
                          controller: controller.feesController.value,
                          // label: 'Title, Registration, and Other Fees',

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
                        onPress: (){
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
              SizedBox(height: 20),

            ],
          ),
        )));
  }

  Container _buildTextField(
      { String? label,  IconData? prefixIcon,  TextAlign? textAlign, required TextEditingController controller,}) {
    return Container(
      decoration: BoxDecoration(
          color: HexColor("#F3F6F9"),
          borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: controller,
        textAlign: textAlign ??  TextAlign.start,
        decoration: InputDecoration(
            hintText: label ?? '',
            hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            border: InputBorder.none, prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 16,) : null, suffixStyle: TextStyle(color: Colors.red)),
        keyboardType: TextInputType.number,

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