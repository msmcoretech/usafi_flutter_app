import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:usafi_app/core/constants/app_colors.dart';

final userProfileProvider =
StateNotifierProvider<UserProfileNotifier, UserProfileState>(
      (ref) => UserProfileNotifier(),
);

class UserProfileState {
  final String? selectedDocument;
  final File? selectedImage;
  final bool isLoading;

  const UserProfileState({
    this.selectedDocument,
    this.selectedImage,
    this.isLoading = false,
  });

  UserProfileState copyWith({
    String? selectedDocument,
    File? selectedImage,
    bool? isLoading,
  }) {
    return UserProfileState(
      selectedDocument: selectedDocument ?? this.selectedDocument,
      selectedImage: selectedImage ?? this.selectedImage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  UserProfileNotifier() : super(const UserProfileState());

  final ImagePicker _picker = ImagePicker();

  void setDocument(String value) {
    state = state.copyWith(selectedDocument: value);
  }

  Future<void> pickImage(
      BuildContext context,
      ImageSource source,
      ) async {
    final permissionGranted =
    await _handlePermission(context, source);

    if (!permissionGranted) return;

    final XFile? image =
    await _picker.pickImage(source: source, imageQuality: 80);

    if (image != null) {
      state = state.copyWith(selectedImage: File(image.path));
    }
  }

  Future<bool> _handlePermission(
      BuildContext context,
      ImageSource source,
      ) async {
    final permission = source == ImageSource.camera
        ? Permission.camera
        : Permission.photos;

    var status = await permission.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      final result = await permission.request();
      if (result.isGranted) return true;
    }

    if (status.isPermanentlyDenied) {
      _showPermissionDialog(context);
    }

    return false;
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.secondary,
          title: const Text('Permission Required'),
          content: const Text(
            'We need to allow permission for the uploading documents',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
