import 'dart:io';

import 'package:drug_delivery_application/backend/firebase.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class AddnewMedicine {
  Future? addNew() {
    final file = File('strepsils.png');
    Future.delayed(
        const Duration(seconds: 1),
        () => addMedicine(
            file,
            'Akamol',
            '20',
            '1',
            'easy',
            'Please follow the instructions included in the product packaging',
            '4',
            'medications',
            ''));
  }
}


void main() {
  test('Add new medicine', () {
    final file = File('test/test_resources/random_user.json');
    var result = addMedicine(
        file,
        'Akamol',
        '20',
        '1',
        'easy',
        'Please follow the instructions included in the product packaging',
        '4',
        'medications','');
    expect(result, 'added succesfully');
  });

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
        'medications','');
    expect(result, 'Failed');
  });
}
