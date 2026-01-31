import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/features/main_navigation/presentation/chat_screen.dart';
import 'package:usafi_app/features/main_navigation/presentation/feed_screen.dart';
import 'package:usafi_app/features/main_navigation/presentation/home_screen.dart';
import 'package:usafi_app/features/main_navigation/presentation/offer_screen.dart';
import 'package:usafi_app/features/main_navigation/presentation/schedule_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ScheduleScreen(),
    OffersScreen(),
    FeedsScreen(),
    ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
        ),
        child: Scaffold(
      body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() => _currentIndex = index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.secondary,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textPrimary,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
            items: [
              BottomNavigationBarItem(icon: BottomNavItem(
                icon: _currentIndex == 0?homeSelected:homeUnselected,
                label: 'Home',
                isSelected: _currentIndex == 0,
              ),
                label: "HOME"
              ),
              BottomNavigationBarItem(
                icon: BottomNavItem(
                  icon: _currentIndex == 1?scheduleSelected:scheduleUnselected,
                  label: 'Schedule',
                  isSelected: _currentIndex == 1,
                ),
                label: "SCHEDULE",
              ),
              BottomNavigationBarItem(
                icon: BottomNavItem(
                  icon: _currentIndex == 2?offerSelected:offerUnselected,
                  label: 'Offers',
                  isSelected: _currentIndex == 2,
                ),
                label: "OFFERS",
              ),
              BottomNavigationBarItem(
                icon: BottomNavItem(
                  icon: _currentIndex == 3?feedSelected:feedUnselected,
                  label: 'Feeds',
                  isSelected: _currentIndex == 3,
                ),
                label: "FEEDS",
              ),
              BottomNavigationBarItem(
                icon: BottomNavItem(
                  icon: _currentIndex == 4?chatSelected:chatUnselected,
                  label: 'Chat',
                  isSelected: _currentIndex == 4,
                ),
                label: "CHAT",
              ),
            ],
          ),
        ));
  }


}

class BottomNavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 2,
          width: 28,
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Image(
          image: AssetImage(icon),
          height: 25,
        ),
      ],
    );
  }
}
