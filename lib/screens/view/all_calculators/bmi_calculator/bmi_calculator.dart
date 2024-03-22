import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/screens/widgets/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:calculation_app/screens/widgets/textfield/textField_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

// class BMICalculator extends StatefulWidget {
//   @override
//   _BMICalculatorState createState() => _BMICalculatorState();
// }

// class _BMICalculatorState extends State<BMICalculator> {
//   TextEditingController weightController = TextEditingController();
//   TextEditingController feetController = TextEditingController();
//   TextEditingController inchesController = TextEditingController();
//   double bmiResult = 0.0;
//   TextEditingController heightFeetController = TextEditingController();
//   TextEditingController heightInchesController = TextEditingController();
//   TextEditingController weighttController = TextEditingController();
//   double bmiResultt = 0.0;
//   void calculateBMI() {
//     double weight = double.tryParse(weightController.text) ?? 0.0;
//     double feet = double.tryParse(feetController.text) ?? 0.0;
//     double inches = double.tryParse(inchesController.text) ?? 0.0;

//     if (weight > 0 && feet > 0 && inches >= 0) {
//       double totalHeightInches = (feet * 12) + inches;
//       setState(() {
//         bmiResult = (weight / (totalHeightInches * totalHeightInches)) * 703;
//       });
//     }
//   }

//   void calculateBMI1() {
//     double heightFeet = double.parse(heightFeetController.text);
//     double heightInches = double.parse(heightInchesController.text);
//     double weight = double.parse(weighttController.text);

