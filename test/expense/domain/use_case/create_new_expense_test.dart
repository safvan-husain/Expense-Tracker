import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/create_new_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'dependencies.mocks.dart';

void main() async {
  late UseCase useCase;
  late MockExpenseRepositoryInterface mockExpenseRepository;

  setUp(() {
    mockExpenseRepository = MockExpenseRepositoryInterface();
    useCase = CreateNewExpense(expenseRepository: mockExpenseRepository);
  });

  final Expense mockExpense = MockExpense();

  test(
    "should return Expense upon successful creation",
    () async {
      when(mockExpenseRepository.createNewExpense(mockExpense))
          .thenAnswer((_) async => Right(mockExpense));
      final result = await useCase.call(NewExpenseParams(mockExpense));
      expect(result, Right(mockExpense));
      verify(mockExpenseRepository.createNewExpense(mockExpense));
      verifyNoMoreInteractions(mockExpenseRepository);
    },
  );
}
