import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/features/user_profile/providers/user_profile_providers.dart';

class ProfileVerifyScreen extends ConsumerWidget {
  const ProfileVerifyScreen({super.key});

  static const documents = [
    'Passport',
    'Driving License',
    'National ID',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userProfileProvider);
    final notifier = ref.read(userProfileProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context),
              _verifyCard(context, state, notifier),
              const SizedBox(height: 30),
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
      child: SafeArea(
        top: true,
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(appLogo, height: 75),
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

  Widget _verifyCard(
      BuildContext context,
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
              'Profile Verify',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 24),
          _dropdown(state, notifier),
          const SizedBox(height: 16),
          _uploadBox(context, state, notifier),
          const SizedBox(height: 24),
          AppButton(
            title: 'Submit for Verify',
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _dropdown(
      UserProfileState state,
      UserProfileNotifier notifier,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: state.selectedDocument,
          hint: const Text('Select Document'),
          isExpanded: true,
          items: documents
              .map(
                (doc) => DropdownMenuItem(
              value: doc,
              child: Text(doc),
            ),
          )
              .toList(),
          onChanged: (value) {
            if (value != null) notifier.setDocument(value);
          },
        ),
      ),
    );
  }

  Widget _uploadBox(
      BuildContext context,
      UserProfileState state,
      UserProfileNotifier notifier,
      ) {
    return GestureDetector(
      onTap: () => _showSourceSheet(context, notifier),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: state.selectedImage == null
            ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload, size: 36),
            SizedBox(height: 8),
            Text('Upload id here'),
          ],
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            File(state.selectedImage!.path),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  void _showSourceSheet(
      BuildContext context,
      UserProfileNotifier notifier,
      ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
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
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  notifier.pickImage(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
