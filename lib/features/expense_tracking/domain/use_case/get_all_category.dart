// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';

import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/repository/expense_repository_interface.dart';

class GetAllCategory implements UseCase<List<ExpenseCategory>, NoParams> {
  final ExpenseRepositoryInterface expenseRepository;
  GetAllCategory({
    required this.expenseRepository,
  });
  @override
  Future<Either<Failure, List<ExpenseCategory>>> call(NoParams params) async {
    return await expenseRepository.getAllCategory();
  }
}
