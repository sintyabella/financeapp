import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financeapp/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const FinanceMateApp());
    expect(find.text('Finance Mate'), findsOneWidget);
  });
}
