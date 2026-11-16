// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduler_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SquadPlayer {

@JsonKey(includeFromJson: false, includeToJson: false) String get id; String get firstName; String get surname; String get nickname; String get totem; bool get active;/// Posities waarop de scheduler deze speler mag zetten.
 List<PlayerPosition> get positions;/// Startrating per positie. Een positie zonder startrating heeft geen
/// rating en doet niet mee in de berekening.
 Map<PlayerPosition, int> get startRatings; String? get uid;
/// Create a copy of SquadPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SquadPlayerCopyWith<SquadPlayer> get copyWith => _$SquadPlayerCopyWithImpl<SquadPlayer>(this as SquadPlayer, _$identity);

  /// Serializes this SquadPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SquadPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.totem, totem) || other.totem == totem)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other.positions, positions)&&const DeepCollectionEquality().equals(other.startRatings, startRatings)&&(identical(other.uid, uid) || other.uid == uid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,surname,nickname,totem,active,const DeepCollectionEquality().hash(positions),const DeepCollectionEquality().hash(startRatings),uid);

@override
String toString() {
  return 'SquadPlayer(id: $id, firstName: $firstName, surname: $surname, nickname: $nickname, totem: $totem, active: $active, positions: $positions, startRatings: $startRatings, uid: $uid)';
}


}

