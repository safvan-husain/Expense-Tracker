import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/create_new_category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'dependencies.mocks.dart';

void main() async {
  late UseCase useCase;
  late MockExpenseRepositoryInterface mockExpenseRepository;
  late Failure failure;

  group("create new category ", () {
    setUp(() {
      mockExpenseRepository = MockExpenseRepositoryInterface();
      useCase = CreateNewCategory(mockExpenseRepository);
      failure = const Failure();
    });

    ExpenseCategory category = MockExpenseCategory();

    test(
      "should return Category upon successful creation",
      () async {
        when(mockExpenseRepository.createNewCategory(any))
            .thenAnswer((_) async => Right(category));
        final result = await useCase.call(NewCategoryParams(category));
        expect(result, Right(category));
        verify(mockExpenseRepository.createNewCategory(category));
        verifyNoMoreInteractions(mockExpenseRepository);
      },
    );

    test(
      "should return failure upon Error",
      () async {
        when(mockExpenseRepository.deleteExpense(0))
            .thenAnswer((_) async => Left(failure));
        final result = await useCase.call(NewCategoryParams(category));
        expect(result, Left(failure));
        verify(mockExpenseRepository.deleteExpense(0));
        verifyNoMoreInteractions(mockExpenseRepository);
      },
    );
  });
}
