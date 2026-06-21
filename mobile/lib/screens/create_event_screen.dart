import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../providers/auth_provider.dart';
import '../providers/event_provider.dart';
import 'package:go_router/go_router.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  bool _isLoading = false;

  Future<void> _submit() async {
    if (_titleController.text.isEmpty || _locationController.text.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final api = ref.read(apiServiceProvider);
      await api.createEvent({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'location': _locationController.text,
        'date': _selectedDate.toIso8601String(),
        'max_capacity': 100, // standard default
        'registration_deadline': _selectedDate.subtract(const Duration(days: 1)).toIso8601String(),
      });
      ref.invalidate(myEventsProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('Create Event'),
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
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 16),
            // Minimal date picker trigger
            FButton(
              child: Text('Date: ${_selectedDate.toIso8601String().substring(0, 10)}'),
              onPress: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => _selectedDate = date);
                }
              },
            ),
            const SizedBox(height: 32),
            FButton(
              onPress: _isLoading ? null : _submit,
              child: _isLoading ? const CircularProgressIndicator() : const Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}
