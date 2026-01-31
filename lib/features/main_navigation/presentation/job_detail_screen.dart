import 'package:flutter/material.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_circle_button.dart';

class JobDetailScreen extends StatefulWidget {
  final String jobStatus;
  final bool isFromWhere;

  const JobDetailScreen({
    super.key,
    required this.jobStatus,
    required this.isFromWhere,
  });

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(context),
        bottomNavigationBar: _bottomActions(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              _companyInfo(),
              const SizedBox(height: 20),
              _dateTimeCard(),
              const SizedBox(height: 16),
              _jobMetaInfo(),
              const SizedBox(height: 16),
              _aboutJob(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AppCircleButton(
          icon: back,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      titleSpacing: 0,
      title: const Text(
        'Job Detail',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
        ),
      ),
      centerTitle: false,
      actions: [_statusChip(), SizedBox(width: 10)],
    );
  }

  Widget _statusChip() {
    Color bgColor;
    Color textColor = AppColors.textPrimary;

    switch (widget.jobStatus) {
      case 'Confirmed' || 'New!':
        bgColor = AppColors.yellow;
        break;
      case 'Pending' || 'Running':
        bgColor = AppColors.jobPending;
        break;
      case 'Finished':
        bgColor = AppColors.jobHeader.withOpacity(0.2);
        textColor = AppColors.secondary;
        break;
      default:
        bgColor = AppColors.jobRejected;
        textColor = AppColors.secondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(08),
      ),
      child: Text(
        widget.jobStatus,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _companyInfo() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVBmvQ0vWIbzrOhkQyUhU-iQ2M2NYbm9lnzg&s',
          ),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'North — New Accreditations to Work Future Etihad Games',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '£12.21 / hour est.',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _dateTimeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.jobHeader),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.secondary,
            child: Image(image:AssetImage(calender),height: 22,),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tomorrow, Tuesday, November 18',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '16:00 - 00:30',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _jobMetaInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _metaRow(person, 'Job role', 'Bar Staff'),
          const SizedBox(height: 12),
          _metaRow(
            marker,
            'Location',
            'Etihad Stadium, Manchester',
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 50),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary,width: 0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(image:AssetImage(distance),height: 13,),
                  SizedBox(width: 05),
                  const Text(
                    '3.5 km',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaRow(String icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.jobHeader,
          child: Image(image:AssetImage(icon),height: 20,),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _aboutJob() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.jobHeader),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Job',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Lorem Ipsum is simply dummy text of the printing '
            'and typesetting industry. Lorem Ipsum has been the '
            'industry\'s standard dummy text ever since. Lorem Ipsum is simply dummy text of the printing '
            'and typesetting industry. Lorem Ipsum has been the '
            'industry\'s standard dummy text ever since. Lorem Ipsum is simply dummy text of the printing '
            'and typesetting industry. Lorem Ipsum has been the '
            'industry\'s standard dummy text ever since. ',
          ),
        ],
      ),
    );
  }

  Widget _bottomActions() {
    return widget.isFromWhere
        ? SizedBox()
        : Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.map);
                    },
                    icon: const Image(image: AssetImage(map), height: 30),
                    label: const Text(
                      'View Map',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    title: "Start Journey",
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.map);
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
