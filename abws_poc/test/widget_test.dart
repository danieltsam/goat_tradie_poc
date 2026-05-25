import 'package:abws_poc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Tablet layout shows sidebar add form', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpAndSettle();

    expect(find.text('A Better Weekly Structure'), findsOneWidget);
    expect(find.text('Add to Schedule +'), findsOneWidget);
    expect(find.text('Mon'), findsOneWidget);
  });

  testWidgets('Phone layout shows FAB instead of sidebar form', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('Add to Schedule +'), findsNothing);
  });
}
