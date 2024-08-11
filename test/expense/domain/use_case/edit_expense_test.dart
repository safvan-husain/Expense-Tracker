import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/data/models/expense_model.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/edit_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'dependencies.mocks.dart';

void main() async {
  late UseCase useCase;
  late MockExpenseRepositoryInterface mockExpenseRepository;
  late Failure failure;

  setUp(() {
    mockExpenseRepository = MockExpenseRepositoryInterface();
    useCase = EditExpense(expenseRepository: mockExpenseRepository);
    failure = const Failure();
  });

  final ExpenseModel mockExpense =
      ExpenseModel(category: "test", discription: 'test', date: DateTime.now());

  group("edit expense", () {
    test(
      "should return Expense upon successful modification",
      () async {
        when(mockExpenseRepository.editExpense())
            .thenAnswer((_) async => Right(mockExpense));
        final result = await useCase.call(const EditExpenseParams(''));
        expect(result, Right(mockExpense));
        verify(mockExpenseRepository.editExpense());
        verifyNoMoreInteractions(mockExpenseRepository);
      },
    );

    test(
      "should return Failure upon unsuccessful modification",
      () async {
        when(mockExpenseRepository.editExpense())
            .thenAnswer((_) async => Left(failure));
        final result = await useCase.call(const EditExpenseParams(''));
        expect(result, Left(failure));
        verify(mockExpenseRepository.editExpense());
        verifyNoMoreInteractions(mockExpenseRepository);
      },
    );
  });
}
