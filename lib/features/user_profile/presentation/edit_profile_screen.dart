import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_constants.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/utils/app_snackbar.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';

import '../../../core/utils/validator.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController? fullNameController = TextEditingController();
  TextEditingController? phoneNumberController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? addressController = TextEditingController();

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
              _editProfileCard(),
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
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _editProfileCard() {
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
              'Edit Profile',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 24),

          AppTextField(hint: fullName,controller: fullNameController,),
          const SizedBox(height: 14),

          AppTextField(
            hint: phoneNumber,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            controller: phoneNumberController,
          ),
          const SizedBox(height: 14),

          AppTextField(
            hint: email,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
          ),
          const SizedBox(height: 14),

          AppTextField(
            controller: addressController,
            hint: address,
            maxLines: 2,
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
        _saveProfileMethod();
      },
    );
  }

  void _saveProfileMethod() {
    if (AppValidators.fullName(fullNameController!.text)) {
      AppSnackBar.error(context, "Enter Full name");
      return;
    }
    if (AppValidators.phone(phoneNumberController!.text)) {
      AppSnackBar.error(context, "Enter valid phone number");
      return;
    }
    if (AppValidators.email(emailController!.text)) {
      AppSnackBar.error(context, "Invalid email");
      return;
    }
    if (AppValidators.fullName(addressController!.text)) {
      AppSnackBar.error(
        context,
        "Enter valid address",
      );
      return;
    }
    Navigator.pop(context);
  }
}