/// @nodoc
abstract mixin class $SquadPlayerCopyWith<$Res>  {
  factory $SquadPlayerCopyWith(SquadPlayer value, $Res Function(SquadPlayer) _then) = _$SquadPlayerCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String id, String firstName, String surname, String nickname, String totem, bool active, List<PlayerPosition> positions, Map<PlayerPosition, int> startRatings, String? uid
});




}
/// @nodoc
class _$SquadPlayerCopyWithImpl<$Res>
    implements $SquadPlayerCopyWith<$Res> {
  _$SquadPlayerCopyWithImpl(this._self, this._then);

  final SquadPlayer _self;
  final $Res Function(SquadPlayer) _then;

/// Create a copy of SquadPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? surname = null,Object? nickname = null,Object? totem = null,Object? active = null,Object? positions = null,Object? startRatings = null,Object? uid = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,surname: null == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,totem: null == totem ? _self.totem : totem // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,positions: null == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as List<PlayerPosition>,startRatings: null == startRatings ? _self.startRatings : startRatings // ignore: cast_nullable_to_non_nullable
as Map<PlayerPosition, int>,uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SquadPlayer].
extension SquadPlayerPatterns on SquadPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SquadPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SquadPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SquadPlayer value)  $default,){
final _that = this;
switch (_that) {
case _SquadPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SquadPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _SquadPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String id,  String firstName,  String surname,  String nickname,  String totem,  bool active,  List<PlayerPosition> positions,  Map<PlayerPosition, int> startRatings,  String? uid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SquadPlayer() when $default != null:
return $default(_that.id,_that.firstName,_that.surname,_that.nickname,_that.totem,_that.active,_that.positions,_that.startRatings,_that.uid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String id,  String firstName,  String surname,  String nickname,  String totem,  bool active,  List<PlayerPosition> positions,  Map<PlayerPosition, int> startRatings,  String? uid)  $default,) {final _that = this;
switch (_that) {
case _SquadPlayer():
return $default(_that.id,_that.firstName,_that.surname,_that.nickname,_that.totem,_that.active,_that.positions,_that.startRatings,_that.uid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  String id,  String firstName,  String surname,  String nickname,  String totem,  bool active,  List<PlayerPosition> positions,  Map<PlayerPosition, int> startRatings,  String? uid)?  $default,) {final _that = this;
switch (_that) {
case _SquadPlayer() when $default != null:
return $default(_that.id,_that.firstName,_that.surname,_that.nickname,_that.totem,_that.active,_that.positions,_that.startRatings,_that.uid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SquadPlayer extends SquadPlayer {
  const _SquadPlayer({@JsonKey(includeFromJson: false, includeToJson: false) this.id = '', required this.firstName, this.surname = '', this.nickname = '', this.totem = '', this.active = true, final  List<PlayerPosition> positions = const <PlayerPosition>[], final  Map<PlayerPosition, int> startRatings = const <PlayerPosition, int>{}, this.uid}): _positions = positions,_startRatings = startRatings,super._();
  factory _SquadPlayer.fromJson(Map<String, dynamic> json) => _$SquadPlayerFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  String id;
@override final  String firstName;
@override@JsonKey() final  String surname;
@override@JsonKey() final  String nickname;
@override@JsonKey() final  String totem;
@override@JsonKey() final  bool active;
/// Posities waarop de scheduler deze speler mag zetten.
 final  List<PlayerPosition> _positions;
/// Posities waarop de scheduler deze speler mag zetten.
@override@JsonKey() List<PlayerPosition> get positions {
  if (_positions is EqualUnmodifiableListView) return _positions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_positions);
}

/// Startrating per positie. Een positie zonder startrating heeft geen
/// rating en doet niet mee in de berekening.
 final  Map<PlayerPosition, int> _startRatings;
/// Startrating per positie. Een positie zonder startrating heeft geen
/// rating en doet niet mee in de berekening.
@override@JsonKey() Map<PlayerPosition, int> get startRatings {
  if (_startRatings is EqualUnmodifiableMapView) return _startRatings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_startRatings);
}

@override final  String? uid;

/// Create a copy of SquadPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SquadPlayerCopyWith<_SquadPlayer> get copyWith => __$SquadPlayerCopyWithImpl<_SquadPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SquadPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SquadPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.totem, totem) || other.totem == totem)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other._positions, _positions)&&const DeepCollectionEquality().equals(other._startRatings, _startRatings)&&(identical(other.uid, uid) || other.uid == uid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,surname,nickname,totem,active,const DeepCollectionEquality().hash(_positions),const DeepCollectionEquality().hash(_startRatings),uid);

@override
String toString() {
  return 'SquadPlayer(id: $id, firstName: $firstName, surname: $surname, nickname: $nickname, totem: $totem, active: $active, positions: $positions, startRatings: $startRatings, uid: $uid)';
}


}

/// @nodoc
abstract mixin class _$SquadPlayerCopyWith<$Res> implements $SquadPlayerCopyWith<$Res> {
  factory _$SquadPlayerCopyWith(_SquadPlayer value, $Res Function(_SquadPlayer) _then) = __$SquadPlayerCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String id, String firstName, String surname, String nickname, String totem, bool active, List<PlayerPosition> positions, Map<PlayerPosition, int> startRatings, String? uid
});




}
/// @nodoc
class __$SquadPlayerCopyWithImpl<$Res>
    implements _$SquadPlayerCopyWith<$Res> {
  __$SquadPlayerCopyWithImpl(this._self, this._then);

  final _SquadPlayer _self;
  final $Res Function(_SquadPlayer) _then;

/// Create a copy of SquadPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? surname = null,Object? nickname = null,Object? totem = null,Object? active = null,Object? positions = null,Object? startRatings = null,Object? uid = freezed,}) {
  return _then(_SquadPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,surname: null == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,totem: null == totem ? _self.totem : totem // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,positions: null == positions ? _self._positions : positions // ignore: cast_nullable_to_non_nullable
as List<PlayerPosition>,startRatings: null == startRatings ? _self._startRatings : startRatings // ignore: cast_nullable_to_non_nullable
as Map<PlayerPosition, int>,uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RatingAdjustment {

@JsonKey(includeFromJson: false, includeToJson: false) String get id; String get playerId; RatingAdjustmentType get type; String get start; String get end; double get change; String get reason;
/// Create a copy of RatingAdjustment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingAdjustmentCopyWith<RatingAdjustment> get copyWith => _$RatingAdjustmentCopyWithImpl<RatingAdjustment>(this as RatingAdjustment, _$identity);

  /// Serializes this RatingAdjustment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingAdjustment&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.type, type) || other.type == type)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.change, change) || other.change == change)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,playerId,type,start,end,change,reason);

@override
String toString() {
  return 'RatingAdjustment(id: $id, playerId: $playerId, type: $type, start: $start, end: $end, change: $change, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $RatingAdjustmentCopyWith<$Res>  {
  factory $RatingAdjustmentCopyWith(RatingAdjustment value, $Res Function(RatingAdjustment) _then) = _$RatingAdjustmentCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String id, String playerId, RatingAdjustmentType type, String start, String end, double change, String reason
});




}
/// @nodoc
class _$RatingAdjustmentCopyWithImpl<$Res>
    implements $RatingAdjustmentCopyWith<$Res> {
  _$RatingAdjustmentCopyWithImpl(this._self, this._then);

  final RatingAdjustment _self;
  final $Res Function(RatingAdjustment) _then;

/// Create a copy of RatingAdjustment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerId = null,Object? type = null,Object? start = null,Object? end = null,Object? change = null,Object? reason = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RatingAdjustmentType,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RatingAdjustment].
extension RatingAdjustmentPatterns on RatingAdjustment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatingAdjustment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatingAdjustment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatingAdjustment value)  $default,){
final _that = this;
switch (_that) {
case _RatingAdjustment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatingAdjustment value)?  $default,){
final _that = this;
switch (_that) {
case _RatingAdjustment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String id,  String playerId,  RatingAdjustmentType type,  String start,  String end,  double change,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatingAdjustment() when $default != null:
return $default(_that.id,_that.playerId,_that.type,_that.start,_that.end,_that.change,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String id,  String playerId,  RatingAdjustmentType type,  String start,  String end,  double change,  String reason)  $default,) {final _that = this;
switch (_that) {
case _RatingAdjustment():
return $default(_that.id,_that.playerId,_that.type,_that.start,_that.end,_that.change,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  String id,  String playerId,  RatingAdjustmentType type,  String start,  String end,  double change,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _RatingAdjustment() when $default != null:
return $default(_that.id,_that.playerId,_that.type,_that.start,_that.end,_that.change,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatingAdjustment implements RatingAdjustment {
  const _RatingAdjustment({@JsonKey(includeFromJson: false, includeToJson: false) this.id = '', required this.playerId, required this.type, required this.start, required this.end, required this.change, this.reason = ''});
  factory _RatingAdjustment.fromJson(Map<String, dynamic> json) => _$RatingAdjustmentFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  String id;
@override final  String playerId;
@override final  RatingAdjustmentType type;
@override final  String start;
@override final  String end;
@override final  double change;
@override@JsonKey() final  String reason;

/// Create a copy of RatingAdjustment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingAdjustmentCopyWith<_RatingAdjustment> get copyWith => __$RatingAdjustmentCopyWithImpl<_RatingAdjustment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatingAdjustmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatingAdjustment&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.type, type) || other.type == type)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.change, change) || other.change == change)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,playerId,type,start,end,change,reason);

@override
String toString() {
  return 'RatingAdjustment(id: $id, playerId: $playerId, type: $type, start: $start, end: $end, change: $change, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$RatingAdjustmentCopyWith<$Res> implements $RatingAdjustmentCopyWith<$Res> {
  factory _$RatingAdjustmentCopyWith(_RatingAdjustment value, $Res Function(_RatingAdjustment) _then) = __$RatingAdjustmentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String id, String playerId, RatingAdjustmentType type, String start, String end, double change, String reason
});




}
/// @nodoc
class __$RatingAdjustmentCopyWithImpl<$Res>
    implements _$RatingAdjustmentCopyWith<$Res> {
  __$RatingAdjustmentCopyWithImpl(this._self, this._then);

  final _RatingAdjustment _self;
  final $Res Function(_RatingAdjustment) _then;

/// Create a copy of RatingAdjustment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerId = null,Object? type = null,Object? start = null,Object? end = null,Object? change = null,Object? reason = null,}) {
  return _then(_RatingAdjustment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RatingAdjustmentType,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LineupEntry {

 String get playerId; PlayerPosition get position;
/// Create a copy of LineupEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineupEntryCopyWith<LineupEntry> get copyWith => _$LineupEntryCopyWithImpl<LineupEntry>(this as LineupEntry, _$identity);

  /// Serializes this LineupEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineupEntry&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,position);

@override
String toString() {
  return 'LineupEntry(playerId: $playerId, position: $position)';
}


}

/// @nodoc
abstract mixin class $LineupEntryCopyWith<$Res>  {
  factory $LineupEntryCopyWith(LineupEntry value, $Res Function(LineupEntry) _then) = _$LineupEntryCopyWithImpl;
@useResult
$Res call({
 String playerId, PlayerPosition position
});




}
/// @nodoc
class _$LineupEntryCopyWithImpl<$Res>
    implements $LineupEntryCopyWith<$Res> {
  _$LineupEntryCopyWithImpl(this._self, this._then);

  final LineupEntry _self;
  final $Res Function(LineupEntry) _then;

/// Create a copy of LineupEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? position = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as PlayerPosition,
  ));
}

}


/// Adds pattern-matching-related methods to [LineupEntry].
extension LineupEntryPatterns on LineupEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LineupEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LineupEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LineupEntry value)  $default,){
final _that = this;
switch (_that) {
case _LineupEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LineupEntry value)?  $default,){
final _that = this;
switch (_that) {
case _LineupEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  PlayerPosition position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LineupEntry() when $default != null:
return $default(_that.playerId,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  PlayerPosition position)  $default,) {final _that = this;
switch (_that) {
case _LineupEntry():
return $default(_that.playerId,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  PlayerPosition position)?  $default,) {final _that = this;
switch (_that) {
case _LineupEntry() when $default != null:
return $default(_that.playerId,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LineupEntry implements LineupEntry {
  const _LineupEntry({required this.playerId, required this.position});
  factory _LineupEntry.fromJson(Map<String, dynamic> json) => _$LineupEntryFromJson(json);

@override final  String playerId;
@override final  PlayerPosition position;

/// Create a copy of LineupEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineupEntryCopyWith<_LineupEntry> get copyWith => __$LineupEntryCopyWithImpl<_LineupEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LineupEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineupEntry&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,position);

@override
String toString() {
  return 'LineupEntry(playerId: $playerId, position: $position)';
}


}

/// @nodoc
abstract mixin class _$LineupEntryCopyWith<$Res> implements $LineupEntryCopyWith<$Res> {
  factory _$LineupEntryCopyWith(_LineupEntry value, $Res Function(_LineupEntry) _then) = __$LineupEntryCopyWithImpl;
@override @useResult
$Res call({
 String playerId, PlayerPosition position
});




}
/// @nodoc
class __$LineupEntryCopyWithImpl<$Res>
    implements _$LineupEntryCopyWith<$Res> {
  __$LineupEntryCopyWithImpl(this._self, this._then);

  final _LineupEntry _self;
  final $Res Function(_LineupEntry) _then;

/// Create a copy of LineupEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? position = null,}) {
  return _then(_LineupEntry(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as PlayerPosition,
  ));
}


}


/// @nodoc
mixin _$GameSide {

/// Naam van de opstelling, bv. "2-3-1".
 String get composition; int get score;/// Spelers die de hele tijd in het water liggen.
 List<LineupEntry> get base;/// Wissels: delen de speeltijd op hun positie met de basisspelers.
 List<LineupEntry> get subs;
/// Create a copy of GameSide
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameSideCopyWith<GameSide> get copyWith => _$GameSideCopyWithImpl<GameSide>(this as GameSide, _$identity);

  /// Serializes this GameSide to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameSide&&(identical(other.composition, composition) || other.composition == composition)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.base, base)&&const DeepCollectionEquality().equals(other.subs, subs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,composition,score,const DeepCollectionEquality().hash(base),const DeepCollectionEquality().hash(subs));

@override
String toString() {
  return 'GameSide(composition: $composition, score: $score, base: $base, subs: $subs)';
}


}

/// @nodoc
abstract mixin class $GameSideCopyWith<$Res>  {
  factory $GameSideCopyWith(GameSide value, $Res Function(GameSide) _then) = _$GameSideCopyWithImpl;
@useResult
$Res call({
 String composition, int score, List<LineupEntry> base, List<LineupEntry> subs
});




}
/// @nodoc
class _$GameSideCopyWithImpl<$Res>
    implements $GameSideCopyWith<$Res> {
  _$GameSideCopyWithImpl(this._self, this._then);

  final GameSide _self;
  final $Res Function(GameSide) _then;

/// Create a copy of GameSide
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? composition = null,Object? score = null,Object? base = null,Object? subs = null,}) {
  return _then(_self.copyWith(
composition: null == composition ? _self.composition : composition // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as List<LineupEntry>,subs: null == subs ? _self.subs : subs // ignore: cast_nullable_to_non_nullable
as List<LineupEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameSide].
extension GameSidePatterns on GameSide {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameSide value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameSide() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameSide value)  $default,){
final _that = this;
switch (_that) {
case _GameSide():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameSide value)?  $default,){
final _that = this;
switch (_that) {
case _GameSide() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String composition,  int score,  List<LineupEntry> base,  List<LineupEntry> subs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameSide() when $default != null:
return $default(_that.composition,_that.score,_that.base,_that.subs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String composition,  int score,  List<LineupEntry> base,  List<LineupEntry> subs)  $default,) {final _that = this;
switch (_that) {
case _GameSide():
return $default(_that.composition,_that.score,_that.base,_that.subs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String composition,  int score,  List<LineupEntry> base,  List<LineupEntry> subs)?  $default,) {final _that = this;
switch (_that) {
case _GameSide() when $default != null:
return $default(_that.composition,_that.score,_that.base,_that.subs);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GameSide extends GameSide {
  const _GameSide({this.composition = '', required this.score, final  List<LineupEntry> base = const <LineupEntry>[], final  List<LineupEntry> subs = const <LineupEntry>[]}): _base = base,_subs = subs,super._();
  factory _GameSide.fromJson(Map<String, dynamic> json) => _$GameSideFromJson(json);

/// Naam van de opstelling, bv. "2-3-1".
@override@JsonKey() final  String composition;
@override final  int score;
/// Spelers die de hele tijd in het water liggen.
 final  List<LineupEntry> _base;
/// Spelers die de hele tijd in het water liggen.
@override@JsonKey() List<LineupEntry> get base {
  if (_base is EqualUnmodifiableListView) return _base;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_base);
}

/// Wissels: delen de speeltijd op hun positie met de basisspelers.
 final  List<LineupEntry> _subs;
/// Wissels: delen de speeltijd op hun positie met de basisspelers.
@override@JsonKey() List<LineupEntry> get subs {
  if (_subs is EqualUnmodifiableListView) return _subs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subs);
}


/// Create a copy of GameSide
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameSideCopyWith<_GameSide> get copyWith => __$GameSideCopyWithImpl<_GameSide>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameSideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameSide&&(identical(other.composition, composition) || other.composition == composition)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._base, _base)&&const DeepCollectionEquality().equals(other._subs, _subs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,composition,score,const DeepCollectionEquality().hash(_base),const DeepCollectionEquality().hash(_subs));

@override
String toString() {
  return 'GameSide(composition: $composition, score: $score, base: $base, subs: $subs)';
}


}

/// @nodoc
abstract mixin class _$GameSideCopyWith<$Res> implements $GameSideCopyWith<$Res> {
  factory _$GameSideCopyWith(_GameSide value, $Res Function(_GameSide) _then) = __$GameSideCopyWithImpl;
@override @useResult
$Res call({
 String composition, int score, List<LineupEntry> base, List<LineupEntry> subs
});




}
/// @nodoc
class __$GameSideCopyWithImpl<$Res>
    implements _$GameSideCopyWith<$Res> {
  __$GameSideCopyWithImpl(this._self, this._then);

  final _GameSide _self;
  final $Res Function(_GameSide) _then;

/// Create a copy of GameSide
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? composition = null,Object? score = null,Object? base = null,Object? subs = null,}) {
  return _then(_GameSide(
composition: null == composition ? _self.composition : composition // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,base: null == base ? _self._base : base // ignore: cast_nullable_to_non_nullable
as List<LineupEntry>,subs: null == subs ? _self._subs : subs // ignore: cast_nullable_to_non_nullable
as List<LineupEntry>,
  ));
}


}


/// @nodoc
mixin _$PracticeGame {

@JsonKey(includeFromJson: false, includeToJson: false) String get id;/// Kalenderdag als `yyyy-MM-dd`.
 String get date; int get durationMinutes; GameSide get white; GameSide get black;
/// Create a copy of PracticeGame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeGameCopyWith<PracticeGame> get copyWith => _$PracticeGameCopyWithImpl<PracticeGame>(this as PracticeGame, _$identity);

  /// Serializes this PracticeGame to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeGame&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.white, white) || other.white == white)&&(identical(other.black, black) || other.black == black));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,durationMinutes,white,black);

@override
String toString() {
  return 'PracticeGame(id: $id, date: $date, durationMinutes: $durationMinutes, white: $white, black: $black)';
}


}

/// @nodoc
abstract mixin class $PracticeGameCopyWith<$Res>  {
  factory $PracticeGameCopyWith(PracticeGame value, $Res Function(PracticeGame) _then) = _$PracticeGameCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String id, String date, int durationMinutes, GameSide white, GameSide black
});


$GameSideCopyWith<$Res> get white;$GameSideCopyWith<$Res> get black;

}
/// @nodoc
class _$PracticeGameCopyWithImpl<$Res>
    implements $PracticeGameCopyWith<$Res> {
  _$PracticeGameCopyWithImpl(this._self, this._then);

  final PracticeGame _self;
  final $Res Function(PracticeGame) _then;

/// Create a copy of PracticeGame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? durationMinutes = null,Object? white = null,Object? black = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,white: null == white ? _self.white : white // ignore: cast_nullable_to_non_nullable
as GameSide,black: null == black ? _self.black : black // ignore: cast_nullable_to_non_nullable
as GameSide,
  ));
}
/// Create a copy of PracticeGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameSideCopyWith<$Res> get white {
  
