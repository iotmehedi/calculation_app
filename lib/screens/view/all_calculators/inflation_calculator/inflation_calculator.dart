import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: InflationCalculatorPage(),
    );
  }
}

class InflationCalculatorPage extends StatelessWidget {
  final InflationCalculatorController controller = Get.put(InflationCalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inflation Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter amount'),
              onChanged: (value) => controller.setAmount(value),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: MonthDropdown('From')),
                SizedBox(width: 16),
                Expanded(child: YearDropdown('From')),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: MonthDropdown('To')),
                SizedBox(width: 16),
                Expanded(child: YearDropdown('To')),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.calculateInflation(),
              child: Text('Calculate'),
            ),
            SizedBox(height: 16),
            Obx(() => controller.result.isNotEmpty ? Text(controller.result.value) : Container()),
          ],
        ),
      ),
    );
  }
}

class MonthDropdown extends StatelessWidget {
  final String label;

  MonthDropdown(this.label);

  @override
  Widget build(BuildContext context) {
    final InflationCalculatorController controller = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label Month'),
        Obx(() => DropdownButton<String>(
          value: controller.getMonthValue(label),
          onChanged: (value) => controller.setMonthValue(label, value!),
          items: controller.monthItems,
        )),
      ],
    );
  }
}

class YearDropdown extends StatelessWidget {
  final String label;

  YearDropdown(this.label);

  @override
  Widget build(BuildContext context) {
    final InflationCalculatorController controller = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label Year'),
        Obx(() => DropdownButton<String>(
          value: controller.getYearValue(label),
          onChanged: (value) => controller.setYearValue(label, value!),
          items: controller.yearItems,
        )),
      ],
    );
  }
}


class InflationCalculatorController extends GetxController {
  var amount = ''.obs;
  var fromMonth = 'January'.obs;
  var fromYear = '1913'.obs;
  var toMonth = 'June'.obs;
  var toYear = DateFormat('yyyy').format(DateTime.now()).obs;
  var result = ''.obs;

  final Map<String, double> cpiData = {
    '1913': 9.8,
    '1914': 10.0,
    '1915': 10.6,
    '1916': 11.6,
    '1917': 12.8,
    '1918': 15.2,
    '1919': 16.7,
    '1920': 20.0,
    '1921': 17.8,
    '1922': 17.3,
    '1923': 17.6,
    '1924': 17.8,
    '1925': 18.0,
    '1926': 18.1,
    '1927': 17.7,
    '1928': 17.4,
    '1929': 17.8,
    '1930': 16.7,
    '1931': 15.5,
    '1932': 14.2,
    '1933': 13.3,
    '1934': 13.6,
    '1935': 13.7,
    '1936': 14.0,
    '1937': 14.8,
    '1938': 14.9,
    '1939': 15.2,
    '1940': 15.6,
    '1941': 16.1,
    '1942': 17.5,
    '1943': 18.5,
    '1944': 18.8,
    '1945': 19.5,
    '1946': 22.1,
    '1947': 23.6,
    '1948': 24.8,
    '1949': 24.6,
    '1950': 26.7,
    '1951': 29.0,
    '1952': 29.8,
    '1953': 29.9,
    '1954': 29.8,
    '1955': 29.6,
    '1956': 30.1,
    '1957': 30.7,
    '1958': 30.4,
    '1959': 30.9,
    '1960': 31.3,
    '1961': 30.9,
    '1962': 30.2,
    '1963': 30.6,
    '1964': 31.3,
    '1965': 31.7,
    '1966': 32.8,
    '1967': 33.4,
    '1968': 34.8,
    '1969': 36.7,
    '1970': 38.8,
    '1971': 40.5,
    '1972': 41.8,
    '1973': 44.5,
    '1974': 49.3,
    '1975': 53.8,
    '1976': 56.9,
    '1977': 60.6,
    '1978': 65.2,
    '1979': 72.6,
    '1980': 82.4,
    '1981': 90.9,
    '1982': 96.5,
    '1983': 99.6,
    '1984': 103.9,
    '1985': 107.6,
    '1986': 109.6,
    '1987': 113.6,
    '1988': 118.3,
    '1989': 124.0,
    '1990': 130.7,
    '1991': 136.2,
    '1992': 140.3,
    '1993': 144.5,
    '1994': 148.2,
    '1995': 152.4,
    '1996': 156.9,
    '1997': 160.5,
    '1998': 163.0,
    '1999': 166.6,
    '2000': 172.2,
    '2001': 177.1,
    '2002': 179.9,
    '2003': 184.0,
    '2004': 188.9,
    '2005': 195.3,
    '2006': 201.6,
    '2007': 207.3,
    '2008': 215.3,
    '2009': 214.5,
    '2010': 218.1,
    '2011': 224.9,
    '2012': 229.6,
    '2013': 233.0,
    '2014': 236.736,
    '2015': 237.017,
    '2016': 240.007,
    '2017': 245.120,
    '2018': 251.107,
    '2019': 255.657,
    '2020': 258.811,
    '2021': 270.970,
    '2022': 287.504,
    '2023': 305.109,
  };


  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December', 'Average'
  ];

  List<String> get years {
    int currentYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
    return List.generate(currentYear - 1913 + 1, (index) => (1913 + index).toString());
  }

  void setAmount(String value) {
    amount.value = value;
  }

  void setMonthValue(String label, String value) {
    if (label == 'From') {
      fromMonth.value = value;
    } else {
      toMonth.value = value;
    }
  }

  void setYearValue(String label, String value) {
    if (label == 'From') {
      fromYear.value = value;
    } else {
      toYear.value = value;
    }
  }

  String getMonthValue(String label) {
    if (label == 'From') {
      return fromMonth.value;
    } else {
      return toMonth.value;
    }
  }

  String getYearValue(String label) {
    if (label == 'From') {
      return fromYear.value;
    } else {
      return toYear.value;
    }
  }

  List<DropdownMenuItem<String>> get monthItems {
    return months.map((month) {
      return DropdownMenuItem(child: Text(month), value: month);
    }).toList();
  }

  List<DropdownMenuItem<String>> get yearItems {
    return years.map((year) {
      return DropdownMenuItem(child: Text(year), value: year);
    }).toList();
  }

  void calculateInflation() {
    double? fromCPI = cpiData[fromYear.value];
    double? toCPI = cpiData[toYear.value];

    if (fromCPI != null && toCPI != null && amount.value.isNotEmpty) {
      double initialAmount = double.tryParse(amount.value) ?? 0;
      double adjustedAmount = initialAmount * (toCPI / fromCPI);

      double inflationRate = ((toCPI - fromCPI) / fromCPI) * 100;
      double averageInflationRate = inflationRate / (int.parse(toYear.value) - int.parse(fromYear.value));

      result.value =
      '\$${adjustedAmount.toStringAsFixed(2)} in ${toMonth.value} ${toYear.value} equals \$${initialAmount.toStringAsFixed(2)} of buying power in ${fromMonth.value} ${fromYear.value}.\n\n'
          'The total inflation rate from ${fromMonth.value} ${fromYear.value} to ${toMonth.value} ${toYear.value} is ${inflationRate.toStringAsFixed(2)}%. '
          'The average inflation rate is ${averageInflationRate.toStringAsFixed(2)}% per year.\n\n'
          'The CPI of ${fromMonth.value} ${fromYear.value} is ${fromCPI.toStringAsFixed(3)} and the CPI of ${toMonth.value} ${toYear.value} is ${toCPI.toStringAsFixed(3)}.';
    } else {
      result.value = 'Please ensure all fields are filled correctly and that the amount is valid.';
    }
  }
}

