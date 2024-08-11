import 'package:expense_tracker/core/utils/date_formatter.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/create_expense_page.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/bloc/expense_bloc.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/widgets/expense_tile.dart';
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
                    // detecting a scroll for showing full list view in full screen.
                    if (details.delta.dy > 15) {
                      ExpenseCubit.instance.handleScroll(true);
                    } else if (details.delta.dy < -15) {
                      ExpenseCubit.instance.handleScroll(false);
                    }
                  },
                  child: Stack(
                    children: [
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
                                    // listening to the ListView scroll to move up and show
                                    //summary when a scroll to upward happen when the list is aleardy in top.

                                    //giving delay so that won't try to build while the frame being updated by the scroll in listview.
                                    Future.delayed(
                                      const Duration(milliseconds: 200),
                                      () {
                                        if (scrollNotification
                                            is OverscrollNotification) {
                                          if (scrollNotification.velocity ==
                                                  0 &&
                                              scrollNotification.overscroll <
                                                  -2) {
                                            ExpenseCubit.instance
                                                .handleScroll(true);
                                          }
                                        }
                                      },
                                    );

                                    return false;
                                  },
                                  child: ListView.builder(
                                    // controller: PostFrameScrollController(),
                                    physics: state.screenPosition ==
                                            ScreenPosition.bottom
                                        ? null
                                        : const NeverScrollableScrollPhysics(),
                                    itemCount: state.expenses.length + 1,
                                    itemBuilder: (context, index) {
                                      // providing a space at the end, so the last elment will not be blinded by floating button.
                                      if (index == state.expenses.length) {
                                        return const SizedBox(
                                          height: 50,
                                        );
                                      }
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
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Icon(Icons.menu),
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

//using this for
class PostFrameScrollController extends ScrollController {
  @override
  void notifyListeners() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      super.notifyListeners();
    });
  }
}
