// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chrono.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Chrono {

 ChronoStatus get status;/// Start moment, expressed in RTDB server-clock milliseconds (see
/// `serverNowMillis` in `core/providers/server_time_offset_provider.dart`)
/// so every reader/writer agrees on it regardless of local clock drift.
 int get authoritativeStartTimeMillis;/// Time accumulated before the current running session.
 int get accumulatedElapsedMillis;/// Opgenomen tijden: de Lap-knop in de app (zonder baan) en de
/// baanknoppen (met baan), in één lijst. Volgorde in Firestore is
/// aankomstvolgorde; sorteer via `chronoLapRows` (chrono_laps.dart).
///
/// Nieuwe veldnaam: het oude `laps` (lijst van ints) wordt genegeerd.
 List<ChronoLap> get lapTimes;/// Maximum aantal laps per baan (en voor de Lap-knop), ingesteld door de
/// coach. De laatste is de finale tijd, de andere zijn tussentijden;
/// verdere drukken op die baan tellen niet. Null = geen maximum.
 int? get maxLaps;
/// Create a copy of Chrono
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChronoCopyWith<Chrono> get copyWith => _$ChronoCopyWithImpl<Chrono>(this as Chrono, _$identity);

  /// Serializes this Chrono to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chrono&&(identical(other.status, status) || other.status == status)&&(identical(other.authoritativeStartTimeMillis, authoritativeStartTimeMillis) || other.authoritativeStartTimeMillis == authoritativeStartTimeMillis)&&(identical(other.accumulatedElapsedMillis, accumulatedElapsedMillis) || other.accumulatedElapsedMillis == accumulatedElapsedMillis)&&const DeepCollectionEquality().equals(other.lapTimes, lapTimes)&&(identical(other.maxLaps, maxLaps) || other.maxLaps == maxLaps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,authoritativeStartTimeMillis,accumulatedElapsedMillis,const DeepCollectionEquality().hash(lapTimes),maxLaps);

@override
String toString() {
  return 'Chrono(status: $status, authoritativeStartTimeMillis: $authoritativeStartTimeMillis, accumulatedElapsedMillis: $accumulatedElapsedMillis, lapTimes: $lapTimes, maxLaps: $maxLaps)';
}


}

