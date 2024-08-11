// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'expense_bloc.dart';

class ExpenseState {
  // final bool isListScrollable;
  final List<Expense> expenses;
  final ScreenPosition screenPosition;
  final List<SummaryItem> summary;
  final Summary summaryBy;
  const ExpenseState({
    required this.summaryBy,
    required this.summary,
    // required this.isListScrollable,
    required this.expenses,
    required this.screenPosition,
  });

  ExpenseState copyWith({
    // bool? isListScrollable,
    List<Expense>? expenses,
    ScreenPosition? screenPosition,
    List<SummaryItem>? summary,
    Summary? summaryBy,
  }) {
    if (expenses != null) {
      expenses.sort((a, b) => b.date.compareTo(a.date));
    }
    return ExpenseState(
      summaryBy: summaryBy ?? this.summaryBy,
      // isListScrollable: isListScrollable ?? this.isListScrollable,
      expenses: expenses ?? this.expenses,
      screenPosition: screenPosition ?? this.screenPosition,
      summary: summary ?? this.summary,
    );
  }
}
