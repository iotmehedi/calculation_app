
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import 'package:logger/logger.dart';

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
  var output = '';
  var operation = '';
  var hideinput = false;
  var outputSize = 32.0;
  double memory = 0.0; // Memory variable
  double mrValue = 0.0; // MR value
  double mPlusValue = 0.0; // M+ value
  double mMinusValue = 0.0; // M- value




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
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("log", "logBase");
        userinput = input.replaceAll("exp", "expBase");
        Parser p = Parser();
        Expression exp = p.parse(userinput);
        ContextModel cm = ContextModel();
        var result = exp.evaluate(EvaluationType.REAL, cm);
        output = result.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
      }
    } else if (value == "(") {
      input += "(";
    }


    else if (value == ")") {
      input += ")";
    } else if (value == "log") {
      input += "log(";
    } else if (value == "exp") {
      input += "exp(";
    } else if (value == "M+") {
      // Add current output value to memory
      // if (output.isNotEmpty && output != 'Error') {
      memory += double.tryParse(input) ?? 0.0;
      mPlusValue = memory;
      output = mPlusValue.toString();
      // }
    } else if (value == "M-") {
      // Subtract current output value from memory
      // if (output.isNotEmpty && output != 'Error') {
      memory -= double.parse(input);
      mMinusValue = memory;
      output = mMinusValue.toString();
      // }
    } else if (value == "MR") {
      // Recall memory value
      input += memory.toString();

      output = memory.toString();
      mrValue = memory;
      output = mrValue.toString();
    } else {
      input += value;
    }

    // Evaluate logarithm if input ends with ")"
    if (input.endsWith(")")) {
      try {
        var expression = input.substring(4, input.length - 1);
        var result = log(double.parse(expression));
        output = result.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
      } catch (e) {
        output = '';
      }
    }
    // Evaluate exponent if input starts with "exp("
    if (input.startsWith("exp(")) {
      try {
        var expression = input.substring(4, input.length - 1);
        var result = exp(double.parse(expression));
        output = result.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
      } catch (e) {
        output = 'Error';
      }
    }



    setState(() {});
  }




  double logBase(num x, num base) => log(x) / log(base);
  num exp(num x) => pow(e, x.toDouble());

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'MR: $mrValue',style: TextStyle(
                  fontSize: 15,
                  color: Colors.green[50],
                ),
                ),
                Text(
                  'M+: $mPlusValue',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'M-: $mMinusValue',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.green[50],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container(
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
                Text( output,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          ),



          Row(
            children: [
              button("MR", Colors.black, Colors.orangeAccent),
              button("log", Colors.black, Colors.orangeAccent),
              button("(", Colors.black, Colors.orangeAccent),
              button(")", Colors.black, Colors.orangeAccent),

              button("AC", Colors.black, Colors.white),
              button("DEL", Colors.black, Colors.white),
            ],
          ),
          Row(
            children: [
              button("M+", Colors.black, Colors.orangeAccent),
              button("exp", Colors.black, Colors.orangeAccent),
              button("7", Colors.black, Colors.white),
              button("8", Colors.black, Colors.white),
              button("9", Colors.black, Colors.white),
              button("/", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("M-", Colors.black, Colors.orangeAccent),
              button("sin", Colors.black, Colors.orangeAccent),
              button("4", Colors.black, Colors.white),
              button("5", Colors.black, Colors.white),
              button("6", Colors.black, Colors.white),
              button("*", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("tan", Colors.black, Colors.orangeAccent),
              button("cos", Colors.black, Colors.orangeAccent),
              button("1", Colors.black, Colors.white),
              button("2", Colors.black, Colors.white),
              button("3", Colors.black, Colors.white),
              button("-", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("ln", Colors.black, Colors.orangeAccent),
              button("0", Colors.black, Colors.orangeAccent),
              button(".", Colors.black, Colors.white),
              button("=", Colors.orangeAccent, Colors.white),
              button("+", Colors.black, Colors.orangeAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget button(text, color, tcolor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10), backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () => _onButtonClicked(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: tcolor,
            ),
          ),
        ),
      ),
    );
  }
}










