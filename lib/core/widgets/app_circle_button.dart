import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';

class AppCircleButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final bool profileIcon;
  final String profileImage;
  const AppCircleButton({super.key, this.icon = "", required this.onTap, this.profileIcon= false, this.profileImage = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 05),
      child: GestureDetector(
        onTap: onTap,
        child: profileIcon?Container(
          padding: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.secondary,
            backgroundImage: NetworkImage(
              profileImage,
            ),
          ),
        ):CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.circleButton,
          child: Image(
            image: AssetImage(icon),
            width: 15,
          ),
        ),
      ),
    );
  }
}
