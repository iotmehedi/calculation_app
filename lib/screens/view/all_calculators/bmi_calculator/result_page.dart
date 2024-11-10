import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/services/ad_services.dart';

class ResultScrren extends StatelessWidget {
  final double bmiresult;
  final double progressValue;
  final String bmiValueName;
  final bool type;
   ResultScrren(
      {super.key,
      required this.bmiresult,
      required this.progressValue,
      required this.bmiValueName,
      required this.type});
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    // Get.find<AdService>().loadBannerAd();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Results',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: adController.getNativeAdWidget(),
      //     ),
      //     20.ph,
      //     adController.getBannerAdWidget(),
      //   ],
      // ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
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
                          color: bmiresult < 0 || bmiresult == 0.0
                              ? AppColors.calculateButtonColor
                              : bmiresult < 18.5
                                  ? HexColor('EE3838')
                                  : bmiresult >= 18.5 && bmiresult < 24.9
                                      ? HexColor('21BB30')
                                      : bmiresult >= 25 && bmiresult < 29.9
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
                                    child: globalText12(text: "Underweight", fontWeight: FontWeight.normal)),
                                Expanded(child: globalText12(text: "Normal", fontWeight: FontWeight.normal)),
                                Expanded(
                                    child: globalText12(text: "Overweight", fontWeight: FontWeight.normal)),
                                Expanded(child: globalText12(text: "Obese", fontWeight: FontWeight.normal)),
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
                                Expanded(child: globalText14(text: "18.5", fontWeight: FontWeight.normal)),
                                Expanded(
                                    child: globalText14(
                                        text: "18.5 - 24.9",
                                        alignment: Alignment.centerRight, fontWeight: FontWeight.normal)),
                                Expanded(
                                    child: globalText14(
                                        text: "25 - 29.9",
                                        alignment: Alignment.centerRight, fontWeight: FontWeight.normal)),
                                Expanded(
                                    child: globalText14(
                                        text: "30+",
                                        alignment: Alignment.centerRight, fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        // width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CustomRichText(
                              heading: 'BMI = ${bmiresult.toStringAsFixed(1)} ',
                              title: bmiValueName,
                              headingFontSize: 27.0,
                              titleFontSIze: 27.0,
                              titleTextColor: bmiresult < 18.5
                                  ? HexColor('EE3838')
                                  : bmiresult >= 18.5 && bmiresult < 24.9
                                      ? HexColor('21BB30')
                                      : bmiresult >= 25 && bmiresult < 29.9
                                          ? HexColor('F2BC67')
                                          : HexColor('F04E71')),
                        ),
                      ),
                      // globalText32(
                      //     text: "BMI = ${bmiresult.toStringAsFixed(1)} kg/m2"),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      // globalText32(
                      //     text: bmiValueName,
                      //     color: bmiresult < 18.5
                      //         ? HexColor('EE3838')
                      //         : bmiresult >= 18.5 && bmiresult < 24.9
                      //             ? HexColor('21BB30')
                      //             : bmiresult >= 25 && bmiresult < 29.9
                      //                 ? HexColor('F2BC67')
                      //                 : HexColor('F04E71')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  globalText16(text: "You are in the  "),
                  globalText16(
                      text: bmiresult < 18.5
                          ? "Underweight"
                          : bmiresult >= 18.5 && bmiresult < 24.9
                              ? "Healthy Normal"
                              : bmiresult >= 25 && bmiresult < 29.9
                                  ? "Overweight"
                                  : "Obese",
                      color: bmiresult < 18.5
                          ? HexColor('EE3838')
                          : bmiresult >= 18.5 && bmiresult < 24.9
                              ? HexColor('21BB30')
                              : bmiresult >= 25 && bmiresult < 29.9
                                  ? HexColor('F2BC67')
                                  : HexColor('F04E71')),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: globalText16(text: "BMI Weight Range:"),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                      heading: 'Less than 18.5 = ',
                      title: 'Underweight',
                      titleTextColor: HexColor('EE3838'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomRichText(
                        heading: 'Between 18.5 - 24.9 = ',
                        title: 'Healthy Normal',
                        titleTextColor: HexColor('21BB30')),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomRichText(
                      heading: 'Between 25 - 29.9 = ',
                      title: 'Overweight',
                      titleTextColor: HexColor('F2BC67'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomRichText(
                      heading: 'Over 30 =',
                      title: 'Obese',
                      titleTextColor: HexColor('F04E71'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
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