/// @nodoc
abstract mixin class $ChronoCopyWith<$Res>  {
  factory $ChronoCopyWith(Chrono value, $Res Function(Chrono) _then) = _$ChronoCopyWithImpl;
@useResult
$Res call({
 ChronoStatus status, int authoritativeStartTimeMillis, int accumulatedElapsedMillis, List<ChronoLap> lapTimes, int? maxLaps
});




}
/// @nodoc
class _$ChronoCopyWithImpl<$Res>
    implements $ChronoCopyWith<$Res> {
  _$ChronoCopyWithImpl(this._self, this._then);

  final Chrono _self;
  final $Res Function(Chrono) _then;

/// Create a copy of Chrono
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? authoritativeStartTimeMillis = null,Object? accumulatedElapsedMillis = null,Object? lapTimes = null,Object? maxLaps = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChronoStatus,authoritativeStartTimeMillis: null == authoritativeStartTimeMillis ? _self.authoritativeStartTimeMillis : authoritativeStartTimeMillis // ignore: cast_nullable_to_non_nullable
as int,accumulatedElapsedMillis: null == accumulatedElapsedMillis ? _self.accumulatedElapsedMillis : accumulatedElapsedMillis // ignore: cast_nullable_to_non_nullable
as int,lapTimes: null == lapTimes ? _self.lapTimes : lapTimes // ignore: cast_nullable_to_non_nullable
as List<ChronoLap>,maxLaps: freezed == maxLaps ? _self.maxLaps : maxLaps // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Chrono].
extension ChronoPatterns on Chrono {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Chrono value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Chrono() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Chrono value)  $default,){
final _that = this;
switch (_that) {
case _Chrono():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Chrono value)?  $default,){
final _that = this;
switch (_that) {
case _Chrono() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChronoStatus status,  int authoritativeStartTimeMillis,  int accumulatedElapsedMillis,  List<ChronoLap> lapTimes,  int? maxLaps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Chrono() when $default != null:
return $default(_that.status,_that.authoritativeStartTimeMillis,_that.accumulatedElapsedMillis,_that.lapTimes,_that.maxLaps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChronoStatus status,  int authoritativeStartTimeMillis,  int accumulatedElapsedMillis,  List<ChronoLap> lapTimes,  int? maxLaps)  $default,) {final _that = this;
switch (_that) {
case _Chrono():
return $default(_that.status,_that.authoritativeStartTimeMillis,_that.accumulatedElapsedMillis,_that.lapTimes,_that.maxLaps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChronoStatus status,  int authoritativeStartTimeMillis,  int accumulatedElapsedMillis,  List<ChronoLap> lapTimes,  int? maxLaps)?  $default,) {final _that = this;
switch (_that) {
case _Chrono() when $default != null:
return $default(_that.status,_that.authoritativeStartTimeMillis,_that.accumulatedElapsedMillis,_that.lapTimes,_that.maxLaps);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Chrono implements Chrono {
  const _Chrono({this.status = ChronoStatus.stopped, this.authoritativeStartTimeMillis = 0, this.accumulatedElapsedMillis = 0, final  List<ChronoLap> lapTimes = const <ChronoLap>[], this.maxLaps}): _lapTimes = lapTimes;
  factory _Chrono.fromJson(Map<String, dynamic> json) => _$ChronoFromJson(json);

@override@JsonKey() final  ChronoStatus status;
/// Start moment, expressed in RTDB server-clock milliseconds (see
/// `serverNowMillis` in `core/providers/server_time_offset_provider.dart`)
/// so every reader/writer agrees on it regardless of local clock drift.
@override@JsonKey() final  int authoritativeStartTimeMillis;
/// Time accumulated before the current running session.
@override@JsonKey() final  int accumulatedElapsedMillis;
/// Opgenomen tijden: de Lap-knop in de app (zonder baan) en de
/// baanknoppen (met baan), in één lijst. Volgorde in Firestore is
/// aankomstvolgorde; sorteer via `chronoLapRows` (chrono_laps.dart).
///
/// Nieuwe veldnaam: het oude `laps` (lijst van ints) wordt genegeerd.
 final  List<ChronoLap> _lapTimes;
/// Opgenomen tijden: de Lap-knop in de app (zonder baan) en de
/// baanknoppen (met baan), in één lijst. Volgorde in Firestore is
/// aankomstvolgorde; sorteer via `chronoLapRows` (chrono_laps.dart).
///
/// Nieuwe veldnaam: het oude `laps` (lijst van ints) wordt genegeerd.
@override@JsonKey() List<ChronoLap> get lapTimes {
  if (_lapTimes is EqualUnmodifiableListView) return _lapTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lapTimes);
}

/// Maximum aantal laps per baan (en voor de Lap-knop), ingesteld door de
/// coach. De laatste is de finale tijd, de andere zijn tussentijden;
/// verdere drukken op die baan tellen niet. Null = geen maximum.
@override final  int? maxLaps;

/// Create a copy of Chrono
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChronoCopyWith<_Chrono> get copyWith => __$ChronoCopyWithImpl<_Chrono>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChronoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Chrono&&(identical(other.status, status) || other.status == status)&&(identical(other.authoritativeStartTimeMillis, authoritativeStartTimeMillis) || other.authoritativeStartTimeMillis == authoritativeStartTimeMillis)&&(identical(other.accumulatedElapsedMillis, accumulatedElapsedMillis) || other.accumulatedElapsedMillis == accumulatedElapsedMillis)&&const DeepCollectionEquality().equals(other._lapTimes, _lapTimes)&&(identical(other.maxLaps, maxLaps) || other.maxLaps == maxLaps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,authoritativeStartTimeMillis,accumulatedElapsedMillis,const DeepCollectionEquality().hash(_lapTimes),maxLaps);

@override
String toString() {
  return 'Chrono(status: $status, authoritativeStartTimeMillis: $authoritativeStartTimeMillis, accumulatedElapsedMillis: $accumulatedElapsedMillis, lapTimes: $lapTimes, maxLaps: $maxLaps)';
}


}

/// @nodoc
abstract mixin class _$ChronoCopyWith<$Res> implements $ChronoCopyWith<$Res> {
  factory _$ChronoCopyWith(_Chrono value, $Res Function(_Chrono) _then) = __$ChronoCopyWithImpl;
@override @useResult
$Res call({
 ChronoStatus status, int authoritativeStartTimeMillis, int accumulatedElapsedMillis, List<ChronoLap> lapTimes, int? maxLaps
});




}
/// @nodoc
class __$ChronoCopyWithImpl<$Res>
    implements _$ChronoCopyWith<$Res> {
  __$ChronoCopyWithImpl(this._self, this._then);

  final _Chrono _self;
  final $Res Function(_Chrono) _then;

/// Create a copy of Chrono
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? authoritativeStartTimeMillis = null,Object? accumulatedElapsedMillis = null,Object? lapTimes = null,Object? maxLaps = freezed,}) {
  return _then(_Chrono(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChronoStatus,authoritativeStartTimeMillis: null == authoritativeStartTimeMillis ? _self.authoritativeStartTimeMillis : authoritativeStartTimeMillis // ignore: cast_nullable_to_non_nullable
as int,accumulatedElapsedMillis: null == accumulatedElapsedMillis ? _self.accumulatedElapsedMillis : accumulatedElapsedMillis // ignore: cast_nullable_to_non_nullable
as int,lapTimes: null == lapTimes ? _self._lapTimes : lapTimes // ignore: cast_nullable_to_non_nullable
as List<ChronoLap>,maxLaps: freezed == maxLaps ? _self.maxLaps : maxLaps // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ChronoLap {

/// Totale verstreken chrono-tijd op het moment van de druk.
 int get elapsedMillis; int? get lane;
/// Create a copy of ChronoLap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChronoLapCopyWith<ChronoLap> get copyWith => _$ChronoLapCopyWithImpl<ChronoLap>(this as ChronoLap, _$identity);

  /// Serializes this ChronoLap to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChronoLap&&(identical(other.elapsedMillis, elapsedMillis) || other.elapsedMillis == elapsedMillis)&&(identical(other.lane, lane) || other.lane == lane));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,elapsedMillis,lane);

@override
String toString() {
  return 'ChronoLap(elapsedMillis: $elapsedMillis, lane: $lane)';
}


}

/// @nodoc
abstract mixin class $ChronoLapCopyWith<$Res>  {
  factory $ChronoLapCopyWith(ChronoLap value, $Res Function(ChronoLap) _then) = _$ChronoLapCopyWithImpl;
@useResult
$Res call({
 int elapsedMillis, int? lane
});




}
/// @nodoc
class _$ChronoLapCopyWithImpl<$Res>
    implements $ChronoLapCopyWith<$Res> {
  _$ChronoLapCopyWithImpl(this._self, this._then);

  final ChronoLap _self;
  final $Res Function(ChronoLap) _then;

/// Create a copy of ChronoLap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? elapsedMillis = null,Object? lane = freezed,}) {
  return _then(_self.copyWith(
elapsedMillis: null == elapsedMillis ? _self.elapsedMillis : elapsedMillis // ignore: cast_nullable_to_non_nullable
as int,lane: freezed == lane ? _self.lane : lane // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChronoLap].
extension ChronoLapPatterns on ChronoLap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChronoLap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChronoLap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChronoLap value)  $default,){
final _that = this;
switch (_that) {
case _ChronoLap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChronoLap value)?  $default,){
final _that = this;
switch (_that) {
case _ChronoLap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int elapsedMillis,  int? lane)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChronoLap() when $default != null:
return $default(_that.elapsedMillis,_that.lane);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int elapsedMillis,  int? lane)  $default,) {final _that = this;
switch (_that) {
case _ChronoLap():
return $default(_that.elapsedMillis,_that.lane);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int elapsedMillis,  int? lane)?  $default,) {final _that = this;
switch (_that) {
case _ChronoLap() when $default != null:
return $default(_that.elapsedMillis,_that.lane);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChronoLap implements ChronoLap {
  const _ChronoLap({required this.elapsedMillis, this.lane});
  factory _ChronoLap.fromJson(Map<String, dynamic> json) => _$ChronoLapFromJson(json);

/// Totale verstreken chrono-tijd op het moment van de druk.
@override final  int elapsedMillis;
@override final  int? lane;

/// Create a copy of ChronoLap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChronoLapCopyWith<_ChronoLap> get copyWith => __$ChronoLapCopyWithImpl<_ChronoLap>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChronoLapToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChronoLap&&(identical(other.elapsedMillis, elapsedMillis) || other.elapsedMillis == elapsedMillis)&&(identical(other.lane, lane) || other.lane == lane));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,elapsedMillis,lane);

@override
String toString() {
  return 'ChronoLap(elapsedMillis: $elapsedMillis, lane: $lane)';
}


}

/// @nodoc
abstract mixin class _$ChronoLapCopyWith<$Res> implements $ChronoLapCopyWith<$Res> {
  factory _$ChronoLapCopyWith(_ChronoLap value, $Res Function(_ChronoLap) _then) = __$ChronoLapCopyWithImpl;
@override @useResult
$Res call({
 int elapsedMillis, int? lane
});




}
/// @nodoc
class __$ChronoLapCopyWithImpl<$Res>
    implements _$ChronoLapCopyWith<$Res> {
  __$ChronoLapCopyWithImpl(this._self, this._then);

  final _ChronoLap _self;
  final $Res Function(_ChronoLap) _then;

/// Create a copy of ChronoLap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? elapsedMillis = null,Object? lane = freezed,}) {
  return _then(_ChronoLap(
elapsedMillis: null == elapsedMillis ? _self.elapsedMillis : elapsedMillis // ignore: cast_nullable_to_non_nullable
as int,lane: freezed == lane ? _self.lane : lane // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
