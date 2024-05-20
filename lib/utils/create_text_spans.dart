import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateTextSpans {
  final List<TextSpan> spans = [];
  int start = 0;

  List<TextSpan> textSpans(Iterable<RegExpMatch> matches, String text, TextStyle? textStyle, TextStyle? linkStyle) {
     for (final RegExpMatch match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: textStyle ?? const TextStyle(color: Colors.black),
        ));
      }
      final String url = match.group(0)!;
      final Uri uri = Uri.parse(url);

      spans.add(
        TextSpan(
          text: url,
          style: linkStyle ?? const TextStyle(color: Colors.red),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
                throw Exception('Could not launch $url');
              }
            },
        ),
      );
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: textStyle,
      ));
    }
    return spans;
  }
}
