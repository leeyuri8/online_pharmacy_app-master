// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  // testWidgets('Add new medicine', (tester) async {
  //   await tester.runAsync(() async {
  //     final file = File('strepsils.png');
  //     Future future = addMedicine(
  //             file,
  //             'Akamol',
  //             '20',
  //             '1',
  //             'easy',
  //             'Please follow the instructions included in the product packaging',
  //             '4',
  //             'medications',
  //             '')
  //         .then((value) async {
  //       expect(Future.value, completion(equals(true)));
  //     });
  //     expect(Future.value(true), completion(equals(true)));
  //     // expect(future, completes);
  //   });
  // });

  test('Failed Add new medicine', () {
    final file = File('test/test_resources/random_user.json');
    var result = addMedicine(
        file,
        'Akamol',
        '20',
        '1',
        'easy',
        'Please follow the instructions included in the product packaging',
        '4',
        'medications',
        '');
    expect(result, false);
  });
}
