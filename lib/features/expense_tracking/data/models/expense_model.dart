import 'dart:convert';

import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';

class ExpenseModel extends Expense {
  const ExpenseModel({
    required super.id,
    required super.money,
    required super.category,
    required super.description,
    required super.date,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      //when storing into db only need to refer the caregory id;
      'category': category.id,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'money': money
    };
  }

  factory ExpenseModel.fromMap(
      Map<String, dynamic> map, ExpenseCategory Function(int id) getCategory) {
    return ExpenseModel(
      id: map['id'],
      category: getCategory(map['category']),
      description: map['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      money: map['money'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  // factory ExpenseModel.fromJson(String source) =>
  //     ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Expense copyWith({
    int? id,
    ExpenseCategory? category,
    String? description,
    DateTime? date,
    int? money,
  }) {
    return ExpenseModel(
      money: money ?? this.money,
      id: id ?? this.id,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [category, id];
}
