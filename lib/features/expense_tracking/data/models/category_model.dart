import 'dart:convert';
import 'dart:ui';

import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';

class CategoryModel extends ExpenseCategory {
  const CategoryModel({
    required super.color,
    required super.title,
    required super.id,
  });

  CategoryModel copyWith({
    String? title,
    Color? color,
    int? id,
  }) {
    return CategoryModel(
      title: title ?? this.title,
      color: color ?? this.color,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'color': color.value,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      title: map['title'] as String,
      color: Color(map['color'] as int),
      id: map["id"] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  List<Object?> get props => [color, title];
}
