import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import '../../events/view_models/events_view_model.dart';

class CreatedTab extends ConsumerWidget {
  const CreatedTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(myEventsViewModelProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FButton(
            child: const Text('Create New Event'),
            onPress: () {
              context.push('/create-event');
            },
          ),
        ),
        Expanded(
          child: eventsAsync.when(
            data: (events) {
              if (events.isEmpty) {
                return const Center(child: Text('You haven\'t created any events yet.'));
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: events.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final event = events[index];
                  return GestureDetector(
                    onTap: () => context.push('/event-details', extra: event),
                    child: FCard(
                      title: Text(event.title),
                      subtitle: Text('Status: ${event.status}'),
                      child: Text(event.date.toString().substring(0, 10)),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
        ),
      ],
    );
  }
}
