import 'package:flutter/material.dart';
import 'dart:math';

enum ActivityLevel {
  basalMetabolicRate,
  sedentary,
  lightlyActive,
  moderatelyActive,
  active,
  veryActive,
  extraActive
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDEE Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TDEECalculator(),
    );
  }
}

class TDEECalculator extends StatefulWidget {
  @override
  _TDEECalculatorState createState() => _TDEECalculatorState();
}

class _TDEECalculatorState extends State<TDEECalculator> {
  bool isMetric = true;
  double weight = 0;
  double heightFeet = 0;
  double heightInches = 0;
  double heightCm = 0;
  double weightKg = 0;
  int age = 0;
  String gender = 'Male';
  ActivityLevel activityLevel = ActivityLevel.sedentary;
  String tdeeResult = '';
  String bmiResult = '';
  String energyIntake = '';

  double calculateBMR() {
    double bmr = 0;

    if (isMetric) {
      // Metric units
      bmr = gender == 'Male'
          ? 88.362 + (13.397 * weightKg) + (4.799 * heightCm) - (5.677 * age)
          : 447.593 + (9.247 * weightKg) + (3.098 * heightCm) - (4.330 * age);
    } else {
      // US units
      double heightInInches = (heightFeet * 12) + heightInches;
      bmr = gender == 'Male'
          ? 66 + (6.23 * weight) + (12.7 * heightInInches) - (6.8 * age)
          : 655 + (4.35 * weight) + (4.7 * heightInInches) - (4.7 * age);
    }

    return bmr;
  }

  double calculateTDEE() {
    double bmr = calculateBMR();
    double activityFactor;

    switch (activityLevel) {
      case ActivityLevel.basalMetabolicRate:
        activityFactor = 1.0;
        break;
      case ActivityLevel.sedentary:
        activityFactor = 1.1812;
        break;
      case ActivityLevel.lightlyActive:
        activityFactor = 1.375;
        break;
      case ActivityLevel.moderatelyActive:
        activityFactor = 1.55;
        break;
      case ActivityLevel.active:
        activityFactor = 1.725;
        break;
      case ActivityLevel.veryActive:
        activityFactor = 1.9;
        break;
      case ActivityLevel.extraActive:
        activityFactor = 2.0;
        break;
    }

    return bmr * activityFactor;
  }

