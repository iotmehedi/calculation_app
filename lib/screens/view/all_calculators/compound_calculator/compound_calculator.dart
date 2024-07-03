import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math';
import 'package:intl/intl.dart';

void main() {
  runApp(CompoundInterestCalculator());
}

class CompoundInterestCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compound Interest Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorForm(),
    );
  }
}

class CalculatorForm extends StatefulWidget {
  @override
  _CalculatorFormState createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _initialDepositController = TextEditingController();
  final TextEditingController _contributionAmountController = TextEditingController();
  final TextEditingController _yearsOfGrowthController = TextEditingController();
  final TextEditingController _rateOfReturnController = TextEditingController();

  String _contributionFrequency = 'Monthly';
  String _compoundFrequency = 'Annually';

  double _result = 0.0;
  double _totalPrincipal = 0.0;
  double _totalInterest = 0.0;
  List<FlSpot> _principalSpots = [const FlSpot(0,0)];
  List<FlSpot> _interestSpots = [const FlSpot(0,0)];


  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    int maxYears = 5;
    double maxX = (maxYears).toDouble();
    double maxY = _result;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compound Interest Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            final x = spot.x.toInt();
                            final balance = spot.y.toInt();
                            print("this is spot ${spot.y}");
                            final interest =_totalPrincipal - balance ;
                            // final currentYear = DateTime.now().year;
                            return LineTooltipItem(
                              'Year: ${currentYear + x}\nBalance: \$${balance.toStringAsFixed(2)}\nPrincipal: \$${balance.toStringAsFixed(2)}\nInterest: \$${interest.toStringAsFixed(2)}',
                              const TextStyle(color: Colors.white),
                              textAlign : TextAlign.center,
                                // textDirection : TextDirection.LTR,
                            );
                          }).toList();
                        },
                      ),
                      handleBuiltInTouches: true,
                      touchCallback: (FlTouchEvent event, barTouchResponse) {},
                    ),

                    gridData: const FlGridData(show: true),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1000, // Customize the interval for Y-axis labels
                            getTitlesWidget: (value, meta) {
                              // int year = currentYear ;

                              int year =  value.toInt();
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 6,
                                child: Text(year.toString(), style: const TextStyle(fontSize: 10)),
                              );
                            },
                          )
                      ),
                      rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            // getTitlesWidget: bottomTitleWidgets,
                          )
                      ),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            // reservedSize: 30,
                            getTitlesWidget: bottomTitleWidgets,
                            interval: 1,
                          )
                      ),
                    ),
                    borderData:  FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide(color: HexColor("E5E5E5"), width: 1),
                        bottom: BorderSide(color: HexColor("E5E5E5"), width: 1),
                        top: BorderSide.none,
                        right: BorderSide.none,
                      ),
                    ),
                    minX: 0,
                    maxX: maxX, // Customize the maximum X value (years)
                    minY: 0,
                    maxY: maxY, // Customize the maximum Y value (money)
                    lineBarsData: [
                      LineChartBarData(
                        spots: _principalSpots,
                        isCurved: false,
                        color: Colors.blue,
                        dotData: const FlDotData(show: true),
                      ),
                      LineChartBarData(
                        spots: _interestSpots,
                        isCurved: true,
                        color: Colors.orange,
                        dotData: const FlDotData(show: true),
                      ),

                    ],
                  ),
                ),
              ),
            ),

                TextFormField(
                  controller: _initialDepositController,
                  decoration: const InputDecoration(labelText: 'Initial Deposit'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the initial deposit';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _contributionAmountController,
                  decoration: const InputDecoration(labelText: 'Contribution Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the contribution amount';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _contributionFrequency,
                  decoration: const InputDecoration(labelText: 'Contribution Frequency'),
                  items: <String>['Monthly', 'Yearly'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _contributionFrequency = newValue!;
                    });
                  },
                ),
                TextFormField(
                  controller: _yearsOfGrowthController,
                  decoration: const InputDecoration(labelText: 'Years of Growth'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of years of growth';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _rateOfReturnController,
                  decoration: const InputDecoration(labelText: 'Estimated Rate of Return (%)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the estimated rate of return';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _compoundFrequency,
                  decoration: const InputDecoration(labelText: 'Compound Frequency'),
                  items: <String>['Daily', 'Monthly', 'Annually'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _compoundFrequency = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateCompoundInterest,
                  child: const Text('Calculate'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Total Balance: \$$_result',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Total Principal: \$$_totalPrincipal',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Total Interest: \$$_totalInterest',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    print("this is value of leftTitleWidget $value");
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text = Text('', style: style);


    print("this is value of bottomTitleWidget $value");
    var total = 0;
    var middle = 0;
    var list = [];
    list.add(value);
    total = total + value.round();
    if(int.parse(_yearsOfGrowthController.text) == value.round()){
      
    middle = (total / list.length).round();
    }
    print('This is hudai $value');
    if(value.toInt() == 0.08333333333333333){
      text = const Text('SEPT', style: style);
    }else if(middle == value.toInt()){
      text = const Text('OCT', style: style);
    }else if(value == int.parse(_yearsOfGrowthController.text)) {
      text = const Text('DEC', style: style);
    }


    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }
  LineChartData get sampleData1 => LineChartData(
    lineTouchData: lineTouchData1,
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: 14,
    maxY: 4,
    minY: 0,
  );

  LineChartData get sampleData2 => LineChartData(
    lineTouchData: lineTouchData2,
    gridData: gridData,
    titlesData: titlesData2,
    borderData: borderData,
    lineBarsData: lineBarsData2,
    minX: 0,
    maxX: 14,
    maxY: 6,
    minY: 0,
  );
  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom:
      BorderSide(color: Colors.blue.withOpacity(0.2), width: 4),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );
  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2,
    lineChartBarData1_3,
  ];

  LineTouchData get lineTouchData2 => const LineTouchData(
    enabled: false,
  );

  FlTitlesData get titlesData2 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  List<LineChartBarData> get lineBarsData2 => [
    lineChartBarData2_1,
    lineChartBarData2_2,
    lineChartBarData2_3,
  ];
  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );
  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );
  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    color: Colors.green,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 1),
      FlSpot(3, 1.5),
      FlSpot(5, 1.4),
      FlSpot(7, 3.4),
      FlSpot(10, 2),
      FlSpot(12, 2.2),
      FlSpot(13, 1.8),
    ],
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: true,
    color: Colors.pink,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
      color: Colors.pink.withOpacity(0),
    ),
    spots: const [
      FlSpot(1, 1),
      FlSpot(3, 2.8),
      FlSpot(7, 1.2),
      FlSpot(10, 2.8),
      FlSpot(12, 2.6),
      FlSpot(13, 3.9),
    ],
  );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
    isCurved: true,
    color: Colors.cyan,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 2.8),
      FlSpot(3, 1.9),
      FlSpot(6, 3),
      FlSpot(10, 1.3),
      FlSpot(13, 2.5),
    ],
  );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
    isCurved: true,
    curveSmoothness: 0,
    color: Colors.green.withOpacity(0.5),
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 1),
      FlSpot(3, 4),
      FlSpot(5, 1.8),
      FlSpot(7, 5),
      FlSpot(10, 2),
      FlSpot(12, 2.2),
      FlSpot(13, 1.8),
    ],
  );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
    isCurved: true,
    color: Colors.pink.withOpacity(0.5),
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(
      show: true,
      color: Colors.pink.withOpacity(0.2),
    ),
    spots: const [
      FlSpot(1, 1),
      FlSpot(3, 2.8),
      FlSpot(7, 1.2),
      FlSpot(10, 2.8),
      FlSpot(12, 2.6),
      FlSpot(13, 3.9),
    ],
  );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
    isCurved: true,
    curveSmoothness: 0,
    color: Colors.cyanAccent.withOpacity(0.5),
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 3.8),
      FlSpot(3, 1.9),
      FlSpot(6, 5),
      FlSpot(10, 3.3),
      FlSpot(13, 4.5),
    ],
  );
  void _calculateCompoundInterest() {
    if (_formKey.currentState!.validate()) {
      double P = double.parse(_initialDepositController.text);
      double PMT = double.parse(_contributionAmountController.text);
      int t = int.parse(_yearsOfGrowthController.text);
      double r = double.parse(_rateOfReturnController.text) / 100;

      int n;
      switch (_compoundFrequency) {
        case 'Daily':
          n = 365;
          break;
        case 'Monthly':
          n = 12;
          break;
        case 'Annually':
        default:
          n = 1;
          break;
      }

      int m;
      switch (_contributionFrequency) {
        case 'Yearly':
          m = 1;
          break;
        case 'Monthly':
        default:
          m = 12;
          break;
      }

      double A = P * pow((1 + r / n), n * t);
      _totalPrincipal = P;
      _principalSpots = [FlSpot(0, P)];
      _interestSpots = [FlSpot(0, P)];
      // List<LineChartSpot> spots = [];
      for (int i = 1; i <= t * m; i++) {
        A += PMT * pow((1 + r / n), n * (t - i / m));
        _totalPrincipal += PMT;
        double totalPrincipalAt = P + (PMT * i / m);
        double amount = totalPrincipalAt * pow((1 + r / n), n * (i / m));
        print(i/m);
        _principalSpots.add(FlSpot(i / m, totalPrincipalAt));
        _interestSpots.add(FlSpot(i / m, amount));
        // spots.add(LineChartSpot(i.toDouble(), A));
        double interest = amount - totalPrincipalAt;
        if (i == t * m) {
          _result = amount;
        }

      }

      _totalInterest = A - _totalPrincipal;

      setState(() {
        _result = A;
      });
    }
  }
}

