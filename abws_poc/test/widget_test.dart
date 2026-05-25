import 'package:abws_poc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Schedule home shows title, step, and week grid', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpAndSettle();

    expect(find.text('A Better Weekly Schedule'), findsOneWidget);
    expect(find.text('Step 3 of 5'), findsOneWidget);
    expect(find.text('Sun'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
