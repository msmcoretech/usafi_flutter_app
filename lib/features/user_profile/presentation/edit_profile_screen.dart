import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_constants.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/utils/app_snackbar.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_circle_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';
import 'package:usafi_app/features/user_profile/providers/user_profile_providers.dart';

import 'package:usafi_app/core/utils/validator.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  TextEditingController? fullNameController = TextEditingController();
  TextEditingController? phoneNumberController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(userProfileProvider);
    final profileNotifier = ref.read(userProfileProvider.notifier);

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
              _editProfileCard(profileState, profileNotifier),
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
              child: Center(child: Image.asset(appLogo, height: 75)),
            ),
            Positioned(
              top: 0,
              left: 10,
              child: AppCircleButton(
                icon: back,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editProfileCard(
    UserProfileState state,
    UserProfileNotifier notifier,
  ) {
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
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.primary.withOpacity(0.15),
                    backgroundImage: state.selectedImage != null
                        ? FileImage(state.selectedImage!)
                        : null,
                    child: state.selectedImage == null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                          child: const Image(
                              image: NetworkImage("https://i.pravatar.cc/180"),
                                                fit: BoxFit.cover,
                            ),
                        )
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: InkWell(
                    onTap: () => _showImagePicker(notifier),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.primary,
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          AppTextField(hint: fullName, controller: fullNameController),
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

  void _showImagePicker(UserProfileNotifier notifier) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                notifier.pickImage(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                notifier.pickImage(context, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveButton() {
    return AppButton(title: 'Save', onTap: _saveProfileMethod);
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
      AppSnackBar.error(context, "Enter valid address");
      return;
    }
    Navigator.pop(context);
  }
}
