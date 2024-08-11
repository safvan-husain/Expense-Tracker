import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/data/data_source/expense_data_source.dart';
import 'package:expense_tracker/features/expense_tracking/data/models/category_model.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/get_expense_history.dart';

class ExpenseLocalDataSource implements ExpenseDataSource {
  final DatabaseHelper databaseHelper;

  // final GetAllExpenses _getAllExpenses;

  ExpenseLocalDataSource(this.databaseHelper);

  @override
  Future<Either<Failure, List<Expense>>> getAllExpenses() async {
    try {
      return Right(await databaseHelper.getAllExpenses());
    } catch (e) {
      print(e);
      return const Left(Failure(message: ""));
    }
  }

  Future<Either<Failure, List<ExpenseCategory>>> getAllCategory() async {
    try {
      return Right(await databaseHelper.getAllCategory());
    } catch (e) {
      print(e);
      return const Left(Failure(message: ""));
    }
  }

  @override
  Future<Either<Failure, Expense>> insetExpense(Expense expense) async {
    try {
      return Right(await databaseHelper.insertExpense(expense));
    } catch (e) {
      print(e);
      return Left(Failure());
    }
  }

  Future<Either<Failure, ExpenseCategory>> insertCategory(
      CategoryModel category) async {
    try {
      return Right(await databaseHelper.insertCategory(category));
    } catch (e) {
      print(e);
      return Left(Failure());
    }
  }

  Future<Either<Failure, void>> deleteExpense(int expenseId) async {
    try {
      return Right(await databaseHelper.deleteExpense(expenseId));
    } catch (e) {
      print(e);
      return Left(Failure());
    }
  }

  Future<Either<Failure, Expense>> editExpence(Expense expense) async {
    try {
      return Right(await databaseHelper.editExpenseData(expense));
    } catch (e) {
      print(e);
      return Left(Failure());
    }
  }
}
