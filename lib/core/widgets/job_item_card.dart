import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';

class JobItemCard extends StatelessWidget {
  final String date;
  final String time;
  final String title;
  final String role;
  final String locationText;
  final String status;
  final int index;
  final bool showApplyButton;
  final VoidCallback? onApply;

  const JobItemCard({
    super.key,
    required this.date,
    required this.time,
    required this.title,
    required this.role,
    required this.index,
    required this.locationText,
    required this.status,
    this.showApplyButton = false,
    this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.jobHeader,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(children: [_header(), _body()]),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _statusChip(),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              time,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip() {
    Color bgColor;
    Color textColor = AppColors.textPrimary;

    switch (status) {
      case 'Confirmed' || 'New!':
        bgColor = AppColors.yellow;
        break;
      case 'Pending' || 'Running':
        bgColor = AppColors.jobPending;
        break;
      case 'Finished':
        bgColor = AppColors.jobFinished;
        break;
      default:
        bgColor = AppColors.jobRejected;
        textColor = AppColors.secondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/16$index',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (!showApplyButton) ...[
                      const SizedBox(height: 4),
                      Text(role),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 25),
          Row(
            children: [
              const Image(
                image: AssetImage(location),
                height: 15,
              ),
              const SizedBox(width: 08),
              Expanded(
                child: Text(
                  locationText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    fontSize: 15
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 05),
          if (showApplyButton) _applyButton(),
        ],
      ),
    );
  }

  Widget _applyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 06),
      child: Container(
        height: 44,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(22),
        ),
        child: InkWell(
          onTap: onApply,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    '£12.21/',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'hour est.',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Apply Now',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
