// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchLease {

 String get deviceId;/// Server-tijd waarop dit toestel de lease nam.
 int get sinceMillis;
/// Create a copy of MatchLease
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchLeaseCopyWith<MatchLease> get copyWith => _$MatchLeaseCopyWithImpl<MatchLease>(this as MatchLease, _$identity);

  /// Serializes this MatchLease to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchLease&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.sinceMillis, sinceMillis) || other.sinceMillis == sinceMillis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,sinceMillis);

@override
String toString() {
  return 'MatchLease(deviceId: $deviceId, sinceMillis: $sinceMillis)';
}


}

/// @nodoc
abstract mixin class $MatchLeaseCopyWith<$Res>  {
  factory $MatchLeaseCopyWith(MatchLease value, $Res Function(MatchLease) _then) = _$MatchLeaseCopyWithImpl;
@useResult
$Res call({
 String deviceId, int sinceMillis
});




}
/// @nodoc
class _$MatchLeaseCopyWithImpl<$Res>
    implements $MatchLeaseCopyWith<$Res> {
  _$MatchLeaseCopyWithImpl(this._self, this._then);

  final MatchLease _self;
  final $Res Function(MatchLease) _then;

/// Create a copy of MatchLease
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? sinceMillis = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,sinceMillis: null == sinceMillis ? _self.sinceMillis : sinceMillis // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchLease].
extension MatchLeasePatterns on MatchLease {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchLease value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchLease() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchLease value)  $default,){
final _that = this;
switch (_that) {
case _MatchLease():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchLease value)?  $default,){
final _that = this;
switch (_that) {
case _MatchLease() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  int sinceMillis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchLease() when $default != null:
return $default(_that.deviceId,_that.sinceMillis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  int sinceMillis)  $default,) {final _that = this;
switch (_that) {
case _MatchLease():
return $default(_that.deviceId,_that.sinceMillis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  int sinceMillis)?  $default,) {final _that = this;
switch (_that) {
case _MatchLease() when $default != null:
return $default(_that.deviceId,_that.sinceMillis);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchLease implements MatchLease {
  const _MatchLease({required this.deviceId, required this.sinceMillis});
  factory _MatchLease.fromJson(Map<String, dynamic> json) => _$MatchLeaseFromJson(json);

@override final  String deviceId;
/// Server-tijd waarop dit toestel de lease nam.
@override final  int sinceMillis;

/// Create a copy of MatchLease
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchLeaseCopyWith<_MatchLease> get copyWith => __$MatchLeaseCopyWithImpl<_MatchLease>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchLeaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchLease&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.sinceMillis, sinceMillis) || other.sinceMillis == sinceMillis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,sinceMillis);

@override
String toString() {
  return 'MatchLease(deviceId: $deviceId, sinceMillis: $sinceMillis)';
}


}

/// @nodoc
abstract mixin class _$MatchLeaseCopyWith<$Res> implements $MatchLeaseCopyWith<$Res> {
  factory _$MatchLeaseCopyWith(_MatchLease value, $Res Function(_MatchLease) _then) = __$MatchLeaseCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, int sinceMillis
});




}
/// @nodoc
class __$MatchLeaseCopyWithImpl<$Res>
    implements _$MatchLeaseCopyWith<$Res> {
  __$MatchLeaseCopyWithImpl(this._self, this._then);

  final _MatchLease _self;
  final $Res Function(_MatchLease) _then;

/// Create a copy of MatchLease
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? sinceMillis = null,}) {
  return _then(_MatchLease(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,sinceMillis: null == sinceMillis ? _self.sinceMillis : sinceMillis // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MatchMeta {

 int get createdAtMillis; String? get tournamentId;/// Veld waarop de wedstrijd gepland is.
 String? get fieldId;/// Het enige toestel dat events mag schrijven; `null` zolang geen
/// tafeltoestel de wedstrijd genomen heeft.
 MatchLease? get lease;/// Veld waarop de wedstrijd nu live is; `null` als ze niet live is.
 String? get liveFieldId;
/// Create a copy of MatchMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchMetaCopyWith<MatchMeta> get copyWith => _$MatchMetaCopyWithImpl<MatchMeta>(this as MatchMeta, _$identity);

  /// Serializes this MatchMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchMeta&&(identical(other.createdAtMillis, createdAtMillis) || other.createdAtMillis == createdAtMillis)&&(identical(other.tournamentId, tournamentId) || other.tournamentId == tournamentId)&&(identical(other.fieldId, fieldId) || other.fieldId == fieldId)&&(identical(other.lease, lease) || other.lease == lease)&&(identical(other.liveFieldId, liveFieldId) || other.liveFieldId == liveFieldId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,createdAtMillis,tournamentId,fieldId,lease,liveFieldId);

@override
String toString() {
  return 'MatchMeta(createdAtMillis: $createdAtMillis, tournamentId: $tournamentId, fieldId: $fieldId, lease: $lease, liveFieldId: $liveFieldId)';
}


}

/// @nodoc
abstract mixin class $MatchMetaCopyWith<$Res>  {
  factory $MatchMetaCopyWith(MatchMeta value, $Res Function(MatchMeta) _then) = _$MatchMetaCopyWithImpl;
@useResult
$Res call({
 int createdAtMillis, String? tournamentId, String? fieldId, MatchLease? lease, String? liveFieldId
});


$MatchLeaseCopyWith<$Res>? get lease;

}
/// @nodoc
class _$MatchMetaCopyWithImpl<$Res>
    implements $MatchMetaCopyWith<$Res> {
  _$MatchMetaCopyWithImpl(this._self, this._then);

  final MatchMeta _self;
  final $Res Function(MatchMeta) _then;

/// Create a copy of MatchMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? createdAtMillis = null,Object? tournamentId = freezed,Object? fieldId = freezed,Object? lease = freezed,Object? liveFieldId = freezed,}) {
  return _then(_self.copyWith(
createdAtMillis: null == createdAtMillis ? _self.createdAtMillis : createdAtMillis // ignore: cast_nullable_to_non_nullable
as int,tournamentId: freezed == tournamentId ? _self.tournamentId : tournamentId // ignore: cast_nullable_to_non_nullable
as String?,fieldId: freezed == fieldId ? _self.fieldId : fieldId // ignore: cast_nullable_to_non_nullable
as String?,lease: freezed == lease ? _self.lease : lease // ignore: cast_nullable_to_non_nullable
as MatchLease?,liveFieldId: freezed == liveFieldId ? _self.liveFieldId : liveFieldId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MatchMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchLeaseCopyWith<$Res>? get lease {
    if (_self.lease == null) {
    return null;
  }

  return $MatchLeaseCopyWith<$Res>(_self.lease!, (value) {
    return _then(_self.copyWith(lease: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchMeta].
extension MatchMetaPatterns on MatchMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchMeta value)  $default,){
final _that = this;
switch (_that) {
case _MatchMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchMeta value)?  $default,){
final _that = this;
switch (_that) {
case _MatchMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int createdAtMillis,  String? tournamentId,  String? fieldId,  MatchLease? lease,  String? liveFieldId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchMeta() when $default != null:
return $default(_that.createdAtMillis,_that.tournamentId,_that.fieldId,_that.lease,_that.liveFieldId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int createdAtMillis,  String? tournamentId,  String? fieldId,  MatchLease? lease,  String? liveFieldId)  $default,) {final _that = this;
switch (_that) {
case _MatchMeta():
return $default(_that.createdAtMillis,_that.tournamentId,_that.fieldId,_that.lease,_that.liveFieldId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int createdAtMillis,  String? tournamentId,  String? fieldId,  MatchLease? lease,  String? liveFieldId)?  $default,) {final _that = this;
switch (_that) {
case _MatchMeta() when $default != null:
return $default(_that.createdAtMillis,_that.tournamentId,_that.fieldId,_that.lease,_that.liveFieldId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _MatchMeta extends MatchMeta {
  const _MatchMeta({required this.createdAtMillis, this.tournamentId, this.fieldId, this.lease, this.liveFieldId}): super._();
  factory _MatchMeta.fromJson(Map<String, dynamic> json) => _$MatchMetaFromJson(json);

@override final  int createdAtMillis;
@override final  String? tournamentId;
/// Veld waarop de wedstrijd gepland is.
@override final  String? fieldId;
/// Het enige toestel dat events mag schrijven; `null` zolang geen
/// tafeltoestel de wedstrijd genomen heeft.
@override final  MatchLease? lease;
/// Veld waarop de wedstrijd nu live is; `null` als ze niet live is.
@override final  String? liveFieldId;

/// Create a copy of MatchMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchMetaCopyWith<_MatchMeta> get copyWith => __$MatchMetaCopyWithImpl<_MatchMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchMeta&&(identical(other.createdAtMillis, createdAtMillis) || other.createdAtMillis == createdAtMillis)&&(identical(other.tournamentId, tournamentId) || other.tournamentId == tournamentId)&&(identical(other.fieldId, fieldId) || other.fieldId == fieldId)&&(identical(other.lease, lease) || other.lease == lease)&&(identical(other.liveFieldId, liveFieldId) || other.liveFieldId == liveFieldId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,createdAtMillis,tournamentId,fieldId,lease,liveFieldId);

@override
String toString() {
  return 'MatchMeta(createdAtMillis: $createdAtMillis, tournamentId: $tournamentId, fieldId: $fieldId, lease: $lease, liveFieldId: $liveFieldId)';
}


}

/// @nodoc
abstract mixin class _$MatchMetaCopyWith<$Res> implements $MatchMetaCopyWith<$Res> {
  factory _$MatchMetaCopyWith(_MatchMeta value, $Res Function(_MatchMeta) _then) = __$MatchMetaCopyWithImpl;
@override @useResult
$Res call({
 int createdAtMillis, String? tournamentId, String? fieldId, MatchLease? lease, String? liveFieldId
});


@override $MatchLeaseCopyWith<$Res>? get lease;

}
/// @nodoc
class __$MatchMetaCopyWithImpl<$Res>
    implements _$MatchMetaCopyWith<$Res> {
  __$MatchMetaCopyWithImpl(this._self, this._then);

  final _MatchMeta _self;
  final $Res Function(_MatchMeta) _then;

/// Create a copy of MatchMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? createdAtMillis = null,Object? tournamentId = freezed,Object? fieldId = freezed,Object? lease = freezed,Object? liveFieldId = freezed,}) {
  return _then(_MatchMeta(
createdAtMillis: null == createdAtMillis ? _self.createdAtMillis : createdAtMillis // ignore: cast_nullable_to_non_nullable
as int,tournamentId: freezed == tournamentId ? _self.tournamentId : tournamentId // ignore: cast_nullable_to_non_nullable
as String?,fieldId: freezed == fieldId ? _self.fieldId : fieldId // ignore: cast_nullable_to_non_nullable
as String?,lease: freezed == lease ? _self.lease : lease // ignore: cast_nullable_to_non_nullable
as MatchLease?,liveFieldId: freezed == liveFieldId ? _self.liveFieldId : liveFieldId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MatchMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchLeaseCopyWith<$Res>? get lease {
    if (_self.lease == null) {
    return null;
  }

  return $MatchLeaseCopyWith<$Res>(_self.lease!, (value) {
    return _then(_self.copyWith(lease: value));
  });
}
}

// dart format on
