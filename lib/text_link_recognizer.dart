library text_link_recognizer;

import 'package:flutter/material.dart';
import 'package:text_link_recognizer/utils/create_text_spans.dart';
import 'package:text_link_recognizer/utils/link_scanner.dart';

class TextLinkRecognizer extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;

  const TextLinkRecognizer({
    super.key,
    required this.text,
    this.textStyle,
    this.linkStyle,
  });

  @override
  Widget build(BuildContext context) {
    Iterable<RegExpMatch> matches = LinkScanner().findLinks(text);
    var spans =
        CreateTextSpans().textSpans(matches, text, textStyle, linkStyle);

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
