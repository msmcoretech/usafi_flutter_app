import 'package:flutter/material.dart';
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
      height: MediaQuery.of(context).size.height / 2.8,
      width: double.infinity,
      color: AppColors.primary,
      alignment: Alignment.center,
      child: Image(image: AssetImage(appLogo), height: 75),
    );
  }

  Widget _loginCard() {
    return Container(
      transform: Matrix4.translationValues(0, -80, 0),
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              login,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            welcomeBack,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          AppTextField(hint: email, keyboardType: TextInputType.emailAddress,controller: emailController,),
          SizedBox(height: 14),
          AppTextField(hint: password, isPassword: _obscurePassword,controller: passwordController,),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.forgotPassword);
              },
              child: const Text(
                forgotPassword,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
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
      AppSnackBar.error(
        context,
        "Weak password",
      );
      return;
    }
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainNavigation,(route) => false,);
  }

  Widget _footer() {
    return Container(
      transform: Matrix4.translationValues(0, -60, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            doNotHaveAccount,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.signup);
            },
            child: const Text(
              signup,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
