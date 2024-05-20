import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_link_recognizer/text_link_recognizer.dart';
import 'package:text_link_recognizer/utils/create_text_spans.dart';
import 'package:text_link_recognizer/utils/link_scanner.dart';

void main() {
  group('LinkScanner', () {
    test('findLinks should find all URLs in the text', () {
      final linkScanner = LinkScanner();
      const text = 'I lend my voice with https://squairr.com and get my meals from https://foodknot.com';
      final links = linkScanner.findLinks(text);

      expect(links.length, 2);
      expect(links.elementAt(0).group(0), 'https://squairr.com');
      expect(links.elementAt(1).group(0), 'https://foodknot.com');
    });

    test('findLinks should return empty iterable if no URLs are found', () {
      final linkScanner = LinkScanner();
      const text = 'This text has no URLs';
      final links = linkScanner.findLinks(text);

      expect(links.isEmpty, true);
    });
  });

  group('CreateTextSpans', () {
    test('textSpans should create TextSpans with links and text', () {
      final createTextSpans = CreateTextSpans();
      const text = 'I lend my voice with https://squairr.com and get my meals from https://foodknot.com';
      final linkScanner = LinkScanner();
      final matches = linkScanner.findLinks(text);
      const textStyle = TextStyle(color: Colors.black);
      const linkStyle = TextStyle(color: Colors.red);

      final spans =
          createTextSpans.textSpans(matches, text, textStyle, linkStyle);

      expect(spans.length, 4);
      expect(spans[0].text, 'I lend my voice with ');
      expect(spans[0].style, textStyle);
      expect(spans[1].text, 'https://squairr.com');
      expect(spans[1].style, linkStyle);
      expect(spans[2].text, ' and get my meals from ');
      expect(spans[2].style, textStyle);
      expect(spans[3].text, 'https://foodknot.com');
      expect(spans[3].style, linkStyle);
    });
  });

  group('TextLinkRecognizer', () {
    testWidgets('TextLinkRecognizer should display text with clickable links',
        (WidgetTester tester) async {
      const text = 'I lend my voice with https://squairr.com and get my meals from https://foodknot.com';
      const textStyle = TextStyle(color: Colors.black);
      const linkStyle = TextStyle(color: Colors.red);

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: TextLinkRecognizer(
            text: text,
            textStyle: textStyle,
            linkStyle: linkStyle,
          ),
        ),
      ));

      final richText = find.byType(RichText);
      expect(richText, findsOneWidget);

      final richTextWidget = tester.widget<RichText>(richText);
      final textSpan = richTextWidget.text as TextSpan;

      expect(textSpan.children?.length, 4);
      expect((textSpan.children?[0] as TextSpan).text, 'I lend my voice with ');
      expect((textSpan.children?[1] as TextSpan).text, 'https://squairr.com');
      expect((textSpan.children?[2] as TextSpan).text, ' and get my meals from ');
      expect((textSpan.children?[3] as TextSpan).text, 'https://foodknot.com');
    });
  });
}
