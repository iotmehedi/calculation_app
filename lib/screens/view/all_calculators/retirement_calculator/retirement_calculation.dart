import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(RetirementCalculatorApp());
}

class RetirementCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RetirementCalculator(),
    );
  }
}

class RetirementCalculator extends StatefulWidget {
  @override
  _RetirementCalculatorState createState() => _RetirementCalculatorState();
}

class _RetirementCalculatorState extends State<RetirementCalculator> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final currentAgeController = TextEditingController();
  final retirementAgeController = TextEditingController();
  final lifeExpectancyController = TextEditingController();
  final annualIncomeController = TextEditingController();
  final currentSavingsController = TextEditingController();
  final monthlyContributionController = TextEditingController();
  final monthlyBudgetController = TextEditingController();
  final otherIncomeController = TextEditingController();
  final preRetirementRateController = TextEditingController();
  final postRetirementRateController = TextEditingController();
  final inflationRateController = TextEditingController();
  final annualIncomeIncreaseController = TextEditingController();

  @override
  void dispose() {
    currentAgeController.dispose();
    retirementAgeController.dispose();
    lifeExpectancyController.dispose();
    annualIncomeController.dispose();
    currentSavingsController.dispose();
    monthlyContributionController.dispose();
    monthlyBudgetController.dispose();
    otherIncomeController.dispose();
    preRetirementRateController.dispose();
    postRetirementRateController.dispose();
    inflationRateController.dispose();
    annualIncomeIncreaseController.dispose();
    super.dispose();
  }

  void _calculateResults() {
    if (_formKey.currentState!.validate()) {
      final int currentAge = int.parse(currentAgeController.text);
      final int retirementAge = int.parse(retirementAgeController.text);
      final int lifeExpectancy = int.parse(lifeExpectancyController.text);
      final double annualIncome = double.parse(annualIncomeController.text);
      final double currentSavings = double.parse(currentSavingsController.text);
      final double monthlyContribution = double.parse(monthlyContributionController.text);
      final double monthlyBudget = double.parse(monthlyBudgetController.text);
      final double otherIncome = double.parse(otherIncomeController.text.isEmpty ? '0' : otherIncomeController.text);
      final double preRetirementRate = double.parse(preRetirementRateController.text) / 100;
      final double postRetirementRate = double.parse(postRetirementRateController.text) / 100;
      final double inflationRate = double.parse(inflationRateController.text) / 100;
      final double annualIncomeIncrease = double.parse(annualIncomeIncreaseController.text) / 100;

      // Years until retirement
      int yearsUntilRetirement = retirementAge - currentAge;

      // Future value of current savings
      double futureValueCurrentSavings = currentSavings * pow(1 + preRetirementRate, yearsUntilRetirement);

      // Future value of contributions
      double futureValueOfContributions = monthlyContribution * (pow(1 + preRetirementRate / 12, yearsUntilRetirement * 12) - 1) / (preRetirementRate / 12) * (1 + preRetirementRate / 12);

      // Total retirement savings at retirement
      double totalRetirementSavings = futureValueCurrentSavings + futureValueOfContributions;

      // Inflation adjusted monthly budget in retirement
      double inflationAdjustedBudget = monthlyBudget * pow(1 + inflationRate, yearsUntilRetirement);

      // Monthly withdrawal needed in retirement
      double monthlyWithdrawal = inflationAdjustedBudget - otherIncome;

      // Total amount needed for retirement (Present Value of Annuity)
      double totalNeeded = monthlyWithdrawal * ((1 - pow(1 + postRetirementRate / 12, -(lifeExpectancy - retirementAge) * 12)) / (postRetirementRate / 12));

      // New monthly contribution to meet retirement goal
      double pv = currentSavings * pow(1 + preRetirementRate, yearsUntilRetirement);
      double newMonthlyContribution = (totalNeeded - pv) * (preRetirementRate / 12) / (pow(1 + preRetirementRate / 12, yearsUntilRetirement * 12) - 1);

      // Age at which savings run out with current plan
      int ageSavingsRunOut = _calculateAgeSavingsRunOut(totalRetirementSavings, monthlyWithdrawal, postRetirementRate);

      // Age at which savings run out with new plan
      int newAgeSavingsRunOut = _calculateAgeSavingsRunOut(totalNeeded, monthlyWithdrawal, postRetirementRate);

      // Show results
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Retirement Calculations'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Total Retirement Savings at Retirement: \$${totalRetirementSavings.toStringAsFixed(2)}'),
                Text('Total Needed for Retirement: \$${totalNeeded.toStringAsFixed(2)}'),
                Text('New Monthly Contribution: \$${newMonthlyContribution.toStringAsFixed(2)}'),
                Text('Age Savings Run Out (Current Plan): $ageSavingsRunOut'),
                Text('Age Savings Run Out (New Plan): $newAgeSavingsRunOut'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  int _calculateAgeSavingsRunOut(double totalSavings, double monthlyWithdrawal, double rateOfReturn) {
    int months = 0;
    double savings = totalSavings;

    while (savings > 0) {
      savings = savings * (1 + rateOfReturn / 12) - monthlyWithdrawal;
      months++;
    }

    return (months / 12).floor();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retirement Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: currentAgeController,
                decoration: InputDecoration(labelText: 'Current Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: retirementAgeController,
                decoration: InputDecoration(labelText: 'Retirement Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your retirement age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lifeExpectancyController,
                decoration: InputDecoration(labelText: 'Life Expectancy'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your life expectancy';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: annualIncomeController,
                decoration: InputDecoration(labelText: 'Annual Pre-tax Income'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your annual pre-tax income';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: currentSavingsController,
                decoration: InputDecoration(labelText: 'Current Retirement Savings'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current retirement savings';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: monthlyContributionController,
                decoration: InputDecoration(labelText: 'Monthly Contribution'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your monthly contribution';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: monthlyBudgetController,
                decoration: InputDecoration(labelText: 'Monthly Budget in Retirement'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your monthly budget in retirement';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: otherIncomeController,
                decoration: InputDecoration(labelText: 'Other Retirement Income (optional)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: preRetirementRateController,
                decoration: InputDecoration(labelText: 'Pre-Retirement Rate of Return (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your pre-retirement rate of return';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: postRetirementRateController,
                decoration: InputDecoration(labelText: 'Post-Retirement Rate of Return (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your post-retirement rate of return';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: inflationRateController,
                decoration: InputDecoration(labelText: 'Inflation Rate (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the inflation rate';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: annualIncomeIncreaseController,
                decoration: InputDecoration(labelText: 'Annual Income Increase (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the annual income increase rate';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateResults,
                child: Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
