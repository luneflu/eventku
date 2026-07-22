import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../../auth/view_models/auth_view_model.dart';
import 'home_tab.dart';
import '../../scan/views/scan_tab.dart';
import 'attended_tab.dart';
import 'created_tab.dart';

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
          ['Discover', 'Scan QR', 'Attended', 'My Events'][_currentIndex],
          style: TextStyle(
            color: context.theme.colors.foreground,
            fontSize: 28, // Made it larger for a friendlier look
            fontWeight: FontWeight.w800,
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
            icon: Icon(Icons.home),
            label: const Text('Home'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: const Text('Scan'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: const Text('Attended'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: const Text('Created'),
          ),
        ],
      ),
      child: _pages[_currentIndex],
    );
  }
}
