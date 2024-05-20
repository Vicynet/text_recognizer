# Package Name

TextLinkRecognizer

## Description

This package recognizes URLs in a String of text (E.g imagine you are working on a chat app, and links will be part of the chat). Allos you to apply custom styling to both the ordinary texts and link texts, and handles click events to open the URLs in a web browser.

## Features

- Recognizes URLs in text strings
- Allows custom styling for regular text and links
- Handles click events to open URLs in a web browser

## Getting started

To use this package, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  your_package_name: ^0.0.1
```

## Usage

```
import 'package:flutter/material.dart';
import 'package:your_package_name/your_package_name.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text Link Recognizer Demo'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: TextLinkRecognizer(
              text: 'I use https://squairr.com for global issues and https://foodknot.com for my meals',
              textStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

```

## Additional information

# Contributing

If you find any issues with the package or would like to contribute, please feel free to open an issue or submit a pull request on [GitHub](https://github.com/Vicynet/text_recognizer).


