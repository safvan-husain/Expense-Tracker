// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';

import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/repository/expense_repository_interface.dart';

class GetAllExpenses implements UseCase<List<Expense>, NoParams> {
  final ExpenseRepositoryInterface expenseRepository;
  GetAllExpenses({
    required this.expenseRepository,
  });
  @override
  Future<Either<Failure, List<Expense>>> call(NoParams params) async {
    return await expenseRepository.getAllExpenses();
  }
}
