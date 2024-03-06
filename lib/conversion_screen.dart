import 'package:flutter/material.dart';

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  void _convert() {
    double kilometers = double.tryParse(_controller.text) ?? 0;
    double miles = kilometers * 0.621371;
    setState(() {
      _result = "${kilometers.toString()} km is equal to ${miles.toStringAsFixed(2)} miles";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KM to Miles Conversion'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter value in kilometers',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}