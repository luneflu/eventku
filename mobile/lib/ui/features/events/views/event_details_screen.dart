import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/event.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../view_models/event_details_view_model.dart';
import '../view_models/events_view_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';

import '../../../core/utils/error_handler.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final Event event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {

  Future<void> _performAction(Future<void> Function() action) async {
    try {
      await action();
      // Invalidate list views so they refresh data when returning
      ref.invalidate(publicEventsViewModelProvider);
      ref.invalidate(myEventsViewModelProvider);
      ref.invalidate(attendedEventsViewModelProvider);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(extractErrorMessage(e))));
      }
    }
  }

  Future<void> _downloadCertificate() async {
    try {
      final bytes = await ref.read(eventDetailsViewModelProvider(widget.event).notifier).downloadCertificate();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/certificate_${widget.event.id}.png');
      await file.writeAsBytes(bytes);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Certificate downloaded')));
      }
      await OpenFilex.open(file.path);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to download: ${extractErrorMessage(e)}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authViewModelProvider).value;
    final eventState = ref.watch(eventDetailsViewModelProvider(widget.event));

    final currentEvent = eventState.value ?? widget.event;
    final isOrganizer = currentUser?.id == currentEvent.organizerId;
    final isLoading = eventState.isLoading;
    final hasJoined = currentEvent.participants?.any((p) => p.id == currentUser?.id) ?? false;

    return FScaffold(
      header: FHeader(
        title: Text(currentEvent.title),
        suffixes: [
          FHeaderAction(
            icon: Icon(Icons.chevron_left),
            onPress: () => context.pop(),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                currentEvent.status.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(currentEvent.description, style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.theme.colors.muted,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 12),
                      Text('Date: ${currentEvent.date.toString().substring(0, 10)}', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 20),
                      const SizedBox(width: 12),
                      Expanded(child: Text('Location: ${currentEvent.location}', style: const TextStyle(fontSize: 16))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (eventState.hasError)
              FAlert(
                title: const Text('Error'),
                subtitle: Text(extractErrorMessage(eventState.error)),
                style: context.theme.alertStyles.destructive,
              ),
            const SizedBox(height: 16),
            
            if (isLoading) const Center(child: CircularProgressIndicator())
            else if (isOrganizer) ...[
              if (currentEvent.status == 'draft')
                FButton(
                  onPress: () => _performAction(() => ref.read(eventDetailsViewModelProvider(widget.event).notifier).publish()),
                  child: const Text('Publish Event'),
                ),
              const SizedBox(height: 8),
              if (currentEvent.status != 'cancelled' && currentEvent.status != 'finished')
                FButton(
                  variant: FButtonVariant.outline,
                  onPress: () => _performAction(() => ref.read(eventDetailsViewModelProvider(widget.event).notifier).cancel()),
                  child: const Text('Cancel Event'),
                ),
              const SizedBox(height: 8),
              if (currentEvent.status == 'public')
                FButton(
                  onPress: () => _performAction(() => ref.read(eventDetailsViewModelProvider(widget.event).notifier).finish()),
                  child: const Text('Finish Event'),
                ),
              const SizedBox(height: 24),
              if (currentEvent.status == 'public' && currentEvent.qrToken != null)
                Center(
                  child: Column(
                    children: [
                      const Text('Attendance QR Code', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        child: QrImageView(
                          data: currentEvent.qrToken!,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ],
                  ),
                ),
            ] else ...[
              // Participant actions
              if (!hasJoined && currentEvent.status == 'public') ...[
                SizedBox(
                  width: double.infinity,
                  child: FButton(
                    onPress: () => _performAction(() => ref.read(eventDetailsViewModelProvider(widget.event).notifier).participate()),
                    child: const Text('Participate Now'),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (hasJoined && currentEvent.status == 'public') ...[
                SizedBox(
                  width: double.infinity,
                  child: FButton(
                    variant: FButtonVariant.outline,
                    onPress: () => _performAction(() => ref.read(eventDetailsViewModelProvider(widget.event).notifier).cancelParticipation()),
                    child: const Text('Cancel Participation'),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (currentEvent.status == 'finished' && hasJoined) ...[
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FButton(
                    onPress: _downloadCertificate,
                    child: const Text('Download Certificate'),
                  ),
                ),
              ],
            ],
            if (currentEvent.participants != null && currentEvent.participants!.isNotEmpty) ...[
              const SizedBox(height: 32),
              const Text('Participants', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ...currentEvent.participants!.map((user) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: context.theme.colors.muted,
                          child: Icon(Icons.person, size: 20, color: context.theme.colors.mutedForeground),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                              if (user.joinedAt != null)
                                Text('Joined: ${user.joinedAt!.toString().substring(0, 16)}', style: TextStyle(fontSize: 13, color: context.theme.colors.mutedForeground)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}

