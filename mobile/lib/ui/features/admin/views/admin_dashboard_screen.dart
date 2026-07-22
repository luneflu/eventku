import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../../auth/view_models/auth_view_model.dart';
import 'admin_users_tab.dart';
import 'admin_events_tab.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AdminUsersTab(),
    const AdminEventsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text(
          ['Manage Users', 'Manage Events'][_currentIndex],
          style: TextStyle(
            color: context.theme.colors.foreground,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        suffixes: [
          FHeaderAction(
            icon: Icon(Icons.logout),
            onPress: () {
              ref.read(authViewModelProvider.notifier).logout();
            },
          ),
        ],
      ),
      footer: FBottomNavigationBar(
        index: _currentIndex,
        onChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          FBottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: const Text('Users'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: const Text('Events'),
          ),
        ],
      ),
      child: _pages[_currentIndex],
    );
  }
}
