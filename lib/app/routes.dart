import 'package:flutter/material.dart';
import 'package:usafi_app/features/auth/presentation/change_password_screen.dart';
import 'package:usafi_app/features/auth/presentation/forgot_password_screen.dart';
import 'package:usafi_app/features/auth/presentation/login_screen.dart';
import 'package:usafi_app/features/auth/presentation/otp_verification_screen.dart';
import 'package:usafi_app/features/auth/presentation/signup_screen.dart';
import 'package:usafi_app/features/intro/view/intro_screen.dart';
import 'package:usafi_app/features/main_navigation/presentation/job_detail_screen.dart';
import 'package:usafi_app/features/main_navigation/presentation/main_navigation_screen.dart';
import 'package:usafi_app/features/main_navigation/presentation/map_screen.dart';
import 'package:usafi_app/features/splash/view/splash_screen.dart';
import 'package:usafi_app/features/user_profile/presentation/edit_profile_screen.dart';
import 'package:usafi_app/features/user_profile/presentation/history_screen.dart';
import 'package:usafi_app/features/user_profile/presentation/profile_screen.dart';
import 'package:usafi_app/features/user_profile/presentation/role_skills_screen.dart';
import 'package:usafi_app/features/user_profile/presentation/verify_profile_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const intro = '/intro';
  static const login = '/login';
  static const signup = '/signup';
  static const verification = '/verification';
  static const forgotPassword = '/forgot-password';
  static const createNewPassword = '/create-new-password';
  static const mainNavigation = '/main-navigation';
  static const jobDetail = '/job-detail';
  static const profile = '/user-profile';
  static const editProfile = '/edit-profile';
  static const roleSkills = '/role-skills';
  static const verifyProfile = '/verify-profile';
  static const history = '/history';
  static const map = '/map';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case AppRoutes.verification:
        final bool isFromForgot = settings.arguments as bool? ?? false;
        return MaterialPageRoute(
          builder: (_) => VerificationScreen(isFromForgot: isFromForgot),
        );

      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case AppRoutes.createNewPassword:
        return MaterialPageRoute(
          builder: (_) => const CreateNewPasswordScreen(),
        );

      case AppRoutes.mainNavigation:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());

      case AppRoutes.jobDetail:
        final Map<String?,dynamic> data = settings.arguments as Map<String?,dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => JobDetailScreen(jobStatus: data["jobStatus"]!, isFromWhere: data["isFromWhere"]!,),
        );

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const MyProfileScreen());

        case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());

        case AppRoutes.roleSkills:
        return MaterialPageRoute(builder: (_) => const RoleSkillsScreen());

        case AppRoutes.verifyProfile:
        return MaterialPageRoute(builder: (_) => const ProfileVerifyScreen());

        case AppRoutes.history:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());

        case AppRoutes.map:
        return MaterialPageRoute(builder: (_) => const MapScreen());

      default:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
    }
  }
}
