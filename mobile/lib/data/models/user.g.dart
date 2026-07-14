// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  joinedAt: json['joined_at'] == null
      ? null
      : DateTime.parse(json['joined_at'] as String),
  role: json['role'] as String? ?? 'user',
  isBanned: json['is_banned'] as bool? ?? false,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'joined_at': instance.joinedAt?.toIso8601String(),
  'role': instance.role,
  'is_banned': instance.isBanned,
};
