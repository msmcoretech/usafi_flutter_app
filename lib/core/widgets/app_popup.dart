import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usafi_app/core/constants/app_colors.dart';

class CommonResultDialog extends StatelessWidget {
  final String title;
  final Widget description;
  final VoidCallback onPrimaryTap;
  final VoidCallback onSecondaryTap;
  final String primaryText;
  final String secondaryText;
  final String icon;
  final Color primaryColor;

  const CommonResultDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onPrimaryTap,
    required this.onSecondaryTap,
    this.primaryText = "OK",
    this.secondaryText = "Cancel",
    this.icon = "",
    this.primaryColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image:AssetImage(icon),
              height: 70,
            ),

            const SizedBox(height: 14),

            Text(
              title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 18),
            description,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onPrimaryTap,
                  child: Text(
                    primaryText,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onSecondaryTap,
                  child: Text(
                    secondaryText,
                    style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
