import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
abstract class Event with _$Event {
  const factory Event({
    required int id,
    required String title,
    required String description,
    required DateTime date,
    required String location,
    @JsonKey(name: 'organizer_id') required int organizerId,
    required String status,
    @JsonKey(name: 'qr_token') String? qrToken,
    @JsonKey(name: 'max_capacity') required int maxCapacity,
    @JsonKey(name: 'registration_deadline') required DateTime registrationDeadline,
    User? organizer,
    List<User>? participants,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
