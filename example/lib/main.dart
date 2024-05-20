import 'package:flutter/material.dart';
import 'package:text_link_recognizer/text_link_recognizer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Text Link Recognizer Demo'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: TextLinkRecognizer(
              text: 'I am https://squairr.com in my https://foodknot.com',
              textStyle: TextStyle(color: Colors.black),
              linkStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ),
        ),
      ),
    );
  }
}
