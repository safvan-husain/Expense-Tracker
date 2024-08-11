import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/data/data_source/expense_local_data_source.dart';
import 'package:expense_tracker/features/expense_tracking/data/models/category_model.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/repository/expense_repository_interface.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/get_expense_history.dart';
// import 'package:flutter/src/foundation/annotations.dart';

final class ExpenseRepository implements ExpenseRepositoryInterface {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepository(this.localDataSource);

  @override
  Future<Either<Failure, List<Expense>>> getAllExpenses() async {
    return await localDataSource.getAllExpenses();
  }

  @override
  Future<Either<Failure, ExpenseCategory>> createNewCategory(
    ExpenseCategory category,
  ) async {
    return await localDataSource.insertCategory(CategoryModel(
      color: category.color,
      title: category.title,
      //will ignore id field by toMap method for storing to database"
      id: 0,
    ));
  }

  @override
  Future<Either<Failure, Expense>> createNewExpense(Expense expense) async {
    return await localDataSource.insetExpense(expense);
  }

  @override
  Future<Either<Failure, void>> deleteExpense(int id) async {
    return await localDataSource.deleteExpense(id);
  }

  @override
  Future<Either<Failure, Expense>> editExpense(Expense expense) async {
    return await localDataSource.editExpence(expense);
  }

  @override
  Future<Either<Failure, List<ExpenseCategory>>> getAllCategory() async {
    return await localDataSource.getAllCategory();
  }
}
