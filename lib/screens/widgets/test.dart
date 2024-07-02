// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Charts Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Charts Demo'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           child: SfCartesianChart(
//             title: ChartTitle(text: 'Investment Growth'),
//             primaryXAxis: NumericAxis(
//               edgeLabelPlacement: EdgeLabelPlacement.shift,
//               majorGridLines: const MajorGridLines(width: 0),
//               interval: 5,
//               title: AxisTitle(text: 'Years'),
//             ),
//             primaryYAxis: NumericAxis(
//               edgeLabelPlacement: EdgeLabelPlacement.shift,
//               majorGridLines: const MajorGridLines(width: 0),
//               interval: 2,
//               title: AxisTitle(text: 'Amount (K)'),
//             ),
//             series: <CartesianSeries<dynamic, dynamic>>[
//               LineSeries<ChartData, int>(
//                 dataSource: <ChartData>[
//                   ChartData(0, 2.9),
//                   ChartData(5, 4),
//                   ChartData(10, 5.2),
//                   ChartData(15, 7.2),
//                   ChartData(20, 9.5),
//                 ],
//                 xValueMapper: (ChartData data, _) => data.x,
//                 yValueMapper: (ChartData data, _) => data.y,
//                 name: 'Total Blance',
//                 color: Colors.green,
//               ),
//               LineSeries<ChartData, int>(
//                 dataSource: <ChartData>[
//                   ChartData(0, 2.9),
//                   ChartData(5, 3.9),
//                   ChartData(10, 4.8),
//                   ChartData(15, 6.3),
//                   ChartData(20, 8.7),
//                 ],
//                 xValueMapper: (ChartData data, _) => data.x,
//                 yValueMapper: (ChartData data, _) => data.y,
//                 name: 'Total Blance',
//                 color: Colors.blue,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ChartData {
//   ChartData(this.x, this.y);
//   final int x;
//   final double y;
// }