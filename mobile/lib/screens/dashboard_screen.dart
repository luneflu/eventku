import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../providers/auth_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.value;

    return FScaffold(
      header: FHeader(
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: context.theme.colors.foreground,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        suffixes: [
          FButton.icon(
            variant: FButtonVariant.ghost,
            onPress: () async {
              await ref.read(authProvider.notifier).logout();
            },
            child: Icon(FIcons.logOut),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello World',
              style: TextStyle(
                color: context.theme.colors.foreground,
                fontSize: 36,
                fontWeight: FontWeight.w900,
              ),
            ),
            if (user != null) ...[
              const SizedBox(height: 16),
              Text(
                'Logged in as: ${user.name}',
                style: TextStyle(
                  color: context.theme.colors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user.email,
                style: TextStyle(
                  color: context.theme.colors.mutedForeground,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
