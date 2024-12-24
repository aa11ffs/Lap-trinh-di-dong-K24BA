import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: AppColor.kFFFFFF,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(width: 1.0, color: AppColor.kDCE1EF)),
        child: child);
  }
}
