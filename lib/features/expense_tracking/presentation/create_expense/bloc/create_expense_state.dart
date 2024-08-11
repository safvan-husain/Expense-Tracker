// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_expense_cubit.dart';

class CreateExpenseState {
  final List<ExpenseCategory> categories;
  final TextEditingController newCategoryController;
  final TextEditingController disciptionController;
  final TextEditingController moneyController;
  final bool isCreatingNewCategory;
  final DateTime? date;
  final ExpenseCategory? selectedCategory;
  //to determine whether creating or editing expense.
  final bool isEditting;

  CreateExpenseState({
    required this.isEditting,
    required this.moneyController,
    required this.categories,
    required this.newCategoryController,
    required this.disciptionController,
    required this.isCreatingNewCategory,
    this.selectedCategory,
    this.date,
  });

  factory CreateExpenseState.initial() {
    return CreateExpenseState(
      moneyController: TextEditingController(),
      isEditting: false,
      categories: [],
      newCategoryController: TextEditingController(),
      disciptionController: TextEditingController(),
      isCreatingNewCategory: false,
    );
  }

  CreateExpenseState copyWith({
    List<ExpenseCategory>? categories,
    TextEditingController? newCategoryController,
    TextEditingController? disciptionController,
    bool? isCreatingNewCategory,
    DateTime? date,
    ExpenseCategory? selectedCategory,
    bool? isEditting,
    TextEditingController? moneyController,
  }) {
    return CreateExpenseState(
      moneyController: moneyController ?? this.moneyController,
      isEditting: isEditting ?? this.isEditting,
      categories: categories ?? this.categories,
      newCategoryController:
          newCategoryController ?? this.newCategoryController,
      disciptionController: disciptionController ?? this.disciptionController,
      isCreatingNewCategory:
          isCreatingNewCategory ?? this.isCreatingNewCategory,
      date: date ?? this.date,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
