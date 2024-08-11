// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';

class SummaryItem {
  final ExpenseCategory category;
  final double percentage;
  SummaryItem({
    required this.category,
    required this.percentage,
  });
}
