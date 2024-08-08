import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class BRMResultScreen extends StatelessWidget {
  final double bmiresult;

  const BRMResultScreen({super.key, required this.bmiresult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Results',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexColor('33743A'),
                    HexColor('FAFFFA'),
                  ],
                  stops: [
                    0.0,
                    1.0,
                  ],
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: globalText24(text: "Calculator", color: Colors.white),
              ),
            ),
            Container(
              height: 120,
              color: HexColor("0F182E"),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.brmCalculationPic,
                    height: 67.58,
                    width: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        globalText20(
                            text: "Basal Metabolic Rate",
                            color: HexColor("7BFF80")),
                        CustomRichText(
                          heading: '$bmiresult',
                          title: '/ Kcal Day',
                          headingTextColor: HexColor('7BFF80'),
                          titleTextColor: HexColor('FFFFFF'),
                          headingFontSize: 24.0,
                          titleFontSIze: 18,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 64,
                    color: HexColor("247C2C"),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: globalText16(
                          text: "Activity Level", color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 1.5,
                ),
                Expanded(
                  child: Container(
                    height: 64,
                    color: HexColor("247C2C"),
                    child: Center(
                      child: globalText16(
                          text: "Calorie",
                          color: Colors.white,
                          alignment: Alignment.center),
                    ),
                  ),
                ),
              ],
            ),
        
            CustomRow(title: "Sedentary: little or no exercise", value: NumberFormat(',###', 'en_US').format(bmiresult * 1.2)),
        
            CustomRow(title: "Exercise 1-3 times/week", value: NumberFormat(',###', 'en_US').format(bmiresult * 1.375)),
        
            CustomRow(title: "Exercise 4-5 times/week", value: NumberFormat(',###', 'en_US').format(bmiresult * 1.465)),
        
            CustomRow(title: "Daily exercise 6-7 times/week", value: NumberFormat(',###', 'en_US').format(bmiresult * 1.725)),
        
            CustomRow(
                title: "Daily  Hard exercise 6-7 times/week", value: NumberFormat(',###', 'en_US').format(bmiresult * 1.9)),
        
          ],
        ),
      ),
    );
  }
}

Widget CustomRow({required String title, required String value, FontWeight? titleFontWeight, FontWeight? headingFontWeight, Color? titleColor, Color? headingColor}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(child: globalText16(text: title, fontWeight: titleFontWeight ?? FontWeight.w500, color: titleColor, textAlign: TextAlign.start),),
            )),
        Container(
          margin: EdgeInsets.only(right: 5, left: 5),
          height: 60,
          width: 1,
          color: HexColor("DDD5D5"),
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: globalText16(
                    text: value,
                    alignment: Alignment.center,
                    fontWeight: headingFontWeight ?? FontWeight.w500, color: headingColor),
              ),
            )),
      ],
    ),
  );
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
