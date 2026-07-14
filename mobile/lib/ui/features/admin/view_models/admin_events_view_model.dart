import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/event.dart';
import '../../../../data/repositories/admin_repository.dart';

final adminEventsViewModelProvider = AsyncNotifierProvider<AdminEventsViewModel, List<Event>>(
  () => AdminEventsViewModel(),
);

class AdminEventsViewModel extends AsyncNotifier<List<Event>> {
  late AdminRepository _repository;

  @override
  FutureOr<List<Event>> build() async {
    _repository = ref.watch(adminRepositoryProvider);
    return await _fetchEvents();
  }

  Future<List<Event>> _fetchEvents() async {
    final response = await _repository.getEvents();
    return response.data;
  }

  Future<void> toggleEventBan(int id) async {
    final previousState = state;
    try {
      final updatedEvent = await _repository.toggleEventBan(id);
      
      state = AsyncValue.data(
        state.value?.map((event) => event.id == id ? updatedEvent : event).toList() ?? [],
      );
    } catch (e, st) {
      state = previousState;
      state = AsyncValue.error(e, st);
    }
  }
}
