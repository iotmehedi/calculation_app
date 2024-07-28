import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class BodyfatResultScreen extends StatelessWidget {
  final String maintainWeight, weight;
  final bool type;
  BodyfatResultScreen({
    super.key,
    required this.maintainWeight,
    required this.type,
    required this.weight,
    // required this.type,
    // required this.weight,
  });
  double bodyFatWeightLbs = 0.0;
  double caloriesToBurnFor1PercentFat = 0.0;
  @override
  Widget build(BuildContext context) {
    double weightInLbs = type == false
        ? ((double.tryParse(weight) ?? 0.0) / 0.453592)
        : (double.tryParse(weight) ?? 0.0);
    bodyFatWeightLbs =
        ((double.tryParse(maintainWeight) ?? 0.0) / 100) * weightInLbs;

    // Calculate calories to burn to lose 1% body fat
    caloriesToBurnFor1PercentFat = (3500 * weightInLbs) / 100;
    print(caloriesToBurnFor1PercentFat);
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
                        globalText20(text: "Body Fat:", color: Colors.white),
                        CustomRichText(
                          heading: maintainWeight,
                          title:
                              '% = ${bodyFatWeightLbs.toStringAsFixed(1)} ${type == false ? 'lbs' : 'Kg'}',
                          headingTextColor: HexColor('7BFF80'),
                          titleTextColor: HexColor("7BFF80"),
                          headingFontSize: 20.0,
                          titleFontSIze: 20.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              color: HexColor("0F182E"),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Weight lose ',
                        style: GoogleFonts.poppins(
                          letterSpacing: 0.2,
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' $maintainWeight%',
                            style: GoogleFonts.poppins(
                              letterSpacing: 0.2,
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: ' body fat, you must burn!',
                            style: GoogleFonts.poppins(
                              letterSpacing: 0.2,
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    5.ph,
                    RichText(
                      text: TextSpan(
                        text: 'At least:',
                        style: GoogleFonts.poppins(
                          letterSpacing: 0.2,
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' ${NumberFormat('#,##,##', 'en_US')
                          .format(caloriesToBurnFor1PercentFat.round())}',
                            style: GoogleFonts.poppins(
                              letterSpacing: 0.2,
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: ' Calories',
                            style: GoogleFonts.poppins(
                              letterSpacing: 0.2,
                              color: Colors.green,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
