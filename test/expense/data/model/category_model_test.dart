import 'dart:convert';

import 'package:expense_tracker/features/expense_tracking/data/models/category_model.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixture_reader.dart';

void main() async {
  ExpenseCategory category =
      const CategoryModel(color: Colors.red, title: 'test', id: 0);

  test(
    "should be a subclass of Expense entity",
    () {
      expect(category, isA<ExpenseCategory>());
    },
  );

  test(
    "should return a valid Category Model when the json is category.json",
    () async {
      final Map<String, dynamic> jsonData =
          json.decode(fixture('category.json'));
      final result = CategoryModel.fromMap(jsonData);
      expect(result, isA<CategoryModel>());
    },
  );
}
