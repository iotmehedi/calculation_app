// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scientific Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      setState(() {
        output = "0";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      });
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/" ||
        buttonText == "^") {
      num1 = double.parse(output);
      operand = buttonText;
      setState(() {
        output = "0";
      });
    } else if (buttonText == ".") {
      if (!output.contains(".")) {
        setState(() {
          output += ".";
        });
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        setState(() {
          output = (num1 + num2).toString();
        });
      }
      if (operand == "-") {
        setState(() {
          output = (num1 - num2).toString();
        });
      }
      if (operand == "*") {
        setState(() {
          output = (num1 * num2).toString();
        });
      }
      if (operand == "/") {
        setState(() {
          output = (num1 / num2).toString();
        });
      }
      if (operand == "^") {
        setState(() {
          output = math.pow(num1, num2).toString();
        });
      }
    } else if (buttonText == "√") {
      num1 = double.parse(output);
      setState(() {
        output = math.sqrt(num1).toStringAsFixed(2);
      });
    } else if (buttonText == "sin") {
      num1 = double.parse(output);
      setState(() {
        output = math.sin(num1).toStringAsFixed(2);
      });
    } else if (buttonText == "cos") {
      num1 = double.parse(output);
      setState(() {
        output = math.cos(num1).toStringAsFixed(2);
      });
    } else if (buttonText == "tan") {
      num1 = double.parse(output);
      setState(() {
        output = math.tan(num1).toStringAsFixed(2);
      });
    } else if (buttonText == "log") {
      num1 = double.parse(output);
      setState(() {
        output = math.log(num1).toStringAsFixed(2);
      });
    } else if (buttonText == "π") {
      setState(() {
        output = math.pi.toStringAsFixed(2);
      });
    } else if (buttonText == "e") {
      setState(() {
        output = math.e.toStringAsFixed(2);
      });
    } else if (buttonText == "x!") {
      num1 = double.parse(output);
      setState(() {
        output = factorial(num1.toInt()).toString();
      });
    } else if (buttonText == "P") {
      num1 = double.parse(output);
      setState(() {
        output = permutations(num1.toInt()).toString();
      });
    } else if (buttonText == "C") {
      num1 = double.parse(output);
      setState(() {
        output = combinations(num1.toInt()).toString();
      });
    } else if (buttonText == "%") {
      num1 = double.parse(output);
      setState(() {
        output = (num1 / 100).toString();
      });
    } else if (buttonText == "rad") {
      num1 = double.parse(output);
      setState(() {
        output = (num1 * (math.pi / 180)).toStringAsFixed(2);
      });
    } else if (buttonText == "°") {
      num1 = double.parse(output);
      setState(() {
        output = (num1 * (180 / math.pi)).toStringAsFixed(2);
      });
    } else {
      setState(() {
        if (output == "0") {
          output = buttonText;
        } else {
          output += buttonText;
        }
      });
    }
  }

  int factorial(int n) {
    if (n <= 0) {
      return 1;
    }
    return n * factorial(n - 1);
  }

  int permutations(int n) {
    if (n <= 0) {
      return 1;
    }
    return factorial(n);
  }

  int combinations(int n) {
    if (n <= 0) {
      return 1;
    }
    return factorial(n) ~/ (factorial(2) * factorial(n - 2));
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
        ),
        child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void showHintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Scientific Calculator'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'This calculator provides standard and scientific calculations.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Text(
                'Functions:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('- Basic arithmetic operations: +, -, *, /'),
              Text('- Exponentiation: ^'),
              Text('- Square root: √'),
              Text('- Trigonometric functions: sin, cos, tan'),
              Text('- Logarithm: log'),
              Text('- Constants: π, e'),
              Text('- Factorial: x!'),
              Text('- Percentage: %'),
              Text('- Degree and radian conversion: °, rad'),
              Text('- Permutations and combinations: P, C'),
              SizedBox(height: 10),
              Text(
                'Created by: Giraldi Prama Yudistira',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
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
        title: const Text('Scientific Calculator'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              showHintDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.black,
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 229, 255, 0),
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton("sin", 1, Colors.orange),
                        buildButton("cos", 1, Colors.orange),
                        buildButton("tan", 1, Colors.orange),
                        buildButton("log", 1, Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton(
                            "7", 1, const Color.fromARGB(255, 250, 0, 0)),
                        buildButton(
                            "8", 1, const Color.fromARGB(255, 250, 0, 0)),
                        buildButton(
                            "9", 1, const Color.fromARGB(255, 250, 0, 0)),
                        buildButton("/", 1, Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton(
                            "4", 1, const Color.fromARGB(255, 250, 0, 0)),
                        buildButton(
                            "5", 1, const Color.fromARGB(255, 250, 0, 0)),
                        buildButton(
                            "6", 1, const Color.fromARGB(255, 250, 0, 0)),
                        buildButton("*", 1, Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton(
                            "1", 1, const Color.fromARGB(255, 250, 0, 0)),
                        buildButton(
                            "2", 1, const Color.fromARGB(255, 250, 0, 0)),
                        buildButton(
                            "3", 1, const Color.fromARGB(255, 250, 0, 0)),
                        buildButton("-", 1, Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton(
                            ".", 1, const Color.fromARGB(255, 88, 88, 88)),
                        buildButton(
                            "0", 1, const Color.fromARGB(255, 250, 0, 0)),
                        buildButton("^", 1, Colors.orange),
                        buildButton("+", 1, Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton(
                            "π", 1, const Color.fromARGB(255, 5, 70, 123)),
                        buildButton(
                            "e", 1, const Color.fromARGB(255, 5, 70, 123)),
                        buildButton(
                            "x!", 1, const Color.fromARGB(255, 5, 70, 123)),
                        buildButton(
                            "%", 1, const Color.fromARGB(255, 5, 70, 123)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton(
                            "P", 1, const Color.fromARGB(255, 5, 70, 123)),
                        buildButton(
                            "C", 1, const Color.fromARGB(255, 5, 70, 123)),
                        buildButton(
                            "rad", 1, const Color.fromARGB(255, 5, 70, 123)),
                        buildButton(
                            "√", 1, const Color.fromARGB(255, 5, 70, 123)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: buildButton("°", 1, Colors.blue),
                        ),
                        Expanded(
                          child: buildButton("=", 1, Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}