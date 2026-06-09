import 'package:abws_poc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Demo home shows schedule title, legend, and grid', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpAndSettle();

    expect(find.text('A Better Weekly Schedule'), findsOneWidget);
    expect(find.text('Step 3 of 5'), findsOneWidget);
    expect(find.text('Family Time'), findsWidgets);
    expect(find.text('Sun'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(find.byIcon(Icons.help_outline));
    await tester.pumpAndSettle();
    expect(find.text('How this works'), findsOneWidget);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();
    expect(find.text('Step 4 of 5'), findsOneWidget);
  });
}
