// ignore_for_file: non_constant_identifier_names

import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Fraction {
  int numerator;
  int denominator;

  Fraction(this.numerator, this.denominator);

  Fraction add(Fraction other) {
    int resultNumerator =
        (numerator * other.denominator) + (other.numerator * denominator);
    int resultDenominator = other.numerator * other.denominator;
    return Fraction(resultNumerator, resultDenominator);
  }

  Fraction subtract(Fraction other) {
    int resultNumerator =
        (numerator * other.denominator) - (other.numerator * denominator);
    int resultDenominator = other.numerator * other.denominator;
    return Fraction(resultNumerator, resultDenominator);
  }

  Fraction multiply(Fraction other) {
    int resultNumerator = numerator * denominator;
    int resultDenominator = other.numerator * other.denominator;
    return Fraction(resultNumerator, resultDenominator);
  }

  Fraction divide(Fraction other) {
    int resultNumerator = numerator * other.denominator;
    int resultDenominator = denominator * other.numerator;
    return Fraction(resultNumerator, resultDenominator);
  }

  Fraction simplify() {
    int gcd = _calculateGCD(numerator.abs(), denominator.abs());
    return Fraction(numerator ~/ gcd, denominator ~/ gcd);
  }

  int _calculateGCD(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  String toString() {
    return "$numerator";
  }

  String toString2() {
    return "$denominator";
  }

  String toStringWithGCD() {
    int gcd = _calculateGCD(numerator.abs(), denominator.abs());
    int simplifiedNumerator = numerator ~/ gcd;
    return "$simplifiedNumerator";
  }

  String toStringWithGCD2() {
    int gcd = _calculateGCD(numerator.abs(), denominator.abs());
    int simplifiedDenominator = denominator ~/ gcd;
    return "$simplifiedDenominator";
  }
}

class FractionCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FractionCalculator(),
    );
  }
}

class FractionCalculator extends StatefulWidget {
  @override
  _FractionCalculatorState createState() => _FractionCalculatorState();
}

class _FractionCalculatorState extends State<FractionCalculator> {
  TextEditingController _numeratorController1 = TextEditingController();
  TextEditingController _denominatorController1 = TextEditingController();
  TextEditingController _numeratorController2 = TextEditingController();
  TextEditingController _denominatorController2 = TextEditingController();

  String _selectedOperation = '+';
  Fraction _result = Fraction(0, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fraction Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildFractionInput(
                "Fraction 1", _numeratorController1, _denominatorController1),
            buildOperationDropdown(),
            buildFractionInput(
                "Fraction 2", _numeratorController2, _denominatorController2),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 40),
            // text, fontSize, fontWeight, color, TextAlign end
            globalText2(
                text: "Answer:",
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                textAlignment: TextAlign.start,
                alignment: Alignment.centerLeft),
            const SizedBox(
              height: 10,
            ),
            Visibility(
                visible: _selectedOperation == '+' ? true : false,
                child: AddFraction()),
            Text(
              'Result without GCD: ${_result.toString()}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Result with GCD: ${_result.toStringWithGCD()}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
//
  Widget AddFraction() {
    return Column(
      children: [
        AnswerWidget(),
        const SizedBox(
          height: 20,
        ),
        globalText2(
            text: "Calculation Step: ",
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            textAlignment: TextAlign.start,
            alignment: Alignment.centerLeft),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              CustomColumn(
                  _numeratorController1.text, _numeratorController2.text),
              const SizedBox(
                width: 10,
              ),
              Text(_selectedOperation),
              const SizedBox(
                width: 10,
              ),
              CustomColumn(
                  _denominatorController1.text, _denominatorController2.text),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            globalText2(
                text: "=",
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                textAlignment: TextAlign.center),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CalculationDetailsRow("(${_numeratorController1.text}",
                        "${_denominatorController2.text})"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(_selectedOperation),
                    const SizedBox(
                      width: 10,
                    ),
                    CalculationDetailsRow("(${_denominatorController1.text}",
                        "${_numeratorController2.text})"),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: SizedBox(
                    width: 120,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CalculationDetailsRow("(${_numeratorController1.text}",
                        "${_denominatorController2.text})"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(_selectedOperation),
                    const SizedBox(
                      width: 10,
                    ),
                    CalculationDetailsRow("(${_denominatorController1.text}",
                        "${_numeratorController2.text})"),
                  ],
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              globalTextSixteen(text: "="),
              const SizedBox(
                width: 10,
              ),
              CustomColumn(_result.toString(), _result.toString2()),
            ],
          ),
        )
      ],
    );
  }

  Widget CalculationDetailsRow(String valueTextOne, String valueTextTwo) {
    return Row(
      children: [
        globalTextSixteen(text: valueTextOne),
        const SizedBox(
          width: 5,
        ),
        globalTextSixteen(text: "*"),
        const SizedBox(
          width: 5,
        ),
        globalTextSixteen(text: valueTextTwo),
      ],
    );
  }

  Widget AnswerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomColumn(_numeratorController1.text, _numeratorController2.text),
        const SizedBox(
          width: 10,
        ),
        Text(_selectedOperation),
        const SizedBox(
          width: 10,
        ),
        CustomColumn(
            _denominatorController1.text, _denominatorController2.text),
        const SizedBox(
          width: 10,
        ),
        const Text('='),
        const SizedBox(
          width: 10,
        ),
        Row(
          children: [
            CustomColumn(_result.toStringWithGCD(), _result.toStringWithGCD2()),
          ],
        ),
      ],
    );
  }

  Widget CustomColumn(String upperValue, String lowerValue, {double? size}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        globalTextSixteen(text: upperValue, alignment: Alignment.center),
        SizedBox(
            width: size ?? 20.0,
            child: const Divider(
              color: Colors.black,
            )),
        globalTextSixteen(text: lowerValue, alignment: Alignment.center),
      ],
    );
  }

  Widget buildFractionInput(
      String label,
      TextEditingController numeratorController,
      TextEditingController denominatorController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: TextField(
            controller: numeratorController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Numerator'),
          ),
        ),
        const Text('/'),
        Flexible(
          child: TextField(
            controller: denominatorController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Denominator'),
          ),
        ),
      ],
    );
  }

  Widget buildOperationDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('Operation:'),
        DropdownButton<String>(
          value: _selectedOperation,
          onChanged: (String? newValue) {
            setState(() {
              _selectedOperation = newValue!;
            });
          },
          items: ['+', '-', '*', '/']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  void calculate() {
    int numerator1 = int.parse(_numeratorController1.text);
    int denominator1 = int.parse(_denominatorController1.text);
    int numerator2 = int.parse(_numeratorController2.text);
    int denominator2 = int.parse(_denominatorController2.text);

    Fraction fraction1 = Fraction(numerator1, denominator1);
    Fraction fraction2 = Fraction(numerator2, denominator2);

    switch (_selectedOperation) {
      case '+':
        setState(() {
          _result = fraction1.add(fraction2);
        });
        break;
      case '-':
        setState(() {
          _result = fraction1.subtract(fraction2);
        });
        break;
      case '*':
        setState(() {
          _result = fraction1.multiply(fraction2);
        });
        break;
      case '/':
        setState(() {
          _result = fraction1.divide(fraction2);
        });
        break;
    }
  }
}
