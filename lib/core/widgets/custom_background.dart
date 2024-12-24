import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/extensions/build_context_extension.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth,
      height: context.getHeight,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            AppColor.kFFFFFF,
            AppColor.kDFE4F1,
          ])),
      child: child,
    );
  }
}
