import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(RandomComplimentApp());
}
//frontend flutter code
class RandomComplimentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compliment_Generator',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
      ),
      home: ComplimentPage(),
    );
  }
}

class ComplimentPage extends StatefulWidget {
  @override
  _ComplimentPageState createState() => _ComplimentPageState();
}

class _ComplimentPageState extends State<ComplimentPage> {
  String compliment = "Press a button to receive a compliment!";
  String complimentType = "random"; // Default compliment type

  Future<void> fetchCompliment(String type) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/compliment?compliment_type=$type'); // backend URL
    final response = await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        compliment = data['compliment'];
      });
    } else {
      setState(() {
        compliment = "Failed to load a compliment.";
      });
    }
  }

  void setComplimentType(String type) {
    setState(() {
      complimentType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compliment Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                compliment,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [//buttons
                ElevatedButton(
                  onPressed: () => fetchCompliment("random"),
                  child: Text('Random'),
                  style: ElevatedButton.styleFrom(
                    // primary: complimentType == "random" ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => fetchCompliment("fun"),//indicates the backend ai to work and produce fun compliment when the button is pressed
                  child: Text('Fun'),
                  style: ElevatedButton.styleFrom(
                    // primary: complimentType == "fun" ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => fetchCompliment("exciting"),//indicates the backend ai to work and produce exciting compliment when the button is pressed
                  child: Text('Exciting'),
                  style: ElevatedButton.styleFrom(
                    // primary: complimentType == "exciting" ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => fetchCompliment("body_positivity"),//indicates the backend ai to work and produce body positive compliment when the button is pressed
                  child: Text('Body Positive'),
                  style: ElevatedButton.styleFrom(
                    // primary: complimentType == "body_positivity" ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => fetchCompliment("comparison"),//indicates the backend ai to work and produce comparison compliment when the button is pressed
                  child: Text('Comparison'),
                  style: ElevatedButton.styleFrom(
                    // primary: complimentType == "comparison" ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//code end