import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';

class NotificationSwitchTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const NotificationSwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          _icon(),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          CupertinoSwitch(
            value: value,
            activeColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _icon() {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: AppColors.lightPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.notifications_none,
        color: AppColors.primary,
      ),
    );
  }
}
