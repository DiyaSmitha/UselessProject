import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(RandomComplimentApp());
}

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
    final url = Uri.parse('http://127.0.0.1:8000/api/compliment?compliment_type=$type'); // Replace with your backend URL
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
        title: Text('Random Compliment Generator'),
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
              children: [
                ElevatedButton(
                  onPressed: () => fetchCompliment("random"),
                  child: Text('Random'),
                  style: ElevatedButton.styleFrom(
                    // primary: complimentType == "random" ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => fetchCompliment("fun"),
                  child: Text('Fun'),
                  style: ElevatedButton.styleFrom(
                    // primary: complimentType == "fun" ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => fetchCompliment("exciting"),
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
                  onPressed: () => fetchCompliment("body_positivity"),
                  child: Text('Body Positive'),
                  style: ElevatedButton.styleFrom(
                    // primary: complimentType == "body_positivity" ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => fetchCompliment("comparison"),
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