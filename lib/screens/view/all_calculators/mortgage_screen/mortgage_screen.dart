import 'dart:math';

import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/core/routes/router.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/mortgage_screen/mortgage_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:calculation_app/screens/widgets/textfield/textField_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_icons_widget/common_icon_widget.dart';
import '../../../widgets/custom_richtext/custom_richtext.dart';

class MortgageScreen extends StatefulWidget {
  const MortgageScreen({super.key});

  @override
  State<MortgageScreen> createState() => _MortgageScreenState();
}

class _MortgageScreenState extends State<MortgageScreen> {
  var controller = Get.put(MortgageController());
  var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
          appBar: CustomAppBar(title: "Mortgage Calculator", onBackPressed: (){
            Navigator.pop(context);
            controller.clearAllField();
          },),
          bottomNavigationBar: adController.getBannerAdWidget(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: controller.formKey.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CustomTextField(hint: "enter Home", obscureText: false, prefixIcon: Icon(Icons.attach_money_sharp),),

                    const CustomText(
                        text: "Home",
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                        fontSize: 16.0),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor("#F3F6F9"),
                                  borderRadius: BorderRadius.circular(12)),
                              child: CustomSimpleTextField(
                                controller:
                                    controller.homePriceController.value,
                                suffixIcon:
                                    CustomIconWidget(icon: Icons.attach_money),
                                prefixIconColor: AppColors.greyForPrefixIcon,
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(flex: 4, child: SizedBox())
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                        text: "Down Payment",
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                        fontSize: 16.0),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor("#F3F6F9"),
                                  borderRadius: BorderRadius.circular(12)),
                              child: CustomSimpleTextField(
                                controller:
                                    controller.downPaymentController.value,

                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child:
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.textFieldColor,
                              ),

                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.downPaymentType.value,
                                  items: <String>['\$', '%'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      controller.downPaymentType.value =
                                          newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2, child: const SizedBox())
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRichText(
                                heading: 'Interested Rate',
                                title: '(%)',
                                titleTextColor: HexColor('458EEC'),
                                headingFontWeight: FontWeight.w400,
                                titleFontWeight: FontWeight.w400,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: HexColor("#F3F6F9"),
                                      borderRadius:
                                          BorderRadius.circular(12)),
                                  child: CustomSimpleTextField(
                                    controller: controller
                                        .interestRateController.value,
                                    suffixIcon: CustomIconWidget(
                                        icon: Icons.percent_outlined),
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomRichText(
                                heading: 'Long Term',
                                title: '(Year)',
                                titleTextColor: HexColor('458EEC'),
                                headingFontWeight: FontWeight.w400,
                                titleFontWeight: FontWeight.w400,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: HexColor("#F3F6F9"),
                                      borderRadius:
                                          BorderRadius.circular(12)),
                                  child: CustomSimpleTextField(
                                    controller:
                                        controller.loanTermController.value,
                                    paddingNeed: false,
                                    // prefixIcon: Icon(Icons.attach_money_sharp , size: 16,),
                                    // prefixIconColor: AppColors.greyForPrefixIcon,
                                  )),
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
                                margin: const EdgeInsets.only(right: 15),
                                // height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.textFieldColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                  child: InkWell(
                                    onTap: selectDate,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: globalTextPodkova(
                                            text:  controller.selectedDate.value ==
                                                null
                                                ? 'Select Date'
                                                : DateFormat("MM/yy").format(
                                                controller.selectedDate.value ?? DateTime.now()),
                                            textSize: 16.0,
                                            fontWeight:  FontWeight.w400,
                                            color: controller.selectedDate.value !=
                                                null ? Colors.black : AppColors.deepGray
                                        ),),
                                        10.pw,
                                        Expanded(
                                          child: const Icon(
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

                    const SizedBox(
                      height: 10,
                    ),
                    if (controller.isChecked.value == false)
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                color: HexColor("244384"),
                                onPress: controller.calculateMonthlyPayment,
                                // RouteGenerator.pushNamed(context, Routes.mortgageResultPage);
                                text: const Text(
                                  "Calculate",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                  fontSize: 20
                                  ),
                                ),
                              ),
                            ),
                            10.pw,
                            Expanded(
                              child: CustomElevatedButton(
                                color: HexColor("F3F6F9"),
                                onPress: controller.allFieldClear,
                                text: Text(
                                  "Clear",
                                  style: TextStyle(
                                      color: HexColor("0F182E"),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (controller.isChecked.value == false)
                      const SizedBox(
                        height: 10,
                      ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() => controller.isChecked.value =
                                !controller.isChecked.value);
                            // widget.onChanged?.call(isChecked);
                          },
                          child: Container(
                            width: 23,
                            height: 24,
                            decoration:controller.isChecked.value ? BoxDecoration(
                                color: HexColor("244384"),
                                borderRadius: BorderRadius.circular(6.0),

                            ):  BoxDecoration(
                              color:  HexColor("#FFFFFF"),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(width: 2)
                            ),
                            child: controller.isChecked.value
                                ? const Icon(
                                    Icons.check,
                                    size: 17,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const CustomText(
                            text: "Include Fee And Texes",
                            fontWeight: FontWeight.w600,
                            textColor: Colors.black,
                            fontSize: 16.0),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible:
                          controller.isChecked.value == true ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                              text: "Property Tax",
                              fontWeight: FontWeight.w400,
                              textColor: Colors.black,
                              fontSize: 20.0),

                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("#F3F6F9"),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: CustomSimpleTextField(
                                      controller: controller
                                          .propertyTaxController.value,
                                      paddingNeed: false,
                                      prefixIconColor:
                                          AppColors.greyForPrefixIcon,
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.textFieldColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: controller.propertyTaxType.value,
                                        items: <String>['\$', '%']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            controller.propertyTaxType.value =
                                                newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: const SizedBox())
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomText(
                              text: "Home Insurance",
                              fontWeight: FontWeight.w400,
                              textColor: Colors.black,
                              fontSize: 20.0),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("#F3F6F9"),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: CustomSimpleTextField(
                                      controller: controller
                                          .homeInsuranceController.value,
                                      paddingNeed: false,
                                      prefixIconColor:
                                          AppColors.greyForPrefixIcon,
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.textFieldColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: controller.homeInsuranceType.value,
                                        items: <String>['\$', '%']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            controller.homeInsuranceType.value =
                                                newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: const SizedBox())
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomText(
                              text: "PMI Fee",
                              fontWeight: FontWeight.w400,
                              textColor: Colors.black,
                              fontSize: 16.0),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("#F3F6F9"),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: CustomSimpleTextField(
                                      controller:
                                          controller.pmiFeeController.value,
                                      prefixIconColor:
                                          AppColors.greyForPrefixIcon,
                                      paddingNeed: false,
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.textFieldColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: controller.pmiInsuranceType.value,
                                        items: <String>['\$', '%']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            controller.pmiInsuranceType.value =
                                                newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: const SizedBox())
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomText(
                              text: "Hoa fee",
                              fontWeight: FontWeight.w400,
                              textColor: Colors.black,
                              fontSize: 20.0),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("#F3F6F9"),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: CustomSimpleTextField(
                                      controller:
                                          controller.hoaFeeController.value,
                                      prefixIconColor:
                                          AppColors.greyForPrefixIcon,
                                      paddingNeed: false,
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.textFieldColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: controller.hoaFeeType.value,
                                        items: <String>['\$', '%']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            controller.hoaFeeType.value =
                                                newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: const SizedBox())
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    if (controller.isChecked.value == true)
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomElevatedButton(
                          color: HexColor("244384"),
                          onPress: controller.calculateMonthlyPayment,
                          // RouteGenerator.pushNamed(context, Routes.mortgageResultPage);
                          text: const Text(
                            "Calculate",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showMonthYearPicker(
      context: context,
      initialDate:
          (controller.selectedDate?.value?.isBefore(DateTime(2000)) ?? false)
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

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:math';
//
//
//
// class MortgageScreen extends StatefulWidget {
//   @override
//   _MortgageScreenState createState() => _MortgageScreenState();
// }
//
// class _MortgageScreenState extends State<MortgageScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _homePriceController = TextEditingController();
//   final _downPaymentController = TextEditingController();
//   final _loanTermController = TextEditingController();
//   final _interestRateController = TextEditingController();
//   final _hoaFeeController = TextEditingController();
//   final _pmiFeeController = TextEditingController();
//   final _homeInsuranceController = TextEditingController();
//   final _propertyTaxController = TextEditingController();
//   final _otherCostsController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mortgage Calculator'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: <Widget>[
//               TextFormField(
//                 controller: _homePriceController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Home Price'),
//                 validator: (value) {
//                   if (value?.isEmpty ?? false) {
//                     return 'Please enter home price';
//                   }
//                   return null;
//                 },
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _downPaymentController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(labelText: 'Down Payment'),
//                       validator: (value) {
//                         if (value?.isEmpty ?? false) {
//                           return 'Please enter down payment';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   DropdownButton<String>(
//                     value: _downPaymentType,
//                     items: <String>['\$', '%'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: ( newValue) {
//                       setState(() {
//                         _downPaymentType = newValue!;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               TextFormField(
//                 controller: _loanTermController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Loan Term (years)'),
//                 validator: (value) {
//                   if (value?.isEmpty ?? false) {
//                     return 'Please enter loan term';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _interestRateController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Interest Rate (%)'),
//                 validator: (value) {
//                   if (value?.isEmpty ?? false) {
//                     return 'Please enter interest rate';
//                   }
//                   return null;
//                 },
//               ),
//               ListTile(
//                 title: Text('Start Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
//                 trailing: Icon(Icons.calendar_today),
//                 onTap: _selectDate,
//               ),
//               TextFormField(
//                 controller: _hoaFeeController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'HOA Fee'),
//               ),
//               TextFormField(
//                 controller: _pmiFeeController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'PMI Fee'),
//               ),
//               TextFormField(
//                 controller: _homeInsuranceController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Home Insurance'),
//               ),
//               TextFormField(
//                 controller: _propertyTaxController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Property Tax'),
//               ),
//               TextFormField(
//                 controller: _otherCostsController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Other Costs'),
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     _calculateMonthlyPayment();
//                   }
//                 },
//                 child: Text('Calculate'),
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 'Monthly Payment: \$${_monthlyPayment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//               Text(
//                 'Total Payment: \$${_totalPayment.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//               Text(
//                 'Total Interest: \$${_totalInterest.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//               Text(
//                 'Mortgage Payoff Date: $_mortgagePayoffDate',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//               SizedBox(height: 20.0),
//               _buildPieChart(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPieChart() {
//     final double hoaFee = double.parse(_hoaFeeController.text.isEmpty ? '0' : _hoaFeeController.text);
//     final double pmiFee = double.parse(_pmiFeeController.text.isEmpty ? '0' : _pmiFeeController.text);
//     final double homeInsurance = double.parse(_homeInsuranceController.text.isEmpty ? '0' : _homeInsuranceController.text);
//     final double propertyTax = double.parse(_propertyTaxController.text.isEmpty ? '0' : _propertyTaxController.text);
//     final double otherCosts = double.parse(_otherCostsController.text.isEmpty ? '0' : _otherCostsController.text);
//     final double principalAndInterest = _monthlyPayment;
//
//     final data = [
//       ChartData('HOA Fee', hoaFee),
//       ChartData('PMI Fee', pmiFee),
//       ChartData('Home Insurance', homeInsurance),
//       ChartData('Property Tax', propertyTax),
//       ChartData('Principal & Interest', principalAndInterest),
//     ];
//
//     final sections = data.map((ChartData data) {
//       return PieChartSectionData(
//         color: _getColor(data.category),
//         value: data.amount,
//         title: '${data.category}: \${data.amount.toStringAsFixed(2)}',
//         radius: 50,
//         titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
//       );
//     }).toList();
//
//     return SizedBox(
//       height: 300.0,
//       child: PieChart(
//         PieChartData(
//           sections: sections,
//           sectionsSpace: 2,
//           centerSpaceRadius: 40,
//           pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {
//
//           }),
//         ),
//       ),
//     );
//   }
//
//   Color _getColor(String category) {
//     switch (category) {
//       case 'HOA Fee':
//         return Colors.blue;
//       case 'PMI Fee':
//         return Colors.red;
//       case 'Home Insurance':
//         return Colors.green;
//       case 'Property Tax':
//         return Colors.yellow;
//       case 'Principal & Interest':
//         return Colors.purple;
//       default:
//         return Colors.grey;
//     }
//   }
//

// }

class ChartData {
  final String category;
  final double amount;

  ChartData(this.category, this.amount);
}
