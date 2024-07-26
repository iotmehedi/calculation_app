import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/gst_calculator/gst_calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';

void main() {
  runApp(GSTCalculatorApp());
}

class GSTCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GST Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GSTCalculatorPage(),
    );
  }
}

class GSTCalculatorPage extends StatefulWidget {
  @override
  _GSTCalculatorPageState createState() => _GSTCalculatorPageState();
}

class _GSTCalculatorPageState extends State<GSTCalculatorPage> {
  var controller = Get.put(GSTCalculatorController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "GST Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => Form(
          key: controller.formKey.value,
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Radio<String>(
                      groupValue: controller.radioButtonStatus.value,
                      onChanged: (value) {
                        controller.radioButtonStatus.value = value ?? '';
                      },
                      value: "1",
                    ),
                    globalText16(
                        text: "GST Exclusive",
                        fontWeight: FontWeight.w500),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Radio<String>(
                      groupValue: controller.radioButtonStatus.value,
                      onChanged: (value) {
                        controller.radioButtonStatus.value = value ?? '';
                      },
                      value: "2",
                    ),
                    globalText16(
                        text: "GST Inclusive",
                        fontWeight: FontWeight.w500),
                  ],
                ),

              ],
            ),
            20.ph,
            CommonTextFieldCustom(
              headingName: 'Total Amount',
              controller: controller.amountController.value,
              keyboardType: TextInputType.number,
              needPadding: true,
              suffixIcon: Icon(Icons.attach_money,size: 16, color: AppColors.deepGray1,),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the total amount';
                }
                return null;
              },
            ),
            10.ph,

            CommonTextFieldCustom(
              headingName: 'Tax Slab',
              controller: controller.taxSlabController.value,
              keyboardType: TextInputType.number,
              needPadding: true,
              onlyNeedSuffix: true,
              suffixIcon: Icon(Icons.percent,size: 16, color: AppColors.deepGray1,),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the tax slab';
                }
                return null;
              },
            ),
            10.ph,


            SizedBox(height: 16),
            CustomCalculateClearWidget(
              onPressCalculate: () {
                if (controller.formKey.value.currentState!
                    .validate()) {
                  if(controller.radioButtonStatus.value == "1"){
                    controller.calculateGSTExclusive();
                  }else{
                    controller.calculateGSTInclusive();
                  }
                }
              },
              onPressClear: controller.clearFields,
              clearButtonTextColor: Colors.black,
              clearButtonFontWeight: FontWeight.w500,
              clearButtonTitleFontSize: 20,
            ),

            SizedBox(height: 16),

          ],
        ),
      ))),
    );
  }
}
