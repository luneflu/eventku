import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../view_models/create_event_view_model.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/error_handler.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 7));

  Future<void> _submit() async {
    if (_titleController.text.isEmpty || _locationController.text.isEmpty) return;

    await ref.read(createEventViewModelProvider.notifier).create({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'location': _locationController.text,
      'date': _selectedDate.toIso8601String(),
      'max_capacity': 100, // standard default
      'registration_deadline': _selectedDate.subtract(const Duration(days: 1)).toIso8601String(),
    });

    final state = ref.read(createEventViewModelProvider);
    if (state.hasError) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(extractErrorMessage(state.error))),
        );
      }
    } else {
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(createEventViewModelProvider);

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
            FTextField(
              control: FTextFieldControl.managed(controller: _titleController),
              label: const Text('Title'),
            ),
            const SizedBox(height: 16),
            FTextField(
              control: FTextFieldControl.managed(controller: _descriptionController),
              label: const Text('Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            FTextField(
              control: FTextFieldControl.managed(controller: _locationController),
              label: const Text('Location'),
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
              onPress: stateAsync.isLoading ? null : _submit,
              child: stateAsync.isLoading ? const CircularProgressIndicator() : const Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}

