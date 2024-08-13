import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/custom_text/custom_text.dart';


class UnitConverter extends StatefulWidget {
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  final TextEditingController _controller = TextEditingController();
  String _fromUnit = 'Meter';
  String _toUnit = 'Kilometer';
  double? _convertedValue;
  var selectedButton = "Length";


  final Map<String, Map<String, double>> _unitFactors = {
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
  // void _convert() {
  //   double inputValue = double.tryParse(_controller.text) ?? 0;
  //   double fromFactor = _unitFactors[selectedButton]!.keys.first;
  //   double toFactor = _unitFactors[selectedButton]!.keys.first;
  //
  //   setState(() {
  //     _convertedValue = (inputValue * fromFactor) / toFactor;
  //   });
  // }
  void _convert() {
    double inputValue = double.tryParse(_controller.text) ?? 0;
    double fromFactor = _unitFactors[selectedButton]![_fromUnit]!;
    double toFactor = _unitFactors[selectedButton]![_toUnit]!;

    setState(() {
      _convertedValue = (inputValue * fromFactor) / toFactor;
    });
  }
  void _convertWeight(){
    double inputValue = double.tryParse(_controller.text) ?? 0;
    double valueInKilograms = inputValue / _unitFactors[selectedButton]![_fromUnit]!;
   setState(() {
     _convertedValue = valueInKilograms * _unitFactors[selectedButton]![_toUnit]!;
   });
  }
  void _convertArea(){

    double inputValue = double.tryParse(_controller.text) ?? 0;
    double valueInSquareMeters = inputValue / _unitFactors[selectedButton]![_fromUnit]!;
   setState(() {
     _convertedValue = valueInSquareMeters * _unitFactors[selectedButton]![_toUnit]!;
   });


  }
  void _updateUnits() {
    setState(() {
      _fromUnit = _unitFactors[selectedButton]!.keys.first;
      _toUnit = _unitFactors[selectedButton]!.keys.first;
    });
  }
  // String _conversionType = 'Length';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: HexColor("244384"),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedButton = "Length";
                              _updateUnits();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: selectedButton ==
                                  "Length"
                                  ? Colors.white
                                  : HexColor("244384"),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Center(
                                  child: CustomText(
                                    text: "Length",
                                    fontSize: 20,
                                    textColor:
                                    selectedButton ==
                                        "Length"
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      5.pw,
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedButton = "Weight";
                              _updateUnits();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: selectedButton ==
                                  "Weight"
                                  ? Colors.white
                                  : HexColor("244384"),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Center(
                                  child: CustomText(
                                    text: "Weight",
                                    fontSize: 20,
                                    textColor:
                                    selectedButton ==
                                        "Weight"
                                        ? HexColor("244384")
                                        : Colors.white,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      5.pw,
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedButton = "Area";
                              _updateUnits();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: selectedButton ==
                                  "Area"
                                  ? Colors.white
                                  : HexColor("244384"),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Center(
                                  child: CustomText(
                                    text: "Area",
                                    fontSize: 20,
                                    textColor:
                                    selectedButton ==
                                        "Area"
                                        ? HexColor("244384")
                                        : Colors.white,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter value',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _fromUnit,
                    onChanged: (newValue) {
                      setState(() {
                        _fromUnit = newValue!;
                      });
                    },
                    items: _unitFactors[selectedButton]!.keys.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    value: _toUnit,
                    onChanged: (newValue) {
                      setState(() {
                        _toUnit = newValue!;
                      });
                    },
                    items: _unitFactors[selectedButton]!.keys.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: (){
                // _convert();
                // _convertWeight();
                _convertArea();
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 24),
            if (_convertedValue != null)
              Text(
                'Converted Value: $_convertedValue $_toUnit',
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
