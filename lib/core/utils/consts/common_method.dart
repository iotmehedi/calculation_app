import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hexcolor/hexcolor.dart';

class CommonMethod{
  List<PieChartSectionData> showingSections({required RxList list, required double total, required String principalColor, required String interestColor}) {
    List<HexColor> colors = [];
    colors = [
      HexColor(principalColor),
      HexColor(interestColor),
    ];

    return List.generate(list.length, (i) {
      const isTouched = false; // you can set this dynamically if you want interactivity
      const fontSize = isTouched == true ? 25.0 : 16.0;
      const radius = isTouched == true ? 60.0 : 50.0;
      return PieChartSectionData(
        color: colors[i],
        value: list[i] / total * 100,
        // title: '${(list[i] / total * 100).round()}%',
        title: '',
        radius: 20,
        titleStyle: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );
    });
  }

  List<PieChartSectionData> showingThreeSections({required RxList list, required double total, required String principalColor, required String interestColor, required String tax}) {
    List<HexColor> colors = [];
    colors = [
      HexColor(principalColor),
      HexColor(interestColor),
      HexColor(tax),
    ];

    return List.generate(list.length, (i) {
      const isTouched = false; // you can set this dynamically if you want interactivity
      const fontSize = isTouched == true ? 25.0 : 16.0;
      const radius = isTouched == true ? 60.0 : 50.0;
      return PieChartSectionData(
        color: colors[i],
        value: list[i] / total * 100,
        title: '${(list[i] / total * 100).round()}%',
        radius: 20,
        titleStyle: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );
    });
  }
}