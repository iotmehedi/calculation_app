// class NormalCalculatorScreen extends StatefulWidget {
//   @override
//   _NormalCalculatorScreenState createState() => _NormalCalculatorScreenState();
// }

// class _NormalCalculatorScreenState extends State<NormalCalculatorScreen> {
//   dynamic displaytxt = 20;
//   //Button Widget
//   Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
//     return Container(
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: btncolor,
//           minimumSize: Size(56, 56),
//           shape: const CircleBorder(),
//         ),
//         onPressed: () {
//           calculation(btntxt);
//         },
//         child: Text(
//           '$btntxt',
//           style: GoogleFonts.poppins(
//               fontSize: 24, color: txtcolor, fontWeight: FontWeight.w600),
//         ),
//         // shape: CircleBorder(),
//         // color: btncolor,
//         // padding: EdgeInsets.all(20),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     //NormalCalculatorScreen
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Normal Calculator'),
//         // backgroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 5),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text(
//                       '$text',
//                       textAlign: TextAlign.left,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 100,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Expanded(
//                   child: calcbutton(
//                       'AC', AssetColor.firstThreeButtonColor, Colors.white),
//                 ),
//                 Expanded(
//                   child: calcbutton(
//                       '+/-', AssetColor.firstThreeButtonColor, Colors.white),
//                 ),
//                 Expanded(
//                   child: calcbutton(
//                       '%', AssetColor.firstThreeButtonColor, Colors.white),
//                 ),
//                 Expanded(
//                   child: calcbutton(
//                       '/', AssetColor.calculationButtonColor, Colors.white),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Expanded(
//                     child: calcbutton('7', AssetColor.digitsColor,
//                         AssetColor.digitsTextColor)),
//                 Expanded(
//                     child: calcbutton('8', AssetColor.digitsColor,
//                         AssetColor.digitsTextColor)),
//                 Expanded(
//                     child: calcbutton('9', AssetColor.digitsColor,
//                         AssetColor.digitsTextColor)),
//                 Expanded(
//                     child: calcbutton(
//                         'x', AssetColor.calculationButtonColor, Colors.white)),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Expanded(
//                     child: calcbutton('4', AssetColor.digitsColor,
//                         AssetColor.digitsTextColor)),
//                 Expanded(
//                     child: calcbutton('5', AssetColor.digitsColor,
//                         AssetColor.digitsTextColor)),
//                 Expanded(
//                     child: calcbutton('6', AssetColor.digitsColor,
//                         AssetColor.digitsTextColor)),
//                 Expanded(
//                     child: calcbutton(
//                         '-', AssetColor.calculationButtonColor, Colors.white)),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                     child: calcbutton('1', AssetColor.digitsColor,
//                         AssetColor.digitsTextColor)),
//                 Expanded(
//                     child: calcbutton('2', AssetColor.digitsColor,
//                         AssetColor.digitsTextColor)),
//                 Expanded(
//                     child: calcbutton('3', AssetColor.digitsColor,
//                         AssetColor.digitsTextColor)),
//                 Expanded(
//                     child: calcbutton(
//                         '+', AssetColor.calculationButtonColor, Colors.white)),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 //this is button Zero
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AssetColor.digitsColor,
//                       minimumSize: const Size(56, 56),
//                       shape: const CircleBorder(),
//                     ),
//                     // padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
//                     onPressed: () {
//                       calculation('00');
//                     },
//                     // shape: StadiumBorder(),
//                     child: Text(
//                       '0',
//                       style: TextStyle(
//                           fontSize: 35, color: AssetColor.digitsTextColor),
//                     ),
//                     // color: Colors.grey[850],
//                   ),
//                 ),
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AssetColor.digitsColor,
//                       minimumSize: const Size(56, 56),
//                       shape: const CircleBorder(),
//                     ),
//                     // padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
//                     onPressed: () {
//                       calculation('0');
//                     },
//                     // shape: StadiumBorder(),
//                     child: Text(
//                       '0',
//                       style: TextStyle(
//                           fontSize: 35, color: AssetColor.digitsTextColor),
//                     ),
//                     // color: Colors.grey[850],
//                   ),
//                 ),
//                 Expanded(
//                     child: calcbutton('.', AssetColor.digitsColor,
//                         AssetColor.digitsTextColor)),
//                 Expanded(
//                     child: calcbutton(
//                         '=', AssetColor.calculationButtonColor, Colors.white)),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   //NormalCalculatorScreen logic
//   dynamic text = '0';
//   double numOne = 0.0;
//   double numTwo = 0.0;

