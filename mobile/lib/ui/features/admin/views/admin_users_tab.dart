import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../view_models/admin_users_view_model.dart';

class AdminUsersTab extends ConsumerWidget {
  const AdminUsersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(adminUsersViewModelProvider);

    return usersState.when(
      data: (users) {
        if (users.isEmpty) {
          return const Center(child: Text('No users found.'));
        }
        return ListView.builder(
          itemCount: users.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final user = users[index];
            return FCard(
              title: Text(user.name),
              subtitle: Text(user.email),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text('Role: ${user.role}'),
                  const SizedBox(height: 8),
                  FButton(
                    onPress: user.role == 'admin' ? null : () {
                      ref.read(adminUsersViewModelProvider.notifier).toggleUserBan(user.id);
                    },
                    variant: user.isBanned ? FButtonVariant.outline : FButtonVariant.destructive,
                    child: Text(user.isBanned ? 'Unban User' : 'Ban User'),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
