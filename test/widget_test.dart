// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:gmgn_clone/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for app to initialize
    await tester.pumpAndSettle();

    // Verify that the app loads with bottom navigation
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Track'), findsOneWidget);
    expect(find.text('Trade'), findsOneWidget);
    expect(find.text('Monitor'), findsOneWidget);
    expect(find.text('Assets'), findsOneWidget);
  });
}
