import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/bloc/expense_bloc.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class StaticCircle extends StatefulWidget {
  final double height;
  const StaticCircle({super.key, required this.height});

  @override
  State<StaticCircle> createState() => _StaticCircleState();
}

class _StaticCircleState extends State<StaticCircle> {
  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    var buttonContent = ["this week", "this month", "this year"];

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: Container(
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              padding: EdgeInsets.all(8.0),
              shrinkWrap: true,
              children: buttonContent
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        switch (e) {
                          case "this week":
                            ExpenseCubit.instance
                                .changeSummaryDuration(Summary.week);
                          case "this month":
                            ExpenseCubit.instance
                                .changeSummaryDuration(Summary.month);
                          case "this year":
                            ExpenseCubit.instance
                                .changeSummaryDuration(Summary.year);
                        }
                        _removeOverlay();
                      },
                      child: ListTile(
                        title: Text(
                          e,
                          style: Get.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 57, 57, 56),
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(color: Get.theme.primaryColorDark), //
          ),
          height: widget.height,
          width: 90.w,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: _buildCircle(),
              ),
              Container(
                height: 20.h,
                alignment: Alignment.center,
                child: Wrap(
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  children: List.generate(
                    state.summary.length,
                    (index) => CatergoryTile(
                      category: state.summary.elementAt(index).category,
                      percentage: state.summary.elementAt(index).percentage,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildCircle() {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        return SizedBox(
          width: 50.w,
          height: 50.w,
          child: Stack(
            children: [
              SizedBox(
                width: 50.w,
                height: 50.w,
              ),
              ...List.generate(
                state.summary.length,
                (index) {
                  return AnimatedRotation(
                    //turn to where the last element is ended. and start from there.
                    turns: index == 0
                        ? 0
                        : state.summary
                                .sublist(0, index)
                                .map((e) => e.percentage)
                                .reduce((value, element) => value + element) /
                            100,
                    duration: const Duration(
                      microseconds: 500,
                    ),
                    child: SizedBox(
                      width: 50.w,
                      height: 50.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 20,
                        color: state.summary.elementAt(index).category.color,
                        value: state.summary.elementAt(index).percentage / 100,
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    if (_overlayEntry == null) {
                      _showOverlay(context);
                    } else {
                      _removeOverlay();
                    }
                  },
                  child: Container(
                    width: 50.w,
                    height: 50.w,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.keyboard_arrow_down),
                        Text(
                            switch (state.summaryBy) {
                              Summary.week => "Week",
                              Summary.month => "Month",
                              Summary.year => "Year",
                            },
                            style: Get.theme.textTheme.titleMedium),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
