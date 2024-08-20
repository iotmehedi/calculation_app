import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnitController extends GetxController{
  var textController = TextEditingController().obs;
  var fromUnit = 'Meter'.obs;
  var toUnit = 'Kilometer'.obs;
  var convertedValue = 0.0.obs;
  var selectedButton = "Length".obs;
  final Map<String, Map<String, double>> unitFactors = {
    'Length': {
      'Meter': 1.0,
      'Kilometer': 1000.0,
      'Centimeter': 0.01,
      'Millimeter': 0.001,
      'Micrometer': 1e-6,
      'Nanometer': 1e-9,
      'Mile': 1609.34,
      'Yard': 0.9144,
      'Foot': 0.3048,
      'Inch': 0.0254,
      'Light Year': 9.461e15,
    },
    'Weight': {
      'Kilogram': 1,
      'Gram': 1e3,
      'Milligram': 1e6,
      'Metric Ton': 1e-3,
      'Long Ton': 9.8421e-4,
      'Short Ton': 1.1023e-3,
      'Pound': 2.20462,
      'Ounce': 35.274,
      'Carat': 5e3,
      'Atomic Mass Unit': 6.02214e26,
    },
    'Area': {
      'Square Meter': 1,
      'Square Kilometer': 1e-6,
      'Square Centimeter': 1e4,
      'Square Millimeter': 1e6,
      'Square Micrometer': 1e12,
      'Hectare': 1e-4,
      'Square Mile': 3.861e-7,
      'Square Yard': 1.19599,
      'Square Foot': 10.7639,
      'Square Inch': 1550.0031,
      'Acre': 2.47105e-4,
    }
  };
  void convert({String? value, required String from}) {
    double inputValue = 0.0;

    if((value?.isEmpty ?? false) && from.isEmpty){
      inputValue = double.tryParse(textController.value.text) ?? 0;
    }else{
      inputValue = double.tryParse(value!) ?? 0;
    }
    double fromFactor = unitFactors[selectedButton]![fromUnit.value]!;
    double toFactor = unitFactors[selectedButton]![toUnit.value]!;
      convertedValue.value = (inputValue * fromFactor) / toFactor;
  }

  void convertWeight({String? value, required String from}) {
    double inputValue = 0.0;
    if((value?.isEmpty ?? false) && from.isEmpty){
      inputValue = double.tryParse(textController.value.text) ?? 0;
    }else{
      inputValue = double.tryParse(value!) ?? 0;
    }
    double valueInKilograms =
        inputValue / unitFactors[selectedButton]![fromUnit.value]!;

      convertedValue.value =
          valueInKilograms * unitFactors[selectedButton]![toUnit.value]!;

  }

  void convertArea({String? value, required String from}) {
    double inputValue = 0.0;
    if((value?.isEmpty ?? false) && from.isEmpty){
      inputValue = double.tryParse(textController.value.text) ?? 0;
    }else{
      inputValue = double.tryParse(value!) ?? 0;
    }
    double valueInSquareMeters =
        inputValue / unitFactors[selectedButton]![fromUnit.value]!;

      convertedValue.value =
          valueInSquareMeters * unitFactors[selectedButton]![toUnit.value]!;

  }

  void updateUnits() {

      fromUnit.value = unitFactors[selectedButton]!.keys.first;
      toUnit.value = unitFactors[selectedButton]!.keys.first;

  }
}