import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_circle_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [
    NotificationModel(
      title: "Your Job Fixed Now",
      description:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      time: "2 days ago",
      isRead: false,
    ),
    NotificationModel(
      title: "Profile Verify",
      description:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      time: "17-05-2026",
      isRead: true,
    ),
    NotificationModel(
      title: "Profile Verify",
      description:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      time: "17-05-2026",
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: AppCircleButton(
            icon: back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  notifications.clear();
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 02),
                decoration: BoxDecoration(
                  color: AppColors.circleButton,
                  borderRadius: BorderRadius.circular(06),
                ),
                child: const Text(
                  "Clear All",
                  style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w700),
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return _notificationItem(index);
        },
      ),
    );
  }

  Widget _notificationItem(int index) {
    final item = notifications[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(index),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.4,
          children: [
            CustomSlidableAction(
              onPressed: (_) {
                setState(() {
                  notifications.removeAt(index);
                });
              },
              backgroundColor: Colors.transparent,
              child: Container(
                // margin: const EdgeInsets.only(left: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.jobRejected,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.cancel_outlined,
                      color: AppColors.secondary,
                      size: 15,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              item.isRead = true;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: item.isRead
                  ? AppColors.secondary
                  : AppColors.lightPrimary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.description,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),

                if (!item.isRead)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ),
    ),);
  }
}


class NotificationModel {
  final String title;
  final String description;
  final String time;
  bool isRead;

  NotificationModel({
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
  });
}
