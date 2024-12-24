import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task/gen/assets.gen.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key, this.width});
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 7,
      child: Lottie.asset(Assets.jsons.splashLotie,
          fit: BoxFit.fill, reverse: true, repeat: false, width: width ?? 350),
    );
  }
}
