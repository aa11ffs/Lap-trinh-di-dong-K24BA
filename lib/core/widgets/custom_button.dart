import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.label,
    this.backgroundColor,
    this.width,
    this.height,
  });
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final void Function()? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColor.k613BE7,
            foregroundColor: AppColor.kFFFFFF,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))),
        child: Text(label, style: AppStyle.semibold14),
      ),
    );
  }
}
