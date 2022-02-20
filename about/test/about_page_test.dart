import 'package:about/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Page should display text and image',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AboutPage(),
    ));

    final textFinder = find.byType(Text);
    final imageFinder = find.byType(Image);

    expect(textFinder, findsOneWidget);
    expect(imageFinder, findsOneWidget);
  });
}
