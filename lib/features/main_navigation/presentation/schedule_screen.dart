import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/widgets/job_item_card.dart';

import '../../../app/routes.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
      body: TabBarView(
        controller: _tabController,
        children: [
          _scheduleList(status: 'Confirmed'),
          _scheduleList(status: 'Pending'),
          _scheduleList(status: 'Rejected'),
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
        indicatorWeight: 3,
        labelColor: AppColors.yellow,
        unselectedLabelColor: AppColors.secondary,
        padding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        tabs: _tabs.map((e) => Tab(text: e)).toList(),
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

  Widget _scheduleList({required String status}) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, AppRoutes.jobDetail,arguments: status);
          },
          child: JobItemCard(
            date: 'Tomorrow, Tuesday, November 18',
            time: '16:00 - 00:30',
            title: 'North — New Accreditations to Work Future Etihad Games',
            role: 'Bar Staff',
            location: 'Etihad Stadium, Manchester',
            status: status,
          ),
        );
      },
    );
  }
}
