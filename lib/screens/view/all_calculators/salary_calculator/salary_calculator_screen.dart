import 'package:flutter/material.dart';

void main() {
  runApp(SalaryCalculatorApp());
}

class SalaryCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salary Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SalaryCalculatorScreen(),
    );
  }
}

class SalaryCalculatorScreen extends StatefulWidget {
  @override
  _SalaryCalculatorScreenState createState() => _SalaryCalculatorScreenState();
}

class _SalaryCalculatorScreenState extends State<SalaryCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedInterval = 'Hourly';
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _hoursPerWeekController = TextEditingController();
  final TextEditingController _daysPerWeekController = TextEditingController();
  final TextEditingController _holidaysPerYearController = TextEditingController();
  final TextEditingController _vacationDaysPerYearController = TextEditingController();

  final List<String> _intervals = ['Hourly', 'Daily', 'Weekly', 'Biweekly', 'Semi-monthly', 'Monthly', 'Quarterly', 'Yearly'];

  Map<String, double> _unadjustedSalaries = {};
  Map<String, double> _adjustedSalaries = {};

  void _calculateSalaries() {
    if (_formKey.currentState!.validate()) {
      double salary = double.parse(_salaryController.text);
      double hoursPerWeek = double.parse(_hoursPerWeekController.text);
      double daysPerWeek = double.parse(_daysPerWeekController.text);
      double holidaysPerYear = double.parse(_holidaysPerYearController.text);
      double vacationDaysPerYear = double.parse(_vacationDaysPerYearController.text);

      double weeksPerYear = 52;
      double workDaysPerYear = daysPerWeek * weeksPerYear;
      double workHoursPerYear = hoursPerWeek * weeksPerYear;
      double totalNonWorkingDays = holidaysPerYear + vacationDaysPerYear;
      double adjustedWorkDaysPerYear = workDaysPerYear - totalNonWorkingDays;
      double adjustedWorkHoursPerYear = adjustedWorkDaysPerYear * (hoursPerWeek / daysPerWeek);

      // Convert the input salary to hourly if it's not hourly
      switch (_selectedInterval) {
        case 'Daily':
          salary /= (hoursPerWeek / daysPerWeek);
          break;
        case 'Weekly':
          salary /= hoursPerWeek;
          break;
        case 'Biweekly':
          salary /= (hoursPerWeek * 2);
          break;
        case 'Semi-monthly':
          salary /= (hoursPerWeek * weeksPerYear / 24);
          break;
        case 'Monthly':
          salary /= (hoursPerWeek * weeksPerYear / 12);
          break;
        case 'Quarterly':
          salary /= (hoursPerWeek * weeksPerYear / 4);
          break;
        case 'Yearly':
          salary /= (hoursPerWeek * weeksPerYear);
          break;
        default:
          break;
      }

      // Unadjusted Salaries Calculation
      _unadjustedSalaries = {
        'Hourly': salary,
        'Daily': salary * hoursPerWeek / daysPerWeek,
        'Weekly': salary * hoursPerWeek,
        'Biweekly': salary * hoursPerWeek * 2,
        'Semi-monthly': salary * hoursPerWeek * weeksPerYear / 24,
        'Monthly': salary * hoursPerWeek * weeksPerYear / 12,
        'Quarterly': salary * hoursPerWeek * weeksPerYear / 4,
        'Yearly': salary * hoursPerWeek * weeksPerYear,
      };

      // Adjusted Salaries Calculation
      double annualAdjustedSalary = salary * adjustedWorkHoursPerYear;
      double adjustedHourlySalary = annualAdjustedSalary / workHoursPerYear;

      _adjustedSalaries = {
        'Hourly': adjustedHourlySalary,
        'Daily': adjustedHourlySalary * (hoursPerWeek / daysPerWeek),
        'Weekly': adjustedHourlySalary * hoursPerWeek,
        'Biweekly': adjustedHourlySalary * hoursPerWeek * 2,
        'Semi-monthly': annualAdjustedSalary / 24,
        'Monthly': annualAdjustedSalary / 12,
        'Quarterly': annualAdjustedSalary / 4,
        'Yearly': annualAdjustedSalary,
      };

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salary Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedInterval,
                  items: _intervals.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedInterval = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Salary Interval',
                  ),
                ),
                TextFormField(
                  controller: _salaryController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Salary Amount',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter salary amount';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _hoursPerWeekController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Hours per Week',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter hours per week';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _daysPerWeekController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Days per Week',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter days per week';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _holidaysPerYearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Holidays per Year',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter holidays per year';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _vacationDaysPerYearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Vacation Days per Year',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vacation days per year';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateSalaries,
                  child: Text('Calculate'),
                ),
                SizedBox(height: 20),
                if (_unadjustedSalaries.isNotEmpty) ...[
                  Text('Unadjusted Salaries:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ..._unadjustedSalaries.entries.map((entry) => Text('${entry.key}: \$${entry.value.toStringAsFixed(2)}')),
                ],
                SizedBox(height: 20),
                if (_adjustedSalaries.isNotEmpty) ...[
                  Text('Adjusted Salaries:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ..._adjustedSalaries.entries.map((entry) => Text('${entry.key}: \$${entry.value.toStringAsFixed(2)}')),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
