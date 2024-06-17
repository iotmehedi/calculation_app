import 'dart:math';

import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/core/routes/router.dart';
import 'package:calculation_app/main.dart';
import 'package:calculation_app/toast/toast.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class MortgageController extends GetxController{
    var isChecked = false.obs;
  Rx<DateTime>? selectedDate = DateTime.now().obs;
  var monthlyPaymentt = 0.0.obs;
  var totalPaymentt = 0.0.obs;
  var totalInterestt = 0.0.obs;
  var downPaymentValue = 0.0.obs;
  var principalAndInterest = 0.0.obs;
  var loanAmount = 0.0.obs;
  var total = 0.0.obs;
  var principleValue = 0.0.obs;
  var monthlyHOAFee = 0.0.obs;
  var monthlyPMIInsurance = 0.0.obs;
  var monthlyHomeInsurance = 0.0.obs;
  var monthlyPropertyTax = 0.0.obs;
  var monthlyPMI = 0.0.obs;
  var mortgagePayoffDatee = ''.obs;
  var principalInterestType = '\$'.obs;
  var propertyTaxType = '\$'.obs;
  var homeInsuranceType = '\$'.obs;
  var pmiInsuranceType = '\$'.obs;
  var hoaFeeType = '\$'.obs;
  var downPaymentType = '%'.obs; 
  var list = [].obs;
  final formKey = GlobalKey<FormState>().obs;
  final homePriceController = TextEditingController().obs;
  final downPaymentController = TextEditingController().obs;
  final loanTermController = TextEditingController().obs;
  final interestRateController = TextEditingController().obs;
  final hoaFeeController = TextEditingController().obs;
  final pmiFeeController = TextEditingController().obs;
  final homeInsuranceController = TextEditingController().obs;
  final propertyTaxController = TextEditingController().obs;
  final otherCostsController = TextEditingController().obs;

void calculateMonthlyPayment() {
  if(homePriceController.value.text.isEmpty){
    errorToast(context: navigatorKey.currentContext!, msg: "Please enter home section");
  }else if(downPaymentController.value.text.isEmpty){
    errorToast(context: navigatorKey.currentContext!, msg: "Please enter down payment section");
  } else if(interestRateController.value.text.isEmpty){
    errorToast(context: navigatorKey.currentContext!, msg: "Please enter interested section");
  } else if(loanTermController.value.text.isEmpty){
    errorToast(context: navigatorKey.currentContext!, msg: "Please enter long term year section");
  }else if(propertyTaxController.value.text.isEmpty && isChecked.value == true){
    errorToast(context: navigatorKey.currentContext!, msg: "Please enter property tax section");
  }else if(homeInsuranceController.value.text.isEmpty && isChecked.value == true){
    errorToast(context: navigatorKey.currentContext!, msg: "Please enter home insurance section");
  }else if(pmiFeeController.value.text.isEmpty && isChecked.value == true){
    errorToast(context: navigatorKey.currentContext!, msg: "Please enter PMI section");
  }else if(hoaFeeController.value.text.isEmpty && isChecked.value == true){
    errorToast(context: navigatorKey.currentContext!, msg: "Please enter HOA section");
  }else{
    final double homePrice = double.parse(homePriceController.value.text);
    final double downPayment = double.parse(downPaymentController.value.text);
    final double propertyTaxRate = isChecked.value == false ? 0.0 : double.parse(propertyTaxController.value.text);
    final double annualHomeInsurance = isChecked.value == false ? 0.0 : double.parse(homeInsuranceController.value.text);
    final double annualPMIRate = isChecked.value == false ? 0.0 : double.parse(pmiFeeController.value.text);
    final double annualHOAFee = isChecked.value == false ? 0.0 : double.parse(hoaFeeController.value.text);
    final double calculatedLoanAmount = downPaymentType.value == '%'
        ? homePrice * (1 - downPayment / 100)
        : homePrice - downPayment;
    final double annualInterestRate =
        double.parse(interestRateController.value.text) / 100;
    final int loanTerm = int.parse(loanTermController.value.text);

    final double monthlyInterestRate = annualInterestRate / 12;
    final int numberOfPayments = loanTerm * 12;

    final double monthlyPayment = calculatedLoanAmount *
        monthlyInterestRate /
        (1 - pow(1 + monthlyInterestRate, -numberOfPayments));

    final double totalPayment = monthlyPayment * numberOfPayments;
    final double totalInterest = totalPayment - calculatedLoanAmount;
    final DateTime payoffDate = DateTime(
      (selectedDate?.value.year ?? 0) + loanTerm,
      selectedDate?.value.month ?? 0,
    );

    monthlyPaymentt.value = monthlyPayment;
    totalPaymentt.value = totalPayment;
    totalInterestt.value = totalInterest;
    mortgagePayoffDatee.value =
    "${payoffDate.month.toString().padLeft(2, '0')}/${payoffDate.year}";

    principalAndInterest.value = monthlyPayment;
    loanAmount.value = calculatedLoanAmount;
    downPaymentValue.value = downPaymentType.value == '%' ? homePrice * (downPayment / 100) : downPayment;


    monthlyPaymentt.value = monthlyPayment;
    totalPaymentt.value = totalPayment;
    totalInterestt.value = totalInterest;
    mortgagePayoffDatee.value =
    "${payoffDate.month.toString().padLeft(2, '0')}/${payoffDate.year}";
    principleValue.value = homePrice - downPaymentValue.value;
    if(isChecked.value == false){
      list.clear();
      list.add(principleValue.value);
      list.add(totalInterestt.value);
      total.value = loanAmount.value + totalInterestt.value;
    }else{
      list.clear();
      monthlyPropertyTax.value = calculateMonthlyPropertyTax(homePrice, propertyTaxRate, propertyTaxType.value == "%" ? true : false);
      monthlyHomeInsurance.value = calculateMonthlyHomeInsurance(annualHomeInsurance, homeInsuranceType.value == "%" ? true : false, homePrice);
      monthlyPMI.value = calculateMonthlyPMI(loanAmount.value, annualPMIRate, pmiInsuranceType.value == "%" ? true : false);
      monthlyHOAFee.value = calculateMonthlyHOAFee(annualHOAFee, hoaFeeType.value == "%"? true : false, homePrice);

      list.add(principalAndInterest.value);
      list.add(monthlyPropertyTax.value);
      list.add(monthlyHomeInsurance.value);
      list.add(monthlyHOAFee.value);
      total.value =  principalAndInterest.value + monthlyPropertyTax.value + monthlyHomeInsurance.value + monthlyHOAFee.value;
    }
    print(monthlyPaymentt.value);
    print(totalPaymentt.value);
    print(totalInterestt.value);
    print(mortgagePayoffDatee.value);
    print(downPaymentValue.value);
    print(loanAmount.value);


    print('Monthly Property Tax: \$${monthlyPropertyTax.toStringAsFixed(2)}');
    print('Monthly Home Insurance: \$${monthlyHomeInsurance.toStringAsFixed(2)}');
    print('Monthly PMI Insurance: \$${monthlyPMI.toStringAsFixed(2)}');
    print('Monthly HOA Fee: \$${monthlyHOAFee.toStringAsFixed(2)}');

    RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.mortgageResultPage);
  }

}

