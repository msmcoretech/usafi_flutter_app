import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_constants.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/utils/app_snackbar.dart';
import 'package:usafi_app/core/utils/validator.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';

import '../../../app/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool _obscurePassword = true;
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              _header(),
              _loginCard(),
              _footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 0.36.sh,
      width: double.infinity,
      color: AppColors.primary,
      alignment: Alignment.center,
      child: Image(
        image: const AssetImage(appLogo),
        height: 75.h,
      ),
    );
  }

  Widget _loginCard() {
    return Container(
      transform: Matrix4.translationValues(0, -80.h, 0),
      padding: EdgeInsets.all(24.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              login,
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            welcomeBack,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            hint: email,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
          ),
          SizedBox(height: 14.h),
          AppTextField(
            hint: password,
            isPassword: _obscurePassword,
            controller: passwordController,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.forgotPassword);
              },
              child: Text(
                forgotPassword,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          _loginButton(),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return AppButton(
      title: logIn,
      onTap: () {
        _loginMethod();
      },
    );
  }

  void _loginMethod() {
    if (AppValidators.email(emailController!.text)) {
      AppSnackBar.error(context, "Invalid email");
      return;
    }

    if (AppValidators.password(passwordController!.text)) {
      AppSnackBar.error(context, "Weak password");
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.mainNavigation,
          (route) => false,
    );
  }

  Widget _footer() {
    return Container(
      transform: Matrix4.translationValues(0, -60.h, 0),
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            doNotHaveAccount,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.signup);
            },
            child: Text(
              signup,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                fontSize: 17.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
