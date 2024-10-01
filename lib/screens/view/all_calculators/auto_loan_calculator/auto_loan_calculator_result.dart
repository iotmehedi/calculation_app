import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import 'auto_loan_calculator_controller.dart';

class AutoLoanCalculatorResult extends StatelessWidget {
  AutoLoanCalculatorResult({super.key});
  var controller = Get.find<LoanController>();
  var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    Get.find<AdService>().loadBannerAd();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
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
      bottomNavigationBar:adController.getBannerAdWidget(),
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
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFFFAFAFA)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x07101010),
                        blurRadius: 45,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomRow(
                                    title: "Loan Amount",
                                    value: NumberFormat('#,##,##0.00', 'en_US')
                                        .format(controller.loanAmount)
                                        .toString(),
                                    titleColor: Colors.black),
                                10.ph,
                                CustomRow(
                                    title: "Sales Tax",
                                    value:  NumberFormat('#,##,##0.00', 'en_US')
                                        .format(controller.salesTaxAmount)
                                        .toString(),
                                    titleColor: Colors.black
                                ),
                                10.ph,
                                CustomRow(
                                    title: "Upfront Payment",
                                    value:  NumberFormat('#,##,##0.00', 'en_US')
                                        .format(controller.upfrontPayment)
                                        .toString(),
                                    titleColor: Colors.black),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomRow(
                                    title: "Total Interest Cost",
                                    value:  NumberFormat('#,##,##0.00', 'en_US')
                                        .format(controller.totalLoanInterest)
                                        .toString(),
                                    titleColor: Colors.black),
                                10.ph,
                                CustomRow(
                                    title: "Total of ${controller.loanTermController.value.text} Loan Payments",
                                    value:  NumberFormat('#,##,##0.00', 'en_US')
                                        .format(controller.totalLoanPayments)
                                        .toString(),
                                    titleColor: AppColors.deepBlue,
                                  valueColor: AppColors.deepBlue,
                                  fontWeight: FontWeight.w500
                                ),
                                10.ph,
                                CustomRow(
                                  title: "Pay Of Date",
                                  value:
                                      '${DateFormat("MM/yyyy").format(controller.payOutDate.toLocal())}'
                                          .split(' ')[0],
                                  valueColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: CustomRow(
                                title: "Total All Cost:",
                                value: NumberFormat('#,##,##0.00', 'en_US')
                                    .format((controller.loanAmount + controller.salesTaxAmount + controller.upfrontPayment + controller.totalLoanInterest + controller.totalLoanPayments))
                                    .toString(),
                                titleColor: AppColors.deepBlue,
                            size: 16.0,
                                fontWeight: FontWeight.w600,
                              valueColor: AppColors.deepBlue,
                            ),
                          ),
                        ],
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
      Color? valueColor,
      Color? titleColor,
        double? size, FontWeight? fontWeight}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: CustomText(
          text: title,
          textColor: titleColor,
          fontSize: size ?? 14,
          fontWeight: fontWeight ?? FontWeight.w400,
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CustomText(
            text: "\$ $value",
            textColor: valueColor,
            fontSize: size ?? 14,
            fontWeight: fontWeight ?? FontWeight.w400,
          ),
        )),
      ],
    );
  }
}
