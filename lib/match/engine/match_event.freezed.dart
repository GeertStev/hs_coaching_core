// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchScore {

 int get white; int get black;
/// Create a copy of MatchScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchScoreCopyWith<MatchScore> get copyWith => _$MatchScoreCopyWithImpl<MatchScore>(this as MatchScore, _$identity);

  /// Serializes this MatchScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchScore&&(identical(other.white, white) || other.white == white)&&(identical(other.black, black) || other.black == black));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,white,black);

@override
String toString() {
  return 'MatchScore(white: $white, black: $black)';
}


}

/// @nodoc
abstract mixin class $MatchScoreCopyWith<$Res>  {
  factory $MatchScoreCopyWith(MatchScore value, $Res Function(MatchScore) _then) = _$MatchScoreCopyWithImpl;
@useResult
$Res call({
 int white, int black
});




}
/// @nodoc
class _$MatchScoreCopyWithImpl<$Res>
    implements $MatchScoreCopyWith<$Res> {
  _$MatchScoreCopyWithImpl(this._self, this._then);

  final MatchScore _self;
  final $Res Function(MatchScore) _then;

/// Create a copy of MatchScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? white = null,Object? black = null,}) {
  return _then(_self.copyWith(
white: null == white ? _self.white : white // ignore: cast_nullable_to_non_nullable
as int,black: null == black ? _self.black : black // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchScore].
extension MatchScorePatterns on MatchScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchScore value)  $default,){
final _that = this;
switch (_that) {
case _MatchScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchScore value)?  $default,){
final _that = this;
switch (_that) {
case _MatchScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int white,  int black)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchScore() when $default != null:
return $default(_that.white,_that.black);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int white,  int black)  $default,) {final _that = this;
switch (_that) {
case _MatchScore():
return $default(_that.white,_that.black);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int white,  int black)?  $default,) {final _that = this;
switch (_that) {
case _MatchScore() when $default != null:
return $default(_that.white,_that.black);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchScore extends MatchScore {
  const _MatchScore({this.white = 0, this.black = 0}): super._();
  factory _MatchScore.fromJson(Map<String, dynamic> json) => _$MatchScoreFromJson(json);

@override@JsonKey() final  int white;
@override@JsonKey() final  int black;

/// Create a copy of MatchScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchScoreCopyWith<_MatchScore> get copyWith => __$MatchScoreCopyWithImpl<_MatchScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchScore&&(identical(other.white, white) || other.white == white)&&(identical(other.black, black) || other.black == black));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,white,black);

@override
String toString() {
  return 'MatchScore(white: $white, black: $black)';
}


}

/// @nodoc
abstract mixin class _$MatchScoreCopyWith<$Res> implements $MatchScoreCopyWith<$Res> {
  factory _$MatchScoreCopyWith(_MatchScore value, $Res Function(_MatchScore) _then) = __$MatchScoreCopyWithImpl;
@override @useResult
$Res call({
 int white, int black
});




}
/// @nodoc
class __$MatchScoreCopyWithImpl<$Res>
    implements _$MatchScoreCopyWith<$Res> {
  __$MatchScoreCopyWithImpl(this._self, this._then);

  final _MatchScore _self;
  final $Res Function(_MatchScore) _then;

/// Create a copy of MatchScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? white = null,Object? black = null,}) {
  return _then(_MatchScore(
white: null == white ? _self.white : white // ignore: cast_nullable_to_non_nullable
as int,black: null == black ? _self.black : black // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MatchEvent {

/// Uniek id (uuid), gekozen door het tafeltoestel.
 String get id; String get matchId;/// Monotoon oplopend per wedstrijd; bepaalt de volgorde in de reducer.
 int get seq;/// Moment van de **tik**, in server-tijd (lokale tijd + de offset uit
/// `serverTimeOffsetProvider`). Nooit het uploadmoment.
 int get serverTimeMillis; String get deviceId; MatchAuthorRole get authorRole; String? get authorId; EventSource get source; MatchEventData get data;
/// Create a copy of MatchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchEventCopyWith<MatchEvent> get copyWith => _$MatchEventCopyWithImpl<MatchEvent>(this as MatchEvent, _$identity);

  /// Serializes this MatchEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.serverTimeMillis, serverTimeMillis) || other.serverTimeMillis == serverTimeMillis)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.authorRole, authorRole) || other.authorRole == authorRole)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.source, source) || other.source == source)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,matchId,seq,serverTimeMillis,deviceId,authorRole,authorId,source,data);

@override
String toString() {
  return 'MatchEvent(id: $id, matchId: $matchId, seq: $seq, serverTimeMillis: $serverTimeMillis, deviceId: $deviceId, authorRole: $authorRole, authorId: $authorId, source: $source, data: $data)';
}


}

/// @nodoc
abstract mixin class $MatchEventCopyWith<$Res>  {
  factory $MatchEventCopyWith(MatchEvent value, $Res Function(MatchEvent) _then) = _$MatchEventCopyWithImpl;
@useResult
$Res call({
 String id, String matchId, int seq, int serverTimeMillis, String deviceId, MatchAuthorRole authorRole, String? authorId, EventSource source, MatchEventData data
});


$MatchEventDataCopyWith<$Res> get data;

}
/// @nodoc
class _$MatchEventCopyWithImpl<$Res>
    implements $MatchEventCopyWith<$Res> {
  _$MatchEventCopyWithImpl(this._self, this._then);

  final MatchEvent _self;
  final $Res Function(MatchEvent) _then;

/// Create a copy of MatchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? matchId = null,Object? seq = null,Object? serverTimeMillis = null,Object? deviceId = null,Object? authorRole = null,Object? authorId = freezed,Object? source = null,Object? data = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,serverTimeMillis: null == serverTimeMillis ? _self.serverTimeMillis : serverTimeMillis // ignore: cast_nullable_to_non_nullable
as int,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,authorRole: null == authorRole ? _self.authorRole : authorRole // ignore: cast_nullable_to_non_nullable
as MatchAuthorRole,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as EventSource,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MatchEventData,
  ));
}
/// Create a copy of MatchEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchEventDataCopyWith<$Res> get data {
  
  return $MatchEventDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchEvent].
extension MatchEventPatterns on MatchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchEvent value)  $default,){
final _that = this;
switch (_that) {
case _MatchEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchEvent value)?  $default,){
final _that = this;
switch (_that) {
case _MatchEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String matchId,  int seq,  int serverTimeMillis,  String deviceId,  MatchAuthorRole authorRole,  String? authorId,  EventSource source,  MatchEventData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchEvent() when $default != null:
return $default(_that.id,_that.matchId,_that.seq,_that.serverTimeMillis,_that.deviceId,_that.authorRole,_that.authorId,_that.source,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String matchId,  int seq,  int serverTimeMillis,  String deviceId,  MatchAuthorRole authorRole,  String? authorId,  EventSource source,  MatchEventData data)  $default,) {final _that = this;
switch (_that) {
case _MatchEvent():
return $default(_that.id,_that.matchId,_that.seq,_that.serverTimeMillis,_that.deviceId,_that.authorRole,_that.authorId,_that.source,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String matchId,  int seq,  int serverTimeMillis,  String deviceId,  MatchAuthorRole authorRole,  String? authorId,  EventSource source,  MatchEventData data)?  $default,) {final _that = this;
switch (_that) {
case _MatchEvent() when $default != null:
return $default(_that.id,_that.matchId,_that.seq,_that.serverTimeMillis,_that.deviceId,_that.authorRole,_that.authorId,_that.source,_that.data);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _MatchEvent implements MatchEvent {
  const _MatchEvent({required this.id, required this.matchId, required this.seq, required this.serverTimeMillis, this.deviceId = '', this.authorRole = MatchAuthorRole.tableOfficial, this.authorId, this.source = EventSource.screen, required this.data});
  factory _MatchEvent.fromJson(Map<String, dynamic> json) => _$MatchEventFromJson(json);

/// Uniek id (uuid), gekozen door het tafeltoestel.
@override final  String id;
@override final  String matchId;
/// Monotoon oplopend per wedstrijd; bepaalt de volgorde in de reducer.
@override final  int seq;
/// Moment van de **tik**, in server-tijd (lokale tijd + de offset uit
/// `serverTimeOffsetProvider`). Nooit het uploadmoment.
@override final  int serverTimeMillis;
@override@JsonKey() final  String deviceId;
@override@JsonKey() final  MatchAuthorRole authorRole;
@override final  String? authorId;
@override@JsonKey() final  EventSource source;
@override final  MatchEventData data;

/// Create a copy of MatchEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchEventCopyWith<_MatchEvent> get copyWith => __$MatchEventCopyWithImpl<_MatchEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.serverTimeMillis, serverTimeMillis) || other.serverTimeMillis == serverTimeMillis)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.authorRole, authorRole) || other.authorRole == authorRole)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.source, source) || other.source == source)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,matchId,seq,serverTimeMillis,deviceId,authorRole,authorId,source,data);

@override
String toString() {
  return 'MatchEvent(id: $id, matchId: $matchId, seq: $seq, serverTimeMillis: $serverTimeMillis, deviceId: $deviceId, authorRole: $authorRole, authorId: $authorId, source: $source, data: $data)';
}


}

/// @nodoc
abstract mixin class _$MatchEventCopyWith<$Res> implements $MatchEventCopyWith<$Res> {
  factory _$MatchEventCopyWith(_MatchEvent value, $Res Function(_MatchEvent) _then) = __$MatchEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String matchId, int seq, int serverTimeMillis, String deviceId, MatchAuthorRole authorRole, String? authorId, EventSource source, MatchEventData data
});


@override $MatchEventDataCopyWith<$Res> get data;

}
/// @nodoc
class __$MatchEventCopyWithImpl<$Res>
    implements _$MatchEventCopyWith<$Res> {
  __$MatchEventCopyWithImpl(this._self, this._then);

  final _MatchEvent _self;
  final $Res Function(_MatchEvent) _then;

/// Create a copy of MatchEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? matchId = null,Object? seq = null,Object? serverTimeMillis = null,Object? deviceId = null,Object? authorRole = null,Object? authorId = freezed,Object? source = null,Object? data = null,}) {
  return _then(_MatchEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,serverTimeMillis: null == serverTimeMillis ? _self.serverTimeMillis : serverTimeMillis // ignore: cast_nullable_to_non_nullable
as int,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,authorRole: null == authorRole ? _self.authorRole : authorRole // ignore: cast_nullable_to_non_nullable
as MatchAuthorRole,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as EventSource,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MatchEventData,
  ));
}

/// Create a copy of MatchEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchEventDataCopyWith<$Res> get data {
  
  return $MatchEventDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

MatchEventData _$MatchEventDataFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'matchCreated':
          return MatchCreated.fromJson(
            json
          );
                case 'rosterDeclared':
          return RosterDeclared.fromJson(
            json
          );
                case 'officialsAssigned':
          return OfficialsAssigned.fromJson(
            json
          );
                case 'periodWarningGiven':
          return PeriodWarningGiven.fromJson(
            json
          );
                case 'playStarted':
          return PlayStarted.fromJson(
            json
          );
                case 'playStopped':
          return PlayStopped.fromJson(
            json
          );
                case 'stopReasonSpecified':
          return StopReasonSpecified.fromJson(
            json
          );
                case 'officialsTimeOutStarted':
          return OfficialsTimeOutStarted.fromJson(
            json
          );
                case 'teamTimeOutRequested':
          return TeamTimeOutRequested.fromJson(
            json
          );
                case 'periodEnded':
          return PeriodEnded.fromJson(
            json
          );
                case 'goalScored':
          return GoalScored.fromJson(
            json
          );
                case 'cautionGiven':
          return CautionGiven.fromJson(
            json
          );
                case 'timePenaltyGiven':
          return TimePenaltyGiven.fromJson(
            json
          );
                case 'playerDismissed':
          return PlayerDismissed.fromJson(
            json
          );
                case 'officialDismissed':
          return OfficialDismissed.fromJson(
            json
          );
                case 'penaltyShotAwarded':
          return PenaltyShotAwarded.fromJson(
            json
          );
                case 'penaltyShotResolved':
          return PenaltyShotResolved.fromJson(
            json
          );
                case 'penaltyPlayerReturned':
          return PenaltyPlayerReturned.fromJson(
            json
          );
                case 'protestLogged':
          return ProtestLogged.fromJson(
            json
          );
                case 'eventVoided':
          return EventVoided.fromJson(
            json
          );
                case 'matchEndedBySignOff':
          return MatchEndedBySignOff.fromJson(
            json
          );
                case 'resultDecidedByDelegate':
          return ResultDecidedByDelegate.fromJson(
            json
          );
                case 'matchForfeited':
          return MatchForfeited.fromJson(
            json
          );
                case 'matchAbandoned':
          return MatchAbandoned.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'MatchEventData',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$MatchEventData {



  /// Serializes this MatchEventData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchEventData);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchEventData()';
}


}

