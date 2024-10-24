// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart' as b;
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/summary_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expense_tracker/features/expense_tracking/domain/use_case/delete_expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/get_expense_history.dart';

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
          summaryBy: Summary.year,
          // isListScrollable: false,
          screenPosition: ScreenPosition.top,
          expenses: [],
          summary: [],
          isLoading: false,
        ));

  void changeLoadingState(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  ///there is another scroll -> listView, so this scroll applay at top only or when list view having NeverScrollPhysics.
  void handleScroll(bool isDown) async {
    //when scrolling down show top, else bottom.
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
    changeLoadingState(true);
    var result = await getAllExpenses.call(NoParams());
    result.fold(
      (l) {
        Get.snackbar("Failure", "failed to get data from database");
      },
      (r) {
        emit(state.copyWith(expenses: r));
        calculateSummary();
      },
    );
    changeLoadingState(false);
  }

  Future<void> deleteExpenseData(Expense expense) async {
    deleteExpense.call(DeleteExpenseParams(expense.id));

    emit(
      state.copyWith(
        expenses: state.expenses.where((e) => e.id != expense.id).toList()
      ),
    );
    calculateSummary();
  }

  ///replace any expense based on the id, if doesn't exist, change nothing.
  void replaceAExpense(Expense expense) {
    changeLoadingState(true);
    emit(state.copyWith(
        expenses: state.expenses.map((e) {
      if (e.id == expense.id) {
        return expense;
      } else {
        return e;
      }
    }).toList()));
    calculateSummary();
    changeLoadingState(false);
  }

  void changeSummaryDuration(Summary summaryDuration) {
    changeLoadingState(true);
    emit(state.copyWith(summaryBy: summaryDuration));
    calculateSummary();
    changeLoadingState(false);
  }

  void filterByDate(BuildContext context) async {
    var now = DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    if (date == null) {
      // changeLoadingState(false);/
      return;
    }
    changeLoadingState(true);
    var result = await getAllExpenses.call(NoParams());
    result.fold(
      (l) {
        Get.snackbar("Failure", "failed to get data from database");
      },
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
    changeLoadingState(false);
  }

  void calculateSummary() async {
    var result = await getAllExpenses.call(NoParams());
    result.fold(
      (l) {
        Get.snackbar("Failure", "failed to get data from database");
      },
      (expenses) {
        // storing money spend by category, using categryId as keys.
        Map<int, int> summaryByCategory = {};
        int totalMoneySpend = 0;
        for (var element
            in filterExpenseWithinDuration(expenses, state.summaryBy)) {
          //when category exist in summary, add amount to it.
          totalMoneySpend += element.money;
          if (summaryByCategory.containsKey(element.category.id)) {
            summaryByCategory[element.category.id] =
                summaryByCategory[element.category.id]! + element.money;
          } else {
            //when category not initated alredy, creating one.
            summaryByCategory
                .addEntries({element.category.id: element.money}.entries);
          }
        }
//turning it into percentage and list.
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
        if (summaryByCategoryPercentage.isEmpty) {
          Get.snackbar("No data", "found no data within this duration");
          //when no data found change back to year duration.
          emit(state.copyWith(summaryBy: Summary.year));
          return;
        }
        emit(state.copyWith(summary: summaryByCategoryPercentage));
      },
    );
  }
}

List<Expense> filterExpenseWithinDuration(
    List<Expense> expenses, Summary duration) {
  DateTime now = DateTime.now();

  return expenses.where((expense) {
    switch (duration) {
      case Summary.week:
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));
        return expense.date.isAfter(startOfWeek) &&
            expense.date.isBefore(endOfWeek);

      case Summary.month:
        DateTime startOfMonth = DateTime(now.year, now.month, 1);
        DateTime endOfMonth = DateTime(now.year, now.month + 1, 1)
            .subtract(const Duration(seconds: 1));
        return expense.date.isAfter(startOfMonth) &&
            expense.date.isBefore(endOfMonth);

      case Summary.year:
        DateTime startOfYear = DateTime(now.year, 1, 1);
        DateTime endOfYear =
            DateTime(now.year + 1, 1, 1).subtract(const Duration(seconds: 1));
        return expense.date.isAfter(startOfYear) &&
            expense.date.isBefore(endOfYear);

      default:
        return false;
    }
  }).toList();
}
