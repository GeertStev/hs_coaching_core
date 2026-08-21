// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tabata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tabata {

// --- Configuratie (Firestore) ---
 int get prepareSeconds; int get workSeconds; int get restSeconds; int get stepSeconds; int get rounds; int get sets; int get restBetweenSets;// --- Runtime status (RTDB, zelfde mechanisme als Chrono) ---
 TabataStatus get status;/// Start moment, expressed in RTDB server-clock milliseconds (see
/// `serverNowMillis` in `core/providers/server_time_offset_provider.dart`).
 int get authoritativeStartTimeMillis;/// Time accumulated before the current running session.
 int get accumulatedElapsedMillis;
/// Create a copy of Tabata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabataCopyWith<Tabata> get copyWith => _$TabataCopyWithImpl<Tabata>(this as Tabata, _$identity);

  /// Serializes this Tabata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tabata&&(identical(other.prepareSeconds, prepareSeconds) || other.prepareSeconds == prepareSeconds)&&(identical(other.workSeconds, workSeconds) || other.workSeconds == workSeconds)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.stepSeconds, stepSeconds) || other.stepSeconds == stepSeconds)&&(identical(other.rounds, rounds) || other.rounds == rounds)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.restBetweenSets, restBetweenSets) || other.restBetweenSets == restBetweenSets)&&(identical(other.status, status) || other.status == status)&&(identical(other.authoritativeStartTimeMillis, authoritativeStartTimeMillis) || other.authoritativeStartTimeMillis == authoritativeStartTimeMillis)&&(identical(other.accumulatedElapsedMillis, accumulatedElapsedMillis) || other.accumulatedElapsedMillis == accumulatedElapsedMillis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prepareSeconds,workSeconds,restSeconds,stepSeconds,rounds,sets,restBetweenSets,status,authoritativeStartTimeMillis,accumulatedElapsedMillis);

@override
String toString() {
  return 'Tabata(prepareSeconds: $prepareSeconds, workSeconds: $workSeconds, restSeconds: $restSeconds, stepSeconds: $stepSeconds, rounds: $rounds, sets: $sets, restBetweenSets: $restBetweenSets, status: $status, authoritativeStartTimeMillis: $authoritativeStartTimeMillis, accumulatedElapsedMillis: $accumulatedElapsedMillis)';
}


}

