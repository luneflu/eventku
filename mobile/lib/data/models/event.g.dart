// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  date: DateTime.parse(json['date'] as String),
  location: json['location'] as String,
  organizerId: (json['organizer_id'] as num).toInt(),
  status: json['status'] as String,
  qrToken: json['qr_token'] as String?,
  maxCapacity: (json['max_capacity'] as num).toInt(),
  registrationDeadline: DateTime.parse(json['registration_deadline'] as String),
  organizer: json['organizer'] == null
      ? null
      : User.fromJson(json['organizer'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'date': instance.date.toIso8601String(),
  'location': instance.location,
  'organizer_id': instance.organizerId,
  'status': instance.status,
  'qr_token': instance.qrToken,
  'max_capacity': instance.maxCapacity,
  'registration_deadline': instance.registrationDeadline.toIso8601String(),
  'organizer': instance.organizer,
};
