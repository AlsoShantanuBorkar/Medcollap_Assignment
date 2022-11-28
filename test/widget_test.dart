// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:medicollap_assignment/main.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  setUp((() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);
    await Hive.openBox('COUNTRY_BOX');
  }));
  testWidgets('Find Text Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    Finder text = find.byType(Text);
    expect(text, findsAtLeastNWidgets(1));
  });
  testWidgets('Find Scaffold Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    Finder scaffold = find.byType(Scaffold);
    expect(scaffold, findsAtLeastNWidgets(1));
  });

  testWidgets('Find Button Text Widget', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 5));

    Finder buttonText = find.text('Get Current Location');
    expect(buttonText, findsOneWidget);
  });
}
