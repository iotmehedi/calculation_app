// ignore_for_file: non_constant_identifier_names

import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';

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
    return FractionCalculator();
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
  var selectedOperator = '';
  @override
  void initState() {
    super.initState();
    // Load the selected operation from SharedPreferences
    _loadSelectedOperation();
  }

  void _loadSelectedOperation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedOperator = prefs.getString('selectedOperation') ?? '+';
  }

  void _saveSelectedOperation(String operation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedOperation', operation);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: connectivityService.isConnected,
        builder: (context, isConnected, child) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackgroundColor,
            appBar: CustomAppBar(
              title: 'Fraction Calculator',
              onBackPressed: () async {
                Navigator.pop(context);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: buildFractionInput("Fraction 1",
                              _numeratorController1, _numeratorController2),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        buildOperationDropdown(),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: buildFractionInput("Fraction 2",
                              _denominatorController1, _denominatorController2),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.calculateButtonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: isConnected
                          ? calculate
                          : () {
                              errorToast(
                                  context: context,
                                  msg: "Please check your internet connection",
                                  color: Colors.grey,
                                  iconColor: Colors.red,
                                  headingTextColor: Colors.red,
                                  valueTextColor: Colors.red);
                            },
                      child: Center(
                        child: globalText20(
                            text: "Calculate",
                            color: Colors.white,
                            alignment: Alignment.center),
                      ),
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
                        visible: ((selectedOperator == '+') ||
                                    (selectedOperator == '-')) &&
                                (_numeratorController1.text.isNotEmpty &&
                                    _numeratorController2.text.isNotEmpty &&
                                    _denominatorController1.text.isNotEmpty &&
                                    _denominatorController2.text.isNotEmpty)
                            ? true
                            : false,
                        child: AddFraction()),

                    Visibility(
                      visible: ((selectedOperator == '*') ||
                              (selectedOperator == 'of')) &&
                          (_numeratorController1.text.isNotEmpty &&
                              _numeratorController2.text.isNotEmpty &&
                              _denominatorController1.text.isNotEmpty &&
                              _denominatorController2.text.isNotEmpty),
                      child: MultiplyWidget(),
                    ),
                    Visibility(
                      visible: (selectedOperator == '÷') &&
                          (_numeratorController1.text.isNotEmpty &&
                              _numeratorController2.text.isNotEmpty &&
                              _denominatorController1.text.isNotEmpty &&
                              _denominatorController2.text.isNotEmpty),
                      child: DivideWidget(),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

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
              globalTextSixteen(text: selectedOperator.toString()),
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
                    globalTextSixteen(text: selectedOperator.toString()),
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
                    CalculationDetailsRow("(${_numeratorController2.text}",
                        "${_denominatorController2.text})"),
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
              CustomColumn(
                  _result.toStringWithGCD(), _result.toStringWithGCD2()),
            ],
          ),
        )
      ],
    );
  }

  Widget MultiplyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnswerWidget(),
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
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomColumn(
                  _numeratorController1.text, _numeratorController2.text),
              const SizedBox(
                width: 10,
              ),
              globalTextSixteen(text: selectedOperator.toString()),
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
              Column(
                children: [
                  CalculationDetailsRow(
                      _numeratorController1.text, _denominatorController1.text),
                  SizedBox(
                    width: 40,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  CalculationDetailsRow(
                      _numeratorController2.text, _denominatorController2.text),
                ],
              ),
            ],
          ),
        ),
        WithAndWithoutGCDResult()
        // globalTextSixteen(text: "*"),
      ],
    );
  }

  Widget DivideWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnswerWidget(),
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
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomColumn(
                  _numeratorController1.text, _numeratorController2.text),
              const SizedBox(
                width: 10,
              ),
              globalTextSixteen(text: selectedOperator.toString()),
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
              Column(
                children: [
                  CalculationDetailsRow(
                      _numeratorController1.text, _denominatorController2.text),
                  SizedBox(
                    width: 40,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  CalculationDetailsRow(
                      _numeratorController2.text, _denominatorController1.text),
                ],
              ),
            ],
          ),
        ),
        WithAndWithoutGCDResult()
        // globalTextSixteen(text: "*"),
      ],
    );
  }

  Widget WithAndWithoutGCDResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
              CustomColumn(
                  _result.toStringWithGCD(), _result.toStringWithGCD2()),
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
        globalTextSixteen(text: selectedOperator.toString()),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.fractionInputTextBorderColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: numeratorController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: '',
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Divider(),
        const SizedBox(
          height: 3,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.fractionInputTextBorderColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            controller: denominatorController,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            decoration:
                const InputDecoration(labelText: '', border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  Widget buildOperationDropdown() {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 39,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.fractionInputTextBorderColor,
        ),
        child: DropdownButton<String>(
          isDense: true,
          value: _selectedOperation,
          alignment: Alignment.center,
          onChanged: (String? newValue) {
            _saveSelectedOperation(newValue!);
            setState(() {
              _selectedOperation = newValue!;
            });
          },
          icon: Icon(Icons.keyboard_arrow_down),
          items: ['+', '-', '*', '÷', 'of']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: globalText24(text: value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void calculate() {
    if (_numeratorController1.text.isEmpty &&
        _numeratorController2.text.isEmpty &&
        _denominatorController1.text.isEmpty &&
        _denominatorController2.text.isEmpty) {
      errorToast(context: context, msg: "Enter value");
    } else if (_numeratorController1.text.isEmpty) {
      print(1);
      errorToast(
          context: context, msg: "Enter a value in the first writing space");
    } else if (_numeratorController2.text.isEmpty) {
      print(2);
      errorToast(
          context: context, msg: "Enter a value in the third writing space");
    } else if (_denominatorController1.text.isEmpty) {
      print(3);
      errorToast(
          context: context, msg: "Enter a value in the second writing space");
    } else if (_denominatorController2.text.isEmpty) {
      errorToast(
          context: context, msg: "Enter a value in the forth writing space");
    } else {
      int numerator1 = int.parse(_numeratorController1.text);
      int denominator1 = int.parse(_denominatorController1.text);
      int numerator2 = int.parse(_numeratorController2.text);
      int denominator2 = int.parse(_denominatorController2.text);
      _loadSelectedOperation();
      Fraction fraction1 = Fraction(numerator1, denominator1);
      Fraction fraction2 = Fraction(numerator2, denominator2);

      switch (_selectedOperation) {
        case '+':
          setState(() {
            _result = fraction1.add(fraction2);
            _saveSelectedOperation("+");
            _loadSelectedOperation();
          });
          break;
        case '-':
          setState(() {
            _result = fraction1.subtract(fraction2);
            _saveSelectedOperation("-");
          });
          break;
        case '*':
          setState(() {
            _result = fraction1.multiply(fraction2);
            _saveSelectedOperation("*");
          });
          break;
        case 'of':
          setState(() {
            _result = fraction1.multiply(fraction2);
            _saveSelectedOperation("of");
          });
          break;
        case '÷':
          setState(() {
            _result = fraction1.divide(fraction2);
            _saveSelectedOperation("÷");
          });
          break;
      }
    }
  }
}
