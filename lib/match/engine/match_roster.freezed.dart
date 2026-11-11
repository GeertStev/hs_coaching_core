// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_roster.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchPlayer {

 int get cap; String get name; MatchPlayerRole get role; String? get playerId;
/// Create a copy of MatchPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchPlayerCopyWith<MatchPlayer> get copyWith => _$MatchPlayerCopyWithImpl<MatchPlayer>(this as MatchPlayer, _$identity);

  /// Serializes this MatchPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchPlayer&&(identical(other.cap, cap) || other.cap == cap)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.playerId, playerId) || other.playerId == playerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cap,name,role,playerId);

@override
String toString() {
  return 'MatchPlayer(cap: $cap, name: $name, role: $role, playerId: $playerId)';
}


}

/// @nodoc
abstract mixin class $MatchPlayerCopyWith<$Res>  {
  factory $MatchPlayerCopyWith(MatchPlayer value, $Res Function(MatchPlayer) _then) = _$MatchPlayerCopyWithImpl;
@useResult
$Res call({
 int cap, String name, MatchPlayerRole role, String? playerId
});




}
/// @nodoc
class _$MatchPlayerCopyWithImpl<$Res>
    implements $MatchPlayerCopyWith<$Res> {
  _$MatchPlayerCopyWithImpl(this._self, this._then);

  final MatchPlayer _self;
  final $Res Function(MatchPlayer) _then;

/// Create a copy of MatchPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cap = null,Object? name = null,Object? role = null,Object? playerId = freezed,}) {
  return _then(_self.copyWith(
cap: null == cap ? _self.cap : cap // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MatchPlayerRole,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchPlayer].
extension MatchPlayerPatterns on MatchPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchPlayer value)  $default,){
final _that = this;
switch (_that) {
case _MatchPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _MatchPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cap,  String name,  MatchPlayerRole role,  String? playerId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchPlayer() when $default != null:
return $default(_that.cap,_that.name,_that.role,_that.playerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cap,  String name,  MatchPlayerRole role,  String? playerId)  $default,) {final _that = this;
switch (_that) {
case _MatchPlayer():
return $default(_that.cap,_that.name,_that.role,_that.playerId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cap,  String name,  MatchPlayerRole role,  String? playerId)?  $default,) {final _that = this;
switch (_that) {
case _MatchPlayer() when $default != null:
return $default(_that.cap,_that.name,_that.role,_that.playerId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchPlayer implements MatchPlayer {
  const _MatchPlayer({required this.cap, required this.name, this.role = MatchPlayerRole.none, this.playerId});
  factory _MatchPlayer.fromJson(Map<String, dynamic> json) => _$MatchPlayerFromJson(json);

@override final  int cap;
@override final  String name;
@override@JsonKey() final  MatchPlayerRole role;
@override final  String? playerId;

/// Create a copy of MatchPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchPlayerCopyWith<_MatchPlayer> get copyWith => __$MatchPlayerCopyWithImpl<_MatchPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchPlayer&&(identical(other.cap, cap) || other.cap == cap)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.playerId, playerId) || other.playerId == playerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cap,name,role,playerId);

@override
String toString() {
  return 'MatchPlayer(cap: $cap, name: $name, role: $role, playerId: $playerId)';
}


}

/// @nodoc
abstract mixin class _$MatchPlayerCopyWith<$Res> implements $MatchPlayerCopyWith<$Res> {
  factory _$MatchPlayerCopyWith(_MatchPlayer value, $Res Function(_MatchPlayer) _then) = __$MatchPlayerCopyWithImpl;
@override @useResult
$Res call({
 int cap, String name, MatchPlayerRole role, String? playerId
});




}
/// @nodoc
class __$MatchPlayerCopyWithImpl<$Res>
    implements _$MatchPlayerCopyWith<$Res> {
  __$MatchPlayerCopyWithImpl(this._self, this._then);

  final _MatchPlayer _self;
  final $Res Function(_MatchPlayer) _then;

/// Create a copy of MatchPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cap = null,Object? name = null,Object? role = null,Object? playerId = freezed,}) {
  return _then(_MatchPlayer(
cap: null == cap ? _self.cap : cap // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MatchPlayerRole,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
