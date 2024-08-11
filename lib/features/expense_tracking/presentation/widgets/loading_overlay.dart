import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

/// loading overlay act as single loading indicator usable by all pages by managing state using [ExpenseCubit]
class LoadingOverlay extends StatelessWidget {
  final Widget child;
  const LoadingOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        return Stack(
          children: [
            //prevent touch.
            AbsorbPointer(
              absorbing: state.isLoading,
              child: child,
            ),
            if (state.isLoading) ...[
              Container(
                color: const Color.fromARGB(143, 3, 3, 3),
                alignment: Alignment.center,
                child: const LoadingIndicator(),
              ),
            ],
          ],
        );
      },
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Get.theme.highlightColor.withOpacity(0.7),
      ),
      child: InfiniteRotation(
        child: Stack(
          children: [
            CircularProgressIndicator(
              color: Get.theme.canvasColor,
              value: .1,
            ),
            Transform.rotate(
              angle: 1,
              child: CircularProgressIndicator(
                color: Get.theme.canvasColor,
                value: .1,
              ),
            ),
            Transform.rotate(
              angle: 2.2,
              child: CircularProgressIndicator(
                color: Get.theme.canvasColor,
                value: .1,
              ),
            ),
            Transform.rotate(
              angle: 3.3,
              child: CircularProgressIndicator(
                color: Get.theme.canvasColor,
                value: .1,
              ),
            ),
            Transform.rotate(
              angle: 4.38,
              child: CircularProgressIndicator(
                color: Get.theme.canvasColor,
                value: .1,
              ),
            ),
            Transform.rotate(
              angle: 5.3,
              child: CircularProgressIndicator(
                color: Get.theme.canvasColor,
                value: .1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfiniteRotation extends StatefulWidget {
  final Widget child;

  const InfiniteRotation({Key? key, required this.child}) : super(key: key);

  @override
  _InfiniteRotationState createState() => _InfiniteRotationState();
}

class _InfiniteRotationState extends State<InfiniteRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}
