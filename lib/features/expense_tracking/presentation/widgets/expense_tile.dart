import 'package:expense_tracker/core/utils/date_formatter.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/bloc/expense_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

enum TilePosition { left, center, right }

class ExpenseTile extends StatefulWidget {
  final int index;
  final ExpenseState state;
  const ExpenseTile({
    super.key,
    required this.index,
    required this.state,
  });

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  TilePosition position = TilePosition.center;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //if index 0 show date anyway otherwise compare with the previous to check both are on same day.
        if (widget.index == 0 ||
            !isSameDay(widget.state.expenses.elementAt(widget.index - 1).date,
                widget.state.expenses.elementAt(widget.index).date))
          Text(formatDate(
            widget.state.expenses.elementAt(widget.index).date,
            showDay: true,
          )),
        GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx > 0) {
              setState(() {
                if (position == TilePosition.center) {
                  position = TilePosition.left;
                } else {
                  position = TilePosition.center;
                }
              });
            } else if (details.velocity.pixelsPerSecond.dx < 0) {
              setState(() {
                if (position == TilePosition.center) {
                  position = TilePosition.right;
                } else {
                  position = TilePosition.center;
                }
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                // margin: const EdgeInsets.symmetric(vertical: 10),
                height: 60,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Get.theme.primaryColorDark,
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      left: switch (position) {
                        TilePosition.center => -80.w - 45,
                        TilePosition.left => 0,
                        TilePosition.right => -180.w,
                      },
                      child: Container(
                        color: Get.theme.primaryColorDark,
                        width: 280.w,
                        child: Row(
                          children: [
                            Container(
                              // color: Colors.red,
                              width: 90.w,
                              height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Do you want to modyfy this?",
                                    style: Get.textTheme.titleSmall,
                                  ),
                                  Row(
                                    children: [
                                      _buildButton(() {
                                        setState(() {
                                          position = TilePosition.center;
                                        });
                                      }, "No"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      _buildButton(() {
                                        CreateExpenseCubit.instance
                                            .showEditExpense(widget
                                                .state.expenses
                                                .elementAt(widget.index));
                                        setState(() {
                                          position = TilePosition.center;
                                        });
                                      }, "Edit"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 90.w,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: widget.state.expenses
                                            .elementAt(widget.index)
                                            .category
                                            .color,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        )),
                                    height: 60,
                                    width: 60,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "\$ ${widget.state.expenses.elementAt(widget.index).money}",
                                      style: Get.textTheme.titleSmall?.copyWith(
                                        color:
                                            Get.theme.scaffoldBackgroundColor,
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
                                      widget.state.expenses
                                          .elementAt(widget.index)
                                          .description,
                                      style: Get.textTheme.titleSmall,
                                      maxLines: 2,
                                    ),
                                  ),

                                  // const Spacer(),

                                  const SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              // color: Colors.yellow,
                              width: 90.w,
                              height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Do you want to delete this?",
                                    style: Get.textTheme.titleSmall,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildButton(() {
                                        setState(() {
                                          position = TilePosition.center;
                                        });
                                      }, "No"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      _buildButton(
                                        () {
                                          ExpenseCubit.instance
                                              .deleteExpenseData(widget
                                                  .state.expenses
                                                  .elementAt(widget.index));
                                          setState(() {
                                            position = TilePosition.center;
                                          });
                                        },
                                        "Delete",
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector _buildButton(void Function() onTap, String text) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          color: Get.theme.highlightColor.withOpacity(.8),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(text,
            style: Get.textTheme.titleMedium?.copyWith(
              color: Get.theme.scaffoldBackgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            )),
      ),
    );
  }
}
