import 'dart:math';

import 'package:flutter/material.dart';



class EmiCalculator extends StatefulWidget {
  @override
  _EmiCalculatorState createState() => _EmiCalculatorState();
}

class _EmiCalculatorState extends State<EmiCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _loanTenureController = TextEditingController();

  double _monthlyEmi = 0.0;
  double _totalInterest = 0.0;
  double _totalPayment = 0.0;

  void _calculateEmi() {
    double loanAmount = double.parse(_loanAmountController.text);
    double interestRate = double.parse(_interestRateController.text) / 12 / 100;
    int loanTenure = int.parse(_loanTenureController.text) * 12;

    double emi = (loanAmount * interestRate * pow((1 + interestRate), loanTenure)) /
        (pow((1 + interestRate), loanTenure) - 1);

    setState(() {
      _monthlyEmi = emi;
      _totalPayment = emi * loanTenure;
      _totalInterest = _totalPayment - loanAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _loanAmountController,
                decoration: InputDecoration(labelText: 'Loan Amount (\$)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter loan amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _interestRateController,
                decoration: InputDecoration(labelText: 'Rate of Interest (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter interest rate';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _loanTenureController,
                decoration: InputDecoration(labelText: 'Loan Tenure (Years)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty ) {
                    return 'Please enter loan tenure';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _calculateEmi();
                  }
                },
                child: Text('Calculate EMI'),
              ),
              SizedBox(height: 20),
              if (_monthlyEmi > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Monthly EMI: \$${_monthlyEmi.toStringAsFixed(2)}'),
                    Text('Total Interest Payable: \$${_totalInterest.toStringAsFixed(2)}'),
                    Text('Total Amount Payable: \$${_totalPayment.toStringAsFixed(2)}'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