/// @nodoc
abstract mixin class $TabataCopyWith<$Res>  {
  factory $TabataCopyWith(Tabata value, $Res Function(Tabata) _then) = _$TabataCopyWithImpl;
@useResult
$Res call({
 int prepareSeconds, int workSeconds, int restSeconds, int stepSeconds, int rounds, int sets, int restBetweenSets, TabataStatus status, int authoritativeStartTimeMillis, int accumulatedElapsedMillis
});




}
/// @nodoc
class _$TabataCopyWithImpl<$Res>
    implements $TabataCopyWith<$Res> {
  _$TabataCopyWithImpl(this._self, this._then);

  final Tabata _self;
  final $Res Function(Tabata) _then;

/// Create a copy of Tabata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prepareSeconds = null,Object? workSeconds = null,Object? restSeconds = null,Object? stepSeconds = null,Object? rounds = null,Object? sets = null,Object? restBetweenSets = null,Object? status = null,Object? authoritativeStartTimeMillis = null,Object? accumulatedElapsedMillis = null,}) {
  return _then(_self.copyWith(
prepareSeconds: null == prepareSeconds ? _self.prepareSeconds : prepareSeconds // ignore: cast_nullable_to_non_nullable
as int,workSeconds: null == workSeconds ? _self.workSeconds : workSeconds // ignore: cast_nullable_to_non_nullable
as int,restSeconds: null == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int,stepSeconds: null == stepSeconds ? _self.stepSeconds : stepSeconds // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self.rounds : rounds // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as int,restBetweenSets: null == restBetweenSets ? _self.restBetweenSets : restBetweenSets // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TabataStatus,authoritativeStartTimeMillis: null == authoritativeStartTimeMillis ? _self.authoritativeStartTimeMillis : authoritativeStartTimeMillis // ignore: cast_nullable_to_non_nullable
as int,accumulatedElapsedMillis: null == accumulatedElapsedMillis ? _self.accumulatedElapsedMillis : accumulatedElapsedMillis // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Tabata].
extension TabataPatterns on Tabata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tabata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tabata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tabata value)  $default,){
final _that = this;
switch (_that) {
case _Tabata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tabata value)?  $default,){
final _that = this;
switch (_that) {
case _Tabata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int prepareSeconds,  int workSeconds,  int restSeconds,  int stepSeconds,  int rounds,  int sets,  int restBetweenSets,  TabataStatus status,  int authoritativeStartTimeMillis,  int accumulatedElapsedMillis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tabata() when $default != null:
return $default(_that.prepareSeconds,_that.workSeconds,_that.restSeconds,_that.stepSeconds,_that.rounds,_that.sets,_that.restBetweenSets,_that.status,_that.authoritativeStartTimeMillis,_that.accumulatedElapsedMillis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int prepareSeconds,  int workSeconds,  int restSeconds,  int stepSeconds,  int rounds,  int sets,  int restBetweenSets,  TabataStatus status,  int authoritativeStartTimeMillis,  int accumulatedElapsedMillis)  $default,) {final _that = this;
switch (_that) {
case _Tabata():
return $default(_that.prepareSeconds,_that.workSeconds,_that.restSeconds,_that.stepSeconds,_that.rounds,_that.sets,_that.restBetweenSets,_that.status,_that.authoritativeStartTimeMillis,_that.accumulatedElapsedMillis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int prepareSeconds,  int workSeconds,  int restSeconds,  int stepSeconds,  int rounds,  int sets,  int restBetweenSets,  TabataStatus status,  int authoritativeStartTimeMillis,  int accumulatedElapsedMillis)?  $default,) {final _that = this;
switch (_that) {
case _Tabata() when $default != null:
return $default(_that.prepareSeconds,_that.workSeconds,_that.restSeconds,_that.stepSeconds,_that.rounds,_that.sets,_that.restBetweenSets,_that.status,_that.authoritativeStartTimeMillis,_that.accumulatedElapsedMillis);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tabata extends Tabata {
  const _Tabata({this.prepareSeconds = 10, this.workSeconds = 20, this.restSeconds = 10, this.stepSeconds = 0, this.rounds = 8, this.sets = 1, this.restBetweenSets = 0, this.status = TabataStatus.stopped, this.authoritativeStartTimeMillis = 0, this.accumulatedElapsedMillis = 0}): super._();
  factory _Tabata.fromJson(Map<String, dynamic> json) => _$TabataFromJson(json);

// --- Configuratie (Firestore) ---
@override@JsonKey() final  int prepareSeconds;
@override@JsonKey() final  int workSeconds;
@override@JsonKey() final  int restSeconds;
@override@JsonKey() final  int stepSeconds;
@override@JsonKey() final  int rounds;
@override@JsonKey() final  int sets;
@override@JsonKey() final  int restBetweenSets;
// --- Runtime status (RTDB, zelfde mechanisme als Chrono) ---
@override@JsonKey() final  TabataStatus status;
/// Start moment, expressed in RTDB server-clock milliseconds (see
/// `serverNowMillis` in `core/providers/server_time_offset_provider.dart`).
@override@JsonKey() final  int authoritativeStartTimeMillis;
/// Time accumulated before the current running session.
@override@JsonKey() final  int accumulatedElapsedMillis;

/// Create a copy of Tabata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabataCopyWith<_Tabata> get copyWith => __$TabataCopyWithImpl<_Tabata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TabataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tabata&&(identical(other.prepareSeconds, prepareSeconds) || other.prepareSeconds == prepareSeconds)&&(identical(other.workSeconds, workSeconds) || other.workSeconds == workSeconds)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.stepSeconds, stepSeconds) || other.stepSeconds == stepSeconds)&&(identical(other.rounds, rounds) || other.rounds == rounds)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.restBetweenSets, restBetweenSets) || other.restBetweenSets == restBetweenSets)&&(identical(other.status, status) || other.status == status)&&(identical(other.authoritativeStartTimeMillis, authoritativeStartTimeMillis) || other.authoritativeStartTimeMillis == authoritativeStartTimeMillis)&&(identical(other.accumulatedElapsedMillis, accumulatedElapsedMillis) || other.accumulatedElapsedMillis == accumulatedElapsedMillis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prepareSeconds,workSeconds,restSeconds,stepSeconds,rounds,sets,restBetweenSets,status,authoritativeStartTimeMillis,accumulatedElapsedMillis);

@override
String toString() {
  return 'Tabata(prepareSeconds: $prepareSeconds, workSeconds: $workSeconds, restSeconds: $restSeconds, stepSeconds: $stepSeconds, rounds: $rounds, sets: $sets, restBetweenSets: $restBetweenSets, status: $status, authoritativeStartTimeMillis: $authoritativeStartTimeMillis, accumulatedElapsedMillis: $accumulatedElapsedMillis)';
}


}

/// @nodoc
abstract mixin class _$TabataCopyWith<$Res> implements $TabataCopyWith<$Res> {
  factory _$TabataCopyWith(_Tabata value, $Res Function(_Tabata) _then) = __$TabataCopyWithImpl;
@override @useResult
$Res call({
 int prepareSeconds, int workSeconds, int restSeconds, int stepSeconds, int rounds, int sets, int restBetweenSets, TabataStatus status, int authoritativeStartTimeMillis, int accumulatedElapsedMillis
});




}
/// @nodoc
class __$TabataCopyWithImpl<$Res>
    implements _$TabataCopyWith<$Res> {
  __$TabataCopyWithImpl(this._self, this._then);

  final _Tabata _self;
  final $Res Function(_Tabata) _then;

/// Create a copy of Tabata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prepareSeconds = null,Object? workSeconds = null,Object? restSeconds = null,Object? stepSeconds = null,Object? rounds = null,Object? sets = null,Object? restBetweenSets = null,Object? status = null,Object? authoritativeStartTimeMillis = null,Object? accumulatedElapsedMillis = null,}) {
  return _then(_Tabata(
prepareSeconds: null == prepareSeconds ? _self.prepareSeconds : prepareSeconds // ignore: cast_nullable_to_non_nullable
as int,workSeconds: null == workSeconds ? _self.workSeconds : workSeconds // ignore: cast_nullable_to_non_nullable
as int,restSeconds: null == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int,stepSeconds: null == stepSeconds ? _self.stepSeconds : stepSeconds // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self.rounds : rounds // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as int,restBetweenSets: null == restBetweenSets ? _self.restBetweenSets : restBetweenSets // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TabataStatus,authoritativeStartTimeMillis: null == authoritativeStartTimeMillis ? _self.authoritativeStartTimeMillis : authoritativeStartTimeMillis // ignore: cast_nullable_to_non_nullable
as int,accumulatedElapsedMillis: null == accumulatedElapsedMillis ? _self.accumulatedElapsedMillis : accumulatedElapsedMillis // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
