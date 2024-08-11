import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/widgets/button.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              // margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey,
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
                          style: Get.textTheme.bodyLarge?.copyWith(
                            color: Get.theme.scaffoldBackgroundColor,
                          )),
                      const Divider(),
                    ],
                  ),
                  if (!state.isCreatingNewCategory)
                    if (state.categories.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(20),
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
                        color: Get.theme.highlightColor,
                      ),
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
                      itemColor: Get.theme.highlightColor,
                      color: Get.theme.primaryColor,
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