final _colors = [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
];

const _labels = [
  'Brent',
  'JCC',
  'HH',
];

//import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'dart:math';
// import 'package:intl/intl.dart';
//
// void main() {
//   runApp(CompoundInterestCalculator());
// }
//
// class CompoundInterestCalculator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Compound Interest Calculator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CalculatorForm(),
//     );
//   }
// }
//
// class CalculatorForm extends StatefulWidget {
//   @override
//   _CalculatorFormState createState() => _CalculatorFormState();
// }
//
// class _CalculatorFormState extends State<CalculatorForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _initialDepositController = TextEditingController();
//   final TextEditingController _contributionAmountController = TextEditingController();
//   final TextEditingController _yearsOfGrowthController = TextEditingController();
//   final TextEditingController _rateOfReturnController = TextEditingController();
//
//   String _contributionFrequency = 'Monthly';
//   String _compoundFrequency = 'Annually';
//
//   double _result = 0.0;
//   double _totalPrincipal = 0.0;
//   double _totalInterest = 0.0;
//
//   List<FlSpot> _principalSpots = [];
//   List<FlSpot> _interestSpots = [];
//
//   @override
//   Widget build(BuildContext context) {
//     double maxX = (_yearsOfGrowthController.text.isNotEmpty) ? double.parse(_yearsOfGrowthController.text) : 10.0;
//     double maxY = _result;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Compound Interest Calculator'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 201,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: LineChart(
//                       LineChartData(
//                         lineTouchData: LineTouchData(
//                           touchTooltipData: LineTouchTooltipData(
//                             getTooltipItems: (touchedSpots) {
//                               return touchedSpots.map((spot) {
//                                 final x = spot.x.toInt();
//                                 final balance = spot.y.toInt();
//                                 final interest = balance - 5000; // Assuming initial principal is 5000
//                                 return LineTooltipItem(
//                                   'Year: $x\nBalance: \$${balance.toString()}\nInterest: \$${interest.toString()}',
//                                   TextStyle(color: Colors.white),
//                                 );
//                               }).toList();
//                             },
//                           ),
//                           handleBuiltInTouches: true,
//                           touchCallback: (FlTouchEvent event, barTouchResponse) {},
//                         ),
//                         gridData: FlGridData(show: true),
//                         titlesData: FlTitlesData(
//                           topTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: false,
//                             )
//                           ),
//                           rightTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: false,
//                             )
//                           ),
//                         ),
//                         borderData: FlBorderData(
//                           show: true,
//                           border: Border(
//                             left: BorderSide(color: HexColor("E5E5E5"), width: 1),
//                             bottom: BorderSide(color: HexColor("E5E5E5"), width: 1),
//                             top: BorderSide.none,
//                             right: BorderSide.none,
//                           ),
//                         ),
//                         minX: 0,
//                         maxX: maxX,
//                         minY: 0,
//                         maxY: maxY,
//                         lineBarsData: [
//                           LineChartBarData(
//                             spots: _principalSpots,
//                             isCurved: false,
//                             color: Colors.blue,
//                             dotData: FlDotData(show: false),
//                           ),
//                           LineChartBarData(
//                             spots: _interestSpots,
//                             isCurved: true,
//                             color: Colors.orange,
//                             dotData: FlDotData(show: false),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 TextFormField(
//                   controller: _initialDepositController,
//                   decoration: InputDecoration(labelText: 'Initial Deposit'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter the initial deposit';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _contributionAmountController,
//                   decoration: InputDecoration(labelText: 'Contribution Amount'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter the contribution amount';
//                     }
//                     return null;
//                   },
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: _contributionFrequency,
//                   decoration: InputDecoration(labelText: 'Contribution Frequency'),
//                   items: <String>['Monthly', 'Yearly'].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       _contributionFrequency = newValue!;
//                     });
//                   },
//                 ),
//                 TextFormField(
//                   controller: _yearsOfGrowthController,
//                   decoration: InputDecoration(labelText: 'Years of Growth'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter the number of years of growth';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _rateOfReturnController,
//                   decoration: InputDecoration(labelText: 'Estimated Rate of Return (%)'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter the estimated rate of return';
//                     }
//                     return null;
//                   },
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: _compoundFrequency,
//                   decoration: InputDecoration(labelText: 'Compound Frequency'),
//                   items: <String>['Daily', 'Monthly', 'Annually'].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       _compoundFrequency = newValue!;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _calculateCompoundInterest,
//                   child: Text('Calculate'),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Total Balance: \$$_result',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Text(
//                   'Total Principal: \$$_totalPrincipal',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Text(
//                   'Total Interest: \$$_totalInterest',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 SizedBox(height: 32),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _calculateCompoundInterest() {
//     if (_formKey.currentState!.validate()) {
//       double P = double.parse(_initialDepositController.text);
//       double PMT = double.parse(_contributionAmountController.text);
//       int t = int.parse(_yearsOfGrowthController.text);
//       double r = double.parse(_rateOfReturnController.text) / 100;
//
//       int n;
//       switch (_compoundFrequency) {
//         case 'Daily':
//           n = 365;
//           break;
//         case 'Monthly':
//           n = 12;
//           break;
//         case 'Annually':
//         default:
//           n = 1;
//           break;
//       }
//
//       int m;
//       switch (_contributionFrequency) {
//         case 'Yearly':
//           m = 1;
//           break;
//         case 'Monthly':
//         default:
//           m = 12;
//           break;
//       }
//
//       double A = P * pow((1 + r / n), n * t);
//       _totalPrincipal = P;
//
//       _principalSpots.clear();
//       _interestSpots.clear();
//
//       for (int i = 0; i <= t; i++) {
//         double totalPrincipalAtYear = P + (PMT * i * m);
//         double totalAmountAtYear = totalPrincipalAtYear * pow((1 + r / n), n * (t - i));
//         _principalSpots.add(FlSpot(i.toDouble(), totalPrincipalAtYear));
//         _interestSpots.add(FlSpot(i.toDouble(), totalAmountAtYear - totalPrincipalAtYear));
//       }
//
//       _totalInterest = A - _totalPrincipal;
//
//       setState(() {
//         _result = A;
//       });
//     }
//   }
// }