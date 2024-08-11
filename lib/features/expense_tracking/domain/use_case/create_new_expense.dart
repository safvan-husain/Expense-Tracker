// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/repository/expense_repository_interface.dart';

class CreateNewExpense extends UseCase<Expense, NewExpenseParams> {
  final ExpenseRepositoryInterface expenseRepository;
  CreateNewExpense({
    required this.expenseRepository,
  });

  @override
  Future<Either<Failure, Expense>> call(NewExpenseParams params) async {
    return await expenseRepository.createNewExpense(params.expense);
  }
}

class NewExpenseParams {
  final Expense expense;
  const NewExpenseParams(this.expense);
}
