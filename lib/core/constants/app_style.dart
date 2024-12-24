import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';
// FontWeight.w100 // Thin (Rất mỏng)
// FontWeight.w200 // Extra Light (Mỏng hơn bình thường)
// FontWeight.w300 // Light (Mỏng)
// FontWeight.w400 // Regular (Bình thường)
// FontWeight.normal // Tương đương w400 (Bình thường)
// FontWeight.w500 // Medium (Hơi đậm)
// FontWeight.w600 // Semi Bold (Đậm vừa)
// FontWeight.w700 // Bold (Đậm)
// FontWeight.bold // Tương đương w700 (Đậm)
// FontWeight.w800 // Extra Bold (Rất đậm)
// FontWeight.w900 // Black (Siêu đậm)

class AppStyle {
  AppStyle._();
  static const TextStyle regular10 = TextStyle(
      fontSize: 10, fontWeight: FontWeight.w400, color: AppColor.k6E7591);
  static const TextStyle regular12 = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: AppColor.k6E7591);
  static const TextStyle regular14 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.k6E7591);
  static const TextStyle medium14 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      color: AppColor.k0D101C);
  static const TextStyle medium16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      color: AppColor.k0D101C);
  static const TextStyle medium20 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      color: AppColor.k0D101C);
  static const TextStyle medium24 = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      color: AppColor.k0D101C);
  static const TextStyle medium26 = TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      color: AppColor.k0D101C);
  static const TextStyle semibold12 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      color: AppColor.kFFFFFF);
  static const TextStyle semibold14 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      color: AppColor.kFFFFFF);
}
