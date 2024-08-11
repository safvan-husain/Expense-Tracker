import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';

abstract class ExpenseDataSource {
  Future<Either<Failure, List<Expense>>> getAllExpenses();
  Future<Either<Failure, Expense>> insetExpense(Expense expense);
}
