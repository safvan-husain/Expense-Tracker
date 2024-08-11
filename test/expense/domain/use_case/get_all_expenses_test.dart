import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failures/expense_failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/data/models/category_model.dart';
import 'package:expense_tracker/features/expense_tracking/data/models/expense_model.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/get_expense_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'dependencies.mocks.dart';

void main() async {
  late UseCase useCase;
  late MockExpenseRepositoryInterface mockExpenseRepository;
  late Failure failure;

  setUp(() {
    mockExpenseRepository = MockExpenseRepositoryInterface();
    useCase = GetAllExpenses(expenseRepository: mockExpenseRepository);
    failure = const Failure();
  });

  final List<ExpenseModel> mockExpenses = [
    ExpenseModel(
      category: const CategoryModel(
        color: Colors.red,
        title: 'test',
        id: 0,
      ),
      description: 'test',
      date: DateTime.now(),
      id: 0,
      money: 0,
    )
  ];

  group("get history of expenses", () {
    test(
      "should get all the expense from the repository",
      () async {
        when(mockExpenseRepository.getAllExpenses())
            .thenAnswer((_) async => Right(mockExpenses));
        final result = await useCase.call(NoParams());
        expect(result, Right(mockExpenses));
        verify(mockExpenseRepository.getAllExpenses());
        verifyNoMoreInteractions(mockExpenseRepository);
      },
    );

    test(
      "should return failure upon failed fetching",
      () async {
        when(mockExpenseRepository.getAllExpenses())
            .thenAnswer((_) async => Left(failure));
        final result = await useCase.call(NoParams());
        expect(result, Left(failure));
        verify(mockExpenseRepository.getAllExpenses());
        verifyNoMoreInteractions(mockExpenseRepository);
      },
    );
  });
}
