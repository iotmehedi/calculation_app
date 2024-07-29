import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

class SciCal extends StatefulWidget {
  const SciCal({super.key});

  @override
  State<SciCal> createState() => _SciCalState();
}

class _SciCalState extends State<SciCal> {
  String pi = '3.14159265359';
  String equation = '0';
  String result = '0';
  String expression = '';
  double doubleres = 0;
  int intres = 0;

  calculation (String btntext) {
    setState(() {
      if (btntext == '⌥') {
        Navigator.pushNamed(context, '/home');
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      }
      else if (btntext == '⌫') {
        equation = equation.substring(0, equation.length-1);
        if (equation == '') {
          equation = '0';
        }
      }
      else if (btntext == 'C') {
        equation = '0';
        result = '0';
      }
      else if (btntext == '√') {
        if (equation == '0') {
          result = 'Error';
        }
        else {
          equation = '(' + equation + ')^(1/2)';
        }
      }
      else if (btntext == '∛') {
        if (equation == '0') {
          result = 'Error';
        }
        else {
          equation = '(' + equation + ')^(1/3)';
        }
      }
      else if (btntext == 'x!') {
        equation = equation + '!';
      }
      else if (btntext == 'sin' || btntext == 'cos' || btntext == 'tan' || btntext == 'ln') {
        if (equation == '0') {
          equation = btntext + '(';
        }
        else {
          equation = equation + btntext + '(';
        }
      }
      else if (btntext == 'log') {
        if (equation == '0') {
          equation = btntext + '10(';
        }
        else {
          equation = equation + btntext + '10(';
        }
        double log10(num x) => math.log(x) / math.ln10;
      }
      else if (btntext == '1/x') {
        if (equation == '0') {
          equation = '1/';
        }
        else {
          equation = equation + '1/';
        }
      }
      else if (btntext == 'eˣ') {
        if (equation == '0') {
          equation = 'e^(';
        }
        else {
          equation = equation + 'e^(';
        }
      }
      else if (btntext == 'x²') {
        if (equation == '0') {
          result = 'Error';
        }
        else {
          equation = '(' + equation + ')^2';
        }
      }
      else if (btntext == 'xʸ') {
        if (equation == '0') {
          result = 'Error';
        }
        else {
          equation = '(' + equation + ')^(';
        }
      }
      else if (btntext == '|x|') {
        if (equation == '0') {
          equation = 'abs(';
        }
        else {
          equation = equation + 'abs(';
        }
        double abs(double x) => (x).abs();
      }
      else if (btntext == '=') {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('π', pi);
        expression = expression.replaceAll('e', 'e^(1)');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          doubleres = double.parse(result);
          if (doubleres%1==0) {
            intres = doubleres.toInt();
            result = intres.toString();
          }
        }
        catch(e) {
          result = 'Error';
        }
      }
      else {
        if (equation == '0') {
          equation = btntext;
        }
        else {
          equation = equation + btntext;
        }
      }
    });
  }

  Widget calcbtns(String btntext, Color btncolor, Color textcolor) {
    return Expanded(
      child: SizedBox(
        height: 30,
        child: ElevatedButton(
          onPressed: () {
            calculation(btntext);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: btncolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
              ),
              padding: EdgeInsets.fromLTRB(1, 0, 1, 0)
          ),
          child: Text(btntext,
            style: TextStyle(
              fontSize: 25,
              color: textcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                    child: Text(equation,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white,
                          fontSize: 40
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(10, 10, 20, 5),
                    child: Text(result,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white,
                          fontSize: 35
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                    child: calcbtns('⌥', Colors.grey.shade900, Colors.yellow.shade600),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: calcbtns('⌫', Colors.grey.shade900, Colors.yellow.shade600),
                  ),
                ],
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtns('√', Colors.grey, Colors.black),
                  calcbtns('∛', Colors.grey, Colors.black),
                  calcbtns('x!', Colors.grey, Colors.black),
                  calcbtns('C', Colors.grey, Colors.yellow.shade600),
                  calcbtns('(', Colors.grey, Colors.black),
                  calcbtns(')', Colors.grey, Colors.black),
                  calcbtns('÷', Colors.yellow.shade700, Colors.white),
                ],
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtns('sin', Colors.grey, Colors.black),
                  calcbtns('cos', Colors.grey, Colors.black),
                  calcbtns('tan', Colors.grey, Colors.black),
                  calcbtns('7', Colors.grey.shade700, Colors.white),
                  calcbtns('8', Colors.grey.shade700, Colors.white),
                  calcbtns('9', Colors.grey.shade700, Colors.white),
                  calcbtns('×', Colors.yellow.shade700, Colors.white),
                ],
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtns('ln', Colors.grey, Colors.black),
                  calcbtns('log', Colors.grey, Colors.black),
                  calcbtns('1/x', Colors.grey, Colors.black),
                  calcbtns('4', Colors.grey.shade700, Colors.white),
                  calcbtns('5', Colors.grey.shade700, Colors.white),
                  calcbtns('6', Colors.grey.shade700, Colors.white),
                  calcbtns('-', Colors.yellow.shade700, Colors.white),
                ],
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtns('eˣ', Colors.grey, Colors.black),
                  calcbtns('x²', Colors.grey, Colors.black),
                  calcbtns('xʸ', Colors.grey, Colors.black),
                  calcbtns('1', Colors.grey.shade700, Colors.white),
                  calcbtns('2', Colors.grey.shade700, Colors.white),
                  calcbtns('3', Colors.grey.shade700, Colors.white),
                  calcbtns('+', Colors.yellow.shade700, Colors.white),
                ],
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtns('|x|', Colors.grey, Colors.black),
                  calcbtns('π', Colors.grey, Colors.black),
                  calcbtns('e', Colors.grey, Colors.black),
                  calcbtns('%', Colors.grey, Colors.black),
                  calcbtns('0', Colors.grey.shade700, Colors.white),
                  calcbtns('.', Colors.grey, Colors.black),
                  calcbtns('=', Colors.yellow.shade700, Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}