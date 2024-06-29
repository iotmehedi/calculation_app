import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GPA Calculator'),
        ),
        body: GPAForm(),
      ),
    );
  }
}

class GPAForm extends StatefulWidget {
  @override
  _GPAFormState createState() => _GPAFormState();
}

class _GPAFormState extends State<GPAForm> {
  final _formKey = GlobalKey<FormState>();
  final _grades = <Grade>[];

  final _targetGPAController = TextEditingController();
  final _additionalWeightController = TextEditingController();

  double _averageGPA = 0.0;
  double _additionalGradeNeeded = 0.0;

  @override
  void dispose() {
    _targetGPAController.dispose();
    _additionalWeightController.dispose();
    super.dispose();
  }

  void _calculateGPA() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var calculator = GPA_Calculator(grades: _grades);
      setState(() {
        _averageGPA = calculator.calculateGPA();
      });
    }
  }

  void _calculateAdditionalGrade() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var calculator = GPA_Calculator(grades: _grades);
      double targetGPA = double.parse(_targetGPAController.text);
      double additionalWeight = double.parse(_additionalWeightController.text);
      setState(() {
        _additionalGradeNeeded = calculator.additionalGradeNeeded(targetGPA, additionalWeight);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ..._grades.map((grade) => ListTile(
              title: Text(grade.subject),
              subtitle: Text('Grade: ${grade.letterGrade}, Weight: ${grade.weight}'),
            )),
            TextFormField(
              decoration: InputDecoration(labelText: 'Subject'),
              onSaved: (value) {
                if (value != null) {
                  _grades.add(Grade(subject: value, letterGrade: 'A', weight: 1.0));
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Letter Grade'),
              onSaved: (value) {
                if (value != null) {
                  _grades.last.letterGrade = value;
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
              onSaved: (value) {
                if (value != null) {
                  _grades.last.weight = double.parse(value);
                }
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateGPA,
              child: Text('Calculate GPA'),
            ),
            Text('Average GPA: $_averageGPA'),
            SizedBox(height: 16),
            TextFormField(
              controller: _targetGPAController,
              decoration: InputDecoration(labelText: 'Target GPA'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a target GPA';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _additionalWeightController,
              decoration: InputDecoration(labelText: 'Additional Weight'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter additional weight';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateAdditionalGrade,
              child: Text('Calculate Additional Grade Needed'),
            ),
            Text('Additional Grade Needed: $_additionalGradeNeeded'),
          ],
        ),
      ),
    );
  }
}
class Grade {
  String subject;
  String letterGrade;
  double weight;

  Grade({required this.subject, required this.letterGrade, required this.weight});

  double get numericGrade {
    switch (letterGrade) {
      case 'A':
        return 4.0;
      case 'A-':
        return 3.7;
      case 'B+':
        return 3.3;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.7;
      case 'C+':
        return 2.3;
      case 'C':
        return 2.0;
      case 'C-':
        return 1.7;
      case 'D+':
        return 1.3;
      case 'D':
        return 1.0;
      case 'D-':
        return 0.7;
      case 'F':
        return 0.0;
      default:
        return 0.0;
    }
  }
}

class GPA_Calculator {
  List<Grade> grades;

  GPA_Calculator({required this.grades});

  double calculateGPA() {
    double totalWeight = 0;
    double totalWeightedGrade = 0;

    for (var grade in grades) {
      totalWeightedGrade += grade.numericGrade * grade.weight;
      totalWeight += grade.weight;
    }

    return totalWeightedGrade / totalWeight;
  }

  double additionalGradeNeeded(double targetGPA, double additionalWeight) {
    double currentGPA = calculateGPA();
    double totalWeight = grades.fold(0, (sum, grade) => sum + int.parse(grade.weight.toString())) + additionalWeight;
    double requiredGrade = (targetGPA * totalWeight - currentGPA * grades.fold(0, (sum, grade) => sum + grade.weight)) / additionalWeight;
    return requiredGrade;
  }
}
