import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_link_recognizer/text_link_recognizer.dart';
import 'package:text_link_recognizer/utils/create_text_spans.dart';
import 'package:text_link_recognizer/utils/link_scanner.dart';

void main() {
  group('LinkScanner', () {
    test('findLinks should find all URLs in the text', () {
      final linkScanner = LinkScanner();
      const text = 'I am https://ttyyt.com in my https://foodknot.com';
      final links = linkScanner.findLinks(text);

      expect(links.length, 2);
      expect(links.elementAt(0).group(0), 'https://ttyyt.com');
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
      const text = 'I am https://ttyyt.com in my https://foodknot.com';
      final linkScanner = LinkScanner();
      final matches = linkScanner.findLinks(text);
      const textStyle = TextStyle(color: Colors.black);
      const linkStyle = TextStyle(color: Colors.red);

      final spans =
          createTextSpans.textSpans(matches, text, textStyle, linkStyle);

      expect(spans.length, 4);
      expect(spans[0].text, 'I am ');
      expect(spans[0].style, textStyle);
      expect(spans[1].text, 'https://ttyyt.com');
      expect(spans[1].style, linkStyle);
      expect(spans[2].text, ' in my ');
      expect(spans[2].style, textStyle);
      expect(spans[3].text, 'https://foodknot.com');
      expect(spans[3].style, linkStyle);
    });
  });

  group('TextLinkRecognizer', () {
    testWidgets('TextLinkRecognizer should display text with clickable links',
        (WidgetTester tester) async {
      const text = 'I am https://squairr.com in my https://foodknot.com';
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
      expect((textSpan.children?[0] as TextSpan).text, 'I am ');
      expect((textSpan.children?[1] as TextSpan).text, 'https://squairr.com');
      expect((textSpan.children?[2] as TextSpan).text, ' in my ');
      expect((textSpan.children?[3] as TextSpan).text, 'https://foodknot.com');
    });

    // testWidgets('Clickable link should launch URL',
    //     (WidgetTester tester) async {
    //   const text = 'I am https://squairr.com in my https://foodknot.com';
    //   const textStyle = TextStyle(color: Colors.black);
    //   const linkStyle = TextStyle(color: Colors.red);
    //   final Uri any = Uri.parse('https://foodknot.com');

    //   await tester.pumpWidget(const MaterialApp(
    //     home: Scaffold(
    //       body: TextLinkRecognizer(
    //         text: text,
    //         textStyle: textStyle,
    //         linkStyle: linkStyle,
    //       ),
    //     ),
    //   ));

    //   final richText = find.byType(RichText);
    //   expect(richText, findsOneWidget);

    //   final linkText = find.text('https://squairr.com');
    //   expect(linkText, findsOneWidget);

    //   // Use the mock to verify that the URL launcher is called with the correct URL
    //   when(launchUrl(any, mode: LaunchMode.inAppBrowserView))
    //       .thenAnswer((_) async => true);

    //   await tester.tap(linkText);
    //   verify(launchUrl(any, mode: LaunchMode.inAppBrowserView)).called(1);
    // });
  });
}
