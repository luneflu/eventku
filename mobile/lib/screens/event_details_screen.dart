import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import '../models/event.dart';
import '../providers/auth_provider.dart';
import '../providers/event_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';

import '../utils/error_handler.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final Event event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  late Event _currentEvent;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _currentEvent = widget.event;
  }

  Future<void> _refreshEvent() async {
    final api = ref.read(apiServiceProvider);
    final event = await api.getEvent(_currentEvent.id);
    setState(() {
      _currentEvent = event;
    });
  }

  Future<void> _performAction(Future<void> Function() action) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await action();
      await _refreshEvent();
      ref.invalidate(publicEventsProvider);
      ref.invalidate(myEventsProvider);
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = extractErrorMessage(e);
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _downloadCertificate() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final bytes = await ref.read(apiServiceProvider).downloadCertificate(_currentEvent.id);
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/certificate_${_currentEvent.id}.png');
      await file.writeAsBytes(bytes);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Certificate downloaded')));
      }
      await OpenFilex.open(file.path);
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to download: ${extractErrorMessage(e)}';
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authProvider).value;
    final isOrganizer = currentUser?.id == _currentEvent.organizerId;

    return FScaffold(
      header: FHeader(
        title: Text(_currentEvent.title),
        suffixes: [
          FHeaderAction(
            icon: Icon(FIcons.chevronLeft),
            onPress: () => context.pop(),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${_currentEvent.status}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(_currentEvent.description),
            const SizedBox(height: 16),
            Text('Date: ${_currentEvent.date.toString().substring(0, 10)}'),
            Text('Location: ${_currentEvent.location}'),
            const SizedBox(height: 16),
            if (_errorMessage != null)
              FAlert(
                title: const Text('Error'),
                subtitle: Text(_errorMessage!),
                style: context.theme.alertStyles.destructive,
              ),
            const SizedBox(height: 16),
            
            if (_isLoading) const Center(child: CircularProgressIndicator())
            else if (isOrganizer) ...[
              if (_currentEvent.status == 'draft')
                FButton(
                  onPress: () => _performAction(() => ref.read(apiServiceProvider).publishEvent(_currentEvent.id)),
                  child: const Text('Publish Event'),
                ),
              const SizedBox(height: 8),
              if (_currentEvent.status != 'cancelled' && _currentEvent.status != 'finished')
                FButton(
                  variant: FButtonVariant.outline,
                  onPress: () => _performAction(() => ref.read(apiServiceProvider).cancelEvent(_currentEvent.id)),
                  child: const Text('Cancel Event'),
                ),
              const SizedBox(height: 8),
              if (_currentEvent.status == 'public')
                FButton(
                  onPress: () => _performAction(() => ref.read(apiServiceProvider).finishEvent(_currentEvent.id)),
                  child: const Text('Finish Event'),
                ),
              const SizedBox(height: 24),
              if (_currentEvent.status == 'public' && _currentEvent.qrToken != null)
                Center(
                  child: Column(
                    children: [
                      const Text('Attendance QR Code', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        child: QrImageView(
                          data: _currentEvent.qrToken!,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ],
                  ),
                ),
            ] else ...[
              // Participant actions
              FButton(
                onPress: () => _performAction(() => ref.read(apiServiceProvider).participate(_currentEvent.id)),
                child: const Text('Participate'),
              ),
              const SizedBox(height: 8),
              FButton(
                variant: FButtonVariant.outline,
                onPress: () => _performAction(() => ref.read(apiServiceProvider).cancelParticipation(_currentEvent.id)),
                child: const Text('Cancel Participation'),
              ),
              if (_currentEvent.status == 'finished') ...[
                const SizedBox(height: 16),
                FButton(
                  onPress: _downloadCertificate,
                  child: const Text('Download Certificate'),
                ),
              ],
            ]
          ],
        ),
      ),
    );
  }
}
