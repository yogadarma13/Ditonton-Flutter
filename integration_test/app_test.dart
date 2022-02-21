import 'package:about/about.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:ditonton/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('open about page', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final menuIcon = find.byKey(Key("menu_button"));
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    expect(find.text('About'), findsOneWidget);
    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();

    final textAbout =
        'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.';

    expect(find.byType(AboutPage), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text(textAbout), findsOneWidget);

    final backButton = find.byKey(Key('back_button_about'));
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });
}
