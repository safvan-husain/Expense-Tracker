// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:bloc/bloc.dart' as b;
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/data/models/category_model.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/summary_item.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/edit_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expense_tracker/features/expense_tracking/domain/use_case/delete_expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/edit_expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/get_expense_history.dart';

part 'expense_event.dart';
part 'expense_state.dart';

enum ScreenPosition { top, bottom }

enum Summary { week, month, year }

class ExpenseCubit extends b.Cubit<ExpenseState> {
  final DeleteExpense deleteExpense;
  final GetAllExpenses getAllExpenses;
  static ExpenseCubit get instance => Get.find<ExpenseCubit>();
  ExpenseCubit({
    required this.deleteExpense,
    required this.getAllExpenses,
  }) : super(const ExpenseState(
          summaryBy: Summary.week,
          isListScrollable: false,
          screenPosition: ScreenPosition.top,
          expenses: [],
          summary: [],
        ));

  void handleTopScroll(bool isDown) async {
    await Future.delayed(Duration(microseconds: 500));
    if (isDown) {
      if (state.screenPosition == ScreenPosition.bottom) {
        emit(state.copyWith(screenPosition: ScreenPosition.top));
      }
    } else {
      if (state.screenPosition == ScreenPosition.top) {
        emit(state.copyWith(screenPosition: ScreenPosition.bottom));
      }
    }
  }

  void loadExpenseHistory() async {
    var result = await getAllExpenses.call(NoParams());
    result.fold(
      (l) {},
      (r) {
        print("loaded expenses ${r}");
        emit(state.copyWith(expenses: r));
        calculateSummary();
      },
    );
  }

  void deleteExpenseData(Expense expense) async {
    await deleteExpense.call(DeleteExpenseParams(expense.id));
    emit(
      state.copyWith(
        expenses: state.expenses
            .where((element) => element.id != expense.id)
            .toList(),
      ),
    );
    calculateSummary();
  }

  void addExpenseToHistory(Expense expense) {
    // emit(state.copyWith(expenses: [expense, ...state.expenses]));

    calculateSummary();
  }

  void replaceAExpense(Expense expense) {
    emit(state.copyWith(
        expenses: state.expenses.map((e) {
      if (e.id == expense.id) {
        return expense;
      } else {
        return e;
      }
    }).toList()));
    calculateSummary();
  }

  void changeSummaryDuration(Summary summaryDuration) {
    emit(state.copyWith(summaryBy: summaryDuration));
    calculateSummary();
  }

  void filterByDate(BuildContext context) async {
    var now = DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    if (date == null) return;
    var result = await getAllExpenses.call(NoParams());
    result.fold(
      (l) {},
      (r) {
        var filtered = r
            .where((element) =>
                element.date.isBefore(date) ||
                element.date.isAtSameMomentAs(date))
            .toList();
        filtered.sort((a, b) => b.date.compareTo(a.date));

        emit(state.copyWith(expenses: filtered));
      },
    );
  }

  void calculateSummary() async {
    var result = await getAllExpenses.call(NoParams());
    result.fold(
      (l) {},
      (expenses) {
        Map<int, int> summaryByCategory = {};
        int totalMoneySpend = 0;
        for (var element in filterDates(expenses, state.summaryBy)) {
          totalMoneySpend += element.money;
          if (summaryByCategory.containsKey(element.category.id)) {
            summaryByCategory[element.category.id] =
                summaryByCategory[element.category.id]! + element.money;
          } else {
            summaryByCategory
                .addEntries({element.category.id: element.money}.entries);
            // summaryByCategory[element.category] = element.money;s
          }
        }

        List<SummaryItem> summaryByCategoryPercentage =
            summaryByCategory.entries.map((e) {
          ExpenseCategory cat = expenses
              .where((element) => element.category.id == e.key)
              .toList()
              .first
              .category;
          return SummaryItem(
              category: cat, percentage: (e.value / totalMoneySpend) * 100);
        }).toList();

        emit(state.copyWith(summary: summaryByCategoryPercentage));
      },
    );
  }
}

List<Expense> filterDates(List<Expense> expenses, Summary duration) {
  DateTime now = DateTime.now();

  return expenses.where((expense) {
    switch (duration) {
      case Summary.week:
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 7));
        return expense.date.isAfter(startOfWeek) &&
            expense.date.isBefore(endOfWeek);

      case Summary.month:
        DateTime startOfMonth = DateTime(now.year, now.month, 1);
        DateTime endOfMonth =
            DateTime(now.year, now.month + 1, 1).subtract(Duration(seconds: 1));
        return expense.date.isAfter(startOfMonth) &&
            expense.date.isBefore(endOfMonth);

      case Summary.year:
        DateTime startOfYear = DateTime(now.year, 1, 1);
        DateTime endOfYear =
            DateTime(now.year + 1, 1, 1).subtract(Duration(seconds: 1));
        return expense.date.isAfter(startOfYear) &&
            expense.date.isBefore(endOfYear);

      default:
        return false;
    }
  }).toList();
}
