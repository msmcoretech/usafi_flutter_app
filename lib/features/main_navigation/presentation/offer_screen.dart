import 'package:flutter/material.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
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
      appBar: _topBar(),
      body: Column(
        children: [
          _monthSelector(),
          Expanded(child: _offersList()),
        ],
      ),
    );
  }

  PreferredSizeWidget _topBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleSpacing: 0,
      title: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        color: AppColors.primary,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.circleButton,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppColors.secondary.withOpacity(0.8),fontWeight: FontWeight.w200,),
                    SizedBox(width: 8),
                    Text(
                      'Search...',
                      style: TextStyle(color: AppColors.secondary.withOpacity(0.8),fontWeight: FontWeight.w300,fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: AppColors.circleButton,
          child: Icon(Icons.tune_outlined,color: AppColors.secondary,size: 20,),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, AppRoutes.profile,);
          },
          child: CircleAvatar(
            backgroundColor: AppColors.circleButton,
            child: Icon(Icons.menu,color: AppColors.secondary,size: 20,),
          ),
        ),SizedBox(
          width: 10,
        ),
      ],
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
        return JobItemCard(
          date: 'Tomorrow, Tuesday, November 18',
          time: '16:00 - 00:30',
          title: 'North — New Accreditations to Work Future Etihad Games',
          role: 'Bar Staff',
          location: 'Etihad Stadium, Manchester',
          status: 'New!',
          showApplyButton: true,
          onApply: () {},
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
