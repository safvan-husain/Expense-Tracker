// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:bloc/bloc.dart' as b;
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/core/utils/random_color.dart';
import 'package:expense_tracker/features/expense_tracking/data/models/category_model.dart';
import 'package:expense_tracker/features/expense_tracking/data/models/expense_model.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/get_all_category.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/widgets/select_category_box.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/bloc/expense_bloc.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/edit_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expense_tracker/features/expense_tracking/domain/use_case/create_new_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/create_new_expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/edit_expense.dart';

part 'create_expense_state.dart';

class CreateExpenseCubit extends b.Cubit<CreateExpenseState> {
  final CreateNewCategory createNewCategory;
  final CreateNewExpense createNewExpense;
  final GetAllCategory getAllCategory;
  final EditExpense editExpense;

  static CreateExpenseCubit get instance => Get.find<CreateExpenseCubit>();
  CreateExpenseCubit({
    required this.createNewCategory,
    required this.createNewExpense,
    required this.getAllCategory,
    required this.editExpense,
  }) : super(CreateExpenseState.initial());

  void showCreateCategory() {
    emit(state.copyWith(isCreatingNewCategory: true));
  }

  void initialState() {
    emit(CreateExpenseState.initial());
  }

  void createNewestCategory() async {
    if (state.categories.length > 5) {
      Get.snackbar("Limit reached", "cannot create more that 6 category");
      return;
    }
    Get.back();
    if (state.newCategoryController.text.isEmpty) {
      Get.snackbar("Field missing", "Select a category");
      return;
    }
    ExpenseCubit.instance.changeLoadingState(true);
    var result = await createNewCategory.call(
      NewCategoryParams(
        CategoryModel(
            title: state.newCategoryController.text,
            color: getRandomColor(),
            //will ignore this field by toMap method for storing to database"
            id: 0),
      ),
    );
    result.fold(
      (failure) {
        //todo
      },
      (category) {
        emit(state.copyWith(
          categories: [...state.categories, category],
          selectedCategory: category,
          newCategoryController: TextEditingController(),
        ));
      },
    );
    ExpenseCubit.instance.changeLoadingState(false);
  }

  void showCalender(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    emit(state.copyWith(date: date));
  }

  void createNewestExpense() async {
    if (state.selectedCategory == null) {
      Get.snackbar("Field missing", "Select a category");
      return;
    }
    if (state.date == null) {
      Get.snackbar("Field missing", "Pick a date");
      return;
    }
    if (state.disciptionController.text.isEmpty) {
      Get.snackbar("Field missing", "Provide a discription");
      return;
    }
    if (state.moneyController.text.isEmpty) {
      Get.snackbar("Field missing", "Specify the amount");
      return;
    }
    ExpenseCubit.instance.changeLoadingState(true);
    var result = await createNewExpense.call(
      NewExpenseParams(
        ExpenseModel(
            category: state.selectedCategory!,
            description: state.disciptionController.text,
            date: state.date!,
            money: int.parse(state.moneyController.text),
            //will ignore this field by toMap method for storing to database"
            id: 0),
      ),
    );

    result.fold(
      (l) {},
      (newExpense) {
        ExpenseCubit.instance.loadExpenseHistory();
        emit(CreateExpenseState.initial()
            .copyWith(categories: state.categories));
        Get.back();
      },
    );
    ExpenseCubit.instance.changeLoadingState(false);
  }

  //For debug purpose.
  void createRandomExpense() async {
    ExpenseCubit.instance.changeLoadingState(true);
    var now = DateTime.now();

    if (state.categories.isEmpty) {
      await showCategories(showDialogue: false);
    }
    if(state.categories.isEmpty) {
      Get.snackbar("No catergeries", "Error");
      return;
    }

    var result = await createNewExpense.call(
      NewExpenseParams(
        ExpenseModel(
            category: state.categories.elementAt(Random().nextInt(state.categories.length)),
            description: "my desc",
            date: now.copyWith(day: Random().nextInt(now.day)),
            money: 299,
            //will ignore this field by toMap method for storing to database"
            id: 0),
      ),
    );

    result.fold(
          (l) {},
          (newExpense) {
        ExpenseCubit.instance.loadExpenseHistory();
        emit(CreateExpenseState.initial()
            .copyWith(categories: state.categories));
        Get.back();
      },
    );
    ExpenseCubit.instance.changeLoadingState(false);
  }

  void selectCategory(ExpenseCategory category) {
    emit(state.copyWith(selectedCategory: category));
    Get.back();
  }

  Future<void> showCategories({bool showDialogue = true}) async {
    var result = await getAllCategory.call(NoParams());
    result.fold(
      (l) {},
      (r) {
        emit(state.copyWith(categories: r));
      },
    );
    if(showDialogue) {
    Get.dialog(
      const SelectCategoryBox(),
      barrierColor: Colors.black,
    );
    }
  }

  void showEditExpense(Expense expense) {
    emit(
      state.copyWith(
        selectedCategory: expense.category,
        disciptionController: TextEditingController(text: expense.description),
        newCategoryController: TextEditingController(),
        moneyController: TextEditingController(text: expense.money.toString()),
        date: expense.date,
      ),
    );
    Get.to(
      () => EditExpensePage(expense: expense),
      transition: Transition.downToUp,
    );
  }

  void editExpenseData(Expense expense) async {
    ExpenseCubit.instance.changeLoadingState(true);
    var result = await editExpense.call(EditExpenseParams(expense));
    result.fold(
      (l) {},
      (r) {
        emit(CreateExpenseState.initial()
            .copyWith(categories: state.categories));
        ExpenseCubit.instance.replaceAExpense(r);
      },
    );
    // clearing input.
    initialState();

    ExpenseCubit.instance.calculateSummary();
    ExpenseCubit.instance.changeLoadingState(false);
    Get.back();
  }
}