//   dynamic result = '';
//   dynamic finalResult = '';
//   dynamic opr = '';
//   dynamic preOpr = '';
//   void calculation(btnText) {
//     if (btnText == 'AC') {
//       if (text.toString().isNotEmpty) {
//         print(text.length);
//         setState(() {
//           text = text.toString().substring(0, text.toString().length - 1);
//         });

//         if (text.isEmpty) {
//           text = "0";
//           numOne = 0;
//           numTwo = 0;
//           result = '';
//           finalResult = '0';
//           opr = '';
//           preOpr = '';
//         }
//       }
//     } else if (opr == '=' && btnText == '=') {
//       if (preOpr == '+') {
//         finalResult = add();
//       } else if (preOpr == '-') {
//         finalResult = sub();
//       } else if (preOpr == 'x') {
//         finalResult = mul();
//       } else if (preOpr == '/') {
//         finalResult = div();
//       }
//     } else if (btnText == '+' ||
//         btnText == '-' ||
//         btnText == 'x' ||
//         btnText == '/' ||
//         btnText == '=') {
//       if (numOne == 0) {
//         numOne = double.parse(result);
//       } else {
//         // numTwo = double.parse(result);
//         if (result != null && result.isNotEmpty) {
//           try {
//             numTwo = double.parse(result);
//           } catch (e) {
//             // Handle the parsing error, e.g., set numTwo to a default value
//             print('Error parsing double: $e');
//             numTwo = 0.0; // Set a default value or handle the error as needed
//           }
//         } else {
//           // Handle the case when the result is empty or null
//           print('Result is empty or null');
//         }
//       }

//       if (opr == '+') {
//         finalResult = add();
//       } else if (opr == '-') {
//         finalResult = sub();
//       } else if (opr == 'x') {
//         finalResult = mul();
//       } else if (opr == '/') {
//         finalResult = div();
//       }
//       preOpr = opr;
//       opr = btnText;
//       result = '';
//     } else if (btnText == '%') {
//       result = numOne / 100;
//       finalResult = doesContainDecimal(result);
//     } else if (btnText == '.') {
//       if (!result.toString().contains('.')) {
//         result = result.toString() + '.';
//       }
//       finalResult = result;
//     } else if (btnText == '+/-') {
//       result.toString().startsWith('-')
//           ? result = result.toString().substring(1)
//           : result = '-' + result.toString();
//       finalResult = result;
//     } else {
//       result = result + btnText;
//       finalResult = result;
//     }

//     setState(() {
//       text = finalResult;
//     });
//   }

//   String add() {
//     result = (numOne + numTwo).toString();
//     numOne = double.parse(result);
//     return doesContainDecimal(result);
//   }

//   String sub() {
//     result = (numOne - numTwo).toString();
//     numOne = double.parse(result);
//     return doesContainDecimal(result);
//   }

//   String mul() {
//     result = (numOne * numTwo).toString();
//     numOne = double.parse(result);
//     return doesContainDecimal(result);
//   }

//   String div() {
//     result = (numOne / numTwo).toString();
//     numOne = double.parse(result);
//     return doesContainDecimal(result);
//   }

//   String doesContainDecimal(dynamic result) {
//     if (result.toString().contains('.')) {
//       List<String> splitDecimal = result.toString().split('.');
//       if (!(int.parse(splitDecimal[1]) > 0))
//         return result = splitDecimal[0].toString();
//     }
//     return result;
//   }
// }













// import 'package:calculation_app/screens/view/all_calculators/normal_calculator/Colors.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:math_expressions/math_expressions.dart';

// class NormalCalculatorScreen extends StatefulWidget {
//   // const NormalCalculatorScreen({Key? key}) : super(key: key);
//   @override
//   _NormalCalculatorScreenState createState() => _NormalCalculatorScreenState();
// }

// class _NormalCalculatorScreenState extends State<NormalCalculatorScreen> {
//   dynamic equation = '0';
//   String result = '0';
//   String finalResult = '0';
//   String expression = "";
//   double equationFontSize = 38;
//   double resultFontSize = 48;
//   String doesContainDecimal(dynamic result) {
//     if (result.toString().contains('.')) {
//       List<String> splitDecimal = result.toString().split('.');
//       if (!(int.parse(splitDecimal[1]) > 0))
//         return result = splitDecimal[0].toString();
//     }
//     return result;
//   }

