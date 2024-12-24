import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.kFFFFFF,
      body: Center(
        child: Text('Error', style: AppStyle.medium26),
      ),
    );
  }
}
