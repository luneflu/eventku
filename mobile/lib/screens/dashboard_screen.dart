import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../providers/auth_provider.dart';
import 'tabs/home_tab.dart';
import 'tabs/scan_tab.dart';
import 'tabs/attended_tab.dart';
import 'tabs/created_tab.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const ScanTab(),
    const AttendedTab(),
    const CreatedTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text(
          ['Events', 'Scan QR', 'My Attendance', 'My Events'][_currentIndex],
          style: TextStyle(
            color: context.theme.colors.foreground,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        suffixes: [
          FHeaderAction(
            icon: Icon(FIcons.logOut),
            onPress: () async {
              await ref.read(authProvider.notifier).logout();
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
            icon: Icon(FIcons.house),
            label: const Text('Home'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(FIcons.scan),
            label: const Text('Scan'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(FIcons.ticket),
            label: const Text('Attended'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(FIcons.calendar),
            label: const Text('Created'),
          ),
        ],
      ),
      child: _pages[_currentIndex],
    );
  }
}
