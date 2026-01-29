import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_constants.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/utils/app_snackbar.dart';
import 'package:usafi_app/core/utils/validator.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';

import '../../../app/routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController? emailController = TextEditingController();

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
              _header(context),
              _forgotCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.8,
      width: double.infinity,
      color: AppColors.primary,
      alignment: Alignment.center,
      child: Image.asset(appLogo, height: 75),
    );
  }

  Widget _forgotCard(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                ),
              ),

              const Text(
                forgotPassword,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            forgotPasswordDescription,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          AppTextField(
            hint: email,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 24),

          AppButton(
            title: verifyEmail,
            onTap: () {
              _verifyEmailMethod();
            },
          ),
        ],
      ),
    );
  }

  void _verifyEmailMethod() {
    if (AppValidators.email(emailController!.text)) {
      AppSnackBar.error(context, "Invalid email");
      return;
    }
    Navigator.pushNamed(context, AppRoutes.verification,arguments: true);
  }
}
