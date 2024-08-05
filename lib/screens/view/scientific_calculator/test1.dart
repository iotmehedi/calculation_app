import 'dart:math';

import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import 'package:logger/logger.dart';

import '../../../core/utils/consts/textstyle.dart';
import 'package:expressions/expressions.dart' as ex;



class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  double num1 = 0.0;
  double num2 = 0.0;
  var input = TextEditingController();
  var input1 = '';
  var output = '';
  var output1 = '';
  var userinput = '';
  double memory = 0.0; // Memory variable
  double memoryValue = 0.0;
  double mrValue = 0.0; // MR value
  double mPlusValue = 0.0; // M+ value
  double mMinusValue = 0.0; // M- value
  var radioButtonStatus = "";
  var getRadioButtonValue = '';
  var isHaveOrOrNot = '';
  FocusNode _focusNode = FocusNode();
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  _onButtonClicked(value) {
    if (value == "AC") {
      input.text = '';
      output = '';
      output1 = '';
      isHaveOrOrNot = '';
      memory = 0.0;
      memoryValue = 0.0;
      mrValue = 0.0;
      mPlusValue = 0.0;
      mMinusValue = 0.0;
    } else if (value == "DEL") {
      if (input.text.isNotEmpty) {
        input.text = input.text.substring(0, input.text.length - 1);
      }
    } else if (value == "=" || value == "Ans") {
      print("the value is $value");
      if (input.text.isNotEmpty) {
        // try{
        userinput = input.text;
        userinput = userinput.replaceAll('÷', '/');
        userinput = userinput.replaceAll('x', '*');
        userinput = userinput.replaceAll('e', 'e^(1)');
        // userinput = userinput.replaceAll("log", "logBase");
        // userinput = userinput.replaceAll("exp", "expBase");
        // userinput = userinput.replaceAll("3√x", "^(1/3)");
        userinput = userinput.replaceAll("log", "logBase");

        userinput =
            userinput.replaceAllMapped(RegExp(r'√(\d+(\.\d+)?)'), (match) {
              return "(${match[1]})^(1/2)";
            });
        userinput = userinput.replaceAll("x", "*");

        if (userinput.contains("logBase")) {
          String sanitizedInput = sanitizeInput(input.text);

          double result = evaluateExpression(sanitizedInput);
          output = result.toString();
        } else if (input.text.contains("^(1/3)")) {
          String sanitizedExpression = sanitizeInput(input.text);
          double result = evaluateInnerExpression(sanitizedExpression);
          output1 = result.toString();
          output = result.toString();
        } else if (input.text.contains("√")) {
          String sanitizedExpression = sanitizeInput(input.text);
          double result = evaluateInnerExpression(sanitizedExpression);
          print("result make: $result");
          output = result.toString();
        } else if (userinput.contains("%")) {
          List<String> operators = ['+', '-', 'x', '/', '^'];
          bool containsOperator = operators.any((op) => input.text.contains(op));

          if (containsOperator) {
            String convertedInput = convertPercentages(input.text);

            // Parse the expression
            ex.Expression expression = ex.Expression.parse(convertedInput);

            // Evaluate the expression
            final evaluator = const ex.ExpressionEvaluator();
            output1 = evaluator.eval(expression, {}).toString();
          } else {
            output1 = (double.parse(input.text.replaceAll("%", "")) / 100)
                .toStringAsFixed(2);
          }
        } else if (userinput.contains("!")) {
          String sanitizedInput = sanitizeInput(input.text);
          double result = evaluateInnerExpression(sanitizedInput);
          output1 = result.toString();
        }else if (userinput.contains("^(1/3)")) {
          String sanitizedInput = sanitizeInput(input.text);
          double result = evaluateInnerExpression(sanitizedInput);
          output1 = result.toString();
        } else if (userinput.contains("sin")) {
          print("this is value sin");
          String sanitizedInput = sanitizeInput(input.text);
          double result = evaluateExpression(sanitizedInput);
          output = result.toString();
          output1 = result.toString();
        } else if (userinput.contains("cos")) {
          String sanitizedInput = sanitizeInput(input.text);
          double result = evaluateExpression(sanitizedInput);
          output1 = result.toString();
        } else if (userinput.contains("tan")) {
          String sanitizedInput = sanitizeInput(input.text);
          double result = evaluateExpression(sanitizedInput);
          output1 = result.toString();
          output = result.toString();
        } else if (userinput.contains("sin-¹")) {
          String sanitizedInput = sanitizeInput(input.text);
          double result = evaluateExpression(sanitizedInput);

          output1 = result.toString();
        } else if (userinput.contains("cos-¹")) {
          String sanitizedInput = sanitizeInput(input.text);
          double result = evaluateExpression(sanitizedInput);
          output1 = result.toString();
        } else if (userinput.contains("tan-¹")) {
          String result1 = input.text.replaceAll("RND", '');
          String sanitizedInput = sanitizeInput(result1);
          double result = evaluateExpression(sanitizedInput);
          print("this is tan-1 $result");
          output1 = result.toString();
        } else if(userinput.contains("eˣ")){
          print("this is debug ");
          String sanitizedInput = sanitizeInput(input.text);
          double result = evaluateInnerExpression(sanitizedInput);
          output = result.toString();
        } else if (userinput.contains("±")) {
          setState(() {
            String sanitizedInput = sanitizeInput(input.text);
            double result = evaluateExpression(sanitizedInput);
            output1 = result.toString();
          });
        } else if (userinput.contains("MR") ||
            userinput.contains("M+") ||
            userinput.contains("M-")) {
          String sanitizedInput = sanitizeInput(input.text);
          double result = evaluateInnerExpression(sanitizedInput);
          output1 = result.toString();
        } else if(userinput.contains("±")){
          String sanitizedInput = sanitizeInput(input.text);
          double result = evaluateExpression(sanitizedInput);
          output1 = result.toString();
        }else {
          Parser p = Parser();
          Expression exp = p.parse(userinput);
          ContextModel cm = ContextModel();
          var result = exp.evaluate(EvaluationType.REAL, cm);
          output = result.toString();
          output1 = result.toString();
          if (output.endsWith(".0")) {
            output = output.substring(0, output.length - 2);
          }
          print("Result: $output $input");
        } // Final result
        // }catch(e){
        //   errorToast(context: context, msg: "Please enter valid value");
        // }
      }
    } else if (value == "(") {
      input.text += "(";
    } else if (value == ")") {
      // input.text += ")";
      handleInput(value);
    } else if (value == "log") {
      input.text += "log(";
    } else if (value == "EXP") {
      input.text += "EXP(";
    } else if (value == "M+") {
      // Add current output value to memory
      input.text += "M+";
    } else if (value == "M-") {
      // Subtract current output value from memory
      input.text += "M-";
    } else if (value == "MR") {
      // Recall memory value
      input.text += "MR";
    } else if (value == "Back") {
      // Recall memory value
      // if(input.text.isEmpty){
      //   input.text = '';
      // }else{
      //   input.text = input.text.substring(0, input.text.length - 1);
      // }
      // // to remove one character
      // if (input.text == '') {
      //   input.text = '';
      // }
      final text = input.text;
      final selection = input.selection;
      final int cursorPosition = selection.start;

      if (cursorPosition > 0) {
        final newText = text.substring(0, cursorPosition - 1) + text.substring(cursorPosition);
        setState(() {
          input.text = newText;
          input.selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition - 1));
        });
      }
    } else if (value == "π") {
      // if (output.isNotEmpty && output != 'Error') {
      setState(() {
        input.text += "3.1415";
      });
      // }
    } else if (value == "e") {
      input.text += "2.72";
    } else if (value == '3√x') {
      if (output == '0') {
        output = 'Error';
      } else {
        input.text = '$input.text^(1/3)';
      }
    } else if (value == '1/x') {
      if (output == '0') {
        input.text = '1/';
      } else {
        input.text = '${input.text}1/';
      }
    } else if (value == '√x') {
      input.text += '√';
    } else if (value == "ln") {
      input.text += "ln("; // Natural log function
    } else if (value == "log") {
      input.text += "log("; // Add base log function
    } else if (value == 'xʸ') {
      if (output == '0') {
        input.text = 'Error';
      } else {
        input.text = '$input.text^';
      }
    } else if (value == 'eˣ') {
      if (output == '0') {
        input.text = 'e^';
      } else {
        input.text = '${input.text}e^';
      }
    } else if (value == '10ˣ') {
      if (output == '0') {
        input.text = '10^';
      } else {
        input.text = '${input.text}10^';
      }
    } else if (value == 'x²') {
      if (output == '0') {
        input.text = 'Error';
      } else {
        input.text = '$input.text^2';
      }
    } else if (value == 'x³') {
      if (output == '0') {
        input.text = 'Error';
      } else {
        input.text = '$input.text^3';
      }
    } else if (value == "n!") {
      input.text = "$input.text!";
    } else if (value == "%") {
      input.text = '$input.text%';
    } else if (value == "Sin") {
      // input.text += "sin(";
      handleInput("sin");
    } else if (value == "Cos") {
      handleInput("cos");
    } else if (value == "Tan") {
      handleInput("tan");
    } else if (value == "sin-¹") {
      input.text += "sin-¹(";
    } else if (value == "cos-¹") {
      input.text += "cos-¹(";
    } else if (value == "tan-¹") {
      // input.text += "tan-¹(";
      _insertText("tan-¹(");
    } else if (value == "±") {
      if (output == '0') {
        input.text = 'Error';
      } else {
        input.text = '($input.text)±';
      }
    } else if (value == "RND") {
      handleInput(value);
    } else if (value == "y√x") {
      // input.text += '√';
      _insertText('√');
    } else {
      handleInput(value);
    }

    setState(() {});
  }
  void _insertText(String textToInsert) {
    final text = input.text;
    final selection = input.selection;

    final newText = text.replaceRange(
      selection.start,
      selection.end,
      textToInsert,
    );

    final newSelection = selection.copyWith(
      baseOffset: selection.start + textToInsert.length,
      extentOffset: selection.start + textToInsert.length,
    );

    input.value = TextEditingValue(
      text: newText,
      selection: newSelection,
    );
  }
  bool insideTrigFunction = false;
  // void handleInput(String value) {
  //   // If the input.text is a trigonometric function, set the flag and append the function
  //   if (value == "sin" || value == "cos" || value == "tan") {
  //     input.text += "$value(";
  //     insideTrigFunction = true;
  //   } else if (value == ")") {
  //     input.text += value;
  //     insideTrigFunction = false;
  //   } else if (value == "RND") {
  //     print("this is random");
  //     input.text += Random().nextDouble().toStringAsFixed(9);
  //   } else {
  //     // If inside a trigonometric function, append the value and degree symbol if it's a number
  //     if (insideTrigFunction && RegExp(r'\d$').hasMatch(value)) {
  //       input.text += value + "°";
  //     } else {
  //       input.text += value;
  //     }
  //   }
  //
  //   print("input $input"); // For debugging
  // }

  void handleInput(String value) {
    final currentText = input.text;
    final selection = input.selection;

    String newText;
    if (value == "sin" || value == "cos" || value == "tan") {
      newText = currentText.replaceRange(
        selection.start,
        selection.end,
        "$value(",
      );
      insideTrigFunction = true;
    } else if (value == ")") {
      newText = currentText.replaceRange(
        selection.start,
        selection.end,
        value,
      );
      insideTrigFunction = false;
    } else if (value == "RND") {
      newText = currentText.replaceRange(
        selection.start,
        selection.end,
        Random().nextDouble().toStringAsFixed(9),
      );
    } else {
      if (insideTrigFunction && RegExp(r'\d$').hasMatch(value) && input.text.contains("sin")) {
        newText = currentText.replaceRange(
          selection.start,
          selection.end,
          value + "°",
        );
      } else {
      newText = currentText.replaceRange(
        selection.start,
        selection.end,
        value,
      );
      }
    }

    final newSelection = selection.copyWith(
      baseOffset: selection.start + (value == "RND" ? Random().nextDouble().toStringAsFixed(9).length : value.length),
      extentOffset: selection.start + (value == "RND" ? Random().nextDouble().toStringAsFixed(9).length : value.length),
    );

    input.value = TextEditingValue(
      text: newText,
      selection: newSelection,
    );

    print("input ${input.text}"); // For debugging
  }

  double evaluateInnerExpression(String expression) {
    // Replace degree symbols and other custom symbols if necessary
    expression = expression.replaceAll('°', '');

    // Evaluate the arithmetic expression
    try {
      print("Evaluating Inner Expression: $expression");
      final expressionObject = ex.Expression.parse(expression);
      final evaluator = const ex.ExpressionEvaluator();
      // Ensure result is double
      var result = evaluator.eval(expressionObject, {});
      if (result is int) {
        result = result.toDouble(); // Convert int to double
      }
      return result as double;
    } catch (e) {
      print("Error evaluating inner expression: $e");
      return double.nan;
    }
  }


  double evaluatePower(double base, double exponent) {
    return pow(base, exponent).toDouble();
  }
  double evaluateTrigonometricFunction(String function, double valueInDegrees) {
    double result;
    double valueInRadians = valueInDegrees * (pi / 180);

    switch (function) {
      case 'sin':
        result = sin(valueInRadians);
        break;
      case 'cos':
        result = cos(valueInRadians);
        break;
      case 'tan':
        result = tan(valueInRadians);
        break;
      default:
        throw ArgumentError('Unsupported function: $function');
    }

    return result;
  }

  double evaluateInverseTrigonometricFunction(
      String function, double valueInDegrees) {
    double result;
    double valueInRadians = valueInDegrees * (pi / 180);

    switch (function) {
      case 'sin-1':
        result = asin(valueInRadians);
        break;
      case 'cos-1':
        result = acos(valueInRadians);
        break;
      case 'tan-1':
        result = atan(valueInRadians);
        break;
      default:
        throw ArgumentError('Unsupported function: $function');
    }

    return result;
  }

  double evaluateNaturalLogarithm(double value) {
    return log(value);
  }

  double evaluateCommonLogarithm(double value) {
    return log(value) / ln10;
  }

  double evaluateSquareRoot(double value) {
    return sqrt(value);
  }

  double evaluateExponential(double exponent) {
    return exp(exponent).toDouble();
  }

  double evaluateExponentialConstant() {
    return exp(1).toDouble();
  }

  double evaluatePercentage(double value) {
    return value / 100;
  }

  int evaluateFactorial(int value) {
    if (value < 0)
      throw ArgumentError('Factorial is not defined for negative numbers');
    if (value == 0 || value == 1) return 1;
    int result = 1;
    for (int i = 2; i <= value; i++) {
      result *= i;
    }
    return result;
  }

