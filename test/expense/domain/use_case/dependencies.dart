// import 'package:expense_tracker/features/expense_tracking/data/repository/expense_repository.dart';

@GenerateNiceMocks([
  MockSpec<ExpenseRepositoryInterface>(),
  // MockSpec<Category>(),
  // MockSpec<Expense>()
])
@GenerateMocks([ExpenseCategory, Expense])

import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/repository/expense_repository_interface.dart';
// import 'package:flutter/foundation.dart';
import 'package:mockito/annotations.dart';
