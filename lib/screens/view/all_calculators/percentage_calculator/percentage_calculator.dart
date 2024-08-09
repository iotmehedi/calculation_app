import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../main.dart';
import '../../../../toast/toast.dart';
import '../../../widgets/textfield/textField_widget.dart';

class PercentageCalculator extends StatefulWidget {
  @override
  _PercentageCalculatorState createState() => _PercentageCalculatorState();
}

class _PercentageCalculatorState extends State<PercentageCalculator> {
  TextEditingController numberController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  double result = 0.0;

  void calculatePercentage() {
    double number = double.tryParse(numberController.text) ?? 0.0;
    double percentage = double.tryParse(percentageController.text) ?? 0.0;
    setState(() {
      result = (number * percentage) / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
            appBar: CustomAppBar(
    title: 'Percentage',
    onBackPressed: () {
      Navigator.pop(context);
    },
  ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: globalText20(
                text: 'What is p% of x?',
                alignment: Alignment.center,
                hexColor: HexColor('80848A'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: globalText20(
                      text: 'What Is',
                      alignment: Alignment.centerRight,
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: CustomSimpleTextField(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      hexColor: HexColor('80848A'),
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      paddingNeed: false,
                      hint: 'P',
                      textAlign: TextAlign.end),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: globalText20(
                      text: 'Of',
                      alignment: Alignment.centerRight,
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: CustomSimpleTextField(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      hexColor: HexColor('80848A'),
                      controller: percentageController,
                      keyboardType: TextInputType.number,
                      paddingNeed: false,
                      hint: "X",
                      textAlign: TextAlign.end),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ValueListenableBuilder<bool>(
                valueListenable: connectivityService.isConnected,
                builder: (context, isConnected, child) {

                  return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("244384"),
                    maximumSize: Size(MediaQuery.of(context).size.width * 0.9, 60),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: isConnected ? calculatePercentage : () {
                    errorToast(
                        context: context,
                        msg: "Please check your internet connection",
                        color: Colors.grey,
                        iconColor: Colors.red,
                        headingTextColor: Colors.red,
                        valueTextColor: Colors.red);
                  },

                    child: globalText20(
                      text: 'Calculate',
                      alignment: Alignment.center,
                      color: Colors.white),
                );
              }
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: globalText32(
                      text: '=',
                      alignment: Alignment.centerRight,
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: HexColor('F3F6F9'),
                    ),
                    child: globalTextSixteen(
                        text: "$result",
                        color: HexColor('555656'),
                        alignment: Alignment.center,
                        fontWeight: FontWeight.bold),
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
