import 'package:flutter/material.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/widgets/job_item_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = [
    'Upcoming',
    'Running Jobs',
    'Finished Jobs',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _tabBar(),
          Container(
            height: 03,
            color: AppColors.primary,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _historyList(status: 'Confirmed'),
                  _historyList(status: 'Running'),
                  _historyList(status: 'Finished'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primary,
      leading: _circleIcon(Icons.arrow_back, () {
        Navigator.pop(context);
      }),
      title: const Text(
        'History',
        style: TextStyle(
          color: AppColors.secondary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 16),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.circleButton,
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.yellow,
      indicatorWeight: 0.3,
      labelPadding: EdgeInsetsGeometry.zero,
      dividerColor: Colors.transparent,
      labelColor: AppColors.yellow,
      unselectedLabelColor: AppColors.secondary,
      labelStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      tabs: _tabs.map((e) => Tab(text: e)).toList(),
    );
  }

  Widget _historyList({required String status}) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (_, index) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, AppRoutes.jobDetail,arguments: {"jobStatus":status, "isFromWhere":true});
          },
          child: JobItemCard(
            date: 'Tomorrow, Tuesday, November 18',
            time: '16:00 - 00:30',
            title: 'North — New Accreditations to Work Future Etihad Games',
            role: 'Bar Staff',
            index: index,
            location: 'Etihad Stadium, Manchester',
            status: status,
          ),
        );
      },
    );
  }
}
