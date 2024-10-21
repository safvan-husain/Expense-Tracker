import 'package:expense_tracker/core/utils/date_formatter.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/bloc/expense_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entity/expense.dart';

enum TilePosition { left, center, right }

class ExpenseTile extends StatefulWidget {
  final Expense expenseData;
  final String? day;
  const ExpenseTile({
    super.key,
    required this.expenseData,
    this.day
  });

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  TilePosition position = TilePosition.center;
  bool isDeletedClicked = false;
  var deleteDuration = const Duration(milliseconds: 50);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //if index 0 show date anyway otherwise compare with the previous to check both are on same day.
        if (widget.day != null)
          Text(widget.day!),
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
              child: AnimatedContainer(
                duration: deleteDuration,
                // margin: const EdgeInsets.symmetric(vertical: 10),
                height: isDeletedClicked ? 0 : 60,
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
                              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      _buildButton(() {
                                        CreateExpenseCubit.instance
                                            .showEditExpense(widget.expenseData);
                                        setState(() {
                                          position = TilePosition.center;
                                        });
                                      }, "Edit"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 90.w,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: widget.expenseData
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
                                      "\$ ${widget.expenseData.money}",
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
                                      widget.expenseData
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
                              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                          setState(() {
                                            isDeletedClicked = true;
                                          });
                                          ExpenseCubit.instance.deleteExpenseData(
                                              widget.expenseData);
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
