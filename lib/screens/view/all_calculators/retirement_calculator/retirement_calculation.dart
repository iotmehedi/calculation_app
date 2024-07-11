import 'package:flutter/material.dart';
import 'dart:math';
class RetirementForm extends StatefulWidget {
  @override
  _RetirementFormState createState() => _RetirementFormState();
}

class _RetirementFormState extends State<RetirementForm> {
  final _formKey = GlobalKey<FormState>();
  final _currentAgeController = TextEditingController();
  final _retirementAgeController = TextEditingController();
  final _lifeExpectancyController = TextEditingController();
  final _annualPreTaxIncomeController = TextEditingController();
  final _currentRetirementSavingsController = TextEditingController();
  final _monthlyContributionController = TextEditingController();
  final _monthlyBudgetInRetirementController = TextEditingController();
  final _otherRetirementIncomeController = TextEditingController();
  final _preRetirementRateOfReturnController = TextEditingController();
  final _postRetirementRateOfReturnController = TextEditingController();
  final _inflationRateController = TextEditingController();
  final _annualIncomeIncreaseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retirement Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _currentAgeController,
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
                  controller: _retirementAgeController,
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
                  controller: _lifeExpectancyController,
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
                  controller: _annualPreTaxIncomeController,
                  decoration: InputDecoration(labelText: 'Annual Pre-Tax Income'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your annual pre-tax income';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _currentRetirementSavingsController,
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
                  controller: _monthlyContributionController,
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
                  controller: _monthlyBudgetInRetirementController,
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
                  controller: _otherRetirementIncomeController,
                  decoration: InputDecoration(labelText: 'Other Retirement Income (Optional)'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _preRetirementRateOfReturnController,
                  decoration: InputDecoration(labelText: 'Pre-Retirement Rate of Return (%)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the pre-retirement rate of return';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _postRetirementRateOfReturnController,
                  decoration: InputDecoration(labelText: 'Post-Retirement Rate of Return (%)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the post-retirement rate of return';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _inflationRateController,
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
                  controller: _annualIncomeIncreaseController,
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
                  onPressed: _calculateRetirementPlan,
                  child: Text('Calculate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _calculateRetirementPlan() {
    if (_formKey.currentState!.validate()) {
      final plan = RetirementPlan(
          currentAge: int.parse(_currentAgeController.text),
    retirementAge: int.parse(_retirementAgeController.text),
    lifeExpectancy: int.parse(_lifeExpectancyController.text),
    annualPreTaxIncome: double.parse(_annualPreTaxIncomeController.text),
    currentRetirementSavings: double.parse(_currentRetirementSavingsController.text),
        monthlyContribution: double.parse(_monthlyContributionController.text),
        monthlyBudgetInRetirement: double.parse(_monthlyBudgetInRetirementController.text),
        otherRetirementIncome: _otherRetirementIncomeController.text.isEmpty
            ? 0.0
            : double.parse(_otherRetirementIncomeController.text),
        preRetirementRateOfReturn: double.parse(_preRetirementRateOfReturnController.text),
        postRetirementRateOfReturn: double.parse(_postRetirementRateOfReturnController.text),
        inflationRate: double.parse(_inflationRateController.text),
        annualIncomeIncrease: double.parse(_annualIncomeIncreaseController.text),
      );

      final results = calculateRetirementPlan(plan);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RetirementResultsScreen(results: results),
        ),
      );
    }
  }

  @override
  void dispose() {
    _currentAgeController.dispose();
    _retirementAgeController.dispose();
    _lifeExpectancyController.dispose();
    _annualPreTaxIncomeController.dispose();
    _currentRetirementSavingsController.dispose();
    _monthlyContributionController.dispose();
    _monthlyBudgetInRetirementController.dispose();
    _otherRetirementIncomeController.dispose();
    _preRetirementRateOfReturnController.dispose();
    _postRetirementRateOfReturnController.dispose();
    _inflationRateController.dispose();
    _annualIncomeIncreaseController.dispose();
    super.dispose();
  }
}




RetirementPlanResults calculateRetirementPlan(RetirementPlan plan) {
  double currentSavings = plan.currentRetirementSavings;
  double monthlyContribution = plan.monthlyContribution;
  double annualContributionIncrease = plan.annualIncomeIncrease / 100;
  double preRetirementRate = plan.preRetirementRateOfReturn / 100;
  double postRetirementRate = plan.postRetirementRateOfReturn / 100;
  double inflationRate = plan.inflationRate / 100;
  int yearsUntilRetirement = plan.retirementAge - plan.currentAge;
  int yearsInRetirement = plan.lifeExpectancy - plan.retirementAge;

  // Calculate future value at retirement age
  double futureValue = currentSavings;
  for (int i = 0; i < yearsUntilRetirement; i++) {
    futureValue = (futureValue + (monthlyContribution * 12)) * (1 + preRetirementRate);
    monthlyContribution *= (1 + annualContributionIncrease);
  }

  // Calculate retirement savings at age 80
  double retirementSavingsAtAge80 = futureValue;
  for (int i = 0; i < 80 - plan.retirementAge; i++) {
    retirementSavingsAtAge80 = (retirementSavingsAtAge80 - (plan.monthlyBudgetInRetirement * 12)) * (1 + postRetirementRate);
  }

  // Calculate what you'll have and what you'll need
  double annualBudget = plan.monthlyBudgetInRetirement * 12;
  double postRetirementIncome = plan.otherRetirementIncome * 12;
  double whatYoullHave = futureValue;
  double whatYoullNeed = 0;

  for (int i = 0; i < yearsInRetirement; i++) {
    whatYoullNeed += annualBudget / pow(1 + inflationRate, i + 1);
    annualBudget *= (1 + inflationRate);
  }

  annualBudget = plan.monthlyBudgetInRetirement * 12;
  int ageSavingsRunOut = plan.retirementAge;
  while (whatYoullHave > annualBudget && ageSavingsRunOut < plan.lifeExpectancy) {
    whatYoullHave -= (annualBudget - postRetirementIncome);
    whatYoullHave *= (1 + postRetirementRate);
    annualBudget *= (1 + inflationRate);
    ageSavingsRunOut++;
  }

  // Calculate total retirement savings needed
  double totalRetirementSavings = whatYoullNeed;
  double newMonthlyContribution = plan.monthlyContribution;
  double tempSavings = plan.currentRetirementSavings;
  for (int i = 0; i < yearsUntilRetirement; i++) {
    tempSavings = (tempSavings + (newMonthlyContribution * 12)) * (1 + preRetirementRate);
    newMonthlyContribution *= (1 + annualContributionIncrease);
  }
  newMonthlyContribution = 500;
  while (totalRetirementSavings > tempSavings && newMonthlyContribution < 10000) {
    newMonthlyContribution += 1;
    tempSavings = plan.currentRetirementSavings;
    for (int i = 0; i < yearsUntilRetirement; i++) {
      tempSavings = (tempSavings + (newMonthlyContribution * 12)) * (1 + preRetirementRate);
      newMonthlyContribution *= (1 + annualContributionIncrease);
    }
  }

  return RetirementPlanResults(
    retirementSavingsAtAge80: retirementSavingsAtAge80,
    whatYoullHave: futureValue,
    whatYoullNeed: whatYoullNeed,
    currentRetirementPlan: CurrentRetirementPlan(
      totalRetirementSavings: futureValue,
      monthlyContribution: plan.monthlyContribution,
      ageRetirementSavingsRunsOut: ageSavingsRunOut,
    ),
    totalRetirementPlan: TotalRetirementPlan(
      totalRetirementSavings: totalRetirementSavings,
      monthlyContribution: newMonthlyContribution,
      ageRetirementSavingsRunsOut: plan.lifeExpectancy,
    ),
  );
}


class RetirementPlan {
  int currentAge;
  int retirementAge;
  int lifeExpectancy;
  double annualPreTaxIncome;
  double currentRetirementSavings;
  double monthlyContribution;
  double monthlyBudgetInRetirement;
  double otherRetirementIncome;
  double preRetirementRateOfReturn;
  double postRetirementRateOfReturn;
  double inflationRate;
  double annualIncomeIncrease;

  RetirementPlan({
    required this.currentAge,
    required this.retirementAge,
    required this.lifeExpectancy,
    required this.annualPreTaxIncome,
    required this.currentRetirementSavings,
    required this.monthlyContribution,
    required this.monthlyBudgetInRetirement,
    this.otherRetirementIncome = 0.0,
    required this.preRetirementRateOfReturn,
    required this.postRetirementRateOfReturn,
    required this.inflationRate,
    required this.annualIncomeIncrease,
  });
}

class RetirementPlanResults {
  double retirementSavingsAtAge80;
  double whatYoullHave;
  double whatYoullNeed;
  CurrentRetirementPlan currentRetirementPlan;
  TotalRetirementPlan totalRetirementPlan;

  RetirementPlanResults({
    required this.retirementSavingsAtAge80,
    required this.whatYoullHave,
    required this.whatYoullNeed,
    required this.currentRetirementPlan,
    required this.totalRetirementPlan,
  });
}

class CurrentRetirementPlan {
  double totalRetirementSavings;
  double monthlyContribution;
  int ageRetirementSavingsRunsOut;

  CurrentRetirementPlan({
    required this.totalRetirementSavings,
    required this.monthlyContribution,
    required this.ageRetirementSavingsRunsOut,
  });
}

class TotalRetirementPlan {
  double totalRetirementSavings;
  double monthlyContribution;
  int ageRetirementSavingsRunsOut;

  TotalRetirementPlan({
    required this.totalRetirementSavings,
    required this.monthlyContribution,
    required this.ageRetirementSavingsRunsOut,
  });
}


class RetirementResultsScreen extends StatelessWidget {
  final RetirementPlanResults results;

  RetirementResultsScreen({required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retirement Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Retirement Savings at Age 80: \$${results.retirementSavingsAtAge80.toStringAsFixed(2)}'),
              SizedBox(height: 10),
              Text('What You\'ll Have: \$${results.whatYoullHave.toStringAsFixed(2)}'),
              SizedBox(height: 10),
              Text('What You\'ll Need: \$${results.whatYoullNeed.toStringAsFixed(2)}'),
              SizedBox(height: 20),
              Text('Current Retirement Plan:'),
              Text('  - Total Retirement Savings: \$${results.currentRetirementPlan.totalRetirementSavings.toStringAsFixed(2)}'),
              Text('  - Monthly Contribution: \$${results.currentRetirementPlan.monthlyContribution.toStringAsFixed(2)}'),
              Text('  - Age Retirement Savings Runs Out: ${results.currentRetirementPlan.ageRetirementSavingsRunsOut}'),
              SizedBox(height: 20),
              Text('Total Retirement Plan:'),
              Text('  - Total Retirement Savings: \$${results.totalRetirementPlan.totalRetirementSavings.toStringAsFixed(2)}'),
              Text('  - Monthly Contribution: \$${results.totalRetirementPlan.monthlyContribution.toStringAsFixed(2)}'),
              Text('  - Age Retirement Savings Runs Out: ${results.totalRetirementPlan.ageRetirementSavingsRunsOut}'),
            ],
          ),
        ),
      ),
    );
  }
}
