import 'package:dartz/dartz.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';
// import 'package:flutter/foundation.dart';

abstract interface class ExpenseRepositoryInterface {
  Future<Either<Failure, List<Expense>>> getAllExpenses();
  Future<Either<Failure, List<ExpenseCategory>>> getAllCategory();
  Future<Either<Failure, Expense>> createNewExpense(Expense expense);
  Future<Either<Failure, void>> deleteExpense(int id);
  Future<Either<Failure, Expense>> editExpense(Expense expense);
  Future<Either<Failure, ExpenseCategory>> createNewCategory(
      ExpenseCategory category);
}