/// @nodoc
class $MatchEventDataCopyWith<$Res>  {
$MatchEventDataCopyWith(MatchEventData _, $Res Function(MatchEventData) __);
}


/// Adds pattern-matching-related methods to [MatchEventData].
extension MatchEventDataPatterns on MatchEventData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MatchCreated value)?  matchCreated,TResult Function( RosterDeclared value)?  rosterDeclared,TResult Function( OfficialsAssigned value)?  officialsAssigned,TResult Function( PeriodWarningGiven value)?  periodWarningGiven,TResult Function( PlayStarted value)?  playStarted,TResult Function( PlayStopped value)?  playStopped,TResult Function( StopReasonSpecified value)?  stopReasonSpecified,TResult Function( OfficialsTimeOutStarted value)?  officialsTimeOutStarted,TResult Function( TeamTimeOutRequested value)?  teamTimeOutRequested,TResult Function( PeriodEnded value)?  periodEnded,TResult Function( GoalScored value)?  goalScored,TResult Function( CautionGiven value)?  cautionGiven,TResult Function( TimePenaltyGiven value)?  timePenaltyGiven,TResult Function( PlayerDismissed value)?  playerDismissed,TResult Function( OfficialDismissed value)?  officialDismissed,TResult Function( PenaltyShotAwarded value)?  penaltyShotAwarded,TResult Function( PenaltyShotResolved value)?  penaltyShotResolved,TResult Function( PenaltyPlayerReturned value)?  penaltyPlayerReturned,TResult Function( ProtestLogged value)?  protestLogged,TResult Function( EventVoided value)?  eventVoided,TResult Function( MatchEndedBySignOff value)?  matchEndedBySignOff,TResult Function( ResultDecidedByDelegate value)?  resultDecidedByDelegate,TResult Function( MatchForfeited value)?  matchForfeited,TResult Function( MatchAbandoned value)?  matchAbandoned,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MatchCreated() when matchCreated != null:
return matchCreated(_that);case RosterDeclared() when rosterDeclared != null:
return rosterDeclared(_that);case OfficialsAssigned() when officialsAssigned != null:
return officialsAssigned(_that);case PeriodWarningGiven() when periodWarningGiven != null:
return periodWarningGiven(_that);case PlayStarted() when playStarted != null:
return playStarted(_that);case PlayStopped() when playStopped != null:
return playStopped(_that);case StopReasonSpecified() when stopReasonSpecified != null:
return stopReasonSpecified(_that);case OfficialsTimeOutStarted() when officialsTimeOutStarted != null:
return officialsTimeOutStarted(_that);case TeamTimeOutRequested() when teamTimeOutRequested != null:
return teamTimeOutRequested(_that);case PeriodEnded() when periodEnded != null:
return periodEnded(_that);case GoalScored() when goalScored != null:
return goalScored(_that);case CautionGiven() when cautionGiven != null:
return cautionGiven(_that);case TimePenaltyGiven() when timePenaltyGiven != null:
return timePenaltyGiven(_that);case PlayerDismissed() when playerDismissed != null:
return playerDismissed(_that);case OfficialDismissed() when officialDismissed != null:
return officialDismissed(_that);case PenaltyShotAwarded() when penaltyShotAwarded != null:
return penaltyShotAwarded(_that);case PenaltyShotResolved() when penaltyShotResolved != null:
return penaltyShotResolved(_that);case PenaltyPlayerReturned() when penaltyPlayerReturned != null:
return penaltyPlayerReturned(_that);case ProtestLogged() when protestLogged != null:
return protestLogged(_that);case EventVoided() when eventVoided != null:
return eventVoided(_that);case MatchEndedBySignOff() when matchEndedBySignOff != null:
return matchEndedBySignOff(_that);case ResultDecidedByDelegate() when resultDecidedByDelegate != null:
return resultDecidedByDelegate(_that);case MatchForfeited() when matchForfeited != null:
return matchForfeited(_that);case MatchAbandoned() when matchAbandoned != null:
return matchAbandoned(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MatchCreated value)  matchCreated,required TResult Function( RosterDeclared value)  rosterDeclared,required TResult Function( OfficialsAssigned value)  officialsAssigned,required TResult Function( PeriodWarningGiven value)  periodWarningGiven,required TResult Function( PlayStarted value)  playStarted,required TResult Function( PlayStopped value)  playStopped,required TResult Function( StopReasonSpecified value)  stopReasonSpecified,required TResult Function( OfficialsTimeOutStarted value)  officialsTimeOutStarted,required TResult Function( TeamTimeOutRequested value)  teamTimeOutRequested,required TResult Function( PeriodEnded value)  periodEnded,required TResult Function( GoalScored value)  goalScored,required TResult Function( CautionGiven value)  cautionGiven,required TResult Function( TimePenaltyGiven value)  timePenaltyGiven,required TResult Function( PlayerDismissed value)  playerDismissed,required TResult Function( OfficialDismissed value)  officialDismissed,required TResult Function( PenaltyShotAwarded value)  penaltyShotAwarded,required TResult Function( PenaltyShotResolved value)  penaltyShotResolved,required TResult Function( PenaltyPlayerReturned value)  penaltyPlayerReturned,required TResult Function( ProtestLogged value)  protestLogged,required TResult Function( EventVoided value)  eventVoided,required TResult Function( MatchEndedBySignOff value)  matchEndedBySignOff,required TResult Function( ResultDecidedByDelegate value)  resultDecidedByDelegate,required TResult Function( MatchForfeited value)  matchForfeited,required TResult Function( MatchAbandoned value)  matchAbandoned,}){
final _that = this;
switch (_that) {
case MatchCreated():
return matchCreated(_that);case RosterDeclared():
return rosterDeclared(_that);case OfficialsAssigned():
return officialsAssigned(_that);case PeriodWarningGiven():
return periodWarningGiven(_that);case PlayStarted():
return playStarted(_that);case PlayStopped():
return playStopped(_that);case StopReasonSpecified():
return stopReasonSpecified(_that);case OfficialsTimeOutStarted():
return officialsTimeOutStarted(_that);case TeamTimeOutRequested():
return teamTimeOutRequested(_that);case PeriodEnded():
return periodEnded(_that);case GoalScored():
return goalScored(_that);case CautionGiven():
return cautionGiven(_that);case TimePenaltyGiven():
return timePenaltyGiven(_that);case PlayerDismissed():
return playerDismissed(_that);case OfficialDismissed():
return officialDismissed(_that);case PenaltyShotAwarded():
return penaltyShotAwarded(_that);case PenaltyShotResolved():
return penaltyShotResolved(_that);case PenaltyPlayerReturned():
return penaltyPlayerReturned(_that);case ProtestLogged():
return protestLogged(_that);case EventVoided():
return eventVoided(_that);case MatchEndedBySignOff():
return matchEndedBySignOff(_that);case ResultDecidedByDelegate():
return resultDecidedByDelegate(_that);case MatchForfeited():
return matchForfeited(_that);case MatchAbandoned():
return matchAbandoned(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MatchCreated value)?  matchCreated,TResult? Function( RosterDeclared value)?  rosterDeclared,TResult? Function( OfficialsAssigned value)?  officialsAssigned,TResult? Function( PeriodWarningGiven value)?  periodWarningGiven,TResult? Function( PlayStarted value)?  playStarted,TResult? Function( PlayStopped value)?  playStopped,TResult? Function( StopReasonSpecified value)?  stopReasonSpecified,TResult? Function( OfficialsTimeOutStarted value)?  officialsTimeOutStarted,TResult? Function( TeamTimeOutRequested value)?  teamTimeOutRequested,TResult? Function( PeriodEnded value)?  periodEnded,TResult? Function( GoalScored value)?  goalScored,TResult? Function( CautionGiven value)?  cautionGiven,TResult? Function( TimePenaltyGiven value)?  timePenaltyGiven,TResult? Function( PlayerDismissed value)?  playerDismissed,TResult? Function( OfficialDismissed value)?  officialDismissed,TResult? Function( PenaltyShotAwarded value)?  penaltyShotAwarded,TResult? Function( PenaltyShotResolved value)?  penaltyShotResolved,TResult? Function( PenaltyPlayerReturned value)?  penaltyPlayerReturned,TResult? Function( ProtestLogged value)?  protestLogged,TResult? Function( EventVoided value)?  eventVoided,TResult? Function( MatchEndedBySignOff value)?  matchEndedBySignOff,TResult? Function( ResultDecidedByDelegate value)?  resultDecidedByDelegate,TResult? Function( MatchForfeited value)?  matchForfeited,TResult? Function( MatchAbandoned value)?  matchAbandoned,}){
final _that = this;
switch (_that) {
case MatchCreated() when matchCreated != null:
return matchCreated(_that);case RosterDeclared() when rosterDeclared != null:
return rosterDeclared(_that);case OfficialsAssigned() when officialsAssigned != null:
return officialsAssigned(_that);case PeriodWarningGiven() when periodWarningGiven != null:
return periodWarningGiven(_that);case PlayStarted() when playStarted != null:
return playStarted(_that);case PlayStopped() when playStopped != null:
return playStopped(_that);case StopReasonSpecified() when stopReasonSpecified != null:
return stopReasonSpecified(_that);case OfficialsTimeOutStarted() when officialsTimeOutStarted != null:
return officialsTimeOutStarted(_that);case TeamTimeOutRequested() when teamTimeOutRequested != null:
return teamTimeOutRequested(_that);case PeriodEnded() when periodEnded != null:
return periodEnded(_that);case GoalScored() when goalScored != null:
return goalScored(_that);case CautionGiven() when cautionGiven != null:
return cautionGiven(_that);case TimePenaltyGiven() when timePenaltyGiven != null:
return timePenaltyGiven(_that);case PlayerDismissed() when playerDismissed != null:
return playerDismissed(_that);case OfficialDismissed() when officialDismissed != null:
return officialDismissed(_that);case PenaltyShotAwarded() when penaltyShotAwarded != null:
return penaltyShotAwarded(_that);case PenaltyShotResolved() when penaltyShotResolved != null:
return penaltyShotResolved(_that);case PenaltyPlayerReturned() when penaltyPlayerReturned != null:
return penaltyPlayerReturned(_that);case ProtestLogged() when protestLogged != null:
return protestLogged(_that);case EventVoided() when eventVoided != null:
return eventVoided(_that);case MatchEndedBySignOff() when matchEndedBySignOff != null:
return matchEndedBySignOff(_that);case ResultDecidedByDelegate() when resultDecidedByDelegate != null:
return resultDecidedByDelegate(_that);case MatchForfeited() when matchForfeited != null:
return matchForfeited(_that);case MatchAbandoned() when matchAbandoned != null:
return matchAbandoned(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( MatchConfig config,  String teamWhite,  String teamBlack,  StartingEnds startingEnds,  String? tournamentId,  String? fieldId)?  matchCreated,TResult Function( TeamColor team,  List<MatchPlayer> players,  List<String> staff)?  rosterDeclared,TResult Function( String chief,  List<String> water,  List<String> timekeepers)?  officialsAssigned,TResult Function( MatchPhase phase)?  periodWarningGiven,TResult Function( RestartType restartType,  TeamColor? team)?  playStarted,TResult Function( StopReason reason)?  playStopped,TResult Function( String targetId,  StopReason reason)?  stopReasonSpecified,TResult Function( String? reason)?  officialsTimeOutStarted,TResult Function( TeamColor team)?  teamTimeOutRequested,TResult Function( MatchPhase phase)?  periodEnded,TResult Function( TeamColor team,  int? scorerCap,  GoalKind kind)?  goalScored,TResult Function( TeamColor team,  int? cap,  String infringementCode,  bool deliberate,  bool isTeamCaution)?  cautionGiven,TResult Function( TeamColor team,  int cap,  int minutes,  String infringementCode,  bool deliberate)?  timePenaltyGiven,TResult Function( TeamColor team,  int cap,  String infringementCode)?  playerDismissed,TResult Function( TeamColor team,  String name)?  officialDismissed,TResult Function( TeamColor againstTeam)?  penaltyShotAwarded,TResult Function( PenaltyShotOutcome outcome,  List<int> attackers,  int? defender)?  penaltyShotResolved,TResult Function( TeamColor team,  int cap)?  penaltyPlayerReturned,TResult Function( TeamColor team,  String by,  String text)?  protestLogged,TResult Function( String targetId,  String reason)?  eventVoided,TResult Function( String chiefSignature,  List<String> waterSignatures)?  matchEndedBySignOff,TResult Function( TeamColor? winner,  String text)?  resultDecidedByDelegate,TResult Function( TeamColor team,  String decisionText)?  matchForfeited,TResult Function( String decisionText,  MatchScore? resultOverride)?  matchAbandoned,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MatchCreated() when matchCreated != null:
return matchCreated(_that.config,_that.teamWhite,_that.teamBlack,_that.startingEnds,_that.tournamentId,_that.fieldId);case RosterDeclared() when rosterDeclared != null:
return rosterDeclared(_that.team,_that.players,_that.staff);case OfficialsAssigned() when officialsAssigned != null:
return officialsAssigned(_that.chief,_that.water,_that.timekeepers);case PeriodWarningGiven() when periodWarningGiven != null:
return periodWarningGiven(_that.phase);case PlayStarted() when playStarted != null:
return playStarted(_that.restartType,_that.team);case PlayStopped() when playStopped != null:
return playStopped(_that.reason);case StopReasonSpecified() when stopReasonSpecified != null:
return stopReasonSpecified(_that.targetId,_that.reason);case OfficialsTimeOutStarted() when officialsTimeOutStarted != null:
return officialsTimeOutStarted(_that.reason);case TeamTimeOutRequested() when teamTimeOutRequested != null:
return teamTimeOutRequested(_that.team);case PeriodEnded() when periodEnded != null:
return periodEnded(_that.phase);case GoalScored() when goalScored != null:
return goalScored(_that.team,_that.scorerCap,_that.kind);case CautionGiven() when cautionGiven != null:
return cautionGiven(_that.team,_that.cap,_that.infringementCode,_that.deliberate,_that.isTeamCaution);case TimePenaltyGiven() when timePenaltyGiven != null:
return timePenaltyGiven(_that.team,_that.cap,_that.minutes,_that.infringementCode,_that.deliberate);case PlayerDismissed() when playerDismissed != null:
return playerDismissed(_that.team,_that.cap,_that.infringementCode);case OfficialDismissed() when officialDismissed != null:
return officialDismissed(_that.team,_that.name);case PenaltyShotAwarded() when penaltyShotAwarded != null:
return penaltyShotAwarded(_that.againstTeam);case PenaltyShotResolved() when penaltyShotResolved != null:
return penaltyShotResolved(_that.outcome,_that.attackers,_that.defender);case PenaltyPlayerReturned() when penaltyPlayerReturned != null:
return penaltyPlayerReturned(_that.team,_that.cap);case ProtestLogged() when protestLogged != null:
return protestLogged(_that.team,_that.by,_that.text);case EventVoided() when eventVoided != null:
return eventVoided(_that.targetId,_that.reason);case MatchEndedBySignOff() when matchEndedBySignOff != null:
return matchEndedBySignOff(_that.chiefSignature,_that.waterSignatures);case ResultDecidedByDelegate() when resultDecidedByDelegate != null:
return resultDecidedByDelegate(_that.winner,_that.text);case MatchForfeited() when matchForfeited != null:
return matchForfeited(_that.team,_that.decisionText);case MatchAbandoned() when matchAbandoned != null:
return matchAbandoned(_that.decisionText,_that.resultOverride);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( MatchConfig config,  String teamWhite,  String teamBlack,  StartingEnds startingEnds,  String? tournamentId,  String? fieldId)  matchCreated,required TResult Function( TeamColor team,  List<MatchPlayer> players,  List<String> staff)  rosterDeclared,required TResult Function( String chief,  List<String> water,  List<String> timekeepers)  officialsAssigned,required TResult Function( MatchPhase phase)  periodWarningGiven,required TResult Function( RestartType restartType,  TeamColor? team)  playStarted,required TResult Function( StopReason reason)  playStopped,required TResult Function( String targetId,  StopReason reason)  stopReasonSpecified,required TResult Function( String? reason)  officialsTimeOutStarted,required TResult Function( TeamColor team)  teamTimeOutRequested,required TResult Function( MatchPhase phase)  periodEnded,required TResult Function( TeamColor team,  int? scorerCap,  GoalKind kind)  goalScored,required TResult Function( TeamColor team,  int? cap,  String infringementCode,  bool deliberate,  bool isTeamCaution)  cautionGiven,required TResult Function( TeamColor team,  int cap,  int minutes,  String infringementCode,  bool deliberate)  timePenaltyGiven,required TResult Function( TeamColor team,  int cap,  String infringementCode)  playerDismissed,required TResult Function( TeamColor team,  String name)  officialDismissed,required TResult Function( TeamColor againstTeam)  penaltyShotAwarded,required TResult Function( PenaltyShotOutcome outcome,  List<int> attackers,  int? defender)  penaltyShotResolved,required TResult Function( TeamColor team,  int cap)  penaltyPlayerReturned,required TResult Function( TeamColor team,  String by,  String text)  protestLogged,required TResult Function( String targetId,  String reason)  eventVoided,required TResult Function( String chiefSignature,  List<String> waterSignatures)  matchEndedBySignOff,required TResult Function( TeamColor? winner,  String text)  resultDecidedByDelegate,required TResult Function( TeamColor team,  String decisionText)  matchForfeited,required TResult Function( String decisionText,  MatchScore? resultOverride)  matchAbandoned,}) {final _that = this;
switch (_that) {
case MatchCreated():
return matchCreated(_that.config,_that.teamWhite,_that.teamBlack,_that.startingEnds,_that.tournamentId,_that.fieldId);case RosterDeclared():
return rosterDeclared(_that.team,_that.players,_that.staff);case OfficialsAssigned():
return officialsAssigned(_that.chief,_that.water,_that.timekeepers);case PeriodWarningGiven():
return periodWarningGiven(_that.phase);case PlayStarted():
return playStarted(_that.restartType,_that.team);case PlayStopped():
return playStopped(_that.reason);case StopReasonSpecified():
return stopReasonSpecified(_that.targetId,_that.reason);case OfficialsTimeOutStarted():
return officialsTimeOutStarted(_that.reason);case TeamTimeOutRequested():
return teamTimeOutRequested(_that.team);case PeriodEnded():
return periodEnded(_that.phase);case GoalScored():
return goalScored(_that.team,_that.scorerCap,_that.kind);case CautionGiven():
return cautionGiven(_that.team,_that.cap,_that.infringementCode,_that.deliberate,_that.isTeamCaution);case TimePenaltyGiven():
return timePenaltyGiven(_that.team,_that.cap,_that.minutes,_that.infringementCode,_that.deliberate);case PlayerDismissed():
return playerDismissed(_that.team,_that.cap,_that.infringementCode);case OfficialDismissed():
return officialDismissed(_that.team,_that.name);case PenaltyShotAwarded():
return penaltyShotAwarded(_that.againstTeam);case PenaltyShotResolved():
return penaltyShotResolved(_that.outcome,_that.attackers,_that.defender);case PenaltyPlayerReturned():
return penaltyPlayerReturned(_that.team,_that.cap);case ProtestLogged():
return protestLogged(_that.team,_that.by,_that.text);case EventVoided():
return eventVoided(_that.targetId,_that.reason);case MatchEndedBySignOff():
return matchEndedBySignOff(_that.chiefSignature,_that.waterSignatures);case ResultDecidedByDelegate():
return resultDecidedByDelegate(_that.winner,_that.text);case MatchForfeited():
return matchForfeited(_that.team,_that.decisionText);case MatchAbandoned():
return matchAbandoned(_that.decisionText,_that.resultOverride);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( MatchConfig config,  String teamWhite,  String teamBlack,  StartingEnds startingEnds,  String? tournamentId,  String? fieldId)?  matchCreated,TResult? Function( TeamColor team,  List<MatchPlayer> players,  List<String> staff)?  rosterDeclared,TResult? Function( String chief,  List<String> water,  List<String> timekeepers)?  officialsAssigned,TResult? Function( MatchPhase phase)?  periodWarningGiven,TResult? Function( RestartType restartType,  TeamColor? team)?  playStarted,TResult? Function( StopReason reason)?  playStopped,TResult? Function( String targetId,  StopReason reason)?  stopReasonSpecified,TResult? Function( String? reason)?  officialsTimeOutStarted,TResult? Function( TeamColor team)?  teamTimeOutRequested,TResult? Function( MatchPhase phase)?  periodEnded,TResult? Function( TeamColor team,  int? scorerCap,  GoalKind kind)?  goalScored,TResult? Function( TeamColor team,  int? cap,  String infringementCode,  bool deliberate,  bool isTeamCaution)?  cautionGiven,TResult? Function( TeamColor team,  int cap,  int minutes,  String infringementCode,  bool deliberate)?  timePenaltyGiven,TResult? Function( TeamColor team,  int cap,  String infringementCode)?  playerDismissed,TResult? Function( TeamColor team,  String name)?  officialDismissed,TResult? Function( TeamColor againstTeam)?  penaltyShotAwarded,TResult? Function( PenaltyShotOutcome outcome,  List<int> attackers,  int? defender)?  penaltyShotResolved,TResult? Function( TeamColor team,  int cap)?  penaltyPlayerReturned,TResult? Function( TeamColor team,  String by,  String text)?  protestLogged,TResult? Function( String targetId,  String reason)?  eventVoided,TResult? Function( String chiefSignature,  List<String> waterSignatures)?  matchEndedBySignOff,TResult? Function( TeamColor? winner,  String text)?  resultDecidedByDelegate,TResult? Function( TeamColor team,  String decisionText)?  matchForfeited,TResult? Function( String decisionText,  MatchScore? resultOverride)?  matchAbandoned,}) {final _that = this;
switch (_that) {
case MatchCreated() when matchCreated != null:
return matchCreated(_that.config,_that.teamWhite,_that.teamBlack,_that.startingEnds,_that.tournamentId,_that.fieldId);case RosterDeclared() when rosterDeclared != null:
return rosterDeclared(_that.team,_that.players,_that.staff);case OfficialsAssigned() when officialsAssigned != null:
return officialsAssigned(_that.chief,_that.water,_that.timekeepers);case PeriodWarningGiven() when periodWarningGiven != null:
return periodWarningGiven(_that.phase);case PlayStarted() when playStarted != null:
return playStarted(_that.restartType,_that.team);case PlayStopped() when playStopped != null:
return playStopped(_that.reason);case StopReasonSpecified() when stopReasonSpecified != null:
return stopReasonSpecified(_that.targetId,_that.reason);case OfficialsTimeOutStarted() when officialsTimeOutStarted != null:
return officialsTimeOutStarted(_that.reason);case TeamTimeOutRequested() when teamTimeOutRequested != null:
return teamTimeOutRequested(_that.team);case PeriodEnded() when periodEnded != null:
return periodEnded(_that.phase);case GoalScored() when goalScored != null:
return goalScored(_that.team,_that.scorerCap,_that.kind);case CautionGiven() when cautionGiven != null:
return cautionGiven(_that.team,_that.cap,_that.infringementCode,_that.deliberate,_that.isTeamCaution);case TimePenaltyGiven() when timePenaltyGiven != null:
return timePenaltyGiven(_that.team,_that.cap,_that.minutes,_that.infringementCode,_that.deliberate);case PlayerDismissed() when playerDismissed != null:
return playerDismissed(_that.team,_that.cap,_that.infringementCode);case OfficialDismissed() when officialDismissed != null:
return officialDismissed(_that.team,_that.name);case PenaltyShotAwarded() when penaltyShotAwarded != null:
return penaltyShotAwarded(_that.againstTeam);case PenaltyShotResolved() when penaltyShotResolved != null:
return penaltyShotResolved(_that.outcome,_that.attackers,_that.defender);case PenaltyPlayerReturned() when penaltyPlayerReturned != null:
return penaltyPlayerReturned(_that.team,_that.cap);case ProtestLogged() when protestLogged != null:
return protestLogged(_that.team,_that.by,_that.text);case EventVoided() when eventVoided != null:
return eventVoided(_that.targetId,_that.reason);case MatchEndedBySignOff() when matchEndedBySignOff != null:
return matchEndedBySignOff(_that.chiefSignature,_that.waterSignatures);case ResultDecidedByDelegate() when resultDecidedByDelegate != null:
return resultDecidedByDelegate(_that.winner,_that.text);case MatchForfeited() when matchForfeited != null:
return matchForfeited(_that.team,_that.decisionText);case MatchAbandoned() when matchAbandoned != null:
return matchAbandoned(_that.decisionText,_that.resultOverride);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class MatchCreated extends MatchEventData {
  const MatchCreated({required this.config, required this.teamWhite, required this.teamBlack, this.startingEnds = StartingEnds.whiteLeft, this.tournamentId, this.fieldId, final  String? $type}): $type = $type ?? 'matchCreated',super._();
  factory MatchCreated.fromJson(Map<String, dynamic> json) => _$MatchCreatedFromJson(json);

/// Snapshot van de effectieve config; latere wijzigingen aan een preset
/// raken deze wedstrijd niet meer.
 final  MatchConfig config;
 final  String teamWhite;
 final  String teamBlack;
@JsonKey() final  StartingEnds startingEnds;
 final  String? tournamentId;
 final  String? fieldId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchCreatedCopyWith<MatchCreated> get copyWith => _$MatchCreatedCopyWithImpl<MatchCreated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchCreatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchCreated&&(identical(other.config, config) || other.config == config)&&(identical(other.teamWhite, teamWhite) || other.teamWhite == teamWhite)&&(identical(other.teamBlack, teamBlack) || other.teamBlack == teamBlack)&&(identical(other.startingEnds, startingEnds) || other.startingEnds == startingEnds)&&(identical(other.tournamentId, tournamentId) || other.tournamentId == tournamentId)&&(identical(other.fieldId, fieldId) || other.fieldId == fieldId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,config,teamWhite,teamBlack,startingEnds,tournamentId,fieldId);

@override
String toString() {
  return 'MatchEventData.matchCreated(config: $config, teamWhite: $teamWhite, teamBlack: $teamBlack, startingEnds: $startingEnds, tournamentId: $tournamentId, fieldId: $fieldId)';
}


}

/// @nodoc
abstract mixin class $MatchCreatedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $MatchCreatedCopyWith(MatchCreated value, $Res Function(MatchCreated) _then) = _$MatchCreatedCopyWithImpl;
@useResult
$Res call({
 MatchConfig config, String teamWhite, String teamBlack, StartingEnds startingEnds, String? tournamentId, String? fieldId
});


$MatchConfigCopyWith<$Res> get config;

}
/// @nodoc
class _$MatchCreatedCopyWithImpl<$Res>
    implements $MatchCreatedCopyWith<$Res> {
  _$MatchCreatedCopyWithImpl(this._self, this._then);

  final MatchCreated _self;
  final $Res Function(MatchCreated) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? config = null,Object? teamWhite = null,Object? teamBlack = null,Object? startingEnds = null,Object? tournamentId = freezed,Object? fieldId = freezed,}) {
  return _then(MatchCreated(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as MatchConfig,teamWhite: null == teamWhite ? _self.teamWhite : teamWhite // ignore: cast_nullable_to_non_nullable
as String,teamBlack: null == teamBlack ? _self.teamBlack : teamBlack // ignore: cast_nullable_to_non_nullable
as String,startingEnds: null == startingEnds ? _self.startingEnds : startingEnds // ignore: cast_nullable_to_non_nullable
as StartingEnds,tournamentId: freezed == tournamentId ? _self.tournamentId : tournamentId // ignore: cast_nullable_to_non_nullable
as String?,fieldId: freezed == fieldId ? _self.fieldId : fieldId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchConfigCopyWith<$Res> get config {
  
  return $MatchConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class RosterDeclared extends MatchEventData {
  const RosterDeclared({required this.team, required final  List<MatchPlayer> players, final  List<String> staff = const <String>[], final  String? $type}): _players = players,_staff = staff,$type = $type ?? 'rosterDeclared',super._();
  factory RosterDeclared.fromJson(Map<String, dynamic> json) => _$RosterDeclaredFromJson(json);

 final  TeamColor team;
 final  List<MatchPlayer> _players;
 List<MatchPlayer> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}

 final  List<String> _staff;
@JsonKey() List<String> get staff {
  if (_staff is EqualUnmodifiableListView) return _staff;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_staff);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RosterDeclaredCopyWith<RosterDeclared> get copyWith => _$RosterDeclaredCopyWithImpl<RosterDeclared>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RosterDeclaredToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RosterDeclared&&(identical(other.team, team) || other.team == team)&&const DeepCollectionEquality().equals(other._players, _players)&&const DeepCollectionEquality().equals(other._staff, _staff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,const DeepCollectionEquality().hash(_players),const DeepCollectionEquality().hash(_staff));

@override
String toString() {
  return 'MatchEventData.rosterDeclared(team: $team, players: $players, staff: $staff)';
}


}

/// @nodoc
abstract mixin class $RosterDeclaredCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $RosterDeclaredCopyWith(RosterDeclared value, $Res Function(RosterDeclared) _then) = _$RosterDeclaredCopyWithImpl;
@useResult
$Res call({
 TeamColor team, List<MatchPlayer> players, List<String> staff
});




}
/// @nodoc
class _$RosterDeclaredCopyWithImpl<$Res>
    implements $RosterDeclaredCopyWith<$Res> {
  _$RosterDeclaredCopyWithImpl(this._self, this._then);

  final RosterDeclared _self;
  final $Res Function(RosterDeclared) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,Object? players = null,Object? staff = null,}) {
  return _then(RosterDeclared(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<MatchPlayer>,staff: null == staff ? _self._staff : staff // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OfficialsAssigned extends MatchEventData {
  const OfficialsAssigned({required this.chief, final  List<String> water = const <String>[], final  List<String> timekeepers = const <String>[], final  String? $type}): _water = water,_timekeepers = timekeepers,$type = $type ?? 'officialsAssigned',super._();
  factory OfficialsAssigned.fromJson(Map<String, dynamic> json) => _$OfficialsAssignedFromJson(json);

 final  String chief;
 final  List<String> _water;
@JsonKey() List<String> get water {
  if (_water is EqualUnmodifiableListView) return _water;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_water);
}

 final  List<String> _timekeepers;
@JsonKey() List<String> get timekeepers {
  if (_timekeepers is EqualUnmodifiableListView) return _timekeepers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timekeepers);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfficialsAssignedCopyWith<OfficialsAssigned> get copyWith => _$OfficialsAssignedCopyWithImpl<OfficialsAssigned>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfficialsAssignedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfficialsAssigned&&(identical(other.chief, chief) || other.chief == chief)&&const DeepCollectionEquality().equals(other._water, _water)&&const DeepCollectionEquality().equals(other._timekeepers, _timekeepers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chief,const DeepCollectionEquality().hash(_water),const DeepCollectionEquality().hash(_timekeepers));

@override
String toString() {
  return 'MatchEventData.officialsAssigned(chief: $chief, water: $water, timekeepers: $timekeepers)';
}


}

/// @nodoc
abstract mixin class $OfficialsAssignedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $OfficialsAssignedCopyWith(OfficialsAssigned value, $Res Function(OfficialsAssigned) _then) = _$OfficialsAssignedCopyWithImpl;
@useResult
$Res call({
 String chief, List<String> water, List<String> timekeepers
});




}
/// @nodoc
class _$OfficialsAssignedCopyWithImpl<$Res>
    implements $OfficialsAssignedCopyWith<$Res> {
  _$OfficialsAssignedCopyWithImpl(this._self, this._then);

  final OfficialsAssigned _self;
  final $Res Function(OfficialsAssigned) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? chief = null,Object? water = null,Object? timekeepers = null,}) {
  return _then(OfficialsAssigned(
chief: null == chief ? _self.chief : chief // ignore: cast_nullable_to_non_nullable
as String,water: null == water ? _self._water : water // ignore: cast_nullable_to_non_nullable
as List<String>,timekeepers: null == timekeepers ? _self._timekeepers : timekeepers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PeriodWarningGiven extends MatchEventData {
  const PeriodWarningGiven({required this.phase, final  String? $type}): $type = $type ?? 'periodWarningGiven',super._();
  factory PeriodWarningGiven.fromJson(Map<String, dynamic> json) => _$PeriodWarningGivenFromJson(json);

 final  MatchPhase phase;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodWarningGivenCopyWith<PeriodWarningGiven> get copyWith => _$PeriodWarningGivenCopyWithImpl<PeriodWarningGiven>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeriodWarningGivenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodWarningGiven&&(identical(other.phase, phase) || other.phase == phase));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phase);

@override
String toString() {
  return 'MatchEventData.periodWarningGiven(phase: $phase)';
}


}

/// @nodoc
abstract mixin class $PeriodWarningGivenCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $PeriodWarningGivenCopyWith(PeriodWarningGiven value, $Res Function(PeriodWarningGiven) _then) = _$PeriodWarningGivenCopyWithImpl;
@useResult
$Res call({
 MatchPhase phase
});




}
/// @nodoc
class _$PeriodWarningGivenCopyWithImpl<$Res>
    implements $PeriodWarningGivenCopyWith<$Res> {
  _$PeriodWarningGivenCopyWithImpl(this._self, this._then);

  final PeriodWarningGiven _self;
  final $Res Function(PeriodWarningGiven) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phase = null,}) {
  return _then(PeriodWarningGiven(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as MatchPhase,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PlayStarted extends MatchEventData {
  const PlayStarted({this.restartType = RestartType.endLineStart, this.team, final  String? $type}): $type = $type ?? 'playStarted',super._();
  factory PlayStarted.fromJson(Map<String, dynamic> json) => _$PlayStartedFromJson(json);

@JsonKey() final  RestartType restartType;
 final  TeamColor? team;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayStartedCopyWith<PlayStarted> get copyWith => _$PlayStartedCopyWithImpl<PlayStarted>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayStartedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayStarted&&(identical(other.restartType, restartType) || other.restartType == restartType)&&(identical(other.team, team) || other.team == team));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restartType,team);

@override
String toString() {
  return 'MatchEventData.playStarted(restartType: $restartType, team: $team)';
}


}

/// @nodoc
abstract mixin class $PlayStartedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $PlayStartedCopyWith(PlayStarted value, $Res Function(PlayStarted) _then) = _$PlayStartedCopyWithImpl;
@useResult
$Res call({
 RestartType restartType, TeamColor? team
});




}
/// @nodoc
class _$PlayStartedCopyWithImpl<$Res>
    implements $PlayStartedCopyWith<$Res> {
  _$PlayStartedCopyWithImpl(this._self, this._then);

  final PlayStarted _self;
  final $Res Function(PlayStarted) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? restartType = null,Object? team = freezed,}) {
  return _then(PlayStarted(
restartType: null == restartType ? _self.restartType : restartType // ignore: cast_nullable_to_non_nullable
as RestartType,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PlayStopped extends MatchEventData {
  const PlayStopped({this.reason = StopReason.unspecified, final  String? $type}): $type = $type ?? 'playStopped',super._();
  factory PlayStopped.fromJson(Map<String, dynamic> json) => _$PlayStoppedFromJson(json);

@JsonKey() final  StopReason reason;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayStoppedCopyWith<PlayStopped> get copyWith => _$PlayStoppedCopyWithImpl<PlayStopped>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayStoppedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayStopped&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'MatchEventData.playStopped(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $PlayStoppedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $PlayStoppedCopyWith(PlayStopped value, $Res Function(PlayStopped) _then) = _$PlayStoppedCopyWithImpl;
@useResult
$Res call({
 StopReason reason
});




}
/// @nodoc
class _$PlayStoppedCopyWithImpl<$Res>
    implements $PlayStoppedCopyWith<$Res> {
  _$PlayStoppedCopyWithImpl(this._self, this._then);

  final PlayStopped _self;
  final $Res Function(PlayStopped) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(PlayStopped(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as StopReason,
  ));
}


}

/// @nodoc
@JsonSerializable()

class StopReasonSpecified extends MatchEventData {
  const StopReasonSpecified({required this.targetId, required this.reason, final  String? $type}): $type = $type ?? 'stopReasonSpecified',super._();
  factory StopReasonSpecified.fromJson(Map<String, dynamic> json) => _$StopReasonSpecifiedFromJson(json);

 final  String targetId;
 final  StopReason reason;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StopReasonSpecifiedCopyWith<StopReasonSpecified> get copyWith => _$StopReasonSpecifiedCopyWithImpl<StopReasonSpecified>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StopReasonSpecifiedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StopReasonSpecified&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetId,reason);

@override
String toString() {
  return 'MatchEventData.stopReasonSpecified(targetId: $targetId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $StopReasonSpecifiedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $StopReasonSpecifiedCopyWith(StopReasonSpecified value, $Res Function(StopReasonSpecified) _then) = _$StopReasonSpecifiedCopyWithImpl;
@useResult
$Res call({
 String targetId, StopReason reason
});




}
/// @nodoc
class _$StopReasonSpecifiedCopyWithImpl<$Res>
    implements $StopReasonSpecifiedCopyWith<$Res> {
  _$StopReasonSpecifiedCopyWithImpl(this._self, this._then);

  final StopReasonSpecified _self;
  final $Res Function(StopReasonSpecified) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? targetId = null,Object? reason = null,}) {
  return _then(StopReasonSpecified(
targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as StopReason,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OfficialsTimeOutStarted extends MatchEventData {
  const OfficialsTimeOutStarted({this.reason, final  String? $type}): $type = $type ?? 'officialsTimeOutStarted',super._();
  factory OfficialsTimeOutStarted.fromJson(Map<String, dynamic> json) => _$OfficialsTimeOutStartedFromJson(json);

 final  String? reason;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfficialsTimeOutStartedCopyWith<OfficialsTimeOutStarted> get copyWith => _$OfficialsTimeOutStartedCopyWithImpl<OfficialsTimeOutStarted>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfficialsTimeOutStartedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfficialsTimeOutStarted&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'MatchEventData.officialsTimeOutStarted(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $OfficialsTimeOutStartedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $OfficialsTimeOutStartedCopyWith(OfficialsTimeOutStarted value, $Res Function(OfficialsTimeOutStarted) _then) = _$OfficialsTimeOutStartedCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class _$OfficialsTimeOutStartedCopyWithImpl<$Res>
    implements $OfficialsTimeOutStartedCopyWith<$Res> {
  _$OfficialsTimeOutStartedCopyWithImpl(this._self, this._then);

  final OfficialsTimeOutStarted _self;
  final $Res Function(OfficialsTimeOutStarted) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(OfficialsTimeOutStarted(
reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TeamTimeOutRequested extends MatchEventData {
  const TeamTimeOutRequested({required this.team, final  String? $type}): $type = $type ?? 'teamTimeOutRequested',super._();
  factory TeamTimeOutRequested.fromJson(Map<String, dynamic> json) => _$TeamTimeOutRequestedFromJson(json);

 final  TeamColor team;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamTimeOutRequestedCopyWith<TeamTimeOutRequested> get copyWith => _$TeamTimeOutRequestedCopyWithImpl<TeamTimeOutRequested>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamTimeOutRequestedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamTimeOutRequested&&(identical(other.team, team) || other.team == team));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team);

@override
String toString() {
  return 'MatchEventData.teamTimeOutRequested(team: $team)';
}


}

/// @nodoc
abstract mixin class $TeamTimeOutRequestedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $TeamTimeOutRequestedCopyWith(TeamTimeOutRequested value, $Res Function(TeamTimeOutRequested) _then) = _$TeamTimeOutRequestedCopyWithImpl;
@useResult
$Res call({
 TeamColor team
});




}
/// @nodoc
class _$TeamTimeOutRequestedCopyWithImpl<$Res>
    implements $TeamTimeOutRequestedCopyWith<$Res> {
  _$TeamTimeOutRequestedCopyWithImpl(this._self, this._then);

  final TeamTimeOutRequested _self;
  final $Res Function(TeamTimeOutRequested) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,}) {
  return _then(TeamTimeOutRequested(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PeriodEnded extends MatchEventData {
  const PeriodEnded({required this.phase, final  String? $type}): $type = $type ?? 'periodEnded',super._();
  factory PeriodEnded.fromJson(Map<String, dynamic> json) => _$PeriodEndedFromJson(json);

 final  MatchPhase phase;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodEndedCopyWith<PeriodEnded> get copyWith => _$PeriodEndedCopyWithImpl<PeriodEnded>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeriodEndedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodEnded&&(identical(other.phase, phase) || other.phase == phase));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phase);

@override
String toString() {
  return 'MatchEventData.periodEnded(phase: $phase)';
}


}

/// @nodoc
abstract mixin class $PeriodEndedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $PeriodEndedCopyWith(PeriodEnded value, $Res Function(PeriodEnded) _then) = _$PeriodEndedCopyWithImpl;
@useResult
$Res call({
 MatchPhase phase
});




}
/// @nodoc
class _$PeriodEndedCopyWithImpl<$Res>
    implements $PeriodEndedCopyWith<$Res> {
  _$PeriodEndedCopyWithImpl(this._self, this._then);

  final PeriodEnded _self;
  final $Res Function(PeriodEnded) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phase = null,}) {
  return _then(PeriodEnded(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as MatchPhase,
  ));
}


}

/// @nodoc
@JsonSerializable()

class GoalScored extends MatchEventData {
  const GoalScored({required this.team, this.scorerCap, this.kind = GoalKind.field, final  String? $type}): $type = $type ?? 'goalScored',super._();
  factory GoalScored.fromJson(Map<String, dynamic> json) => _$GoalScoredFromJson(json);

 final  TeamColor team;
 final  int? scorerCap;
@JsonKey() final  GoalKind kind;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalScoredCopyWith<GoalScored> get copyWith => _$GoalScoredCopyWithImpl<GoalScored>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalScoredToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalScored&&(identical(other.team, team) || other.team == team)&&(identical(other.scorerCap, scorerCap) || other.scorerCap == scorerCap)&&(identical(other.kind, kind) || other.kind == kind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,scorerCap,kind);

@override
String toString() {
  return 'MatchEventData.goalScored(team: $team, scorerCap: $scorerCap, kind: $kind)';
}


}

/// @nodoc
abstract mixin class $GoalScoredCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $GoalScoredCopyWith(GoalScored value, $Res Function(GoalScored) _then) = _$GoalScoredCopyWithImpl;
@useResult
$Res call({
 TeamColor team, int? scorerCap, GoalKind kind
});




}
/// @nodoc
class _$GoalScoredCopyWithImpl<$Res>
    implements $GoalScoredCopyWith<$Res> {
  _$GoalScoredCopyWithImpl(this._self, this._then);

  final GoalScored _self;
  final $Res Function(GoalScored) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,Object? scorerCap = freezed,Object? kind = null,}) {
  return _then(GoalScored(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor,scorerCap: freezed == scorerCap ? _self.scorerCap : scorerCap // ignore: cast_nullable_to_non_nullable
as int?,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as GoalKind,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CautionGiven extends MatchEventData {
  const CautionGiven({required this.team, this.cap, required this.infringementCode, this.deliberate = false, this.isTeamCaution = false, final  String? $type}): $type = $type ?? 'cautionGiven',super._();
  factory CautionGiven.fromJson(Map<String, dynamic> json) => _$CautionGivenFromJson(json);

 final  TeamColor team;
 final  int? cap;
 final  String infringementCode;
@JsonKey() final  bool deliberate;
@JsonKey() final  bool isTeamCaution;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CautionGivenCopyWith<CautionGiven> get copyWith => _$CautionGivenCopyWithImpl<CautionGiven>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CautionGivenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CautionGiven&&(identical(other.team, team) || other.team == team)&&(identical(other.cap, cap) || other.cap == cap)&&(identical(other.infringementCode, infringementCode) || other.infringementCode == infringementCode)&&(identical(other.deliberate, deliberate) || other.deliberate == deliberate)&&(identical(other.isTeamCaution, isTeamCaution) || other.isTeamCaution == isTeamCaution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,cap,infringementCode,deliberate,isTeamCaution);

@override
String toString() {
  return 'MatchEventData.cautionGiven(team: $team, cap: $cap, infringementCode: $infringementCode, deliberate: $deliberate, isTeamCaution: $isTeamCaution)';
}


}

/// @nodoc
abstract mixin class $CautionGivenCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $CautionGivenCopyWith(CautionGiven value, $Res Function(CautionGiven) _then) = _$CautionGivenCopyWithImpl;
@useResult
$Res call({
 TeamColor team, int? cap, String infringementCode, bool deliberate, bool isTeamCaution
});




}
/// @nodoc
class _$CautionGivenCopyWithImpl<$Res>
    implements $CautionGivenCopyWith<$Res> {
  _$CautionGivenCopyWithImpl(this._self, this._then);

  final CautionGiven _self;
  final $Res Function(CautionGiven) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,Object? cap = freezed,Object? infringementCode = null,Object? deliberate = null,Object? isTeamCaution = null,}) {
  return _then(CautionGiven(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor,cap: freezed == cap ? _self.cap : cap // ignore: cast_nullable_to_non_nullable
as int?,infringementCode: null == infringementCode ? _self.infringementCode : infringementCode // ignore: cast_nullable_to_non_nullable
as String,deliberate: null == deliberate ? _self.deliberate : deliberate // ignore: cast_nullable_to_non_nullable
as bool,isTeamCaution: null == isTeamCaution ? _self.isTeamCaution : isTeamCaution // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TimePenaltyGiven extends MatchEventData {
  const TimePenaltyGiven({required this.team, required this.cap, required this.minutes, required this.infringementCode, this.deliberate = false, final  String? $type}): $type = $type ?? 'timePenaltyGiven',super._();
  factory TimePenaltyGiven.fromJson(Map<String, dynamic> json) => _$TimePenaltyGivenFromJson(json);

 final  TeamColor team;
 final  int cap;
 final  int minutes;
 final  String infringementCode;
@JsonKey() final  bool deliberate;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimePenaltyGivenCopyWith<TimePenaltyGiven> get copyWith => _$TimePenaltyGivenCopyWithImpl<TimePenaltyGiven>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimePenaltyGivenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimePenaltyGiven&&(identical(other.team, team) || other.team == team)&&(identical(other.cap, cap) || other.cap == cap)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.infringementCode, infringementCode) || other.infringementCode == infringementCode)&&(identical(other.deliberate, deliberate) || other.deliberate == deliberate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,cap,minutes,infringementCode,deliberate);

@override
String toString() {
  return 'MatchEventData.timePenaltyGiven(team: $team, cap: $cap, minutes: $minutes, infringementCode: $infringementCode, deliberate: $deliberate)';
}


}

/// @nodoc
abstract mixin class $TimePenaltyGivenCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $TimePenaltyGivenCopyWith(TimePenaltyGiven value, $Res Function(TimePenaltyGiven) _then) = _$TimePenaltyGivenCopyWithImpl;
@useResult
$Res call({
 TeamColor team, int cap, int minutes, String infringementCode, bool deliberate
});




}
/// @nodoc
class _$TimePenaltyGivenCopyWithImpl<$Res>
    implements $TimePenaltyGivenCopyWith<$Res> {
  _$TimePenaltyGivenCopyWithImpl(this._self, this._then);

  final TimePenaltyGiven _self;
  final $Res Function(TimePenaltyGiven) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,Object? cap = null,Object? minutes = null,Object? infringementCode = null,Object? deliberate = null,}) {
  return _then(TimePenaltyGiven(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor,cap: null == cap ? _self.cap : cap // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,infringementCode: null == infringementCode ? _self.infringementCode : infringementCode // ignore: cast_nullable_to_non_nullable
as String,deliberate: null == deliberate ? _self.deliberate : deliberate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PlayerDismissed extends MatchEventData {
  const PlayerDismissed({required this.team, required this.cap, required this.infringementCode, final  String? $type}): $type = $type ?? 'playerDismissed',super._();
  factory PlayerDismissed.fromJson(Map<String, dynamic> json) => _$PlayerDismissedFromJson(json);

 final  TeamColor team;
 final  int cap;
 final  String infringementCode;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerDismissedCopyWith<PlayerDismissed> get copyWith => _$PlayerDismissedCopyWithImpl<PlayerDismissed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerDismissedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerDismissed&&(identical(other.team, team) || other.team == team)&&(identical(other.cap, cap) || other.cap == cap)&&(identical(other.infringementCode, infringementCode) || other.infringementCode == infringementCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,cap,infringementCode);

@override
String toString() {
  return 'MatchEventData.playerDismissed(team: $team, cap: $cap, infringementCode: $infringementCode)';
}


}

/// @nodoc
abstract mixin class $PlayerDismissedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $PlayerDismissedCopyWith(PlayerDismissed value, $Res Function(PlayerDismissed) _then) = _$PlayerDismissedCopyWithImpl;
@useResult
$Res call({
 TeamColor team, int cap, String infringementCode
});




}
/// @nodoc
class _$PlayerDismissedCopyWithImpl<$Res>
    implements $PlayerDismissedCopyWith<$Res> {
  _$PlayerDismissedCopyWithImpl(this._self, this._then);

  final PlayerDismissed _self;
  final $Res Function(PlayerDismissed) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,Object? cap = null,Object? infringementCode = null,}) {
  return _then(PlayerDismissed(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor,cap: null == cap ? _self.cap : cap // ignore: cast_nullable_to_non_nullable
as int,infringementCode: null == infringementCode ? _self.infringementCode : infringementCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OfficialDismissed extends MatchEventData {
  const OfficialDismissed({required this.team, required this.name, final  String? $type}): $type = $type ?? 'officialDismissed',super._();
  factory OfficialDismissed.fromJson(Map<String, dynamic> json) => _$OfficialDismissedFromJson(json);

 final  TeamColor team;
 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfficialDismissedCopyWith<OfficialDismissed> get copyWith => _$OfficialDismissedCopyWithImpl<OfficialDismissed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfficialDismissedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfficialDismissed&&(identical(other.team, team) || other.team == team)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,name);

@override
String toString() {
  return 'MatchEventData.officialDismissed(team: $team, name: $name)';
}


}

/// @nodoc
abstract mixin class $OfficialDismissedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $OfficialDismissedCopyWith(OfficialDismissed value, $Res Function(OfficialDismissed) _then) = _$OfficialDismissedCopyWithImpl;
@useResult
$Res call({
 TeamColor team, String name
});




}
/// @nodoc
class _$OfficialDismissedCopyWithImpl<$Res>
    implements $OfficialDismissedCopyWith<$Res> {
  _$OfficialDismissedCopyWithImpl(this._self, this._then);

  final OfficialDismissed _self;
  final $Res Function(OfficialDismissed) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,Object? name = null,}) {
  return _then(OfficialDismissed(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PenaltyShotAwarded extends MatchEventData {
  const PenaltyShotAwarded({required this.againstTeam, final  String? $type}): $type = $type ?? 'penaltyShotAwarded',super._();
  factory PenaltyShotAwarded.fromJson(Map<String, dynamic> json) => _$PenaltyShotAwardedFromJson(json);

 final  TeamColor againstTeam;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PenaltyShotAwardedCopyWith<PenaltyShotAwarded> get copyWith => _$PenaltyShotAwardedCopyWithImpl<PenaltyShotAwarded>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PenaltyShotAwardedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PenaltyShotAwarded&&(identical(other.againstTeam, againstTeam) || other.againstTeam == againstTeam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,againstTeam);

@override
String toString() {
  return 'MatchEventData.penaltyShotAwarded(againstTeam: $againstTeam)';
}


}

/// @nodoc
abstract mixin class $PenaltyShotAwardedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $PenaltyShotAwardedCopyWith(PenaltyShotAwarded value, $Res Function(PenaltyShotAwarded) _then) = _$PenaltyShotAwardedCopyWithImpl;
@useResult
$Res call({
 TeamColor againstTeam
});




}
/// @nodoc
class _$PenaltyShotAwardedCopyWithImpl<$Res>
    implements $PenaltyShotAwardedCopyWith<$Res> {
  _$PenaltyShotAwardedCopyWithImpl(this._self, this._then);

  final PenaltyShotAwarded _self;
  final $Res Function(PenaltyShotAwarded) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? againstTeam = null,}) {
  return _then(PenaltyShotAwarded(
againstTeam: null == againstTeam ? _self.againstTeam : againstTeam // ignore: cast_nullable_to_non_nullable
as TeamColor,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PenaltyShotResolved extends MatchEventData {
  const PenaltyShotResolved({required this.outcome, final  List<int> attackers = const <int>[], this.defender, final  String? $type}): _attackers = attackers,$type = $type ?? 'penaltyShotResolved',super._();
  factory PenaltyShotResolved.fromJson(Map<String, dynamic> json) => _$PenaltyShotResolvedFromJson(json);

 final  PenaltyShotOutcome outcome;
 final  List<int> _attackers;
@JsonKey() List<int> get attackers {
  if (_attackers is EqualUnmodifiableListView) return _attackers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attackers);
}

 final  int? defender;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PenaltyShotResolvedCopyWith<PenaltyShotResolved> get copyWith => _$PenaltyShotResolvedCopyWithImpl<PenaltyShotResolved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PenaltyShotResolvedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PenaltyShotResolved&&(identical(other.outcome, outcome) || other.outcome == outcome)&&const DeepCollectionEquality().equals(other._attackers, _attackers)&&(identical(other.defender, defender) || other.defender == defender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,outcome,const DeepCollectionEquality().hash(_attackers),defender);

@override
String toString() {
  return 'MatchEventData.penaltyShotResolved(outcome: $outcome, attackers: $attackers, defender: $defender)';
}


}

/// @nodoc
abstract mixin class $PenaltyShotResolvedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $PenaltyShotResolvedCopyWith(PenaltyShotResolved value, $Res Function(PenaltyShotResolved) _then) = _$PenaltyShotResolvedCopyWithImpl;
@useResult
$Res call({
 PenaltyShotOutcome outcome, List<int> attackers, int? defender
});




}
/// @nodoc
class _$PenaltyShotResolvedCopyWithImpl<$Res>
    implements $PenaltyShotResolvedCopyWith<$Res> {
  _$PenaltyShotResolvedCopyWithImpl(this._self, this._then);

  final PenaltyShotResolved _self;
  final $Res Function(PenaltyShotResolved) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? outcome = null,Object? attackers = null,Object? defender = freezed,}) {
  return _then(PenaltyShotResolved(
outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as PenaltyShotOutcome,attackers: null == attackers ? _self._attackers : attackers // ignore: cast_nullable_to_non_nullable
as List<int>,defender: freezed == defender ? _self.defender : defender // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PenaltyPlayerReturned extends MatchEventData {
  const PenaltyPlayerReturned({required this.team, required this.cap, final  String? $type}): $type = $type ?? 'penaltyPlayerReturned',super._();
  factory PenaltyPlayerReturned.fromJson(Map<String, dynamic> json) => _$PenaltyPlayerReturnedFromJson(json);

 final  TeamColor team;
 final  int cap;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PenaltyPlayerReturnedCopyWith<PenaltyPlayerReturned> get copyWith => _$PenaltyPlayerReturnedCopyWithImpl<PenaltyPlayerReturned>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PenaltyPlayerReturnedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PenaltyPlayerReturned&&(identical(other.team, team) || other.team == team)&&(identical(other.cap, cap) || other.cap == cap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,cap);

@override
String toString() {
  return 'MatchEventData.penaltyPlayerReturned(team: $team, cap: $cap)';
}


}

/// @nodoc
abstract mixin class $PenaltyPlayerReturnedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $PenaltyPlayerReturnedCopyWith(PenaltyPlayerReturned value, $Res Function(PenaltyPlayerReturned) _then) = _$PenaltyPlayerReturnedCopyWithImpl;
@useResult
$Res call({
 TeamColor team, int cap
});




}
/// @nodoc
class _$PenaltyPlayerReturnedCopyWithImpl<$Res>
    implements $PenaltyPlayerReturnedCopyWith<$Res> {
  _$PenaltyPlayerReturnedCopyWithImpl(this._self, this._then);

  final PenaltyPlayerReturned _self;
  final $Res Function(PenaltyPlayerReturned) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,Object? cap = null,}) {
  return _then(PenaltyPlayerReturned(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor,cap: null == cap ? _self.cap : cap // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ProtestLogged extends MatchEventData {
  const ProtestLogged({required this.team, required this.by, required this.text, final  String? $type}): $type = $type ?? 'protestLogged',super._();
  factory ProtestLogged.fromJson(Map<String, dynamic> json) => _$ProtestLoggedFromJson(json);

 final  TeamColor team;
 final  String by;
 final  String text;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProtestLoggedCopyWith<ProtestLogged> get copyWith => _$ProtestLoggedCopyWithImpl<ProtestLogged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProtestLoggedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProtestLogged&&(identical(other.team, team) || other.team == team)&&(identical(other.by, by) || other.by == by)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,by,text);

@override
String toString() {
  return 'MatchEventData.protestLogged(team: $team, by: $by, text: $text)';
}


}

/// @nodoc
abstract mixin class $ProtestLoggedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $ProtestLoggedCopyWith(ProtestLogged value, $Res Function(ProtestLogged) _then) = _$ProtestLoggedCopyWithImpl;
@useResult
$Res call({
 TeamColor team, String by, String text
});




}
/// @nodoc
class _$ProtestLoggedCopyWithImpl<$Res>
    implements $ProtestLoggedCopyWith<$Res> {
  _$ProtestLoggedCopyWithImpl(this._self, this._then);

  final ProtestLogged _self;
  final $Res Function(ProtestLogged) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,Object? by = null,Object? text = null,}) {
  return _then(ProtestLogged(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor,by: null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EventVoided extends MatchEventData {
  const EventVoided({required this.targetId, this.reason = '', final  String? $type}): $type = $type ?? 'eventVoided',super._();
  factory EventVoided.fromJson(Map<String, dynamic> json) => _$EventVoidedFromJson(json);

 final  String targetId;
@JsonKey() final  String reason;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventVoidedCopyWith<EventVoided> get copyWith => _$EventVoidedCopyWithImpl<EventVoided>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventVoidedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventVoided&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetId,reason);

@override
String toString() {
  return 'MatchEventData.eventVoided(targetId: $targetId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $EventVoidedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $EventVoidedCopyWith(EventVoided value, $Res Function(EventVoided) _then) = _$EventVoidedCopyWithImpl;
@useResult
$Res call({
 String targetId, String reason
});




}
/// @nodoc
class _$EventVoidedCopyWithImpl<$Res>
    implements $EventVoidedCopyWith<$Res> {
  _$EventVoidedCopyWithImpl(this._self, this._then);

  final EventVoided _self;
  final $Res Function(EventVoided) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? targetId = null,Object? reason = null,}) {
  return _then(EventVoided(
targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MatchEndedBySignOff extends MatchEventData {
  const MatchEndedBySignOff({required this.chiefSignature, final  List<String> waterSignatures = const <String>[], final  String? $type}): _waterSignatures = waterSignatures,$type = $type ?? 'matchEndedBySignOff',super._();
  factory MatchEndedBySignOff.fromJson(Map<String, dynamic> json) => _$MatchEndedBySignOffFromJson(json);

 final  String chiefSignature;
 final  List<String> _waterSignatures;
@JsonKey() List<String> get waterSignatures {
  if (_waterSignatures is EqualUnmodifiableListView) return _waterSignatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waterSignatures);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchEndedBySignOffCopyWith<MatchEndedBySignOff> get copyWith => _$MatchEndedBySignOffCopyWithImpl<MatchEndedBySignOff>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchEndedBySignOffToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchEndedBySignOff&&(identical(other.chiefSignature, chiefSignature) || other.chiefSignature == chiefSignature)&&const DeepCollectionEquality().equals(other._waterSignatures, _waterSignatures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chiefSignature,const DeepCollectionEquality().hash(_waterSignatures));

@override
String toString() {
  return 'MatchEventData.matchEndedBySignOff(chiefSignature: $chiefSignature, waterSignatures: $waterSignatures)';
}


}

/// @nodoc
abstract mixin class $MatchEndedBySignOffCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $MatchEndedBySignOffCopyWith(MatchEndedBySignOff value, $Res Function(MatchEndedBySignOff) _then) = _$MatchEndedBySignOffCopyWithImpl;
@useResult
$Res call({
 String chiefSignature, List<String> waterSignatures
});




}
/// @nodoc
class _$MatchEndedBySignOffCopyWithImpl<$Res>
    implements $MatchEndedBySignOffCopyWith<$Res> {
  _$MatchEndedBySignOffCopyWithImpl(this._self, this._then);

  final MatchEndedBySignOff _self;
  final $Res Function(MatchEndedBySignOff) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? chiefSignature = null,Object? waterSignatures = null,}) {
  return _then(MatchEndedBySignOff(
chiefSignature: null == chiefSignature ? _self.chiefSignature : chiefSignature // ignore: cast_nullable_to_non_nullable
as String,waterSignatures: null == waterSignatures ? _self._waterSignatures : waterSignatures // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ResultDecidedByDelegate extends MatchEventData {
  const ResultDecidedByDelegate({this.winner, required this.text, final  String? $type}): $type = $type ?? 'resultDecidedByDelegate',super._();
  factory ResultDecidedByDelegate.fromJson(Map<String, dynamic> json) => _$ResultDecidedByDelegateFromJson(json);

 final  TeamColor? winner;
 final  String text;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultDecidedByDelegateCopyWith<ResultDecidedByDelegate> get copyWith => _$ResultDecidedByDelegateCopyWithImpl<ResultDecidedByDelegate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResultDecidedByDelegateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultDecidedByDelegate&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,winner,text);

@override
String toString() {
  return 'MatchEventData.resultDecidedByDelegate(winner: $winner, text: $text)';
}


}

/// @nodoc
abstract mixin class $ResultDecidedByDelegateCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $ResultDecidedByDelegateCopyWith(ResultDecidedByDelegate value, $Res Function(ResultDecidedByDelegate) _then) = _$ResultDecidedByDelegateCopyWithImpl;
@useResult
$Res call({
 TeamColor? winner, String text
});




}
/// @nodoc
class _$ResultDecidedByDelegateCopyWithImpl<$Res>
    implements $ResultDecidedByDelegateCopyWith<$Res> {
  _$ResultDecidedByDelegateCopyWithImpl(this._self, this._then);

  final ResultDecidedByDelegate _self;
  final $Res Function(ResultDecidedByDelegate) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? winner = freezed,Object? text = null,}) {
  return _then(ResultDecidedByDelegate(
winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as TeamColor?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MatchForfeited extends MatchEventData {
  const MatchForfeited({required this.team, required this.decisionText, final  String? $type}): $type = $type ?? 'matchForfeited',super._();
  factory MatchForfeited.fromJson(Map<String, dynamic> json) => _$MatchForfeitedFromJson(json);

 final  TeamColor team;
 final  String decisionText;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchForfeitedCopyWith<MatchForfeited> get copyWith => _$MatchForfeitedCopyWithImpl<MatchForfeited>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchForfeitedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchForfeited&&(identical(other.team, team) || other.team == team)&&(identical(other.decisionText, decisionText) || other.decisionText == decisionText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,decisionText);

@override
String toString() {
  return 'MatchEventData.matchForfeited(team: $team, decisionText: $decisionText)';
}


}

/// @nodoc
abstract mixin class $MatchForfeitedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $MatchForfeitedCopyWith(MatchForfeited value, $Res Function(MatchForfeited) _then) = _$MatchForfeitedCopyWithImpl;
@useResult
$Res call({
 TeamColor team, String decisionText
});




}
/// @nodoc
class _$MatchForfeitedCopyWithImpl<$Res>
    implements $MatchForfeitedCopyWith<$Res> {
  _$MatchForfeitedCopyWithImpl(this._self, this._then);

  final MatchForfeited _self;
  final $Res Function(MatchForfeited) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,Object? decisionText = null,}) {
  return _then(MatchForfeited(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamColor,decisionText: null == decisionText ? _self.decisionText : decisionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class MatchAbandoned extends MatchEventData {
  const MatchAbandoned({required this.decisionText, this.resultOverride, final  String? $type}): $type = $type ?? 'matchAbandoned',super._();
  factory MatchAbandoned.fromJson(Map<String, dynamic> json) => _$MatchAbandonedFromJson(json);

 final  String decisionText;
 final  MatchScore? resultOverride;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchAbandonedCopyWith<MatchAbandoned> get copyWith => _$MatchAbandonedCopyWithImpl<MatchAbandoned>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchAbandonedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchAbandoned&&(identical(other.decisionText, decisionText) || other.decisionText == decisionText)&&(identical(other.resultOverride, resultOverride) || other.resultOverride == resultOverride));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,decisionText,resultOverride);

@override
String toString() {
  return 'MatchEventData.matchAbandoned(decisionText: $decisionText, resultOverride: $resultOverride)';
}


}

/// @nodoc
abstract mixin class $MatchAbandonedCopyWith<$Res> implements $MatchEventDataCopyWith<$Res> {
  factory $MatchAbandonedCopyWith(MatchAbandoned value, $Res Function(MatchAbandoned) _then) = _$MatchAbandonedCopyWithImpl;
@useResult
$Res call({
 String decisionText, MatchScore? resultOverride
});


$MatchScoreCopyWith<$Res>? get resultOverride;

}
/// @nodoc
class _$MatchAbandonedCopyWithImpl<$Res>
    implements $MatchAbandonedCopyWith<$Res> {
  _$MatchAbandonedCopyWithImpl(this._self, this._then);

  final MatchAbandoned _self;
  final $Res Function(MatchAbandoned) _then;

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? decisionText = null,Object? resultOverride = freezed,}) {
  return _then(MatchAbandoned(
decisionText: null == decisionText ? _self.decisionText : decisionText // ignore: cast_nullable_to_non_nullable
as String,resultOverride: freezed == resultOverride ? _self.resultOverride : resultOverride // ignore: cast_nullable_to_non_nullable
as MatchScore?,
  ));
}

/// Create a copy of MatchEventData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchScoreCopyWith<$Res>? get resultOverride {
    if (_self.resultOverride == null) {
    return null;
  }

  return $MatchScoreCopyWith<$Res>(_self.resultOverride!, (value) {
    return _then(_self.copyWith(resultOverride: value));
  });
}
}

// dart format on
