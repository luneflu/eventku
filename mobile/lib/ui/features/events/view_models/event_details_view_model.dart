import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/event.dart';
import '../../../../data/repositories/event_repository.dart';

final eventDetailsViewModelProvider = AsyncNotifierProvider
    .family<EventDetailsViewModel, Event, Event>(
  (arg) => EventDetailsViewModel(arg),
);

class EventDetailsViewModel extends AsyncNotifier<Event> {
  EventDetailsViewModel(this._initialEvent);

  final Event _initialEvent;
  late EventRepository _repository;

  Event get _arg => _initialEvent;

  @override
  Future<Event> build() async {
    _repository = ref.watch(eventRepositoryProvider);
    return await _repository.getEvent(_arg.id.toString());
  }

  Future<void> publish() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.publishEvent(_arg.id.toString());
      return await _repository.getEvent(_arg.id.toString());
    });
  }

  Future<void> cancel() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.cancelEvent(_arg.id.toString());
      return await _repository.getEvent(_arg.id.toString());
    });
  }

  Future<void> finish() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.finishEvent(_arg.id.toString());
      return await _repository.getEvent(_arg.id.toString());
    });
  }

  Future<void> participate() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.participate(_arg.id.toString());
      return await _repository.getEvent(_arg.id.toString());
    });
  }

  Future<void> cancelParticipation() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.cancelParticipation(_arg.id.toString());
      return await _repository.getEvent(_arg.id.toString());
    });
  }

  Future<Uint8List> downloadCertificate() async {
    return await _repository.downloadCertificate(_arg.id.toString());
  }
}
