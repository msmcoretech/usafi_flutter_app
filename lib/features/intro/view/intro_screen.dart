import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_constants.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _background(),
            _angledCards(),
            _bottomContent(),
          ],
        ),
      ),
    );
  }

  Widget _background() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _angledCards() {
    return Positioned(
      top: 0.10.sh, // responsive height
      left: 0,
      right: 0,
      child: Column(
        children: [
          _animatedLabel(
            text: findYourDreamJob,
            color: AppColors.yellow,
            angle: -15,
            delay: 100,
            textColor: Colors.black,
          ),
          SizedBox(height: 20.h),
          _animatedLabel(
            text: flexibleJobProvider,
            color: AppColors.green,
            angle: 10,
            delay: 800,
            textColor: Colors.white,
          ),
          SizedBox(height: 20.h),
          _animatedLabel(
            text: connectWithProvider,
            color: AppColors.secondary,
            angle: -15,
            delay: 1500,
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _bottomContent() {
    return Positioned(
      bottom: 0.02.sh,
      left: 24.w,
      right: 24.w,
      child: Column(
        children: [
          Text(
            applicationForJobProvider,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          SizedBox(height: 20.h),
          AppButton(
            title: getStarted,
            backgroundColor: AppColors.secondary,
            textColor: AppColors.primary,
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }

  Widget _animatedLabel({
    required String text,
    required Color color,
    required double angle,
    required int delay,
    required Color textColor,
  }) {
    return _DelayedAnimatedLabel(
      text: text,
      color: color,
      angle: angle,
      delay: delay,
      textColor: textColor,
    );
  }
}

class _DelayedAnimatedLabel extends StatefulWidget {
  final String text;
  final Color color;
  final double angle;
  final int delay;
  final Color textColor;

  const _DelayedAnimatedLabel({
    required this.text,
    required this.color,
    required this.angle,
    required this.delay,
    required this.textColor,
  });

  @override
  State<_DelayedAnimatedLabel> createState() => _DelayedAnimatedLabelState();
}

class _DelayedAnimatedLabelState extends State<_DelayedAnimatedLabel> {
  bool _start = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        setState(() {
          _start = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutBack,
      tween: Tween<double>(begin: 0.0, end: _start ? 1.0 : 0.0),
      builder: (context, value, child) {
        final safeValue = value.clamp(0.0, 1.0);

        return Transform.translate(
          offset: Offset(0, (1 - safeValue) * 40.h),
          child: Opacity(
            opacity: safeValue,
            child: Transform.rotate(
              angle: widget.angle * pi / 180,
              child: _labelContainer(
                widget.text,
                widget.color,
                widget.textColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _labelContainer(String text, Color bg, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 26.w,
        vertical: 14.h,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
