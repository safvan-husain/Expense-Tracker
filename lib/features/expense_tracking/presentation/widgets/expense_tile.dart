import 'package:expense_tracker/core/utils/date_formatter.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ExpenseTile extends StatelessWidget {
  final int index;
  final ExpenseState state;
  const ExpenseTile({
    super.key,
    required this.index,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //if index 0 show date anyway otherwise compare with the previous to check both are on same day.
        if (index == 0 ||
            !isSameDay(state.expenses.elementAt(index - 1).date,
                state.expenses.elementAt(index).date))
          Text(formatDate(
            state.expenses.elementAt(index).date,
            showDay: true,
          )),
        Container(
          margin: const EdgeInsets.all(10),
          height: 60,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Get.theme.primaryColorDark,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: state.expenses.elementAt(index).category.color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    )),
                height: 60,
                width: 60,
                alignment: Alignment.center,
                child: Text(
                  "\$ ${state.expenses.elementAt(index).money}",
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: Get.theme.scaffoldBackgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 50.w,
                child: Text(
                  state.expenses.elementAt(index).description,
                  style: Get.textTheme.bodyMedium,
                  maxLines: 2,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        CreateExpenseCubit.instance
                            .showEditExpense(state.expenses.elementAt(index));
                      },
                      child: const Icon(Icons.edit)),
                  GestureDetector(
                      onTap: () {
                        ExpenseCubit.instance
                            .deleteExpenseData(state.expenses.elementAt(index));
                      },
                      child: const Icon(Icons.delete)),
                ],
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}
