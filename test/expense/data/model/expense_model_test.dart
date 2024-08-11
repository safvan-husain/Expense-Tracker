import 'dart:convert';

import 'package:expense_tracker/features/expense_tracking/data/models/expense_model.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixture_reader.dart';

void main() async {
  final ExpenseModel expense = ExpenseModel(
    category: "test",
    discription: "test",
    date: DateTime.now(),
  );

  test(
    "should be a subclass of Expense entity",
    () {
      expect(expense, isA<Expense>());
    },
  );

  test(
    "should return a valid Expense Model when the json is expense.json",
    () async {
      final Map<String, dynamic> jsonData =
          json.decode(fixture('expense.json'));
      final result = ExpenseModel.fromMap(jsonData);
      expect(expense, result);
    },
  );
}
