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

  _onButtonClicked(value) {
    if (value == "AC") {
      input = '';
      output = '';
      memory = 0.0;
      mrValue = 0.0;
      mPlusValue = 0.0;
      mMinusValue = 0.0;
    } else if (value == "DEL") {
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
          output = math
              .log(int.parse(input.replaceAll("log(", '').replaceAll(")", '')))
              .toStringAsFixed(2);
        } else if (userinput.contains("%")) {
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
        } else if (userinput.contains("!")) {
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
        } else if (userinput.contains("sin")) {
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
        } else {
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
      input += ")";
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
      if (output.isNotEmpty && output != 'Error') {
        memory -= double.parse(input);
        mMinusValue = memory;
        if (output == '0.0') {
          output = '0.0';
        } else {
          output = mMinusValue.toString();
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

        input = '($input)^(1/3)';
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
        input = '√';
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
      input += "sin(";
    } else if (value == "Cos") {
      input += "cos(";
    } else if (value == "Tan") {
      input += "tan(";
    } else {
      handleInput(value);
    }

    setState(() {});
  }
  void handleInput(String value) {
    if (value == "Sin" || value == "Cos" || value == "Tan") {
      input += "$value(";
    } else if (value == ")" || value == "°") {
      input += value;
    } else {
      // Handle numeric input or operators
      // input += value;

      // Check if we need to append the degree symbol
      if (value == "Sin" || value == "Cos" || value == "Tan") {
        input += "$value(";
      } else if (value == ")" || value == "°") {
        // Directly append parentheses or degree symbol if pressed
        input += value;
      } else {
        // Handle numeric input or operators
        input += value;

        // Check if we need to append the degree symbol and closing parenthesis
        if ((input.contains("sin(") ||
            input.contains("cos(") ||
            input.contains("tan(")) &&
            !input.endsWith("°)") &&
            RegExp(r'\d$').hasMatch(input) &&  // Check if ends with a digit
            !RegExp(r'[+\-*/]$').hasMatch(input.substring(input.length - 2, input.length - 1))) {
          // Add degree symbol and closing parenthesis if the last character is a digit and previous character is not an arithmetic operator
          input += "°)";
        }
      }
    }

    print(input); // For debugging
  }

  String sanitizeInput(String input) {
    // Convert sin(), cos(), and tan() functions to their computed values
    String sanitized = input
        .replaceAllMapped(RegExp(r'sin\((\d+)°\)'), (match) {
      double degrees = double.parse(match.group(1)!);
      double radians = degrees * (pi / 180);
      double sinValue = sin(radians);
      return sinValue.toString();
    })
        .replaceAllMapped(RegExp(r'cos\((\d+)°\)'), (match) {
      double degrees = double.parse(match.group(1)!);
      double radians = degrees * (pi / 180);
      double cosValue = cos(radians);
      return cosValue.toString();
    })
        .replaceAllMapped(RegExp(r'tan\((\d+)°\)'), (match) {
      double degrees = double.parse(match.group(1)!);
      double radians = degrees * (pi / 180);
      double tanValue = tan(radians);
      return tanValue.toString();
    });

    // Replace exponentiation operator ^ with Dart's power function operator **
    sanitized = sanitized.replaceAllMapped(RegExp(r'(\d+)\^(\d+)'), (match) {
      double base = double.parse(match.group(1)!);
      double exponent = double.parse(match.group(2)!);
      return pow(base, exponent).toString();
    });

    return sanitized;
  }

  double evaluateExpression(String input) {
    // Parse and evaluate the expression
    ex.Expression expression = ex.Expression.parse(input);
    final evaluator = const ex.ExpressionEvaluator();
    var result = evaluator.eval(expression, {});
    return result;
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
      body: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(fontSize: 48, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    input == userinput
                        ? double.tryParse(output1)
                                ?.toStringAsFixed(9)
                                .toString()
                                .replaceAll(".00", '') ??
                            ''
                        : double.tryParse(output)
                                ?.toStringAsFixed(2)
                                .toString()
                                .replaceAll(".00", '') ??
                            '',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
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
                    button("", HexColor("2E250F"), Colors.white,
                        image: AppAssets.antiSin, height: 25, weight: 25),
                    button("", HexColor("2E250F"), Colors.white,
                        image: AppAssets.antiCos, height: 25, weight: 25),
                    button("", HexColor("2E250F"), Colors.white,
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
                    button("", HexColor("244384"), Colors.white,
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
            ))
          ],
        ),
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
