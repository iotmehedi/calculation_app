import 'package:flutter/material.dart';

class CalorieCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalorieCalculatorScreen(),
    );
  }
}

enum ActivityLevel {
  basalMetabolicRate,
  sedentary,
  lightlyActive,
  moderatelyActive,
  active,
  veryActive,
  extraActive,
}

enum Gender {
  male,
  female,
}

class CalorieCalculatorScreen extends StatefulWidget {
  @override
  _CalorieCalculatorScreenState createState() =>
      _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  late int heightFeet;
  late int heightInches;
  late double weightKg; // Changed to double to handle decimal values
  late int age;
  late Gender gender;
  late ActivityLevel activityLevel;
  late int calculatedCalories;
  late Map<String, int> weightLossCalories;

  @override
  void initState() {
    super.initState();
    heightFeet = 0;
    heightInches = 0;
    weightKg = 0.0;
    age = 0;
    gender = Gender.male;
    activityLevel = ActivityLevel.sedentary;
    calculatedCalories = 0;
    weightLossCalories = {
      'Maintain weight': 0,
      'Mild weight loss (0.5 lb/week)': 0,
      'Weight loss (1 lb/week)': 0,
      'Extreme weight loss (2 lb/week)': 0,
    };
  }

  void calculateCalories() {
    int heightInInches = heightFeet * 12 + heightInches;
    double weightInPounds = weightKg * 2.20462; // Conversion from kg to lbs
    double bmr;

    // Mifflin-St Jeor Equation
    if (gender == Gender.male) {
      bmr = 10 * weightInPounds + 6.25 * heightInInches - 5 * age + 5;
    } else {
      bmr = 10 * weightInPounds + 6.25 * heightInInches - 5 * age - 161;
    }

    switch (activityLevel) {
      case ActivityLevel.basalMetabolicRate:
        bmr *= 1.1; // Basal Metabolic Rate
        break;
      case ActivityLevel.sedentary:
        bmr *= 1.2; // little or no exercise
        break;
      case ActivityLevel.lightlyActive:
        bmr *= 1.375; // exercise 1-3 times/weeks
        break;
      case ActivityLevel.moderatelyActive:
        bmr *= 1.465; // Exercise 4-5 times/week
        break;
      case ActivityLevel.active:
        bmr *= 1.55; // daily exercise or intense exercise 3-4 times/week
        break;
      case ActivityLevel.veryActive:
        bmr *= 1.725; // intese exercise 6-7 times/week
        break;
      case ActivityLevel.extraActive:
        bmr *= 1.9; // very intense exercise daily or physical job
        break;
    }

    setState(() {
      calculatedCalories = bmr.round();
      // Calculate weight loss calories
      weightLossCalories['Maintain weight'] = calculatedCalories;
      weightLossCalories['Mild weight loss (0.5 lb/week)'] =
          (calculatedCalories * 0.84).round();
      weightLossCalories['Weight loss (1 lb/week)'] =
          (calculatedCalories * 0.67).round();
      weightLossCalories['Extreme weight loss (2 lb/week)'] =
          (calculatedCalories * 0.35).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Calculator'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Gender'),
            Row(
              children: <Widget>[
                Radio(
                  value: Gender.male,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value as Gender;
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: Gender.female,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value as Gender;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            Text('Age'),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  age = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Height (feet)'),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  heightFeet = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Height (inches)'),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  heightInches = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Weight (kg)'), // Changed label to indicate input is in kg
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  weightKg = double.tryParse(value) ?? 0.0; // Changed to double
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Activity Level'),
            DropdownButton<ActivityLevel>(
              value: activityLevel,
              onChanged: (value) {
                setState(() {
                  activityLevel = value!;
                });
              },
              items: ActivityLevel.values.map((activity) {
                String activityText;
                switch (activity) {
                  case ActivityLevel.basalMetabolicRate:
                    activityText = 'Basal Metabolic Rate';
                    break;
                  case ActivityLevel.sedentary:
                    activityText = 'Sedentary: little or no exercise';
                    break;
                  case ActivityLevel.lightlyActive:
                    activityText = 'Light: exercise 1-3 times/week';
                    break;
                  case ActivityLevel.moderatelyActive:
                    activityText = 'Moderate: Exercise 4-5 times/week';
                    break;
                  case ActivityLevel.active:
                    activityText =
                        'Active: daily exercise or intense exercise 3-4 times/week';
                    break;
                  case ActivityLevel.veryActive:
                    activityText =
                        'Very Active: intense exercise 6-7 times/week';
                    break;
                  case ActivityLevel.extraActive:
                    activityText =
                        'Extra Active: very intense exercise daily or physical job';
                    break;
                }
                return DropdownMenuItem<ActivityLevel>(
                  value: activity,
                  child: Text(activityText),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculateCalories,
              child: Text('Calculate Calories'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Calculated Calories:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Maintain weight: ${weightLossCalories['Maintain weight']} Calories/day'),
            Text('Mild weight loss (0.5 lb/week): ${weightLossCalories['Mild weight loss (0.5 lb/week)']} Calories/day'),
            Text('Weight loss (1 lb/week): ${weightLossCalories['Weight loss (1 lb/week)']} Calories/day'),
            Text('Extreme weight loss (2 lb/week): ${weightLossCalories['Extreme weight loss (2 lb/week)']} Calories/day'),
          ],
        ),
      ),
    );
  }
}

