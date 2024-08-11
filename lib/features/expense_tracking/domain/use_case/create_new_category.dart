import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/repository/expense_repository_interface.dart';

class CreateNewCategory extends UseCase<ExpenseCategory, NewCategoryParams> {
  final ExpenseRepositoryInterface expenseRepository;

  CreateNewCategory(this.expenseRepository);
  @override
  Future<Either<Failure, ExpenseCategory>> call(
      NewCategoryParams params) async {
    return await expenseRepository.createNewCategory(params.category);
  }
}

class NewCategoryParams {
  final ExpenseCategory category;
  const NewCategoryParams(this.category);
}
