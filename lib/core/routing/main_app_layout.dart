import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';

class MainAppLayout extends StatelessWidget {
  final Widget child;
  final String currentLocation;

  const MainAppLayout({
    super.key,
    required this.child,
    required this.currentLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _MainBottomNavigation(
        currentLocation: currentLocation,
      ),
    );
  }
}

class _MainBottomNavigation extends StatelessWidget {
  final String currentLocation;

  const _MainBottomNavigation({required this.currentLocation});

  int _getSelectedIndex() {
    if (currentLocation.startsWith('/home')) return 0;
    if (currentLocation.startsWith('/questions')) return 1;
    if (currentLocation.startsWith('/statistics')) return 2;
    if (currentLocation.startsWith('/profile') ||
        currentLocation.startsWith('/settings'))
      return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _getSelectedIndex(),
        onTap: (index) => _onTabSelected(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            activeIcon: Icon(Icons.quiz),
            label: '문제풀이',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: '통계',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '더보기',
          ),
        ],
      ),
    );
  }

  void _onTabSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/questions');
        break;
      case 2:
        context.go('/statistics');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}
