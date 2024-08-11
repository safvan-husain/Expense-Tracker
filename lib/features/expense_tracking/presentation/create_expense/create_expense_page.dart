import 'package:expense_tracker/core/utils/date_formatter.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/widgets/category_tile.dart';
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

class SelectCategoryBox extends StatelessWidget {
  const SelectCategoryBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateExpenseCubit, CreateExpenseState>(
        builder: (context, state) {
      return AnimatedContainer(
        duration: const Duration(microseconds: 500),
        padding: EdgeInsets.symmetric(
          vertical: state.isCreatingNewCategory
              ? 35.h
              : state.categories.isEmpty
                  ? 35.h
                  : 25.h,
          horizontal: state.isCreatingNewCategory ? 10.w : 20.w,
        ),
        // height: 20.h,
        // width: state.isCreatingNewCategory ? 70.w : 50.w,
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              // margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Get.theme.primaryColorDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      Text(
                          "${state.isCreatingNewCategory ? "" : "Select or"} Create",
                          style: Get.textTheme.bodyLarge),
                      const Divider(),
                    ],
                  ),
                  if (!state.isCreatingNewCategory)
                    if (state.categories.isEmpty)
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "No category has been created yet",
                          style: Get.textTheme.bodyMedium,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      )
                    else
                      SizedBox(
                        height: 30.h,
                        width: 50.w,
                        child: ListView.builder(
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return CatergoryTile(
                              category: state.categories.elementAt(index),
                            );
                          },
                        ),
                      )
                  else
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Get.theme.highlightColor),
                      child: TextField(
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(color: Get.theme.canvasColor),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        controller: state.newCategoryController,
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: state.isCreatingNewCategory ? 10 : 0),
                    child: LocalButton(
                      contentAlignment: Alignment.center,
                      label: "Create new category",
                      onTap: () {
                        if (state.isCreatingNewCategory) {
                          CreateExpenseCubit.instance.createNewestCategory();
                        } else {
                          CreateExpenseCubit.instance.showCreateCategory();
                        }
                      },
                      width:
                          state.isCreatingNewCategory ? 60.w : double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class LocalButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final double? width;
  final Color? color;
  final Color? itemColor;
  final Alignment? contentAlignment;
  const LocalButton({
    super.key,
    this.color,
    this.itemColor,
    this.contentAlignment,
    required this.label,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        width: width ?? 60.w,
        height: 5.h,
        alignment: contentAlignment ?? Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: color ?? Get.theme.highlightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: Get.textTheme.bodyMedium
              ?.copyWith(color: itemColor ?? Get.theme.canvasColor),
        ),
      ),
    );
  }
}
