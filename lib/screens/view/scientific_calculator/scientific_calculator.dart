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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyCalculator(),
    );
  }
}

final logger = Logger();

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  double num1 = 0.0;
  double num2 = 0.0;
  var input = '';
  var input1 = '';
  var output = '';
  var output1 = '';
  var operation = '';
  var hideinput = false;
  var userinput = '';
  var outputSize = 32.0;
  double memory = 0.0; // Memory variable

  double mrValue = 0.0; // MR value
  double mPlusValue = 0.0; // M+ value
  double mMinusValue = 0.0; // M- value
  var radioButtonStatus = "";
  var getRadioButtonValue = '';
  var isAntiCosSinTan = false;

  _onButtonClicked(value) {
    if (value == "AC") {
      input = '';
      output = '';
      memory = 0.0;
      mrValue = 0.0;
      mPlusValue = 0.0;
      mMinusValue = 0.0;
    } else if (value == "DEL") {
      isAntiCosSinTan = true;
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=" || value == "Ans") {
      print("the value is $value");
      if (input.isNotEmpty) {
        // try{
        userinput = input;
        userinput = userinput.replaceAll('÷', '/');
        userinput = userinput.replaceAll('e', 'e^(1)');
        // userinput = userinput.replaceAll("log", "logBase");
        userinput = userinput.replaceAll("exp", "expBase");
        userinput = userinput.replaceAll("3√x", "^(1/3)");
        userinput = userinput.replaceAll("log", "logBase");

        userinput =
            userinput.replaceAllMapped(RegExp(r'√(\d+(\.\d+)?)'), (match) {
          return "(${match[1]})^(1/2)";
        });
        userinput = userinput.replaceAll("x", "*");

        if (userinput.contains("logBase")) {
          String sanitizedInput = sanitizeInput(input);

          double result = evaluateExpression(sanitizedInput);
          output = result.toString();
        } else if(input.contains("^(1/3)")){
          String sanitizedExpression = sanitizeInput(input);
          double result = evaluateInnerExpression(sanitizedExpression);
          output = result.toString();
        }else if(input.contains("√")){
          String sanitizedExpression = sanitizeInput(input);
          double result = evaluateInnerExpression(sanitizedExpression);
          print("result make: $result");
          output = result.toString();
        }
        else if (userinput.contains("%")) {
          List<String> operators = ['+', '-', 'x', '/', '^'];
          bool containsOperator = operators.any((op) => input.contains(op));

          if (containsOperator) {
            String convertedInput = convertPercentages(input);

            // Parse the expression
            ex.Expression expression = ex.Expression.parse(convertedInput);

            // Evaluate the expression
            final evaluator = const ex.ExpressionEvaluator();
            output1 = evaluator.eval(expression, {}).toString();
          } else {
            output1 = (double.parse(input.replaceAll("%", "")) / 100)
                .toStringAsFixed(2);
          }
        }
        else if (userinput.contains("!")) {
          List<String> operators = ['+', '-', 'x', '/', '^'];
          bool containsOperator = operators.any((op) => input.contains(op));

          if (containsOperator) {
            String convertedInput = convertFactorials(input);

            // Parse the expression
            ex.Expression expression = ex.Expression.parse(convertedInput);

            // Evaluate the expression
            const evaluator = ex.ExpressionEvaluator();
            output1 = evaluator.eval(expression, {}).toString();
          } else {
            // output1 = (double.parse(input.replaceAll("%", "")) / 100).toStringAsFixed(2);
            output1 =
                factorial(int.parse(input.replaceAll("!", ""))).toString();
          }
        }
        else if (userinput.contains("sin")) {
          // double degrees = double.tryParse(extractDigit(input))  ?? 0.0;
          // double radians = degrees * (pi / 180); // Convert degrees to radians
          // double sineValue = sin(radians);
          String sanitizedInput = sanitizeInput(input);

          double result = evaluateExpression(sanitizedInput);
          output1 = result.toString();
        } else if (userinput.contains("cos")) {
          // double degrees = double.tryParse(extractDigit(input))  ?? 0.0;
          // double radians = degrees * (pi / 180); // Convert degrees to radians
          // double sineValue = cos(radians);
          // output1 = sineValue.toString();
          String sanitizedInput = sanitizeInput(input);

          double result = evaluateExpression(sanitizedInput);
          output1 = result.toString();
        } else if (userinput.contains("tan")) {
          // double degrees = double.tryParse(extractDigit(input))  ?? 0.0;
          // double radians = degrees * (pi / 180); // Convert degrees to radians
          // double sineValue = tan(radians);
          // output1 = sineValue.toString();
          String sanitizedInput = sanitizeInput(input);

          double result = evaluateExpression(sanitizedInput);
          output1 = result.toString();
        }else if (userinput.contains("sin-¹")) {
          // double degrees = double.tryParse(extractDigit(input))  ?? 0.0;
          // double radians = degrees * (pi / 180); // Convert degrees to radians
          // double sineValue = sin(radians);
          String sanitizedInput = sanitizeInput(input);

          double result = evaluateExpression(sanitizedInput);
          output1 = result.toString();
        } else if (userinput.contains("cos-¹")) {
          // double degrees = double.tryParse(extractDigit(input))  ?? 0.0;
          // double radians = degrees * (pi / 180); // Convert degrees to radians
          // double sineValue = cos(radians);
          // output1 = sineValue.toString();
          String sanitizedInput = sanitizeInput(input);

          double result = evaluateExpression(sanitizedInput);
          output1 = result.toString();
        } else if (userinput.contains("tan-¹")) {
          // double degrees = double.tryParse(extractDigit(input))  ?? 0.0;
          // double radians = degrees * (pi / 180); // Convert degrees to radians
          // double sineValue = tan(radians);
          // output1 = sineValue.toString();
          String result1 = input.replaceAll("RND", '');
          String sanitizedInput = sanitizeInput(result1);

          double result = evaluateExpression(sanitizedInput);
          output1 = result.toString();
        }
        else if(userinput.contains("RND")){
          RegExp regExp = RegExp(r'RND\d+(\.\d+)?');

          // Replace all occurrences with 'RND'
          String result = input.replaceAll("RND", '');
          print("this is RND $result");
          // String sanitizedInput = sanitizeInput(result);
          // double result1 = evaluateExpression(sanitizedInput);
          // output1 = result1.toString();
        }
        else {
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
      input += "(";
    } else if (value == ")") {
      // input += ")";
      handleInput(value);
    } else if (value == "log") {
      input += "log(";
    } else if (value == "EXP") {
      input += "exp(";
    } else if (value == "M+") {
      // Add current output value to memory
      if (output.isNotEmpty && output != 'Error') {
        memory += double.tryParse(input) ?? 0.0;
        mPlusValue = memory;
        output = mPlusValue.toString();
      }
    } else if (value == "M-") {
      // Subtract current output value from memory
      if (output1.isNotEmpty && output1 != 'Error') {
        memory -= double.parse(input);
        mMinusValue = memory;
        if (output1 == '0.0') {
          output1 = '0.0';
        } else {
          output1 = mMinusValue.toString();
        }
      }
    } else if (value == "MR") {
      // Recall memory value
      input += memory.toString();

      output = memory.toString();
      mrValue = memory;
      if (output == '') {
        output = '0';
      }
    } else if (value == "Back") {
      // Recall memory value
      input = input.substring(0, input.length - 1); // to remove one character
      if (input == '') {
        input = '';
      }
    } else if (value == "π") {
      // if (output.isNotEmpty && output != 'Error') {
      setState(() {
        input += "3.1415";
        //math.pi.toStringAsFixed(2);
      });
      // }
    } else if (value == "e") {
      // setState(() {
      input += "2.72";
      //math.e.toStringAsFixed(2);
      // });
    } else if (value == '3√x') {
      if (output == '0') {
        output = 'Error';
      } else {
        // Expression exp;
        // Parser p = Parser();
        // input = input.replaceAll("∛", "^(1/3)");

        input = '$input^(1/3)';
        // exp = p.parse('(' + input + ')^(1/3)');
        // ContextModel cm = ContextModel();
        // cm.bindVariable(Variable('pi'), Number(math.pi));
        // output = exp.evaluate(EvaluationType.REAL, cm).toString();
        // print(output);
      }
    } else if (value == '1/x') {
      if (output == '0') {
        input = '1/';
      } else {
        input = '${input}1/';
      }
    } else if (value == '√x') {
      if (output == '0') {
        input = 'Error';
      } else {
        input += '√';
      }
    } else if (value == "ln") {
      input += "ln("; // Natural log function
    } else if (value == "log") {
      input += "log("; // Add base log function
    } else if (value == 'xʸ') {
      if (output == '0') {
        input = 'Error';
      } else {
        input = '$input^';
      }
    } else if (value == 'eˣ') {
      if (output == '0') {
        input = 'e^';
      } else {
        input = '${input}e^';
      }
    } else if (value == '10ˣ') {
      if (output == '0') {
        input = '10^';
      } else {
        input = '${input}10^';
      }
    } else if (value == 'x²') {
      if (output == '0') {
        input = 'Error';
      } else {
        input = '$input^2';
      }
    } else if (value == 'x³') {
      if (output == '0') {
        input = 'Error';
      } else {
        input = '$input^3';
      }
    } else if (value == "n!") {
      input = "$input!";
    } else if (value == "%") {
      // num1 = double.parse(input);

      input = '$input%';
      // input = (double.parse(input) / 100).toString();
    } else if (value == "Sin") {
      // input += "sin(";
       handleInput("sin");
    } else if (value == "Cos") {
      handleInput("cos");
    } else if (value == "Tan") {
      handleInput("tan");
    }else if (value == "sin-¹") {
      input += "sin-¹(";
    } else if (value == "cos-¹") {
      input += "cos-¹(";
    } else if (value == "tan-¹") {
      input += "tan-¹(";
    } else if(value == "±"){
      if (output == '0') {
        input = 'Error';
      }else{
      input = '-$input';
      }

    }  else if(value == "RND"){

      handleInput(value);
    } else {
      handleInput(value);
    }

    setState(() {});
  }
  bool insideTrigFunction = false;
  void handleInput(String value) {
    // If the input is a trigonometric function, set the flag and append the function
    if (value == "sin" || value == "cos" || value == "tan") {
      input += "$value(";
      insideTrigFunction = true;
    } else if (value == ")") {
      input += value;
      insideTrigFunction = false;
    } else if(value == "RND"){
      print("this is random");
      input += Random().nextDouble().toStringAsFixed(9);
    } else {
      // If inside a trigonometric function, append the value and degree symbol if it's a number
      if (insideTrigFunction && RegExp(r'\d$').hasMatch(value)) {
        input += value + "°";
      } else {
        input += value;
      }
    }

    print("input $input"); // For debugging
  }

















  double evaluateInnerExpression(String expression) {
    // Replace degree symbols
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

  double evaluateInverseTrigonometricFunction(String function, double valueInDegrees) {
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

  double evaluatePower(double base, double exponent) {
    return pow(base, exponent).toDouble();
  }

  double evaluateReciprocal(double value) {
    if (value == 0) {
      throw ArgumentError('Division by zero is not allowed.');
    }
    return 1 / value;
  }

  String sanitizeInput(String input) {
    // Process cosine
    input = input.replaceAllMapped(RegExp(r'cos\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double totalDegrees = evaluateInnerExpression(innerExpression);
      double cosValue = evaluateTrigonometricFunction('cos', totalDegrees);
      return cosValue.toString();
    });

    // Process sine
    input = input.replaceAllMapped(RegExp(r'sin\(([^)]+)\)'), (match) {
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
      double sinInverseValue = evaluateInverseTrigonometricFunction('sin-1', totalDegrees);
      return sinInverseValue.toString();
    });

    // Process inverse cosine
    input = input.replaceAllMapped(RegExp(r'cos-¹\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double totalDegrees = evaluateInnerExpression(innerExpression);
      double cosInverseValue = evaluateInverseTrigonometricFunction('cos-1', totalDegrees);
      return cosInverseValue.toString();
    });

    // Process inverse tangent
    input = input.replaceAllMapped(RegExp(r'tan-¹\(([^)]+)\)'), (match) {
      String innerExpression = match.group(1)!;
      double totalDegrees = evaluateInnerExpression(innerExpression);
      double tanInverseValue = evaluateInverseTrigonometricFunction('tan-1', totalDegrees);
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
    input = input.replaceAllMapped(RegExp(r'(\d+(\.\d+)?|\d+(\.\d+)?\^\d+(\.\d+)?|\d+\.\d+|\d+)\^\((\d+)/(\d+)\)'), (match) {
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

    // Process reciprocal (1/x)
    input = input.replaceAllMapped(RegExp(r'1/(\d+(\.\d+)?)'), (match) {
      double value = double.parse(match.group(1)!);
      return evaluateReciprocal(value).toString();
    });

    // Remove any remaining degree symbols
    input = input.replaceAll('°', '');

    return input;
  }


  double evaluateExpression(String input) {
    try {
      // Debug: print the expression to ensure it's correctly formatted
      print("Evaluating Expression: $input");

      final expressionObject = ex.Expression.parse(input);
      final evaluator = const ex.ExpressionEvaluator();
      var result = evaluator.eval(expressionObject, {});
      print("Result make $result");
      return result;
    } catch (e) {
      print("Error parsing expression: $e");
      return double.nan;
    }
  }




  String extractDigit(String input) {
    RegExp regExp = RegExp(r'cos\((\d+)°\)');
    Match? match = regExp.firstMatch(input);

    if (match != null) {
      return match.group(1)!; // Extracts the digit part
    }

    return "No digit found"; // Default return value if no match is found
  }
  String convertTrigonometricFunctions(String input) {
    print("this is input value $input");
    RegExp exp = RegExp(r'sin\((\d+)°\)');
    return input.replaceAllMapped(exp, (Match match) {
      double degrees = double.parse(match.group(1)!);
      double radians = degrees * (pi / 180);
      double sinValue = sin(radians);
      return sinValue.toString();
    });
  }

  String backspace(String output) {
    if (output.isNotEmpty) {
      return output.substring(0, output.length - 1);
    } else {
      return output;
    }
  }

  double logBase(num x, num base) => log(x) / log(base);
  num exp(num x) => pow(e, x.toDouble());
  int factorial(int n) {
    if (n <= 0) {
      return 1;
    }
    return n * factorial(n - 1);
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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            color: HexColor("F3F6F9"),
            child: Padding(padding: EdgeInsets.only(right: 10), child: globalText24(text: input.replaceAll("RND", ''), alignment: Alignment.centerRight, fontWeight: FontWeight.normal, visibleOrNot: true)),
          ),
          Container(
            height: 64,
            width: MediaQuery.of(context).size.width,
            color: HexColor("0F182E"),
            child: Padding(padding: const EdgeInsets.only(right: 10), child: globalText24(text: input == userinput
                ? formatResult(output1)
                : formatResult(output), alignment: Alignment.centerRight, fontWeight: FontWeight.normal, color: Colors.white),)
          ),
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
                            });
                            if (output.isNotEmpty && output != 'Error') {
                              num1 = double.parse(output);
                              setState(() {
                                output =
                                    (num1 * (math.pi / 180)).toStringAsFixed(2);
                              });
                            }
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
                            if (output.isNotEmpty && output != 'Error') {
                              num1 = double.parse(output);
                              setState(() {
                                output =
                                    (num1 * (180 / math.pi)).toStringAsFixed(2);
                              });
                            }
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
