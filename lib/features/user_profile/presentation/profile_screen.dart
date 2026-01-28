import 'package:flutter/material.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/widgets/app_button.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          _profileHeader(context),
          Expanded(child: _profileDetails()),
        ],
      ),
    );
  }

  Widget _profileHeader(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        decoration: const BoxDecoration(
          color: AppColors.primary,
        ),
        child: Column(
          children: [
            Row(
              children: [
                _circleIcon(Icons.arrow_back, () {
                  Navigator.pop(context);
                }),
                const SizedBox(width: 12),
                const Text(
                  'My Profile',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
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
                      'https://i.pravatar.cc/150?img=47',
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
                        Icon(Icons.call_outlined,color: AppColors.secondary,size: 15,),
                        Text(
                          '+12 36547890',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.email_outlined,color: AppColors.secondary,size: 15,),
                        Text(
                          'janecooper@usafi.com',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Row(
                        children: [
                          GestureDetector(onTap: (){
                            Navigator.pushNamed(context, AppRoutes.editProfile,);
                          },
                              child: _headerButton('Edit Profile')),
                          const SizedBox(width: 12),
                          _headerButton('History'),
                        ],
                      ),
                    )
                  ],
                )
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
          const Icon(Icons.verified, color: Colors.red, size: 26),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Verify',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Please upload documents and verify this account.',
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(width: 06),
          GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.verifyProfile,);
              },child: _headerButton('Verify')),
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
              value: 'Hospitality, events, stadiums, arenas'),
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
      width: MediaQuery.of(context).size.width*0.7,
      child: AppButton(title: "Add/Edit Role & Skills", onTap: (){
        Navigator.pushNamed(context, AppRoutes.roleSkills,);
      },),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.circleButton,
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _headerButton(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
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
          Text(title!,
              style: const TextStyle(fontSize: 14, color: AppColors.textPrimary,fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(value!,
              style:
              const TextStyle(fontSize: 18, color: AppColors.textPrimary,fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, thickness: 0.6,color: AppColors.jobPending,);
  }
}


