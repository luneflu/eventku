import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../view_models/admin_events_view_model.dart';
import '../../../core/widgets/event_card.dart';

class AdminEventsTab extends ConsumerWidget {
  const AdminEventsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsState = ref.watch(adminEventsViewModelProvider);

    return eventsState.when(
      data: (events) {
        if (events.isEmpty) {
          return const Center(child: Text('No events found.'));
        }
        return ListView.separated(
          itemCount: events.length,
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final event = events[index];
            return Column(
              children: [
                EventCard(
                  event: event,
                  index: index,
                ),
                const SizedBox(height: 8),
                FButton(
                  onPress: () {
                    ref.read(adminEventsViewModelProvider.notifier).toggleEventBan(event.id);
                  },
                  variant: event.isBanned ? FButtonVariant.outline : FButtonVariant.destructive,
                  child: Text(event.isBanned ? 'Unban Event' : 'Ban Event'),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