double calculateMonthlyPropertyTax(double homePrice, double propertyTaxRate, bool isPercentage) {
  if (isPercentage) {
    return (homePrice * (propertyTaxRate / 100)) / 12;
  } else {
    return propertyTaxRate / 12;
  }
}

// Function to calculate the monthly home insurance
double calculateMonthlyHomeInsurance(double homeInsurance, bool isPercentage, double homePrice) {
  if (isPercentage) {
    // Calculate insurance amount as a percentage of home price
    double insuranceAmount = (homePrice * (homeInsurance / 100));
    // Divide by 12 to get monthly insurance
    return insuranceAmount / 12;
  } else {
    // If fixed value, simply divide by 12
    return homeInsurance / 12;
  }
}

// Function to calculate the monthly PMI insurance
double calculateMonthlyPMI(double loanAmount, double pmiInsurance, bool isPercentage) {
  if (isPercentage) {
    return (loanAmount * (pmiInsurance / 100)) / 12;
  } else {
    return pmiInsurance / 12;
  }
}

// Function to calculate the monthly HOA fee
double calculateMonthlyHOAFee(double hoaFee, bool isPercentage, double homePrice) {
  if (isPercentage) {
    return (homePrice * (hoaFee / 100)) / 12;
  } else {
    return hoaFee / 12;
  }
}

void allFieldClear(){


 homePriceController.value.text = '';
 downPaymentController.value.text = '';
 loanTermController.value.text = '';
 interestRateController.value.text = '';
 hoaFeeController.value.text = '';
 pmiFeeController.value.text = '';
 homeInsuranceController.value.text = '';
 propertyTaxController.value.text = '';
 otherCostsController.value.text = '';
  // selectedDate = null;

}
  @override
  void dispose() {
    homePriceController.value.dispose();
    downPaymentController.value.dispose();
    loanTermController.value.dispose();
    interestRateController.value.dispose();
    hoaFeeController.value.dispose();
    pmiFeeController.value.dispose();
    homeInsuranceController.value.dispose();
    propertyTaxController.value.dispose();
    otherCostsController.value.dispose();
    super.dispose();
  }
    List<PieChartSectionData> showingSections() {
List<Color> colors = [];
if(isChecked.value == false){
  colors = [
      Colors.blue,
      Colors.green,
      // Colors.blue,
    ];
}else{
    colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.yellow
      // Colors.blue,
    ];
}
     

    return List.generate(list.length, (i) {
      const isTouched = false; // you can set this dynamically if you want interactivity
      const fontSize = isTouched == true ? 25.0 : 16.0;
      const radius = isTouched == true ? 60.0 : 50.0;
      return PieChartSectionData(
        color: colors[i],
        value: list[i] / total.value * 100,
        title: '${(list[i] / total.value * 100).round()}%',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );
    });
  }

}