import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/features/splash/viewmodel/splash_viewmodel.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashProvider, (previous, next) {
      next.whenData((isLoggedIn) async {
        await Future.delayed(const Duration(seconds: 3));
        if (!context.mounted) return;
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.mainNavigation,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.intro,
          );
        }
      });
    });

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Center(
        child: Image.asset(
          splashImage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

