import 'package:flutter/material.dart';

void main() {
  runApp(TipCalculatorApp());
}

class TipCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TipCalculator(),
    );
  }
}

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final _priceController = TextEditingController();
  final _tipController = TextEditingController();
  final _peopleController = TextEditingController();

  double _tipAmount = 0;
  double _totalAmount = 0;
  double _tipPerPerson = 0;
  double _totalPerPerson = 0;

  void _calculateTip() {
    final double price = double.tryParse(_priceController.text) ?? 0;
    final double tipPercent = double.tryParse(_tipController.text) ?? 0;
    final int numberOfPeople = int.tryParse(_peopleController.text) ?? 1;

    setState(() {
      _tipAmount = price * tipPercent / 100;
      _totalAmount = price + _tipAmount;
      _tipPerPerson = _tipAmount / numberOfPeople;
      _totalPerPerson = _totalAmount / numberOfPeople;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price (\$)',
              ),
            ),
            TextField(
              controller: _tipController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tip (%)',
              ),
            ),
            TextField(
              controller: _peopleController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of People',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateTip,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text('Tip: \$${_tipAmount.toStringAsFixed(2)}'),
            Text('Total Amount: \$${_totalAmount.toStringAsFixed(2)}'),
            Text('Tip per Person: \$${_tipPerPerson.toStringAsFixed(2)}'),
            Text('Total per Person: \$${_totalPerPerson.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