//   buttonPress(String buttonText) {
//     setState(() {
//       // -----------      CLEAR STATE     --------------
//       if (buttonText == 'C') {
//         equation = '0';
//         result = '0';
//         equationFontSize = 38;
//         resultFontSize = 48;
//       }
//       // -----------    BACKSPACE STATE    --------------
//       else if (buttonText == '%') {
//         try {
//           var numericValue = double.parse(equation);
//           var resultValue = numericValue / 100;
//           result = resultValue.toString();
//           finalResult = doesContainDecimal(result);
//         } catch (e) {
//           // Handle the case where the conversion fails (equation is not a valid numeric string)
//           print('Error: $e');
//         }
//       }
//       // else if (buttonText == '%') {
//       //     result = equation / 100;
//       //     result = doesContainDecimal(result);
//       //   }
//       else if (buttonText == '+/-') {
//         // else if (btnText == '+/-') {
//         equation.toString().startsWith('-')
//             ? equation = equation.toString().substring(1)
//             : equation = '-' + equation.toString();

// //     }
//       } else if (buttonText == '⌫') {
//         equationFontSize = 48;
//         resultFontSize = 38;
//         equation = equation.substring(
//             0, equation.length - 1); // to remove one character
//         if (equation == '') {
//           equation = '0';
//         }
//       } else if (buttonText == '=') {
//         equationFontSize = 38;
//         resultFontSize = 48;

//         expression = equation;
//         expression = expression.replaceAll('×', '*');
//         expression = expression.replaceAll('÷', '/');
//         try {
//           Parser p = new Parser();
//           Expression exp = p.parse(expression);

//           // Change expression value
//           ContextModel cm = ContextModel();
//           result = '${exp.evaluate(EvaluationType.REAL, cm)}';
//         } catch (e) {
//           result = 'Error';
//         }
//       }
//       // --------   NORMAL STATE  ------------
//       else {
//         equationFontSize = 48;
//         resultFontSize = 38;
//         if (equation == '0') {
//           equation = buttonText;
//         } else {
//           equation = equation + buttonText;
//         }
//       }
//     });
//   }

//   Widget buildButton(
//       String buttonText, double buttonHeight, Color buttonColor) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
//       color: buttonColor,
//       child: TextButton(
//         style: TextButton.styleFrom(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(0.0),
//               side: BorderSide(
//                   color: Colors.white, width: .82, style: BorderStyle.solid)),
//           padding: EdgeInsets.all(14.0),
//         ),
//         onPressed: () => buttonPress(buttonText),
//         child: Text(
//           buttonText,
//           style: TextStyle(
//               fontSize: 30.0,
//               fontWeight: FontWeight.normal,
//               color: Colors.white),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Simple Calculator')),
//       body: Column(
//         children: <Widget>[
//           Container(
//             alignment: Alignment.centerRight,
//             padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
//             child: Text(
//               equation,
//               style: TextStyle(fontSize: equationFontSize),
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerRight,
//             padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
//             child: Text(
//               result,
//               style: TextStyle(fontSize: resultFontSize),
//             ),
//           ),
//           Expanded(
//             child: Divider(),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width * .75,
//                 child: Table(
//                   children: [
//                     TableRow(children: [
//                       buildButton("%", 1, Colors.orangeAccent),
//                       // buildButton("+/-", 1, Colors.orangeAccent),
//                       buildButton("C", 1, Colors.orangeAccent),
//                       buildButton("÷", 1, Colors.orangeAccent),
//                     ]),
//                     TableRow(children: [
//                       buildButton("7", 1, Colors.black54),
//                       buildButton("8", 1, Colors.black54),
//                       buildButton("9", 1, Colors.black54),
//                     ]),
//                     TableRow(children: [
//                       buildButton("4", 1, Colors.black54),
//                       buildButton("5", 1, Colors.black54),
//                       buildButton("6", 1, Colors.black54),
//                     ]),
//                     TableRow(children: [
//                       buildButton("1", 1, Colors.black54),
//                       buildButton("2", 1, Colors.black54),
//                       buildButton("3", 1, Colors.black54),
//                     ]),
//                     TableRow(children: [
//                       buildButton(".", 1, Colors.black54),
//                       buildButton("0", 1, Colors.black54),
//                       buildButton("00", 1, Colors.black54),
//                     ]),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.25,
//                 child: Table(
//                   children: [
//                     TableRow(children: [
//                       buildButton("×", 1, Colors.orangeAccent),
//                     ]),
//                     TableRow(children: [
//                       buildButton("-", 1, Colors.orangeAccent),
//                     ]),
//                     TableRow(children: [
//                       buildButton("+", 1, Colors.orangeAccent),
//                     ]),
//                     TableRow(children: [
//                       buildButton("=", 2, Colors.orangeAccent),
//                     ]),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }