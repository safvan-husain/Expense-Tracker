// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:expense_tracker/core/failures/expense_failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/domain/repository/expense_repository_interface.dart';

class DeleteExpense extends UseCase<void, DeleteExpenseParams> {
  final ExpenseRepositoryInterface expenseRepository;
  DeleteExpense({
    required this.expenseRepository,
  });

  @override
  Future<Either<Failure, void>> call(DeleteExpenseParams params) async {
    return await expenseRepository.deleteExpense(params.dataId);
  }
}

class DeleteExpenseParams {
  final int dataId;
  const DeleteExpenseParams(this.dataId);
}
