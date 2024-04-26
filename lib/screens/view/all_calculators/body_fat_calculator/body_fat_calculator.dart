import 'package:flutter/material.dart';

class BodyFatCalculator extends StatefulWidget {
  @override
  _BodyFatCalculatorState createState() => _BodyFatCalculatorState();
}

class _BodyFatCalculatorState extends State<BodyFatCalculator> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightInchesController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  String gender = 'Male';
  double result = 0.0;

  void calculateBodyFat() {
    if (_validateInputs()) {
      double weightInKg = double.tryParse(weightController.text) ?? 0;
      if (weightInKg <= 0) {
        _showErrorDialog('Invalid weight');
        return;
      }
      int heightFeet = int.tryParse(heightFeetController.text) ?? 0;
      int heightInches = int.tryParse(heightInchesController.text) ?? 0;
      int age = int.tryParse(ageController.text) ?? 0;
      double neck = double.tryParse(neckController.text) ?? 0;
      double waist = double.tryParse(waistController.text) ?? 0;
      double hip = double.tryParse(hipController.text) ?? 0;

      // Example calculation (use a formula appropriate for your application)
      double bodyFatPercentage = 0.0;

      if (gender == 'Male') {
        bodyFatPercentage = (86.010 * (waist - neck) / weightInKg - 70.041 * heightFeet - 0.334 * age) + 36.76;
      } else {
        bodyFatPercentage = (163.205 * (waist + hip - neck) / weightInKg - 97.684 * heightFeet - 78.387 * heightInches - 76.76);
      }

      setState(() {
        result = bodyFatPercentage;
      });
    }
  }

  bool _validateInputs() {
    if (weightController.text.isEmpty ||
        heightFeetController.text.isEmpty ||
        heightInchesController.text.isEmpty ||
        ageController.text.isEmpty ||
        neckController.text.isEmpty ||
        waistController.text.isEmpty ||
        (gender == 'Female' && hipController.text.isEmpty)) {
      _showErrorDialog('Missing Information');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Fat Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton<String>(
              value: gender,
              onChanged: ( newValue) {
                setState(() {
                  gender = newValue!;
                });
              },
              items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              controller: weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Weight (kg)'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: heightFeetController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Height (feet)'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: heightInchesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Height (inches)'),
                  ),
                ),
              ],
            ),
            if (gender == 'Female')
              TextFormField(
                controller: hipController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Hip (inches)'),
              ),
            TextFormField(
              controller: neckController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Neck (inches)'),
            ),
            TextFormField(
              controller: waistController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Waist (inches)'),
            ),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBodyFat,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            if (result != 0.0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Body Fat:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${result.toStringAsFixed(1)}% = ${(result * double.parse(weightController.text) * 0.01 * 2.20462).toStringAsFixed(0)} lbs',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Weight lose 1% body fat, you must burn',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'At least: ${(5390 * double.parse(weightController.text)).toStringAsFixed(0)} Calories',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

