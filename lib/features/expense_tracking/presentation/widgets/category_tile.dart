import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CatergoryTile extends StatelessWidget {
  final ExpenseCategory category;
  final double? percentage;
  const CatergoryTile({
    super.key,
    required this.category,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CreateExpenseCubit.instance.selectCategory(category);
      },
      child: Container(
        width: 35.w,
        height: 30,
        decoration: BoxDecoration(
          // color: Colors.grey,
          color: Get.theme.scaffoldBackgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Get.theme.dividerColor),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          children: [
            if (percentage != null)
              Container(
                height: 30,
                width: 50,
                decoration: BoxDecoration(
                  color: category.color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${percentage?.toInt()} %",
                  style: Get.theme.textTheme.bodyMedium
                      ?.copyWith(color: Get.theme.scaffoldBackgroundColor),
                ),
              ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 17.w,
              child: Text(
                category.title,
                style: Get.theme.textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
