import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_circle_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';
import 'package:usafi_app/core/widgets/job_item_card.dart';

import 'package:usafi_app/app/routes.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isMenuOpen = false;
  final List<String> _tabs = ['Approved', 'Pending', 'Rejected'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              _scheduleList(status: 'Confirmed'),
              _scheduleList(status: 'Pending'),
              _scheduleList(status: 'Rejected'),
            ],
          ),
          if (_isMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() => _isMenuOpen = false);
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
            ),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleSpacing: 0,
      title: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.yellow,
        labelPadding: EdgeInsets.zero,
        indicatorWeight: 0.001,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.yellow,
          ),
          insets: EdgeInsets.symmetric(horizontal: 0),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: AppColors.yellow,
        unselectedLabelColor: AppColors.secondary,
        padding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        tabs: _tabs.map((e) => Tab(text: e)).toList(),
      ),
      bottom: PreferredSize(preferredSize: Size(double.infinity, 06), child: Container()),
      actions: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.3,sigmaY: 0.8,tileMode: TileMode.mirror),
          child: PopupMenuButton<String>(
            offset: const Offset(-10, 60),
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
              child: Image(
                image: AssetImage(filter),
                height: 15,
              ),
            ),
            onOpened: () {
              setState(() => _isMenuOpen = true);
            },
            onCanceled: () {
              setState(() => _isMenuOpen = false);
            },
            onSelected: (value) {
              debugPrint(value);
              setState(() => _isMenuOpen = false);
              switch (value) {
                case 'date':
                  _openDateBottomSheet(context);
                  break;
                case 'location':
                  _openLocationBottomSheet(context);
                  break;
                case 'job':
                  _openJobRoleBottomSheet(context);
                  break;
              }
            },
            itemBuilder: (context) => [
              _menuHeader(),
              PopupMenuDivider(color: AppColors.jobHeader, thickness: 01,height: 20,),
              _menuItem('date', 'Date'),
              PopupMenuDivider(color: Colors.transparent,height: 10,),
              _menuItem('location', 'Location'),
              PopupMenuDivider(color: Colors.transparent,height: 10,),
              _menuItem('job', 'Job role'),
              PopupMenuDivider(color: Colors.transparent,height: 10,),
            ],
          ),
        ),
        AppCircleButton(profileImage: 'https://i.pravatar.cc/180', onTap: (){
          Navigator.pushNamed(context, AppRoutes.profile,);
        },profileIcon: true,),
        SizedBox(width: 10,),
      ],
    );
  }

  PopupMenuItem<String> _menuHeader() {
    return const PopupMenuItem<String>(
      enabled: false,
      height: 40,
      child: Text(
        'Filter Shifts',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  PopupMenuItem<String> _menuItem(String value, String title) {
    return PopupMenuItem<String>(
      value: value,
      height: 46,
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 08, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _openDateBottomSheet(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  minimumDate: DateTime(2000, 1, 1),
                  maximumDate: DateTime.now(),
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime date) {
                    selectedDate = date;
                  },
                ),
                // child: CupertinoDateTimePicker(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      debugPrint('Selected Date: $selectedDate');
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _openLocationBottomSheet(BuildContext context) {
    final TextEditingController locationController = TextEditingController();
    String? selectedLocation;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 20),

                AppTextField(hint: "Enter Location"),
                const SizedBox(height: 16),
                const Text(
                  'OR',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedLocation,
                  icon: Icon(Icons.keyboard_arrow_down),
                  dropdownColor: AppColors.secondary,
                  hint: const Text('Select Location'),
                  items: const [
                    DropdownMenuItem(
                      value: 'Manchester',
                      child: Text('Manchester'),
                    ),
                    DropdownMenuItem(value: 'London', child: Text('London')),
                    DropdownMenuItem(
                      value: 'Birmingham',
                      child: Text('Birmingham'),
                    ),
                  ],
                  onChanged: (value) {
                    selectedLocation = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                AppButton(
                  title: "Filter Now",
                  onTap: () {
                    debugPrint('Typed Location: ${locationController.text}');
                    debugPrint('Selected Location: $selectedLocation');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openJobRoleBottomSheet(BuildContext context) {
    String? selectedLocation;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Job Role',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedLocation,
                  icon: Icon(Icons.keyboard_arrow_down),
                  dropdownColor: AppColors.secondary,
                  hint: const Text('Select Job Role'),
                  items: const [
                    DropdownMenuItem(
                      value: 'Sales Man',
                      child: Text('Sales Man'),
                    ),
                    DropdownMenuItem(
                      value: 'Product Manager',
                      child: Text('Product Manager'),
                    ),
                    DropdownMenuItem(
                      value: 'Developer',
                      child: Text('Developer'),
                    ),
                  ],
                  onChanged: (value) {
                    selectedLocation = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                AppButton(
                  title: "Filter Now",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _scheduleList({required String status}) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.jobDetail,
              arguments: {"jobStatus": status, "isFromWhere": false},
            );
          },
          child: JobItemCard(
            date: 'Tomorrow, Tuesday, November 18',
            time: '16:00 - 00:30',
            title: 'North — New Accreditations to Work Future Etihad Games',
            role: 'Bar Staff',
            index: index,
            locationText: 'Etihad Stadium, Manchester',
            status: status,
          ),
        );
      },
    );
  }
}

class FilterSelectorDialog extends StatelessWidget {
  const FilterSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Filter Shifts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            _FilterButton(
              title: 'Date',
              onTap: () {
                Navigator.pop(context);
                // open date picker later
              },
            ),

            const SizedBox(height: 12),

            _FilterButton(
              title: 'Location',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 12),

            _FilterButton(
              title: 'Job role',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FilterButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}