  return $GameSideCopyWith<$Res>(_self.white, (value) {
    return _then(_self.copyWith(white: value));
  });
}/// Create a copy of PracticeGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameSideCopyWith<$Res> get black {
  
  return $GameSideCopyWith<$Res>(_self.black, (value) {
    return _then(_self.copyWith(black: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticeGame].
extension PracticeGamePatterns on PracticeGame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeGame value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeGame() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeGame value)  $default,){
final _that = this;
switch (_that) {
case _PracticeGame():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeGame value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeGame() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String id,  String date,  int durationMinutes,  GameSide white,  GameSide black)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeGame() when $default != null:
return $default(_that.id,_that.date,_that.durationMinutes,_that.white,_that.black);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String id,  String date,  int durationMinutes,  GameSide white,  GameSide black)  $default,) {final _that = this;
switch (_that) {
case _PracticeGame():
return $default(_that.id,_that.date,_that.durationMinutes,_that.white,_that.black);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  String id,  String date,  int durationMinutes,  GameSide white,  GameSide black)?  $default,) {final _that = this;
switch (_that) {
case _PracticeGame() when $default != null:
return $default(_that.id,_that.date,_that.durationMinutes,_that.white,_that.black);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _PracticeGame implements PracticeGame {
  const _PracticeGame({@JsonKey(includeFromJson: false, includeToJson: false) this.id = '', required this.date, required this.durationMinutes, required this.white, required this.black});
  factory _PracticeGame.fromJson(Map<String, dynamic> json) => _$PracticeGameFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  String id;
/// Kalenderdag als `yyyy-MM-dd`.
@override final  String date;
@override final  int durationMinutes;
@override final  GameSide white;
@override final  GameSide black;

/// Create a copy of PracticeGame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeGameCopyWith<_PracticeGame> get copyWith => __$PracticeGameCopyWithImpl<_PracticeGame>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeGameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeGame&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.white, white) || other.white == white)&&(identical(other.black, black) || other.black == black));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,durationMinutes,white,black);

@override
String toString() {
  return 'PracticeGame(id: $id, date: $date, durationMinutes: $durationMinutes, white: $white, black: $black)';
}


}

/// @nodoc
abstract mixin class _$PracticeGameCopyWith<$Res> implements $PracticeGameCopyWith<$Res> {
  factory _$PracticeGameCopyWith(_PracticeGame value, $Res Function(_PracticeGame) _then) = __$PracticeGameCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String id, String date, int durationMinutes, GameSide white, GameSide black
});


@override $GameSideCopyWith<$Res> get white;@override $GameSideCopyWith<$Res> get black;

}
/// @nodoc
class __$PracticeGameCopyWithImpl<$Res>
    implements _$PracticeGameCopyWith<$Res> {
  __$PracticeGameCopyWithImpl(this._self, this._then);

  final _PracticeGame _self;
  final $Res Function(_PracticeGame) _then;

/// Create a copy of PracticeGame
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? durationMinutes = null,Object? white = null,Object? black = null,}) {
  return _then(_PracticeGame(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,white: null == white ? _self.white : white // ignore: cast_nullable_to_non_nullable
as GameSide,black: null == black ? _self.black : black // ignore: cast_nullable_to_non_nullable
as GameSide,
  ));
}

