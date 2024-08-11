// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class ExpenseCategory extends Equatable {
  final String title;
  final Color color;
  //will ignore this field by toMap method for storing to database"
  final int id;
  const ExpenseCategory({
    required this.id,
    required this.title,
    required this.color,
  });
}