//     double heightInMeters = ((heightFeet * 12) + heightInches) * 0.0254;
//     setState(() {
//       bmiResultt = weight / (heightInMeters * heightInMeters);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BMI Calculator'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               TextField(
//                 controller: weightController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Weight (lbs)',
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Row(
//                 children: <Widget>[
//                   Flexible(
//                     child: TextField(
//                       controller: feetController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Height (feet)',
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10.0),
//                   Flexible(
//                     child: TextField(
//                       controller: inchesController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Inches',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: calculateBMI,
//                 child: Text('Calculate BMI'),
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 'BMI Result: ${bmiResult.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: heightFeetController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Height (feet)'),
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 controller: heightInchesController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Height (inches)'),
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 controller: weighttController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Weight (kg)'),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   calculateBMI1();
//                 },
//                 child: Text('Calculate BMI'),
//               ),
//               SizedBox(height: 16.0),
//               bmiResult != null
//                   ? Text(
//                       'Your BMI: ${bmiResultt.toStringAsFixed(2)}',
//                       style: TextStyle(fontSize: 20.0),
//                     )
//                   : Container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  TextEditingController ageController = TextEditingController();
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightInchesController = TextEditingController();
  TextEditingController weightKgController = TextEditingController();
  double bmiResult = 0.0;
  String? type = 'usUnit';
  String? bmiValueName;
  double progressValue = 0.0; // Initial value for progress indicator
  void calculateUsUnitBMI() {
    double weight = double.tryParse(weightKgController.text) ?? 0.0;
    double feet = double.tryParse(heightFeetController.text) ?? 0.0;
    double inches = double.tryParse(heightInchesController.text) ?? 0.0;

    if (weight > 0 && feet > 0 && inches >= 0) {
      double totalHeightInches = (feet * 12) + inches;
      setState(() {
        bmiResult = (weight / (totalHeightInches * totalHeightInches)) * 703;
        _updateProgressValue();
      });
    }
  }

  void calculateMatricsBMI() {
    double heightFeet = double.parse(heightFeetController.text);
    double heightInches = double.parse(heightInchesController.text);
    double heightCm = (heightFeet * 30.48) +
        (heightInches * 2.54); // Convert feet and inches to cm
    double weightKg = double.parse(weightKgController.text);
    setState(() {
      bmiResult = weightKg / ((heightCm / 100) * (heightCm / 100));
      _updateProgressValue();
    });
  }

  void _updateProgressValue() {
    if (bmiResult < 18.5) {
      progressValue = 0.2; // Underweight
    } else if (bmiResult >= 18.5 && bmiResult < 24.9) {
      progressValue = 0.4; // Normal weight
    } else if (bmiResult >= 25 && bmiResult < 29.9) {
      progressValue = 0.6; // Overweight
    } else {
      progressValue = 0.8; // Obese
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                        child: CustomElevatedButton(
                      text: globalText20(
                          text: 'Us Unit',
                          color: type != 'usUnit' && (type?.isNotEmpty ?? false)
                              ? HexColor('0F182E')
                              : Colors.white,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.normal),
                      color: type == 'usUnit' && (type?.isNotEmpty ?? false)
                          ? AppColors.calculateButtonColor
                          : HexColor('EEF2F6'),
                      onPress: () {
                        setState(() {
                          type = "usUnit";
                        });
                      },
                    )),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: CustomElevatedButton(
                        onPress: () {
                          setState(() {
                            type = 'matrics';
                          });
                        },
                        color: type == 'matrics' && (type?.isNotEmpty ?? false)
                            ? AppColors.calculateButtonColor
                            : HexColor('EEF2F6'),
                        text: globalText20(
                            text: 'Matrics Units',
                            color:
                                type != 'matrics' && (type?.isNotEmpty ?? false)
                                    ? HexColor('0F182E')
                                    : Colors.white,
                            alignment: Alignment.center,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                CustomSimpleTextField(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    hexColor: HexColor('80848A'),
                    controller: ageController,
                    textInputType: TextInputType.number,
                    paddingNeed: false,
                    hint: "Age",
                    textAlign: TextAlign.end),
                const SizedBox(height: 10),
                TextField(
                  controller: heightFeetController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Height (Feet)',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: heightInchesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Height (Inches)',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: weightKgController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (type == 'matrics') {
                      calculateMatricsBMI();
                    } else {
                      calculateUsUnitBMI();
                    }
                  },
                  child: const Text('Calculate BMI'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Your BMI: ${bmiResult.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width - 32,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Container(
                          height: 56,
                          width: MediaQuery.of(context).size.width - 32,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                HexColor('EE3838'),
                                HexColor('21BB30'),
                                HexColor('F2BC67'),
                                HexColor('F04E71'),
                              ],
                              stops: [
                                0.0,
                                0.55,
                                0.70,
                                0.90,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Positioned(
                        left: progressValue *
                                (MediaQuery.of(context).size.width - 32) -
                            5,
                        top: 25,
                        // bottom: -15,
                        // right: 0,
                        child: TriangleIndicator(
                            color: bmiResult < 0 || bmiResult == 0.0
                                ? AppColors.calculateButtonColor
                                : bmiResult < 18.5
                                    ? HexColor('EE3838')
                                    : bmiResult >= 18.5 && bmiResult < 24.9
                                        ? HexColor('21BB30')
                                        : bmiResult >= 25 && bmiResult < 29.9
                                            ? HexColor('F2BC67')
                                            : HexColor('F04E71')),
                      ),
                      Positioned(
                          top: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SizedBox(
                              height: 15,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: globalText12(text: "Underweight")),
                                  Expanded(child: globalText12(text: "Normal")),
                                  Expanded(
                                      child: globalText12(text: "Overweight")),
                                  Expanded(child: globalText12(text: "Obese")),
                                ],
                              ),
                            ),
                          )),
                      Positioned(
                          bottom: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: SizedBox(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.91,
                              child: Row(
                                children: [
                                  Expanded(child: globalText14(text: "18.5")),
                                  Expanded(
                                      child: globalText14(
                                          text: "18.5 - 24.9",
                                          alignment: Alignment.centerRight)),
                                  Expanded(
                                      child: globalText14(
                                          text: "25 - 29.9",
                                          alignment: Alignment.centerRight)),
                                  Expanded(
                                      child: globalText14(
                                          text: "30+",
                                          alignment: Alignment.centerRight)),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TriangleIndicator extends StatelessWidget {
  final HexColor color;
  const TriangleIndicator({
    super.key,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(20, 16),
      painter: TrianglePainter(color: color),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final HexColor color;
  const TrianglePainter({
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
