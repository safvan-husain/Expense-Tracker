import 'package:expense_tracker/core/utils/date_formatter.dart';
import 'package:expense_tracker/features/expense_tracking/data/models/expense_model.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/create_expense_page.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/bloc/expense_bloc.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditExpensePage extends StatelessWidget {
  final Expense expense;
  const EditExpensePage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: 100.w,
        child: BlocBuilder<CreateExpenseCubit, CreateExpenseState>(
            builder: (context, state) {
          return Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Modify expense",
                      style: Get.textTheme.titleMedium,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width: 60.w,
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 10),
                // alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Get.theme.highlightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: state.moneyController,
                  style: Get.textTheme.bodyMedium
                      ?.copyWith(color: Get.theme.canvasColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: Get.textTheme.bodyMedium
                        ?.copyWith(color: Get.theme.canvasColor),
                    hintText: "Specify the amount",
                  ),
                  minLines: 5,
                  maxLines: 6,
                ),
              ),
              LocalButton(
                label: state.date == null
                    ? "Pick a date"
                    : formatDate(state.date!),
                onTap: () {
                  CreateExpenseCubit.instance.showCalender(context);
                },
              ),
              LocalButton(
                label: state.selectedCategory == null
                    ? "Select a category"
                    : state.selectedCategory!.title,
                onTap: () {
                  CreateExpenseCubit.instance.showCategories();
                  // Get.dialog(SelectCategoryBox());
                },
              ),
              Container(
                width: 60.w,
                height: 20.h,
                margin: const EdgeInsets.symmetric(vertical: 10),
                // alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Get.theme.highlightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: state.disciptionController,
                  style: Get.textTheme.bodyMedium
                      ?.copyWith(color: Get.theme.canvasColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: Get.textTheme.bodyMedium
                        ?.copyWith(color: Get.theme.canvasColor),
                    hintText: "Discription",
                  ),
                  minLines: 5,
                  maxLines: 6,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              LocalButton(
                width: 30.w,
                color: Get.theme.primaryColor,
                contentAlignment: Alignment.center,
                itemColor: Get.theme.highlightColor,
                label: "Modify",
                onTap: () {
                  CreateExpenseCubit.instance.editExpenseData(ExpenseModel(
                    money: expense.money,
                    id: expense.id,
                    category: state.selectedCategory!,
                    description: state.disciptionController.text,
                    date: state.date!,
                  ));
                },
                // width: state.isCreatingNewCategory ? 60.w : double.infinity,/
              ),
            ],
          );
        }),
      )),
    );
  }
}
