import 'package:flutter/material.dart';
import 'package:task/core/constants/app_style.dart';

class CustomStatusBox extends StatelessWidget {
  const CustomStatusBox({
    super.key,
    this.status = '',
    this.color = Colors.green,
  });
  final String status;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(40.0)),
      child: Text(
        status,
        style: AppStyle.semibold12,
      ),
    );
  }
}
