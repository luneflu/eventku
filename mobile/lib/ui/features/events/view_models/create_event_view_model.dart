import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/event_repository.dart';
import 'events_view_model.dart';

final createEventViewModelProvider =
    AsyncNotifierProvider<CreateEventViewModel, void>(
  CreateEventViewModel.new,
);

class CreateEventViewModel extends AsyncNotifier<void> {
  late EventRepository _repository;

  @override
  Future<void> build() async {
    _repository = ref.watch(eventRepositoryProvider);
  }

  Future<void> create(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.createEvent(data);
      ref.invalidate(myEventsViewModelProvider);
    });
  }
}
