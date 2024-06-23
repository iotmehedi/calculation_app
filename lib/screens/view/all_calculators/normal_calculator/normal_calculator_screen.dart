import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

import 'package:calculation_app/screens/view/all_calculators/normal_calculator/Colors.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalCalculatorScreen extends StatefulWidget {
  // const NormalCalculatorScreen({Key? key}) : super(key: key);
  @override
  _NormalCalculatorScreenState createState() => _NormalCalculatorScreenState();
}

class _NormalCalculatorScreenState extends State<NormalCalculatorScreen> {
  dynamic equation = '0';
  String result = '0';
  String finalResult = '0';
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;
  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      // Check if the decimal part is non-zero or the integer part is non-zero
      if (int.parse(splitDecimal[1]) > 0 || int.parse(splitDecimal[0]) > 0) {
        // If either part is non-zero, return result as is
        return result.toString();
      } else {
        // If both parts are zero, return '0'
        return '0';
      }
    } else if (result.toString() == '.') {
      // If the result is just a decimal point, return '0'
      return '0';
    }
    return result.toString();
  }

  buttonPress(String buttonText) {
    setState(() {
      // -----------      CLEAR STATE     --------------
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
        equationFontSize = 38;
        resultFontSize = 48;
      }
      // -----------    BACKSPACE STATE    --------------
      else if (buttonText == '%') {
        try {
          var numericValue = double.parse(equation);
          var resultValue = numericValue / 100;
          result = resultValue.toString();
          finalResult = doesContainDecimal(result);
        } catch (e) {
          // Handle the case where the conversion fails (equation is not a valid numeric string)
          print('Error: $e');
        }
      }
      // else if (buttonText == '%') {
      //     result = equation / 100;
      //     result = doesContainDecimal(result);
      //   }
      else if (buttonText == '+/-') {
        // else if (btnText == '+/-') {
        equation.toString().startsWith('-')
            ? equation = equation.toString().substring(1)
            : equation = '-' + equation.toString();

//     }
      } else if (buttonText == '⌫') {
        equationFontSize = 48;
        resultFontSize = 38;
        equation = equation.substring(
            0, equation.length - 1); // to remove one character
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        equationFontSize = 38;
        resultFontSize = 48;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          // Change expression value
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      }
      // --------   NORMAL STATE  ------------
      else {
        equationFontSize = 48;
        resultFontSize = 38;
        if (equation == '0') {
          equation = buttonText;
        } else {
          // Handle the case when a decimal point is entered as the first character
          if (buttonText == '.') {
            // Check if the equation already contains a decimal point
            if (!equation.contains('.')) {
              equation += buttonText; // Add the decimal point
            }
          } else {
            equation += buttonText;
          }
        }
        // Adjust equation to remove unnecessary decimal points
        // equation = doesContainDecimal(equation);
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      Color digitTextColor,
      {bool? calculationButtons}) {
    return InkWell(
      onTap: () => buttonPress(buttonText),
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.podkova(
                fontSize: calculationButtons == true ? 24.0 : 20.0,
                fontWeight: FontWeight.w600,
                color: digitTextColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Simple Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                reverse: true,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child: Text(
                          equation,
                          // maxLines: 4,
                          style: TextStyle(
                              fontSize: equation.length >= 65 ? 12 : 30),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                        child: Text(
                          result.replaceAll(".0", '').replaceAll(".00", ''),
                          // maxLines: 3,
                          style: TextStyle(fontSize: resultFontSize),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButton("C", 1,
                              AssetColor.firstThreeButtonColor, Colors.white,
                              calculationButtons: true),
                          buildButton("+/-", 1,
                              AssetColor.firstThreeButtonColor, Colors.white,
                              calculationButtons: true),
                          buildButton("%", 1,
                              AssetColor.firstThreeButtonColor, Colors.white,
                              calculationButtons: true),
                          buildButton("÷", 1,
                              AssetColor.calculationButtonColor, Colors.white,
                              calculationButtons: true),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButton("7", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("8", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("9", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("×", 1,
                              AssetColor.calculationButtonColor, Colors.white,
                              calculationButtons: true),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButton("4", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("5", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("6", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("-", 1,
                              AssetColor.calculationButtonColor, Colors.white,
                              calculationButtons: true),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButton("1", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("2", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("3", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("+", 1,
                              AssetColor.calculationButtonColor, Colors.white,
                              calculationButtons: true),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButton("⌫", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("0", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton(".", 1, AssetColor.digitsColor,
                              AssetColor.digitsTextColor),
                          buildButton("=", 1,
                              AssetColor.calculationButtonColor, Colors.white,
                              calculationButtons: true),
                        ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// class NormalNormalCalculatorScreenScreen extends StatefulWidget {
//   const NormalNormalCalculatorScreenScreen({super.key});
//
//   @override
//   State<NormalNormalCalculatorScreenScreen> createState() => _NormalNormalCalculatorScreenScreenState();
// }
//
// class _NormalNormalCalculatorScreenScreenState extends State<NormalNormalCalculatorScreenScreen> {
//   String input = "";
//   String result = "";
//   void inputHandle(String userInput) {
//     // Clear all Input data
//     try {
//       if (userInput == "<") {
//         setState(() {
//           input = input.substring(0, input.length - 1);
//         });
//       } else if (userInput == "AC") {
//         setState(() {
//           input = "";
//           result = "";
//         });
//       } else if (userInput == "=") {
//         final finalInput = input.replaceAll('x', '*');
//         Parser p = Parser();
//         Expression exp = p.parse(finalInput);
//         ContextModel contextModel = ContextModel();
//         setState(() {
//           result = exp.evaluate(EvaluationType.REAL, contextModel).toString();
//         });
//       } else {
//         setState(() {
//           input = input + userInput;
//         });
//       }
//     } catch (ex) {
//       setState(() {
//         result = ex.toString();
//       });
//       print(ex);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: orangeColor,
//           centerTitle: true,
//           title: Text(
//             "NormalCalculatorScreen",
//             style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 shadows: [
//                   BoxShadow(
//                     color: Color(0xff354970).withOpacity(0.2),
//                     offset: Offset(-2, -2),
//                     blurRadius: 10,
//                   )
//                 ]),
//           ),
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     SizedBox(height: 20),
//                     ResultDisplay(
//                       inputText: input,
//                       resultText: result,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         MyButton(
//                           onTap: () {
//                             inputHandle("AC");
//                           },
//                           btnText: "AC",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("/");
//                           },
//                           btnText: "/",
//                           isFunBtn: true,
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("%");
//                           },
//                           btnText: "%",
//                           isFunBtn: true,
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("<");
//                           },
//                           btnText: "<",
//                           isFunBtn: true,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         MyButton(
//                           onTap: () {
//                             inputHandle("7");
//                           },
//                           btnText: "7",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("8");
//                           },
//                           btnText: "8",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("9");
//                           },
//                           btnText: "9",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("x");
//                           },
//                           btnText: "X",
//                           isFunBtn: true,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         MyButton(
//                           onTap: () {
//                             inputHandle("4");
//                           },
//                           btnText: "4",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("5");
//                           },
//                           btnText: "5",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("6");
//                           },
//                           btnText: "6",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("-");
//                           },
//                           btnText: "-",
//                           isFunBtn: true,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         MyButton(
//                           onTap: () {
//                             inputHandle("1");
//                           },
//                           btnText: "1",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("2");
//                           },
//                           btnText: "2",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("3");
//                           },
//                           btnText: "3",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("+");
//                           },
//                           btnText: "+",
//                           isFunBtn: true,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         MyButton(
//                           onTap: () {
//                             inputHandle("0");
//                           },
//                           btnText: "0",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle(".");
//                           },
//                           btnText: ".",
//                         ),
//                         MyButton(
//                           onTap: () {
//                             inputHandle("=");
//                           },
//                           btnText: "=",
//                           isFunBtn: true,
//                           isEqualBtn: true,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20)
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
