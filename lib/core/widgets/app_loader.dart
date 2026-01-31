import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final bool showBackground;
  final Color? backgroundColor;

  const AppLoader({
    super.key,
    this.size = 120,
    this.showBackground = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final loader = Center(
      child: Lottie.asset(
        'assets/lottie_json/loader.json',
        width: size,
        height: size,
        fit: BoxFit.contain,
        repeat: true,
      ),
    );

    if (!showBackground) return loader;

    return Container(
      color: backgroundColor ?? Colors.black.withOpacity(0.3),
      child: loader,
    );
  }
}