/// Create a copy of PracticeGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameSideCopyWith<$Res> get white {
  
  return $GameSideCopyWith<$Res>(_self.white, (value) {
    return _then(_self.copyWith(white: value));
  });
}/// Create a copy of PracticeGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameSideCopyWith<$Res> get black {
  
  return $GameSideCopyWith<$Res>(_self.black, (value) {
    return _then(_self.copyWith(black: value));
  });
}
}


/// @nodoc
mixin _$TeamComposition {

 String get name; List<PlayerPosition> get slots;
/// Create a copy of TeamComposition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamCompositionCopyWith<TeamComposition> get copyWith => _$TeamCompositionCopyWithImpl<TeamComposition>(this as TeamComposition, _$identity);

  /// Serializes this TeamComposition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamComposition&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.slots, slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(slots));

@override
String toString() {
  return 'TeamComposition(name: $name, slots: $slots)';
}


}

/// @nodoc
abstract mixin class $TeamCompositionCopyWith<$Res>  {
  factory $TeamCompositionCopyWith(TeamComposition value, $Res Function(TeamComposition) _then) = _$TeamCompositionCopyWithImpl;
@useResult
$Res call({
 String name, List<PlayerPosition> slots
});




}
/// @nodoc
class _$TeamCompositionCopyWithImpl<$Res>
    implements $TeamCompositionCopyWith<$Res> {
  _$TeamCompositionCopyWithImpl(this._self, this._then);

  final TeamComposition _self;
  final $Res Function(TeamComposition) _then;

/// Create a copy of TeamComposition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? slots = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<PlayerPosition>,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamComposition].
extension TeamCompositionPatterns on TeamComposition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamComposition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamComposition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamComposition value)  $default,){
final _that = this;
switch (_that) {
case _TeamComposition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamComposition value)?  $default,){
final _that = this;
switch (_that) {
case _TeamComposition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<PlayerPosition> slots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamComposition() when $default != null:
return $default(_that.name,_that.slots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<PlayerPosition> slots)  $default,) {final _that = this;
switch (_that) {
case _TeamComposition():
return $default(_that.name,_that.slots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<PlayerPosition> slots)?  $default,) {final _that = this;
switch (_that) {
case _TeamComposition() when $default != null:
return $default(_that.name,_that.slots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamComposition implements TeamComposition {
  const _TeamComposition({required this.name, required final  List<PlayerPosition> slots}): _slots = slots;
  factory _TeamComposition.fromJson(Map<String, dynamic> json) => _$TeamCompositionFromJson(json);

@override final  String name;
 final  List<PlayerPosition> _slots;
@override List<PlayerPosition> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}


/// Create a copy of TeamComposition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamCompositionCopyWith<_TeamComposition> get copyWith => __$TeamCompositionCopyWithImpl<_TeamComposition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamCompositionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamComposition&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._slots, _slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_slots));

@override
String toString() {
  return 'TeamComposition(name: $name, slots: $slots)';
}


}

/// @nodoc
abstract mixin class _$TeamCompositionCopyWith<$Res> implements $TeamCompositionCopyWith<$Res> {
  factory _$TeamCompositionCopyWith(_TeamComposition value, $Res Function(_TeamComposition) _then) = __$TeamCompositionCopyWithImpl;
@override @useResult
$Res call({
 String name, List<PlayerPosition> slots
});




}
/// @nodoc
class __$TeamCompositionCopyWithImpl<$Res>
    implements _$TeamCompositionCopyWith<$Res> {
  __$TeamCompositionCopyWithImpl(this._self, this._then);

  final _TeamComposition _self;
  final $Res Function(_TeamComposition) _then;

/// Create a copy of TeamComposition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? slots = null,}) {
  return _then(_TeamComposition(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<PlayerPosition>,
  ));
}


}

// dart format on
