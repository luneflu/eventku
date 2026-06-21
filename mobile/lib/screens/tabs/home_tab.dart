import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import '../../providers/event_provider.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(publicEventsProvider);

    return eventsAsync.when(
      data: (events) {
        if (events.isEmpty) {
          return const Center(child: Text('No events found.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: events.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final event = events[index];
            return GestureDetector(
              onTap: () => context.push('/event-details', extra: event),
              child: FCard(
                title: Text(event.title),
                subtitle: Text(event.location),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.date.toString().substring(0, 10)),
                    const SizedBox(height: 8),
                    Text(
                      event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