//for m+
  void addToMemory(double value) {
    memoryValue += value;
  }

  void clearMemory() {
    memoryValue = 0.0;
  }

  double recallMemory() {
    return memoryValue;
  }

  //M-
  void subtractFromMemory(double value) {
    memoryValue -= value;
  }



  double evaluateReciprocal(double value) {
    if (value == 0) {
      throw ArgumentError('Division by zero is not allowed.');
    }
    return 1 / value;
  }
  double evaluateMemoryRecall() {
    return 3.5;
  }
  String sanitizeInput(String input) {
    input = input.replaceAll("x", "*").replaceAll('÷', '/');
    // Process cosine
    input = input.replaceAllMapped(RegExp(r'cos\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double totalDegrees = evaluateInnerExpression(innerExpression);
      double cosValue = evaluateTrigonometricFunction('cos', totalDegrees);
      return cosValue.toString();
    });
    print("hudai");
    // Process sine
    input = input.replaceAllMapped(RegExp(r'sin\(([^)x]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double totalDegrees = evaluateInnerExpression(innerExpression);
      double sinValue = evaluateTrigonometricFunction('sin', totalDegrees);
      return sinValue.toString();
    });

    // Process tangent
    input = input.replaceAllMapped(RegExp(r'tan\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double totalDegrees = evaluateInnerExpression(innerExpression);
      double tanValue = evaluateTrigonometricFunction('tan', totalDegrees);
      return tanValue.toString();
    });

    // Process inverse sine
    input = input.replaceAllMapped(RegExp(r'sin-¹\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double totalDegrees = evaluateInnerExpression(innerExpression);
      double sinInverseValue =
      evaluateInverseTrigonometricFunction('sin-1', totalDegrees);
      return sinInverseValue.toString();
    });

    // Process inverse cosine
    input = input.replaceAllMapped(RegExp(r'cos-¹\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double totalDegrees = evaluateInnerExpression(innerExpression);
      double cosInverseValue =
      evaluateInverseTrigonometricFunction('cos-1', totalDegrees);
      return cosInverseValue.toString();
    });

    // Process inverse tangent
    input = input.replaceAllMapped(RegExp(r'tan-¹\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double totalDegrees = evaluateInnerExpression(innerExpression);
      double tanInverseValue =
      evaluateInverseTrigonometricFunction('tan-1', totalDegrees);
      return tanInverseValue.toString();
    });

    // Process natural logarithm
    input = input.replaceAllMapped(RegExp(r'ln\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double innerValue = evaluateInnerExpression(innerExpression);
      double lnValue = evaluateNaturalLogarithm(innerValue);
      return lnValue.toString();
    });

    // Process common logarithm (base 10)
    input = input.replaceAllMapped(RegExp(r'log\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double innerValue = evaluateInnerExpression(innerExpression);
      double logValue = evaluateCommonLogarithm(innerValue);
      return logValue.toString();
    });

    // Process square root
    input = input.replaceAllMapped(RegExp(r'√(\d+(\.\d+)?)'), (match) {
      double value = double.parse(match.group(1)!);
      double sqrtValue = evaluateSquareRoot(value);
      return sqrtValue.toString();
    });

    // Process fractional exponentiation (e.g., a^(1/b))
    input = input.replaceAllMapped(
        RegExp(
            r'(\d+(\.\d+)?|\d+(\.\d+)?\^\d+(\.\d+)?|\d+\.\d+|\d+)\^\((\d+)/(\d+)\)'),
            (match) {
          double base = evaluateInnerExpression(match.group(1)!);
          double numerator = double.parse(match.group(5)!);
          double denominator = double.parse(match.group(6)!);
          double exponent = numerator / denominator;
          return evaluatePower(base, exponent).toString();
        });

    // Replace exponentiation operator ^ with Dart's power function operator **
    input = input.replaceAllMapped(RegExp(r'(\d+)\^(\d+)'), (match) {
      double base = double.parse(match.group(1)!);
      double exponent = double.parse(match.group(2)!);
      return pow(base, exponent).toString();
    });

    // Process exponential function e^x
    input = input.replaceAllMapped(RegExp(r'e\^(\d+(\.\d+)?)'), (match) {
      double exponent = double.parse(match.group(1)!);
      double expValue = evaluateExponential(exponent);
      return expValue.toString();
    });
// Substitute the constant 'e' with its value
    input = input.replaceAll('e', evaluateExponentialConstant().toString());
    // Process reciprocal (1/x)
    input = input.replaceAllMapped(RegExp(r'1/(\d+(\.\d+)?)'), (match) {
      double value = double.parse(match.group(1)!);
      return evaluateReciprocal(value).toString();
    });

    // Process percentages
    input = input.replaceAllMapped(RegExp(r'(\d+(\.\d+)?)%'), (match) {
      double value = double.parse(match.group(1)!);
      return evaluatePercentage(value).toString();
    });

    // Process factorials
    input = input.replaceAllMapped(RegExp(r'(\d+)!'), (match) {
      int value = int.parse(match.group(1)!);
      return evaluateFactorial(value).toString();
    });

    input = input.replaceAllMapped(RegExp(r'M\+'), (match) {
      double lastResult =
      evaluateInnerExpression(input.substring(0, match.start));
      addToMemory(lastResult);
      return '';
    });

    // Handle M-
    input = input.replaceAllMapped(RegExp(r'M-'), (match) {
      double lastResult =
      evaluateInnerExpression(input.substring(0, match.start));
      subtractFromMemory(lastResult);
      return '';
    });

    // Process memory recall (MR)
    input = input.replaceAllMapped(RegExp(r'MR'), (match) {
      return evaluateMemoryRecall().toString();
    });

    // Handle RAD
    input = input.replaceAllMapped(RegExp(r'RAD\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double degrees = evaluateInnerExpression(innerExpression);
      double radians = degrees * (pi / 180);
      return radians.toString();
    });

    // Handle degree symbol (°)
    input = input.replaceAllMapped(RegExp(r'(\d+(\.\d+)?)°'), (match) {
      double degrees = double.parse(match.group(1)!);
      return degrees.toString();
    });

    // Handle EXP function
    input = input.replaceAllMapped(RegExp(r'EXP\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double exponent = evaluateInnerExpression(innerExpression);
      double expValue = evaluateExponential(exponent);
      return expValue.toString();
    });

// Handle ± (plus-minus)
    print("this is input $input");
    input =
        input.replaceAllMapped(RegExp(r'(\d+(\.\d+)?)±(\d+(\.\d+)?)'), (match) {
          double base = double.parse(match.group(1)!);
          double offset = double.parse(match.group(3)!);
          return '${base + offset} or ${base - offset}';
        });

    print("this is input $input");
    // Handle expressions like "2^(1/3)"
    input = input.replaceAllMapped(RegExp(r'(\d+(\.\d+)?|\d+)\^\((\d+)/(\d+)\)'), (match) {
      double base = double.parse(match.group(1)!);
      double numerator = double.parse(match.group(3)!);
      double denominator = double.parse(match.group(4)!);
      double exponent = numerator / denominator;
      return evaluatePower(base, exponent).toString();
    });
    // Remove any remaining degree symbols
    input = input.replaceAll('°', '');

    return input;
  }

  double evaluateExpression(String input) {
    try {

      // Debug: print the expression to ensure it's correctly formatted
      print("Evaluating Expression: $input");
      if (input.contains("or")) {
        // Split the input on "or" to handle multiple possible expressions
        List<String> parts = input.split(RegExp(r'\sor\s'));

        if (parts.length != 2) {
          print("Unexpected format in the expression.");
          return double.nan;
        }

        // Parse and evaluate both expressions
        final expressionObject1 = ex.Expression.parse(parts[0].trim());
        final expressionObject2 = ex.Expression.parse(parts[1].trim());
        final evaluator = const ex.ExpressionEvaluator();
        var result1 = evaluator.eval(expressionObject1, {});
        var result2 = evaluator.eval(expressionObject2, {});
        print("this is result $result2");
        print("this is result $result1");

        isHaveOrOrNot = "${double.tryParse(result1.toString())?.toStringAsFixed(4).toString()} or ${double.tryParse(result2.toString())?.toStringAsFixed(4).toString()}";
        // Handle the case where both results need to be returned or selected
        // For now, we'll just return the first result for demonstration purposes
        return result1 is num ? result1.toDouble() : double.nan;
      }else{
        isHaveOrOrNot = '';
        final expressionObject = ex.Expression.parse(input);
        final evaluator = const ex.ExpressionEvaluator();
        var result = evaluator.eval(expressionObject, {});
        print("Result make $result");
        return result;
      }

    } catch (e) {
      print("Error parsing expression: $e");
      return double.nan;
    }
  }

  String convertPercentages(String input) {
    RegExp exp = RegExp(r'(\d+)%');
    return input.replaceAllMapped(exp, (Match match) {
      double value = double.parse(match.group(1)!) / 100;
      return value.toString();
    });
  }

  String convertFactorials(String input) {
    RegExp exp = RegExp(r'(\d+)!');
    return input.replaceAllMapped(exp, (Match match) {
      int value = int.parse(match.group(1)!);
      int factorial = 1;
      for (int i = 1; i <= value; i++) {
        factorial *= i;
      }
      return factorial.toString();
    });
  }

  String handleExponentiation(String input) {
    print("input is $input");
    RegExp exp = RegExp(r'(\d+)\^(\d+)');
    return input.replaceAllMapped(exp, (Match match) {
      String base = match.group(1)!;
      String exponent = match.group(2)!;
      return '($base)^$exponent';
    });
  }

  String formatResult(String input) {
    // Try parsing the input to a double
    double? value = double.tryParse(input);
    if (value == null) {
      return ''; // Return an empty string if parsing fails
    }

    // Convert the double to a string with fixed precision and then remove trailing zeros
    String result = value.toStringAsFixed(9);

    // Remove unnecessary trailing zeros and the decimal point if not needed
    result = result.replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');

    return result;
  }
  void _onTapDown(TapDownDetails details) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);

    final textSpan = TextSpan(
      text: input.text,
      style: TextStyle(fontSize: 16.0),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: renderBox.size.width,
    );

    final position = textPainter.getPositionForOffset(localPosition);
    input.selection = TextSelection.fromPosition(position);
  }
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Scientific Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            color: HexColor("F3F6F9"),
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                // onTapDown: _onTapDown,
                child: TextField(
                  controller: input,
                  focusNode: _focusNode,
                  showCursor: true,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 64,
              width: MediaQuery.of(context).size.width,
              color: HexColor("0F182E"),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: isHaveOrOrNot.isNotEmpty
                    ? globalText24(
                    text: isHaveOrOrNot.toString(),
                    alignment: Alignment.centerRight,
                    fontWeight: FontWeight.normal,
                    color: Colors.white)
                    : globalText24(
                    text: input == userinput
                        ? formatResult(output1)
                        : formatResult(output),
                    alignment: Alignment.centerRight,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              )),
          20.ph,
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        button("Sin", HexColor("2E250F"), Colors.white),
                        button("Cos", HexColor("2E250F"), Colors.white),
                        button("Tan", HexColor("2E250F"), Colors.white),
                        10.pw,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  radioButtonStatus = "1";
                                  input.text += "RAD(";
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 8,
                                    width: 8,
                                    child: Radio<String>(
                                      fillColor: MaterialStateProperty.resolveWith(
                                              (Set states) {
                                            if (states
                                                .contains(MaterialState.disabled)) {
                                              return HexColor("0F182E");
                                            }
                                            return HexColor("0F182E");
                                          }),
                                      groupValue: radioButtonStatus,
                                      onChanged: (value) {
                                        setState(() {
                                          getRadioButtonValue = value ?? '';
                                        });
                                      },
                                      value: "1",
                                    ),
                                  ),
                                  10.pw,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: HexColor("F3F3F3")),
                                    child: globalText14(
                                        text: "Rad", fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            10.pw,
                            InkWell(
                              onTap: () {
                                setState(() {
                                  radioButtonStatus = "2";
                                });
                                // if (output.isNotEmpty && output != 'Error') {
                                input.text += "°";
                                // }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8,
                                    width: 8,
                                    child: Radio<String>(
                                      fillColor: MaterialStateProperty.resolveWith(
                                              (Set states) {
                                            if (states
                                                .contains(MaterialState.disabled)) {
                                              return HexColor("0F182E");
                                            }
                                            return HexColor("0F182E");
                                          }),
                                      groupValue: radioButtonStatus,
                                      onChanged: (value) {
                                        // controller.instructorControllers.clear();
                                        setState(() {
                                          radioButtonStatus = value ?? '';
                                        });
                                        // controller.addCourseLetter();
                                        // controller.initialCourse();
                                      },
                                      value: "2",
                                    ),
                                  ),
                                  10.pw,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: HexColor("F3F3F3")),
                                    child: globalText14(
                                        text: "DEG", fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        button("sin-¹", HexColor("2E250F"), Colors.white,
                            image: AppAssets.antiSin, height: 25, weight: 25),
                        button("cos-¹", HexColor("2E250F"), Colors.white,
                            image: AppAssets.antiCos, height: 25, weight: 25),
                        button("tan-¹", HexColor("2E250F"), Colors.white,
                            image: AppAssets.antiTan, height: 25, weight: 25),
                        button("π", HexColor("2E250F"), Colors.white),
                        button("e", HexColor("2E250F"), Colors.white),
                      ],
                    ),
                    Row(
                      children: [
                        button("xʸ", HexColor("2E250F"), Colors.white,
                            image: AppAssets.xy, height: 14, weight: 14),
                        button("x³", HexColor("2E250F"), Colors.white,
                            image: AppAssets.x3, height: 14, weight: 14),
                        button("x²", HexColor("2E250F"), Colors.white,
                            image: AppAssets.x2, height: 14, weight: 14),
                        button("eˣ", HexColor("2E250F"), Colors.white,
                            image: AppAssets.ex, height: 15, weight: 15),
                        button("10ˣ", HexColor("2E250F"), Colors.white,
                            image: AppAssets.tenX, height: 19, weight: 19),
                      ],
                    ),
                    Row(
                      children: [
                        button("y√x", HexColor("2E250F"), Colors.white),
                        button("3√x", HexColor("2E250F"), Colors.white),
                        button("√x", HexColor("2E250F"), Colors.white),
                        button("ln", HexColor("2E250F"), Colors.white),
                        button("log", HexColor("2E250F"), Colors.white),
                      ],
                    ),
                    Row(
                      children: [
                        button("(", HexColor("2E250F"), Colors.white),
                        button(")", HexColor("2E250F"), Colors.white),
                        button("1/x", HexColor("2E250F"), Colors.white),
                        button("%", HexColor("2E250F"), Colors.white),
                        button("n!", HexColor("2E250F"), Colors.white),
                      ],
                    ),
                    Row(
                      children: [
                        button("7", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("8", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("9", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("+", HexColor("244384"), Colors.white),
                        button("Back", HexColor("244384"), Colors.white),
                      ],
                    ),
                    Row(
                      children: [
                        button("4", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("5", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("6", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("-", HexColor("244384"), Colors.white),
                        button("Ans", HexColor("244384"), Colors.white),
                      ],
                    ),
                    Row(
                      children: [
                        button("1", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("2", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("3", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("x", HexColor("244384"), Colors.white),
                        button("M+", HexColor("244384"), Colors.white),
                      ],
                    ),
                    Row(
                      children: [
                        button("0", HexColor("F3F6F9"), HexColor("0F182E")),
                        button(".", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("EXP", HexColor("244384"), Colors.white),
                        button("÷", HexColor("244384"), Colors.white),
                        button("M-", HexColor("244384"), Colors.white),
                      ],
                    ),
                    Row(
                      children: [
                        button("AC", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("=", HexColor("F3F6F9"), HexColor("0F182E")),
                        button("±", HexColor("244384"), Colors.white,
                            image: AppAssets.plusMinus, height: 15, weight: 15),
                        button("RND", HexColor("244384"), Colors.white),
                        button("MR", HexColor("244384"), Colors.white),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     button("MR", Colors.black, Colors.orangeAccent),
                    //     button("log", Colors.black, Colors.orangeAccent),
                    //     button("(", Colors.black, Colors.orangeAccent),
                    //     button(")", Colors.black, Colors.orangeAccent),
                    //     button("AC", Colors.black, Colors.white),
                    //     button("DEL", Colors.black, Colors.white),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     button("M+", Colors.black, Colors.orangeAccent),
                    //     button("exp", Colors.black, Colors.orangeAccent),
                    //     button("7", Colors.black, Colors.white),
                    //     button("8", Colors.black, Colors.white),
                    //     button("9", Colors.black, Colors.white),
                    //     button("/", Colors.black, Colors.orangeAccent),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     button("M-", Colors.black, Colors.orangeAccent),
                    //     button("sin", Colors.black, Colors.orangeAccent),
                    //     button("4", Colors.black, Colors.white),
                    //     button("5", Colors.black, Colors.white),
                    //     button("6", Colors.black, Colors.white),
                    //     button("*", Colors.black, Colors.orangeAccent),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     button("tan", Colors.black, Colors.orangeAccent),
                    //     button("cos", Colors.black, Colors.orangeAccent),
                    //     button("1", Colors.black, Colors.white),
                    //     button("2", Colors.black, Colors.white),
                    //     button("3", Colors.black, Colors.white),
                    //     button("-", Colors.black, Colors.orangeAccent),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     button("ln", Colors.black, Colors.orangeAccent),
                    //     button("0", Colors.black, Colors.orangeAccent),
                    //     button(".", Colors.black, Colors.white),
                    //     button("=", Colors.orangeAccent, Colors.white),
                    //     button("+", Colors.black, Colors.orangeAccent),
                    //   ],
                    // ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget button(text, color, tcolor,
      {String? image, double? height, double? weight}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(6),
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.all(0),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => _onButtonClicked(text),
          child: text.toString().isNotEmpty && (image?.isNotEmpty ?? false)
              ? Image.asset(
            image ?? '',
            height: height,
            width: weight,
          )
              : Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.013,
              fontWeight: FontWeight.bold,
              color: tcolor,
            ),
          ),
        ),
      ),
    );
  }
}
