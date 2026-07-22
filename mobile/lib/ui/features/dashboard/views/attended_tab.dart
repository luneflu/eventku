import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../events/view_models/events_view_model.dart';
import '../../../core/widgets/event_card.dart';

class AttendedTab extends ConsumerWidget {
  const AttendedTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participationsAsync = ref.watch(attendedEventsViewModelProvider);

    return participationsAsync.when(
      data: (events) {
        if (events.isEmpty) {
          return const Center(child: Text('You are not participating in any events.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: events.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final event = events[index];
            return EventCard(event: event, index: index);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
