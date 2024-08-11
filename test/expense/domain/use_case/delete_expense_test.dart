import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/delete_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'dependencies.mocks.dart';

void main() async {
  late UseCase useCase;
  late MockExpenseRepositoryInterface mockExpenseRepository;
  late Failure failure;

  group("delete expense", () {
    setUp(() {
      mockExpenseRepository = MockExpenseRepositoryInterface();
      useCase = DeleteExpense(expenseRepository: mockExpenseRepository);
    });

    test(
      "should return true upon successful deletion",
      () async {
        when(mockExpenseRepository.deleteExpense())
            .thenAnswer((_) async => const Right(true));
        final result = await useCase.call(const DeleteExpenseParams('test'));
        expect(result, const Right(true));
        verify(mockExpenseRepository.deleteExpense());
        verifyNoMoreInteractions(mockExpenseRepository);
      },
    );

    test(
      "should return false upon unsuccessful deletion",
      () async {
        when(mockExpenseRepository.deleteExpense())
            .thenAnswer((_) async => const Right(false));
        final result = await useCase.call(const DeleteExpenseParams('test'));
        expect(result, const Right(false));
        verify(mockExpenseRepository.deleteExpense());
        verifyNoMoreInteractions(mockExpenseRepository);
      },
    );

    setUp(() => {failure = const Failure()});
    test(
      "should return failure upon Error",
      () async {
        when(mockExpenseRepository.deleteExpense())
            .thenAnswer((_) async => Left(failure));
        final result = await useCase.call(const DeleteExpenseParams('test'));
        expect(result, Left(failure));
        verify(mockExpenseRepository.deleteExpense());
        verifyNoMoreInteractions(mockExpenseRepository);
      },
    );
  });
}
