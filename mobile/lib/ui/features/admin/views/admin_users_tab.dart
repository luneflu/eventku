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
        return ListView.separated(
          itemCount: users.length,
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final user = users[index];
            return Container(
              decoration: BoxDecoration(
                color: context.theme.colors.background,
                borderRadius: BorderRadius.circular(48),
                border: Border.all(color: context.theme.colors.border, width: 1),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          user.name, 
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: context.theme.colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          user.role.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: context.theme.colors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: TextStyle(color: context.theme.colors.mutedForeground, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
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
