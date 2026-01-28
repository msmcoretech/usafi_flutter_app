import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_constants.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';

import '../../../app/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              _header(),
              _signUpCard(),
              _footer(),
              const SizedBox(height: 20),
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
      child: Image(
        image: AssetImage(appLogo),
        height: 75,
      ),
    );
  }


  Widget _signUpCard() {
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
              signup,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            kindlyEnterYourDetails,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          AppTextField(hint: fullName),
          const SizedBox(height: 14),

          AppTextField(
            hint: phoneNumber,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 14),

          AppTextField(
            hint: email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 14),

          AppTextField(
            hint: password,
            isPassword: true,
          ),
          const SizedBox(height: 14),

          AppTextField(
            hint: confirmPassword,
            isPassword: true,
          ),
          const SizedBox(height: 14),

          AppTextField(hint: jobRole),
          const SizedBox(height: 14),

          AppTextField(hint: skills),
          const SizedBox(height: 14),

          AppTextField(hint: address),
          const SizedBox(height: 20),

          _signUpButton(),
        ],
      ),
    );
  }


  Widget _signUpButton() {
    return AppButton(
      title: signup,
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.verification,arguments: false);
      },
    );
  }


  Widget _footer() {
    return Container(
      transform: Matrix4.translationValues(0, -60, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                alreadyHaveAccount,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 17,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  login,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // const Text(or),
          _dividerWithText(or),
          const SizedBox(height: 16),

          _googleButton(),
        ],
      ),
    );
  }

  Widget _dividerWithText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          const Expanded(child: Divider(
            color: AppColors.divider,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.divider,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(child: Divider(
            color: AppColors.divider,
          )),
        ],
      ),
    );
  }


  Widget _googleButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      icon: Image.asset(
        googleIcon,
        height: 22,
      ),
      label: const Text(
        signupWithGoogle,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
