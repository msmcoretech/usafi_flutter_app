import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';

class RoleSkillsScreen extends StatefulWidget {
  const RoleSkillsScreen({super.key});

  @override
  State<RoleSkillsScreen> createState() => _RoleSkillsScreenState();
}

class _RoleSkillsScreenState extends State<RoleSkillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              _header(),
              _roleSkillsCard(),
              const SizedBox(height: 30),
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
      child: SafeArea(
        top: true,
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  appLogo,
                  height: 75,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 16,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.circleButton,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roleSkillsCard() {
    return Container(
      transform: Matrix4.translationValues(0, -90, 0),
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
              'Role & Skills',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 24),
          AppTextField(hint: 'Experience'),
          const SizedBox(height: 14),
          AppTextField(hint: 'Education'),
          const SizedBox(height: 14),
          AppTextField(hint: 'Job Role'),
          const SizedBox(height: 14),
          AppTextField(
            hint: 'Skills',
          ),
          const SizedBox(height: 24),
          _saveButton(),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return AppButton(
      title: 'Save',
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
