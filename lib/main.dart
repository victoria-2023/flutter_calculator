import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';
import 'conversion_screen.dart';
import 'history_screen.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _input = "";

  buttonPressed(String buttonText) async {
    if (buttonText == "C") {
      _input = "";
      _output = "0";
    } else if (buttonText == "=") {
      final result = evaluateExpression(_input);
      await _saveCalculation('$_input = $result');
      _input = result; // Update input to result for further calculations
      _output = result; // Update output to show the result
    } else {
      _input += buttonText; // Build the equation string
      _output = _input; // Show current equation as output
    }

    setState(() {
      // This ensures the UI is refreshed with the new output
    });
  }

  Future<void> _saveCalculation(String calculation) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('calculationHistory') ?? [];
    String timestamp = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    history.add("$calculation at $timestamp");
    await prefs.setStringList('calculationHistory', history);
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        child: Text(buttonText, style: TextStyle(fontSize: 20.0)),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  void _navigateToConversionScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConversionScreen()));
  }

  void _navigateToHistoryScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _navigateToHistoryScreen,
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(_output, style: TextStyle(fontSize: 48.0)),
            ),
            Expanded(child: Divider()),
            Column(children: [
              Row(children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("/")]),
              Row(children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("*")]),
              Row(children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")]),
              Row(children: [buildButton("."), buildButton("0"), buildButton("00"), buildButton("+")]),
              Row(children: [buildButton("C"), buildButton("=")]),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    child: Text("KM to Miles", style: TextStyle(fontSize: 20.0)),
                    onPressed: _navigateToConversionScreen,
                  ),
                ),
              ]),
            ])
          ],
        ),
      ),
    );
  }

  // Implement the evaluateExpression function using math_expressions package
  String evaluateExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString(); // Return the result as a string
    } catch (e) {
      return "Error"; // Return an error message or handle it appropriately
    }
  }
}