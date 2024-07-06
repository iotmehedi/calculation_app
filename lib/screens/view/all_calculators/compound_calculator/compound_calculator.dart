import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/compound_calculator/compound_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math';
import 'package:intl/intl.dart';

void main() {
  runApp(CompoundInterestCalculator());
}

class CompoundInterestCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compound Interest Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorForm(),
    );
  }
}

class CalculatorForm extends StatefulWidget {
  @override
  _CalculatorFormState createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  var controller = Get.put(CompoundController());
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Compound Interest Calculator'),
      ),
      body: Obx(() => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey.value,
                child: Column(
                  children: <Widget>[

                    TextFormField(
                      controller: controller.initialDepositController.value,
                      decoration:
                          const InputDecoration(labelText: 'Initial Deposit'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the initial deposit';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.contributionAmountController.value,
                      decoration: const InputDecoration(
                          labelText: 'Contribution Amount'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the contribution amount';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: controller.contributionFrequency.value,
                      decoration: const InputDecoration(
                          labelText: 'Contribution Frequency'),
                      items: <String>['Monthly', 'Yearly'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          controller.contributionFrequency.value = newValue!;
                        });
                      },
                    ),
                    TextFormField(
                      controller: controller.yearsOfGrowthController.value,
                      decoration:
                          const InputDecoration(labelText: 'Years of Growth'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the number of years of growth';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.rateOfReturnController.value,
                      decoration: const InputDecoration(
                          labelText: 'Estimated Rate of Return (%)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the estimated rate of return';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: controller.compoundFrequency.value,
                      decoration: const InputDecoration(
                          labelText: 'Compound Frequency'),
                      items: <String>['Daily', 'Monthly', 'Annually']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          controller.compoundFrequency.value = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.calculateCompoundInterest,
                      child: const Text('Calculate'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Total Balance: \$${controller.result.value.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Total Principal: \$${controller.totalPrincipal.value.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Total Interest: \$${controller.totalInterest.value.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          )),
    );
  }




}
