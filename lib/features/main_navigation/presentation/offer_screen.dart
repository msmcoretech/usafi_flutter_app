import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_circle_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';
import 'package:usafi_app/core/widgets/job_item_card.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  DateTime selectedMonth = DateTime(2025, 11);

  void _pickMonthYear() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        selectedMonth = DateTime(picked.year, picked.month);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: _appBar(),
      body: Column(
        children: [
          _monthSelector(),
          Expanded(child: _offersList()),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleSpacing: 0,
      title: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        color: AppColors.primary,
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.circleButton,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image(image:AssetImage(search),height: 18,),
              SizedBox(width: 8),
              Text(
                'Search...',
                style: TextStyle(color: AppColors.secondary.withOpacity(0.8),fontWeight: FontWeight.w300,fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      actions: [
        PopupMenuButton<String>(
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
          onSelected: (value) {
            debugPrint(value);
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

  Widget _monthSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: _pickMonthYear,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_monthName(selectedMonth.month)} ${selectedMonth.year}',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _offersList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 5,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.jobDetail,
              arguments: {"jobStatus": "New!", "isFromWhere": false},
            );
          },
          child: JobItemCard(
            date: 'Tomorrow, Tuesday, November 18',
            time: '16:00 - 00:30',
            title: 'North — New Accreditations to Work Future Etihad Games',
            role: 'Bar Staff',
            locationText: 'Etihad Stadium, Manchester',
            status: 'New!',
            index: index,
            showApplyButton: true,
            onApply: () {},
          ),
        );
      },
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    return months[month - 1];
  }
}
