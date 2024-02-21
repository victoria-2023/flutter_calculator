import 'package:flutter/material.dart';

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

  String _input = "0";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _input = "0";
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      _num1 = double.parse(_input);
      _operand = buttonText;
      _input = "0";
    } else if (buttonText == ".") {
      if (_input.contains(".")) {
        return;
      } else {
        _input = _input + buttonText;
      }
    } else if (buttonText == "=") {
      _num2 = double.parse(_input);

      if (_operand == "+") {
        _input = (_num1 + _num2).toString();
      } else if (_operand == "-") {
        _input = (_num1 - _num2).toString();
      } else if (_operand == "*") {
        _input = (_num1 * _num2).toString();
      } else if (_operand == "/") {
        _input = (_num1 / _num2).toString();
      }

      _num1 = 0.0;
      _operand = "";
      _num2 = 0.0;
    } else {
      _input = _input + buttonText;
    }

    setState(() {
      _output = double.parse(_input).toStringAsFixed(2);
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        child: Text(buttonText,
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 12.0),
                child: Text(_output, style: TextStyle(fontSize: 48.0))),
            Expanded(
              child: Divider(),
            ),
            Column(children: [
              Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/")
              ]),
              Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*")
              ]),
              Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-")
              ]),
              Row(children: [
                buildButton("."),
                buildButton("0"),
                buildButton("00"),
                buildButton("+")
              ]),
              Row(children: [
                buildButton("C"),
                buildButton("=")
              ])
            ])
          ],
        ),
      ),
    );
  }
}
