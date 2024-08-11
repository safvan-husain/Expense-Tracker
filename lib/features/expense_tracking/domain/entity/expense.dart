import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class Expense extends Equatable {
  final int id;
  final int money;
  final ExpenseCategory category;
  final String description;
  final DateTime date;
  const Expense({
    required this.id,
    required this.money,
    required this.category,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap();
}
