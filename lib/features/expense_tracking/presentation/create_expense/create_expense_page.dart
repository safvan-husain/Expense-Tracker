import 'package:expense_tracker/core/utils/date_formatter.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CreateExpensePage extends StatelessWidget {
  const CreateExpensePage({super.key});

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
                      CreateExpenseCubit.instance.initialState();
                    },
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Add new expense",
                      style: Get.textTheme.titleMedium,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width: 80.w,
                height: 5.h,
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
                width: 80.w,
                label: state.date == null
                    ? "Pick a date"
                    : formatDate(state.date!),
                onTap: () {
                  CreateExpenseCubit.instance.showCalender(context);
                },
              ),
              LocalButton(
                width: 80.w,
                label: state.selectedCategory == null
                    ? "Select a category"
                    : state.selectedCategory!.title,
                onTap: () {
                  CreateExpenseCubit.instance.showCategories();
                  // Get.dialog(SelectCategoryBox());
                },
              ),
              Container(
                width: 80.w,
                height: 15.h,
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
                label: "Create",
                onTap: () {
                  CreateExpenseCubit.instance.createNewestExpense();
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
