import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.tag,
  });
  final void Function()? onPressed;
  final IconData icon;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: tag,
      onPressed: onPressed,
      backgroundColor: AppColor.k613BE7,
      foregroundColor: AppColor.kFFFFFF,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Icon(icon),
    );
  }
}
