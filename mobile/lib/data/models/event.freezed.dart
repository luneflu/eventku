// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Event {

 int get id; String get title; String get description; DateTime get date; String get location;@JsonKey(name: 'organizer_id') int get organizerId; String get status;@JsonKey(name: 'qr_token') String? get qrToken;@JsonKey(name: 'max_capacity') int get maxCapacity;@JsonKey(name: 'registration_deadline') DateTime get registrationDeadline; User? get organizer;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.location, location) || other.location == location)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.qrToken, qrToken) || other.qrToken == qrToken)&&(identical(other.maxCapacity, maxCapacity) || other.maxCapacity == maxCapacity)&&(identical(other.registrationDeadline, registrationDeadline) || other.registrationDeadline == registrationDeadline)&&(identical(other.organizer, organizer) || other.organizer == organizer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,date,location,organizerId,status,qrToken,maxCapacity,registrationDeadline,organizer);

@override
String toString() {
  return 'Event(id: $id, title: $title, description: $description, date: $date, location: $location, organizerId: $organizerId, status: $status, qrToken: $qrToken, maxCapacity: $maxCapacity, registrationDeadline: $registrationDeadline, organizer: $organizer)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, DateTime date, String location,@JsonKey(name: 'organizer_id') int organizerId, String status,@JsonKey(name: 'qr_token') String? qrToken,@JsonKey(name: 'max_capacity') int maxCapacity,@JsonKey(name: 'registration_deadline') DateTime registrationDeadline, User? organizer
});


$UserCopyWith<$Res>? get organizer;

}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? date = null,Object? location = null,Object? organizerId = null,Object? status = null,Object? qrToken = freezed,Object? maxCapacity = null,Object? registrationDeadline = null,Object? organizer = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,qrToken: freezed == qrToken ? _self.qrToken : qrToken // ignore: cast_nullable_to_non_nullable
as String?,maxCapacity: null == maxCapacity ? _self.maxCapacity : maxCapacity // ignore: cast_nullable_to_non_nullable
as int,registrationDeadline: null == registrationDeadline ? _self.registrationDeadline : registrationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime,organizer: freezed == organizer ? _self.organizer : organizer // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get organizer {
    if (_self.organizer == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.organizer!, (value) {
    return _then(_self.copyWith(organizer: value));
  });
}
}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Event value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Event value)  $default,){
final _that = this;
switch (_that) {
case _Event():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Event value)?  $default,){
final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  DateTime date,  String location, @JsonKey(name: 'organizer_id')  int organizerId,  String status, @JsonKey(name: 'qr_token')  String? qrToken, @JsonKey(name: 'max_capacity')  int maxCapacity, @JsonKey(name: 'registration_deadline')  DateTime registrationDeadline,  User? organizer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.date,_that.location,_that.organizerId,_that.status,_that.qrToken,_that.maxCapacity,_that.registrationDeadline,_that.organizer);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  DateTime date,  String location, @JsonKey(name: 'organizer_id')  int organizerId,  String status, @JsonKey(name: 'qr_token')  String? qrToken, @JsonKey(name: 'max_capacity')  int maxCapacity, @JsonKey(name: 'registration_deadline')  DateTime registrationDeadline,  User? organizer)  $default,) {final _that = this;
switch (_that) {
case _Event():
return $default(_that.id,_that.title,_that.description,_that.date,_that.location,_that.organizerId,_that.status,_that.qrToken,_that.maxCapacity,_that.registrationDeadline,_that.organizer);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  DateTime date,  String location, @JsonKey(name: 'organizer_id')  int organizerId,  String status, @JsonKey(name: 'qr_token')  String? qrToken, @JsonKey(name: 'max_capacity')  int maxCapacity, @JsonKey(name: 'registration_deadline')  DateTime registrationDeadline,  User? organizer)?  $default,) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.date,_that.location,_that.organizerId,_that.status,_that.qrToken,_that.maxCapacity,_that.registrationDeadline,_that.organizer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Event implements Event {
  const _Event({required this.id, required this.title, required this.description, required this.date, required this.location, @JsonKey(name: 'organizer_id') required this.organizerId, required this.status, @JsonKey(name: 'qr_token') this.qrToken, @JsonKey(name: 'max_capacity') required this.maxCapacity, @JsonKey(name: 'registration_deadline') required this.registrationDeadline, this.organizer});
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

@override final  int id;
@override final  String title;
@override final  String description;
@override final  DateTime date;
@override final  String location;
@override@JsonKey(name: 'organizer_id') final  int organizerId;
@override final  String status;
@override@JsonKey(name: 'qr_token') final  String? qrToken;
@override@JsonKey(name: 'max_capacity') final  int maxCapacity;
@override@JsonKey(name: 'registration_deadline') final  DateTime registrationDeadline;
@override final  User? organizer;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.location, location) || other.location == location)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.qrToken, qrToken) || other.qrToken == qrToken)&&(identical(other.maxCapacity, maxCapacity) || other.maxCapacity == maxCapacity)&&(identical(other.registrationDeadline, registrationDeadline) || other.registrationDeadline == registrationDeadline)&&(identical(other.organizer, organizer) || other.organizer == organizer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,date,location,organizerId,status,qrToken,maxCapacity,registrationDeadline,organizer);

@override
String toString() {
  return 'Event(id: $id, title: $title, description: $description, date: $date, location: $location, organizerId: $organizerId, status: $status, qrToken: $qrToken, maxCapacity: $maxCapacity, registrationDeadline: $registrationDeadline, organizer: $organizer)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, DateTime date, String location,@JsonKey(name: 'organizer_id') int organizerId, String status,@JsonKey(name: 'qr_token') String? qrToken,@JsonKey(name: 'max_capacity') int maxCapacity,@JsonKey(name: 'registration_deadline') DateTime registrationDeadline, User? organizer
});


@override $UserCopyWith<$Res>? get organizer;

}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? date = null,Object? location = null,Object? organizerId = null,Object? status = null,Object? qrToken = freezed,Object? maxCapacity = null,Object? registrationDeadline = null,Object? organizer = freezed,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,qrToken: freezed == qrToken ? _self.qrToken : qrToken // ignore: cast_nullable_to_non_nullable
as String?,maxCapacity: null == maxCapacity ? _self.maxCapacity : maxCapacity // ignore: cast_nullable_to_non_nullable
as int,registrationDeadline: null == registrationDeadline ? _self.registrationDeadline : registrationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime,organizer: freezed == organizer ? _self.organizer : organizer // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get organizer {
    if (_self.organizer == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.organizer!, (value) {
    return _then(_self.copyWith(organizer: value));
  });
}
}

// dart format on
