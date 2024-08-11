import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
