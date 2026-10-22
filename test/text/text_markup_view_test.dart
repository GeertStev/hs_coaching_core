import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/text/text_markup_view.dart';

void main() {
  testWidgets('toont regels, kolommen en een tabel zonder fouten', (
    tester,
  ) async {
    const style = TextStyle(fontSize: 16);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: TextMarkupView(
              '# Titel\nIntro\n{\nLinks\n\nmeer\n}\n{\n| A | B |\n|---|---|\n| 1 | 2 |\n}\n{\nRechts\n}',
              bodyStyle: style,
              heading1Style: style,
              heading2Style: style,
              lineColor: Colors.grey,
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.byType(Table), findsOneWidget);
    expect(find.byType(Expanded), findsNWidgets(3));
    expect(find.text('Rechts', findRichText: true), findsOneWidget);
  });
}
