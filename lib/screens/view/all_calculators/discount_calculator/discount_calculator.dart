import 'package:calculation_app/screens/view/all_calculators/discount_calculator/discount_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';

class DiscountCalculatorPage extends StatefulWidget {
  @override
  _DiscountCalculatorPageState createState() => _DiscountCalculatorPageState();
}

class _DiscountCalculatorPageState extends State<DiscountCalculatorPage> {
var controller = Get.put(DiscountController());
var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    Get.find<AdService>().loadBannerAd();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Discount Calculator",
        onBackPressed: () {
          Navigator.pop(context);
          controller.allFieldClear();
        },
      ),
      bottomNavigationBar: adController.getBannerAdWidget(),
      body: Obx(() => Form(
        key: controller.formKey.value,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonTextFieldCustom(
                  headingName: 'Original Price',
                  controller: controller.originalPriceController.value,
                  keyboardType: TextInputType.number,
                  needPadding: true,
                  onlyNeedSuffix: true,
                  suffixIcon: Icon(
                    Icons.attach_money_outlined,
                    size: 16,
                    color: HexColor("80848A"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter original price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CommonTextFieldCustom(
                  headingName: 'Percentage Rate',
                  controller: controller.discountRateController.value,
                  keyboardType: TextInputType.number,
                  titleTextColor: HexColor("437AFF"),
                  titleName: "(%)",
                  titleFontWeight: FontWeight.normal,
                  titleFontSize: 16,
                  needPadding: true,
                  onlyNeedSuffix: true,
                  suffixIcon: Icon(
                    Icons.percent,
                    size: 16,
                    color: HexColor("80848A"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter percentage rate';
                    }
                    return null;
                  },
                ),
            
                SizedBox(height: 16.0),
                CustomCalculateClearWidget1(
                  onPressCalculate: () {
                    if (controller.formKey.value.currentState?.validate() ?? false) {
                      controller.calculateDiscount();
                    }
                  },
                  onPressClear: controller.allFieldClear,
                  clearButtonTextColor: HexColor("0F182E"),
                  clearButtonFontWeight: FontWeight.w500,
                  clearButtonTitleFontSize: 20,
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
