import 'package:flutter/material.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_constants.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/utils/app_snackbar.dart';
import 'package:usafi_app/core/utils/validator.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              _header(),
              _passwordCard(),
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
      child: Image.asset(
        appLogo,
        height: 75,
      ),
    );
  }


  Widget _passwordCard() {
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
          const Center(
            child: Text(
              createNewPassword,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            createNewPasswordDescription,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),

          AppTextField(
            hint: password,
            controller: passwordController,
            isPassword: _obscurePassword,
            ),

          const SizedBox(height: 14),

          AppTextField(
            hint: confirmPassword,
            controller: confirmPasswordController,
            isPassword: _obscureConfirmPassword,
          ),

          const SizedBox(height: 24),

          AppButton(
            title: changePassword,
            onTap: _onChangePassword,
          ),
        ],
      ),
    );
  }


  void _onChangePassword() {
    if (AppValidators.password(passwordController!.text)) {
      AppSnackBar.error(context, 'Weak password');
      return;
    }
    if (AppValidators.password(confirmPasswordController!.text)) {
      AppSnackBar.error(context, 'Weak confirm password');
      return;
    }
    if (AppValidators.confirmPassword(passwordController!.text,confirmPasswordController!.text)) {
      AppSnackBar.error(context, 'Please enter valid password');
      return;
    }
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login,(route) => false,);
  }
}