  double calculateBMI() {
    double heightInMeters = isMetric
        ? heightCm / 100
        : (heightFeet * 0.3048) + (heightInches * 0.0254);
    double heightSquared = pow(heightInMeters, 2).toDouble();
    double weightInKg = isMetric ? weightKg : weight * 0.453592;
    return weightInKg / heightSquared;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TDEE Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Switch for Metric/US units
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Metric Units'),
                  Switch(
                    value: isMetric,
                    onChanged: (value) {
                      setState(() {
                        isMetric = value;
                        if (isMetric) {
                          // Convert US units to Metric if necessary
                          heightCm =
                              (heightFeet * 30.48) + (heightInches * 2.54);
                          weightKg = weight * 0.453592;
                        } else {
                          // Convert Metric units to US if necessary
                          heightFeet = (heightCm / 30.48).floor().toDouble();
                          heightInches = (heightCm % 30.48) / 2.54;
                          weight = weightKg / 0.453592;
                        }
                      });
                    },
                  ),
                  Text('US Units'),
                ],
              ),
              // Age input
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age'),
                onChanged: (value) => setState(() {
                  age = int.tryParse(value) ?? 0;
                }),
              ),
              // Gender dropdown
              DropdownButton<String>(
                value: gender,
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    gender = newValue!;
                  });
                },
              ),
              // Height inputs based on unit selection
              if (isMetric)
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Height (cm)'),
                  onChanged: (value) => setState(() {
                    heightCm = double.tryParse(value) ?? 0;
                  }),
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Height (feet)'),
                        onChanged: (value) => setState(() {
                          heightFeet = double.tryParse(value) ?? 0;
                        }),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(labelText: 'Height (inches)'),
                        onChanged: (value) => setState(() {
                          heightInches = double.tryParse(value) ?? 0;
                        }),
                      ),
                    ),
                  ],
                ),
              // Weight inputs based on unit selection
              if (isMetric)
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                  onChanged: (value) => setState(() {
                    weightKg = double.tryParse(value) ?? 0;
                  }),
                )
              else
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Weight (pounds)'),
                  onChanged: (value) => setState(() {
                    weight = double.tryParse(value) ?? 0;
                  }),
                ),
              // Activity level dropdown
              DropdownButton<ActivityLevel>(
                value: activityLevel,
                items: ActivityLevel.values.map((ActivityLevel value) {
                  return DropdownMenuItem<ActivityLevel>(
                    value: value,
                    child: Text(_getActivityText(value)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    activityLevel = newValue!;
                  });
                },
              ),
              // Calculate TDEE button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    double tdee = calculateTDEE();
                    double bmi = calculateBMI();
                    double weightInPounds =
                        isMetric ? weightKg * 2.20462 : weight;
                    double heightInInches = isMetric
                        ? heightCm / 2.54
                        : (heightFeet * 12) + heightInches;
                    double heightInMeters = heightInInches * 0.0254;
                    double bmiScore = weightInPounds / pow(heightInMeters, 2);

                    tdeeResult =
                        'The estimated TDEE or body weight maintenance energy requirement is ${tdee.toStringAsFixed(0)} Calories per day.';
                    bmiResult =
                        'BMI Score: ${bmiScore.toStringAsFixed(1)} kg/m2 (${_getBMICategory(bmi)})';
                    energyIntake = _getEnergyIntake(tdee);
                  });
                },
                child: Text('Calculate TDEE'),
              ),
              // TDEE result
              SizedBox(height: 20),
              Text(
                tdeeResult,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                bmiResult,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                energyIntake,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getActivityText(ActivityLevel activityLevel) {
    switch (activityLevel) {
      case ActivityLevel.basalMetabolicRate:
        return 'Basal Metabolic Rate';
      case ActivityLevel.sedentary:
        return 'Sedentary: little or no exercise';
      case ActivityLevel.lightlyActive:
        return 'Light: exercise 1-3 times/week';
      case ActivityLevel.moderatelyActive:
        return 'Moderate: Exercise 4-5 times/week';
      case ActivityLevel.active:
        return 'Active: daily exercise or intense exercise 3-4 times/week';
      case ActivityLevel.veryActive:
        return 'Very Active: intense exercise 6-7 times/week';
      case ActivityLevel.extraActive:
        return 'Extra Active: very intense exercise daily or physical job';
      default:
        return '';
    }
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25) {
      return 'Normal';
    } else if (bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  String _getEnergyIntake(double tdee) {
    double mildWeightLoss = tdee * 0.9;
    double weightLoss = tdee * 0.8;
    double extremeWeightLoss = tdee * 0.61;

    double mildWeightGain = tdee * 1.1;
    double weightGain = tdee * 1.2;
    double fastWeightGain = tdee * 1.39;

    return '''
Energy intake to lose weight:
Mild weight loss (0.5 lb/week): ${mildWeightLoss.toStringAsFixed(0)} Calories/day
Weight loss (1 lb/week): ${weightLoss.toStringAsFixed(0)} Calories/day
Extreme weight loss (2 lb/week): ${extremeWeightLoss.toStringAsFixed(0)} Calories/day

Energy intake to gain weight:
Mild weight gain (0.5 lb/week): ${mildWeightGain.toStringAsFixed(0)} Calories/day
Weight gain (1 lb/week): ${weightGain.toStringAsFixed(0)} Calories/day
Fast weight gain (2 lb/week): ${fastWeightGain.toStringAsFixed(0)} Calories/day
''';
  }
}
