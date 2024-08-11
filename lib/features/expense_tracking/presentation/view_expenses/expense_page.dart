import 'package:expense_tracker/core/utils/date_formatter.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/create_expense_page.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/bloc/expense_bloc.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/widgets/static_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as g;
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, state) {
            return ClipRRect(
              child: Container(
                height: 100.h,
                width: 90.w,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (details.delta.dy > 15) {
                      ExpenseCubit.instance.handleTopScroll(true);
                    } else if (details.delta.dy < -15) {
                      ExpenseCubit.instance.handleTopScroll(false);
                    }
                    // });
                  },
                  child: Stack(
                    children: [
                      // SizedBox(
                      //   height: 100.h,
                      //   width: 90.w,
                      // ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        top: state.screenPosition == ScreenPosition.top
                            ? 70
                            : -50.h + 20,
                        child: SizedBox(
                          height: 170.h,
                          width: 90.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                // color: Colors.red,
                                child: StaticCircle(
                                  height: 55.h,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "History",
                                        textAlign: TextAlign.left,
                                        style: Get.textTheme.bodyLarge,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          ExpenseCubit.instance
                                              .filterByDate(context);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.filter_alt),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 84.h,
                                width: 90.w,
                                child: NotificationListener<ScrollNotification>(
                                  onNotification: (scrollNotification) {
                                    Future.delayed(
                                      const Duration(milliseconds: 200),
                                      () {
                                        if (scrollNotification
                                            is OverscrollNotification) {
                                          if (scrollNotification.velocity ==
                                                  0 &&
                                              scrollNotification.overscroll <
                                                  -2) {
                                            print("happening");
                                            ExpenseCubit.instance
                                                .handleTopScroll(true);
                                          }
                                        }
                                      },
                                    );
                                    Future.microtask(() {});
                                    // WidgetsBinding.instance
                                    //     .addPostFrameCallback((_) {
                                    //   if (scrollNotification
                                    //       is OverscrollNotification) {
                                    //     if (scrollNotification.velocity == 0 &&
                                    //         scrollNotification.overscroll <
                                    //             -2) {
                                    //       print("happening");
                                    //       ExpenseCubit.instance
                                    //           .handleTopScroll(true);
                                    //     }
                                    //   }
                                    // });

                                    return false;
                                  },
                                  child: ListView.builder(
                                    controller: PostFrameScrollController(),
                                    physics: state.screenPosition ==
                                            ScreenPosition.bottom
                                        ? null
                                        : NeverScrollableScrollPhysics(),
                                    itemCount: state.expenses.length,
                                    itemBuilder: (context, index) {
                                      return ExpenseTile(
                                        index: index,
                                        state: state,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(top: 0, child: _appBar())
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Get.theme.highlightColor,
        onPressed: () {
          g.Get.to(
            () => const CreateExpensePage(),
            transition: g.Transition.downToUp,
          );
        },
        label: const Icon(Icons.add),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(10),
      width: 90.w,
      color: Get.theme.scaffoldBackgroundColor,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: const Icon(Icons.menu),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Dash board",
              style: g.Get.theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

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
          margin: EdgeInsets.all(10),
          height: 60,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: g.Get.theme.primaryColorDark,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: state.expenses.elementAt(index).category.color,
                    borderRadius: BorderRadius.only(
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
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        CreateExpenseCubit.instance
                            .showExpenseData(state.expenses.elementAt(index));
                      },
                      child: Icon(Icons.edit)),
                  GestureDetector(
                      onTap: () {
                        ExpenseCubit.instance
                            .deleteExpenseData(state.expenses.elementAt(index));
                      },
                      child: Icon(Icons.delete)),
                ],
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PostFrameScrollController extends ScrollController {
  @override
  void notifyListeners() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      super.notifyListeners();
    });
  }
}
