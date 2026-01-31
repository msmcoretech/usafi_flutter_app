import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_circle_button.dart';
import 'package:usafi_app/core/widgets/app_popup.dart';
import 'package:usafi_app/core/widgets/app_switch_button.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: _appBar(),
      body: Column(
        children: [
          _profileHeader(context),
          Expanded(child: _profileDetails()),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: AppCircleButton(
          icon: back,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      centerTitle: false,
      title: Text(
        'My Profile',
        style: TextStyle(
          color: AppColors.secondary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          offset: const Offset(-20, 50),
          color: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
                topLeft: Radius.circular(18),
            ),
          ),
          icon: CircleAvatar(
            backgroundColor: AppColors.circleButton,
            child: Image(image: AssetImage(settings), height: 20),
          ),
          onSelected: (value) {
            debugPrint(value);
            switch (value) {
              case 'notification':
                break;
              case 'contactUs':
                Navigator.pushNamed(context, AppRoutes.contactUs);
                break;
              case 'privacyPolicy':
                Navigator.pushNamed(
                  context,
                  AppRoutes.webview,
                  arguments: {
                    "url": "https://flutter.dev/",
                    "title": "Privacy Policy",
                  },
                );
                break;
              case 'termsAndCondition':
                Navigator.pushNamed(
                  context,
                  AppRoutes.webview,
                  arguments: {
                    "url": "https://flutter.dev/",
                    "title": "Terms & Condition",
                  },
                );
                break;
              case 'deleteAccount':
                _deleteAccount();
                break;
              case 'logout':
                _logoutAccount();
                break;
            }
          },
          itemBuilder: (context) => [
            _menuHeader(),
            PopupMenuDivider(color: AppColors.jobHeader, thickness: 03),
            _menuItem('notification', 'Notification'),
            PopupMenuDivider(color: Colors.transparent, height: 10),
            _menuItem('contactUs', 'Contact Us'),
            PopupMenuDivider(color: Colors.transparent, height: 10),
            _menuItem('privacyPolicy', 'Privacy Policy'),
            PopupMenuDivider(color: Colors.transparent, height: 10),
            _menuItem('termsAndCondition', 'Terms & Conditions'),
            PopupMenuDivider(color: Colors.transparent, height: 10),
            _menuItem('deleteAccount', 'Delete Account'),
            PopupMenuDivider(color: Colors.transparent, height: 10),
            _menuItem('logout', 'Logout'),
            _menuBottom(),
          ],
        ),
        SizedBox(width: 10,),
      ],
    );
  }

  PopupMenuItem<String> _menuHeader() {
    return const PopupMenuItem<String>(
      enabled: false,
      height: 40,
      child: Text(
        'Settings',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  PopupMenuItem<String> _menuBottom() {
    return PopupMenuItem<String>(
      enabled: false,
      height: 40,
      child: Center(
        child: Text(
          "V 1.0",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _menuItem(String value, String title) {
    return PopupMenuItem<String>(
      value: value,

      child: Container(
        height: 60,
        width: double.infinity,
        // margin: EdgeInsets.only(bottom: 06),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 08, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: title == "Notification"
            ? StatefulBuilder(
                builder: (context, setPopupState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 10),
                      CupertinoSwitch(
                        value: notificationsEnabled,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setPopupState(() {
                            notificationsEnabled = !notificationsEnabled;
                          });
                        },
                      ),
                    ],
                  );
                },
              )
            : Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: title == "Delete Account"
                      ? AppColors.jobRejected
                      : AppColors.textPrimary,
                ),
              ),
      ),
    );
  }

  Widget _profileHeader(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        decoration: const BoxDecoration(color: AppColors.primary),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.secondary,
                    backgroundImage: const NetworkImage(
                      'https://i.pravatar.cc/180',
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jane Cooper',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      children: [
                        Image(image: AssetImage(phone), height: 12),
                        SizedBox(width: 05),
                        Text(
                          '+12 36547890',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Image(image: AssetImage(mail), height: 12),
                        SizedBox(width: 05),
                        Text(
                          'janecooper@usafi.com',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.editProfile,
                              );
                            },
                            child: _headerButton('Edit Profile'),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.history);
                            },
                            child: _headerButton('History'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileDetails() {
    return Container(
      color: AppColors.secondary,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _verifyCard(),
            const SizedBox(height: 16),
            _infoCard(),
            const SizedBox(height: 20),
            _mainButton(),
          ],
        ),
      ),
    );
  }

  Widget _verifyCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.jobHeader,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(image: AssetImage(verify), height: 28),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Verify',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'Please upload documents and verify this account.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          // const SizedBox(width: 06),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.verifyProfile);
              },
              child: _headerButton('Verify'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.jobHeader,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(title: 'Experience', value: '5 Years 6 Months'),
          _divider(),
          _infoRow(title: 'Job Role', value: 'House Supervisors'),
          _divider(),
          _infoRow(
            title: 'Skills',
            value: 'Hospitality, events, stadiums, arenas',
          ),
          _divider(),
          _infoRow(title: 'Education', value: '12th Pass'),
          _divider(),
          _infoRow(title: 'Address', value: '123, lorem ipsum address'),
        ],
      ),
    );
  }

  Widget _mainButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: AppButton(
        title: "Add/Edit Role & Skills",
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.roleSkills);
        },
      ),
    );
  }

  Widget _headerButton(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _infoRow({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title!,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value!,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, thickness: 0.6, color: AppColors.jobPending);
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => CommonResultDialog(
        title: "Delete Account",
        icon: deleteAccount,
        description: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.jobHeader,
          ),
          child: Text(
            "Do you want to delete your account?",
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onPrimaryTap: () {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login,(route) => false,);
        },
        onSecondaryTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _logoutAccount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => CommonResultDialog(
        title: "Logout",
        icon: logout,
        description: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.jobHeader,
          ),
          child: Text(
            "Do you want to logout your account?",
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onPrimaryTap: () {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login,(route) => false,);
        },
        onSecondaryTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
