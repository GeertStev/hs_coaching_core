// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchConfig {

@DurationMillisConverter() Duration get periodLength;@DurationMillisConverter() Duration get halfTimeBreak;/// Poule = false, knock-out = true.
 bool get requiresWinner;@DurationMillisConverter() Duration get overtimeBreak;@DurationMillisConverter() Duration get overtimePeriod;@DurationMillisConverter() Duration get overtimeInterval;@DurationMillisConverter() Duration get suddenDeathBreak;/// Venster op het einde van een fase waarin de klok bij elke
/// onderbreking stilstaat (14.2.3.1).
@DurationMillisConverter() Duration get stoppedClockWindow;@DurationMillisConverter() Duration get teamTimeOutLength;/// Verstreken tijd van een team time-out waarop de waarschuwing klinkt.
@DurationMillisConverter() Duration get timeOutWarningAt;@DurationMillisConverter() Duration get periodStartWarning;@DurationMillisConverter() Duration get goalRestartMax; int get timeOutsPerTeamPerHalf;/// OPEN-2.
 PenaltyClockPolicy get penaltyClockPolicy; String get rulesVersion;/// OPEN-1: fases waarin het stilgezette-klokvenster geldt. Sudden death
/// staat altijd in stilgezette-klokmodus, ook als het hier ontbreekt.
 Set<MatchPhase> get stoppedClockPhases;/// OPEN-10: 2 (CMAS) of 0; enkel relevant als [requiresWinner].
 int get overtimePeriods;/// OPEN-10.
 bool get suddenDeathEnabled;/// Vrij label, enkel voor weergave.
 String get presetName;
/// Create a copy of MatchConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchConfigCopyWith<MatchConfig> get copyWith => _$MatchConfigCopyWithImpl<MatchConfig>(this as MatchConfig, _$identity);

  /// Serializes this MatchConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchConfig&&(identical(other.periodLength, periodLength) || other.periodLength == periodLength)&&(identical(other.halfTimeBreak, halfTimeBreak) || other.halfTimeBreak == halfTimeBreak)&&(identical(other.requiresWinner, requiresWinner) || other.requiresWinner == requiresWinner)&&(identical(other.overtimeBreak, overtimeBreak) || other.overtimeBreak == overtimeBreak)&&(identical(other.overtimePeriod, overtimePeriod) || other.overtimePeriod == overtimePeriod)&&(identical(other.overtimeInterval, overtimeInterval) || other.overtimeInterval == overtimeInterval)&&(identical(other.suddenDeathBreak, suddenDeathBreak) || other.suddenDeathBreak == suddenDeathBreak)&&(identical(other.stoppedClockWindow, stoppedClockWindow) || other.stoppedClockWindow == stoppedClockWindow)&&(identical(other.teamTimeOutLength, teamTimeOutLength) || other.teamTimeOutLength == teamTimeOutLength)&&(identical(other.timeOutWarningAt, timeOutWarningAt) || other.timeOutWarningAt == timeOutWarningAt)&&(identical(other.periodStartWarning, periodStartWarning) || other.periodStartWarning == periodStartWarning)&&(identical(other.goalRestartMax, goalRestartMax) || other.goalRestartMax == goalRestartMax)&&(identical(other.timeOutsPerTeamPerHalf, timeOutsPerTeamPerHalf) || other.timeOutsPerTeamPerHalf == timeOutsPerTeamPerHalf)&&(identical(other.penaltyClockPolicy, penaltyClockPolicy) || other.penaltyClockPolicy == penaltyClockPolicy)&&(identical(other.rulesVersion, rulesVersion) || other.rulesVersion == rulesVersion)&&const DeepCollectionEquality().equals(other.stoppedClockPhases, stoppedClockPhases)&&(identical(other.overtimePeriods, overtimePeriods) || other.overtimePeriods == overtimePeriods)&&(identical(other.suddenDeathEnabled, suddenDeathEnabled) || other.suddenDeathEnabled == suddenDeathEnabled)&&(identical(other.presetName, presetName) || other.presetName == presetName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,periodLength,halfTimeBreak,requiresWinner,overtimeBreak,overtimePeriod,overtimeInterval,suddenDeathBreak,stoppedClockWindow,teamTimeOutLength,timeOutWarningAt,periodStartWarning,goalRestartMax,timeOutsPerTeamPerHalf,penaltyClockPolicy,rulesVersion,const DeepCollectionEquality().hash(stoppedClockPhases),overtimePeriods,suddenDeathEnabled,presetName]);

@override
String toString() {
  return 'MatchConfig(periodLength: $periodLength, halfTimeBreak: $halfTimeBreak, requiresWinner: $requiresWinner, overtimeBreak: $overtimeBreak, overtimePeriod: $overtimePeriod, overtimeInterval: $overtimeInterval, suddenDeathBreak: $suddenDeathBreak, stoppedClockWindow: $stoppedClockWindow, teamTimeOutLength: $teamTimeOutLength, timeOutWarningAt: $timeOutWarningAt, periodStartWarning: $periodStartWarning, goalRestartMax: $goalRestartMax, timeOutsPerTeamPerHalf: $timeOutsPerTeamPerHalf, penaltyClockPolicy: $penaltyClockPolicy, rulesVersion: $rulesVersion, stoppedClockPhases: $stoppedClockPhases, overtimePeriods: $overtimePeriods, suddenDeathEnabled: $suddenDeathEnabled, presetName: $presetName)';
}


}

/// @nodoc
abstract mixin class $MatchConfigCopyWith<$Res>  {
  factory $MatchConfigCopyWith(MatchConfig value, $Res Function(MatchConfig) _then) = _$MatchConfigCopyWithImpl;
@useResult
$Res call({
@DurationMillisConverter() Duration periodLength,@DurationMillisConverter() Duration halfTimeBreak, bool requiresWinner,@DurationMillisConverter() Duration overtimeBreak,@DurationMillisConverter() Duration overtimePeriod,@DurationMillisConverter() Duration overtimeInterval,@DurationMillisConverter() Duration suddenDeathBreak,@DurationMillisConverter() Duration stoppedClockWindow,@DurationMillisConverter() Duration teamTimeOutLength,@DurationMillisConverter() Duration timeOutWarningAt,@DurationMillisConverter() Duration periodStartWarning,@DurationMillisConverter() Duration goalRestartMax, int timeOutsPerTeamPerHalf, PenaltyClockPolicy penaltyClockPolicy, String rulesVersion, Set<MatchPhase> stoppedClockPhases, int overtimePeriods, bool suddenDeathEnabled, String presetName
});




}
/// @nodoc
class _$MatchConfigCopyWithImpl<$Res>
    implements $MatchConfigCopyWith<$Res> {
  _$MatchConfigCopyWithImpl(this._self, this._then);

  final MatchConfig _self;
  final $Res Function(MatchConfig) _then;

/// Create a copy of MatchConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? periodLength = null,Object? halfTimeBreak = null,Object? requiresWinner = null,Object? overtimeBreak = null,Object? overtimePeriod = null,Object? overtimeInterval = null,Object? suddenDeathBreak = null,Object? stoppedClockWindow = null,Object? teamTimeOutLength = null,Object? timeOutWarningAt = null,Object? periodStartWarning = null,Object? goalRestartMax = null,Object? timeOutsPerTeamPerHalf = null,Object? penaltyClockPolicy = null,Object? rulesVersion = null,Object? stoppedClockPhases = null,Object? overtimePeriods = null,Object? suddenDeathEnabled = null,Object? presetName = null,}) {
  return _then(_self.copyWith(
periodLength: null == periodLength ? _self.periodLength : periodLength // ignore: cast_nullable_to_non_nullable
as Duration,halfTimeBreak: null == halfTimeBreak ? _self.halfTimeBreak : halfTimeBreak // ignore: cast_nullable_to_non_nullable
as Duration,requiresWinner: null == requiresWinner ? _self.requiresWinner : requiresWinner // ignore: cast_nullable_to_non_nullable
as bool,overtimeBreak: null == overtimeBreak ? _self.overtimeBreak : overtimeBreak // ignore: cast_nullable_to_non_nullable
as Duration,overtimePeriod: null == overtimePeriod ? _self.overtimePeriod : overtimePeriod // ignore: cast_nullable_to_non_nullable
as Duration,overtimeInterval: null == overtimeInterval ? _self.overtimeInterval : overtimeInterval // ignore: cast_nullable_to_non_nullable
as Duration,suddenDeathBreak: null == suddenDeathBreak ? _self.suddenDeathBreak : suddenDeathBreak // ignore: cast_nullable_to_non_nullable
as Duration,stoppedClockWindow: null == stoppedClockWindow ? _self.stoppedClockWindow : stoppedClockWindow // ignore: cast_nullable_to_non_nullable
as Duration,teamTimeOutLength: null == teamTimeOutLength ? _self.teamTimeOutLength : teamTimeOutLength // ignore: cast_nullable_to_non_nullable
as Duration,timeOutWarningAt: null == timeOutWarningAt ? _self.timeOutWarningAt : timeOutWarningAt // ignore: cast_nullable_to_non_nullable
as Duration,periodStartWarning: null == periodStartWarning ? _self.periodStartWarning : periodStartWarning // ignore: cast_nullable_to_non_nullable
as Duration,goalRestartMax: null == goalRestartMax ? _self.goalRestartMax : goalRestartMax // ignore: cast_nullable_to_non_nullable
as Duration,timeOutsPerTeamPerHalf: null == timeOutsPerTeamPerHalf ? _self.timeOutsPerTeamPerHalf : timeOutsPerTeamPerHalf // ignore: cast_nullable_to_non_nullable
as int,penaltyClockPolicy: null == penaltyClockPolicy ? _self.penaltyClockPolicy : penaltyClockPolicy // ignore: cast_nullable_to_non_nullable
as PenaltyClockPolicy,rulesVersion: null == rulesVersion ? _self.rulesVersion : rulesVersion // ignore: cast_nullable_to_non_nullable
as String,stoppedClockPhases: null == stoppedClockPhases ? _self.stoppedClockPhases : stoppedClockPhases // ignore: cast_nullable_to_non_nullable
as Set<MatchPhase>,overtimePeriods: null == overtimePeriods ? _self.overtimePeriods : overtimePeriods // ignore: cast_nullable_to_non_nullable
as int,suddenDeathEnabled: null == suddenDeathEnabled ? _self.suddenDeathEnabled : suddenDeathEnabled // ignore: cast_nullable_to_non_nullable
as bool,presetName: null == presetName ? _self.presetName : presetName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchConfig].
extension MatchConfigPatterns on MatchConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchConfig value)  $default,){
final _that = this;
switch (_that) {
case _MatchConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchConfig value)?  $default,){
final _that = this;
switch (_that) {
case _MatchConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@DurationMillisConverter()  Duration periodLength, @DurationMillisConverter()  Duration halfTimeBreak,  bool requiresWinner, @DurationMillisConverter()  Duration overtimeBreak, @DurationMillisConverter()  Duration overtimePeriod, @DurationMillisConverter()  Duration overtimeInterval, @DurationMillisConverter()  Duration suddenDeathBreak, @DurationMillisConverter()  Duration stoppedClockWindow, @DurationMillisConverter()  Duration teamTimeOutLength, @DurationMillisConverter()  Duration timeOutWarningAt, @DurationMillisConverter()  Duration periodStartWarning, @DurationMillisConverter()  Duration goalRestartMax,  int timeOutsPerTeamPerHalf,  PenaltyClockPolicy penaltyClockPolicy,  String rulesVersion,  Set<MatchPhase> stoppedClockPhases,  int overtimePeriods,  bool suddenDeathEnabled,  String presetName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchConfig() when $default != null:
return $default(_that.periodLength,_that.halfTimeBreak,_that.requiresWinner,_that.overtimeBreak,_that.overtimePeriod,_that.overtimeInterval,_that.suddenDeathBreak,_that.stoppedClockWindow,_that.teamTimeOutLength,_that.timeOutWarningAt,_that.periodStartWarning,_that.goalRestartMax,_that.timeOutsPerTeamPerHalf,_that.penaltyClockPolicy,_that.rulesVersion,_that.stoppedClockPhases,_that.overtimePeriods,_that.suddenDeathEnabled,_that.presetName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@DurationMillisConverter()  Duration periodLength, @DurationMillisConverter()  Duration halfTimeBreak,  bool requiresWinner, @DurationMillisConverter()  Duration overtimeBreak, @DurationMillisConverter()  Duration overtimePeriod, @DurationMillisConverter()  Duration overtimeInterval, @DurationMillisConverter()  Duration suddenDeathBreak, @DurationMillisConverter()  Duration stoppedClockWindow, @DurationMillisConverter()  Duration teamTimeOutLength, @DurationMillisConverter()  Duration timeOutWarningAt, @DurationMillisConverter()  Duration periodStartWarning, @DurationMillisConverter()  Duration goalRestartMax,  int timeOutsPerTeamPerHalf,  PenaltyClockPolicy penaltyClockPolicy,  String rulesVersion,  Set<MatchPhase> stoppedClockPhases,  int overtimePeriods,  bool suddenDeathEnabled,  String presetName)  $default,) {final _that = this;
switch (_that) {
case _MatchConfig():
return $default(_that.periodLength,_that.halfTimeBreak,_that.requiresWinner,_that.overtimeBreak,_that.overtimePeriod,_that.overtimeInterval,_that.suddenDeathBreak,_that.stoppedClockWindow,_that.teamTimeOutLength,_that.timeOutWarningAt,_that.periodStartWarning,_that.goalRestartMax,_that.timeOutsPerTeamPerHalf,_that.penaltyClockPolicy,_that.rulesVersion,_that.stoppedClockPhases,_that.overtimePeriods,_that.suddenDeathEnabled,_that.presetName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@DurationMillisConverter()  Duration periodLength, @DurationMillisConverter()  Duration halfTimeBreak,  bool requiresWinner, @DurationMillisConverter()  Duration overtimeBreak, @DurationMillisConverter()  Duration overtimePeriod, @DurationMillisConverter()  Duration overtimeInterval, @DurationMillisConverter()  Duration suddenDeathBreak, @DurationMillisConverter()  Duration stoppedClockWindow, @DurationMillisConverter()  Duration teamTimeOutLength, @DurationMillisConverter()  Duration timeOutWarningAt, @DurationMillisConverter()  Duration periodStartWarning, @DurationMillisConverter()  Duration goalRestartMax,  int timeOutsPerTeamPerHalf,  PenaltyClockPolicy penaltyClockPolicy,  String rulesVersion,  Set<MatchPhase> stoppedClockPhases,  int overtimePeriods,  bool suddenDeathEnabled,  String presetName)?  $default,) {final _that = this;
switch (_that) {
case _MatchConfig() when $default != null:
return $default(_that.periodLength,_that.halfTimeBreak,_that.requiresWinner,_that.overtimeBreak,_that.overtimePeriod,_that.overtimeInterval,_that.suddenDeathBreak,_that.stoppedClockWindow,_that.teamTimeOutLength,_that.timeOutWarningAt,_that.periodStartWarning,_that.goalRestartMax,_that.timeOutsPerTeamPerHalf,_that.penaltyClockPolicy,_that.rulesVersion,_that.stoppedClockPhases,_that.overtimePeriods,_that.suddenDeathEnabled,_that.presetName);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _MatchConfig extends MatchConfig {
  const _MatchConfig({@DurationMillisConverter() this.periodLength = const Duration(minutes: 15), @DurationMillisConverter() this.halfTimeBreak = const Duration(minutes: 3), this.requiresWinner = false, @DurationMillisConverter() this.overtimeBreak = const Duration(minutes: 3), @DurationMillisConverter() this.overtimePeriod = const Duration(minutes: 5), @DurationMillisConverter() this.overtimeInterval = const Duration(minutes: 1), @DurationMillisConverter() this.suddenDeathBreak = const Duration(minutes: 1), @DurationMillisConverter() this.stoppedClockWindow = const Duration(minutes: 2), @DurationMillisConverter() this.teamTimeOutLength = const Duration(minutes: 1), @DurationMillisConverter() this.timeOutWarningAt = const Duration(seconds: 45), @DurationMillisConverter() this.periodStartWarning = const Duration(seconds: 30), @DurationMillisConverter() this.goalRestartMax = const Duration(seconds: 30), this.timeOutsPerTeamPerHalf = 1, this.penaltyClockPolicy = PenaltyClockPolicy.matchClockOnly, this.rulesVersion = 'CMAS-13.0', final  Set<MatchPhase> stoppedClockPhases = const {MatchPhase.p2, MatchPhase.ot2, MatchPhase.suddenDeath}, this.overtimePeriods = 2, this.suddenDeathEnabled = true, this.presetName = 'CMAS standaard'}): _stoppedClockPhases = stoppedClockPhases,super._();
  factory _MatchConfig.fromJson(Map<String, dynamic> json) => _$MatchConfigFromJson(json);

@override@JsonKey()@DurationMillisConverter() final  Duration periodLength;
@override@JsonKey()@DurationMillisConverter() final  Duration halfTimeBreak;
/// Poule = false, knock-out = true.
@override@JsonKey() final  bool requiresWinner;
@override@JsonKey()@DurationMillisConverter() final  Duration overtimeBreak;
@override@JsonKey()@DurationMillisConverter() final  Duration overtimePeriod;
@override@JsonKey()@DurationMillisConverter() final  Duration overtimeInterval;
@override@JsonKey()@DurationMillisConverter() final  Duration suddenDeathBreak;
/// Venster op het einde van een fase waarin de klok bij elke
/// onderbreking stilstaat (14.2.3.1).
@override@JsonKey()@DurationMillisConverter() final  Duration stoppedClockWindow;
@override@JsonKey()@DurationMillisConverter() final  Duration teamTimeOutLength;
/// Verstreken tijd van een team time-out waarop de waarschuwing klinkt.
@override@JsonKey()@DurationMillisConverter() final  Duration timeOutWarningAt;
@override@JsonKey()@DurationMillisConverter() final  Duration periodStartWarning;
@override@JsonKey()@DurationMillisConverter() final  Duration goalRestartMax;
@override@JsonKey() final  int timeOutsPerTeamPerHalf;
/// OPEN-2.
@override@JsonKey() final  PenaltyClockPolicy penaltyClockPolicy;
@override@JsonKey() final  String rulesVersion;
/// OPEN-1: fases waarin het stilgezette-klokvenster geldt. Sudden death
/// staat altijd in stilgezette-klokmodus, ook als het hier ontbreekt.
 final  Set<MatchPhase> _stoppedClockPhases;
/// OPEN-1: fases waarin het stilgezette-klokvenster geldt. Sudden death
/// staat altijd in stilgezette-klokmodus, ook als het hier ontbreekt.
@override@JsonKey() Set<MatchPhase> get stoppedClockPhases {
  if (_stoppedClockPhases is EqualUnmodifiableSetView) return _stoppedClockPhases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_stoppedClockPhases);
}

/// OPEN-10: 2 (CMAS) of 0; enkel relevant als [requiresWinner].
@override@JsonKey() final  int overtimePeriods;
/// OPEN-10.
@override@JsonKey() final  bool suddenDeathEnabled;
/// Vrij label, enkel voor weergave.
@override@JsonKey() final  String presetName;

/// Create a copy of MatchConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchConfigCopyWith<_MatchConfig> get copyWith => __$MatchConfigCopyWithImpl<_MatchConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchConfig&&(identical(other.periodLength, periodLength) || other.periodLength == periodLength)&&(identical(other.halfTimeBreak, halfTimeBreak) || other.halfTimeBreak == halfTimeBreak)&&(identical(other.requiresWinner, requiresWinner) || other.requiresWinner == requiresWinner)&&(identical(other.overtimeBreak, overtimeBreak) || other.overtimeBreak == overtimeBreak)&&(identical(other.overtimePeriod, overtimePeriod) || other.overtimePeriod == overtimePeriod)&&(identical(other.overtimeInterval, overtimeInterval) || other.overtimeInterval == overtimeInterval)&&(identical(other.suddenDeathBreak, suddenDeathBreak) || other.suddenDeathBreak == suddenDeathBreak)&&(identical(other.stoppedClockWindow, stoppedClockWindow) || other.stoppedClockWindow == stoppedClockWindow)&&(identical(other.teamTimeOutLength, teamTimeOutLength) || other.teamTimeOutLength == teamTimeOutLength)&&(identical(other.timeOutWarningAt, timeOutWarningAt) || other.timeOutWarningAt == timeOutWarningAt)&&(identical(other.periodStartWarning, periodStartWarning) || other.periodStartWarning == periodStartWarning)&&(identical(other.goalRestartMax, goalRestartMax) || other.goalRestartMax == goalRestartMax)&&(identical(other.timeOutsPerTeamPerHalf, timeOutsPerTeamPerHalf) || other.timeOutsPerTeamPerHalf == timeOutsPerTeamPerHalf)&&(identical(other.penaltyClockPolicy, penaltyClockPolicy) || other.penaltyClockPolicy == penaltyClockPolicy)&&(identical(other.rulesVersion, rulesVersion) || other.rulesVersion == rulesVersion)&&const DeepCollectionEquality().equals(other._stoppedClockPhases, _stoppedClockPhases)&&(identical(other.overtimePeriods, overtimePeriods) || other.overtimePeriods == overtimePeriods)&&(identical(other.suddenDeathEnabled, suddenDeathEnabled) || other.suddenDeathEnabled == suddenDeathEnabled)&&(identical(other.presetName, presetName) || other.presetName == presetName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,periodLength,halfTimeBreak,requiresWinner,overtimeBreak,overtimePeriod,overtimeInterval,suddenDeathBreak,stoppedClockWindow,teamTimeOutLength,timeOutWarningAt,periodStartWarning,goalRestartMax,timeOutsPerTeamPerHalf,penaltyClockPolicy,rulesVersion,const DeepCollectionEquality().hash(_stoppedClockPhases),overtimePeriods,suddenDeathEnabled,presetName]);

@override
String toString() {
  return 'MatchConfig(periodLength: $periodLength, halfTimeBreak: $halfTimeBreak, requiresWinner: $requiresWinner, overtimeBreak: $overtimeBreak, overtimePeriod: $overtimePeriod, overtimeInterval: $overtimeInterval, suddenDeathBreak: $suddenDeathBreak, stoppedClockWindow: $stoppedClockWindow, teamTimeOutLength: $teamTimeOutLength, timeOutWarningAt: $timeOutWarningAt, periodStartWarning: $periodStartWarning, goalRestartMax: $goalRestartMax, timeOutsPerTeamPerHalf: $timeOutsPerTeamPerHalf, penaltyClockPolicy: $penaltyClockPolicy, rulesVersion: $rulesVersion, stoppedClockPhases: $stoppedClockPhases, overtimePeriods: $overtimePeriods, suddenDeathEnabled: $suddenDeathEnabled, presetName: $presetName)';
}


}

/// @nodoc
abstract mixin class _$MatchConfigCopyWith<$Res> implements $MatchConfigCopyWith<$Res> {
  factory _$MatchConfigCopyWith(_MatchConfig value, $Res Function(_MatchConfig) _then) = __$MatchConfigCopyWithImpl;
@override @useResult
$Res call({
@DurationMillisConverter() Duration periodLength,@DurationMillisConverter() Duration halfTimeBreak, bool requiresWinner,@DurationMillisConverter() Duration overtimeBreak,@DurationMillisConverter() Duration overtimePeriod,@DurationMillisConverter() Duration overtimeInterval,@DurationMillisConverter() Duration suddenDeathBreak,@DurationMillisConverter() Duration stoppedClockWindow,@DurationMillisConverter() Duration teamTimeOutLength,@DurationMillisConverter() Duration timeOutWarningAt,@DurationMillisConverter() Duration periodStartWarning,@DurationMillisConverter() Duration goalRestartMax, int timeOutsPerTeamPerHalf, PenaltyClockPolicy penaltyClockPolicy, String rulesVersion, Set<MatchPhase> stoppedClockPhases, int overtimePeriods, bool suddenDeathEnabled, String presetName
});




}
/// @nodoc
class __$MatchConfigCopyWithImpl<$Res>
    implements _$MatchConfigCopyWith<$Res> {
  __$MatchConfigCopyWithImpl(this._self, this._then);

  final _MatchConfig _self;
  final $Res Function(_MatchConfig) _then;

/// Create a copy of MatchConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? periodLength = null,Object? halfTimeBreak = null,Object? requiresWinner = null,Object? overtimeBreak = null,Object? overtimePeriod = null,Object? overtimeInterval = null,Object? suddenDeathBreak = null,Object? stoppedClockWindow = null,Object? teamTimeOutLength = null,Object? timeOutWarningAt = null,Object? periodStartWarning = null,Object? goalRestartMax = null,Object? timeOutsPerTeamPerHalf = null,Object? penaltyClockPolicy = null,Object? rulesVersion = null,Object? stoppedClockPhases = null,Object? overtimePeriods = null,Object? suddenDeathEnabled = null,Object? presetName = null,}) {
  return _then(_MatchConfig(
periodLength: null == periodLength ? _self.periodLength : periodLength // ignore: cast_nullable_to_non_nullable
as Duration,halfTimeBreak: null == halfTimeBreak ? _self.halfTimeBreak : halfTimeBreak // ignore: cast_nullable_to_non_nullable
as Duration,requiresWinner: null == requiresWinner ? _self.requiresWinner : requiresWinner // ignore: cast_nullable_to_non_nullable
as bool,overtimeBreak: null == overtimeBreak ? _self.overtimeBreak : overtimeBreak // ignore: cast_nullable_to_non_nullable
as Duration,overtimePeriod: null == overtimePeriod ? _self.overtimePeriod : overtimePeriod // ignore: cast_nullable_to_non_nullable
as Duration,overtimeInterval: null == overtimeInterval ? _self.overtimeInterval : overtimeInterval // ignore: cast_nullable_to_non_nullable
as Duration,suddenDeathBreak: null == suddenDeathBreak ? _self.suddenDeathBreak : suddenDeathBreak // ignore: cast_nullable_to_non_nullable
as Duration,stoppedClockWindow: null == stoppedClockWindow ? _self.stoppedClockWindow : stoppedClockWindow // ignore: cast_nullable_to_non_nullable
as Duration,teamTimeOutLength: null == teamTimeOutLength ? _self.teamTimeOutLength : teamTimeOutLength // ignore: cast_nullable_to_non_nullable
as Duration,timeOutWarningAt: null == timeOutWarningAt ? _self.timeOutWarningAt : timeOutWarningAt // ignore: cast_nullable_to_non_nullable
as Duration,periodStartWarning: null == periodStartWarning ? _self.periodStartWarning : periodStartWarning // ignore: cast_nullable_to_non_nullable
as Duration,goalRestartMax: null == goalRestartMax ? _self.goalRestartMax : goalRestartMax // ignore: cast_nullable_to_non_nullable
as Duration,timeOutsPerTeamPerHalf: null == timeOutsPerTeamPerHalf ? _self.timeOutsPerTeamPerHalf : timeOutsPerTeamPerHalf // ignore: cast_nullable_to_non_nullable
as int,penaltyClockPolicy: null == penaltyClockPolicy ? _self.penaltyClockPolicy : penaltyClockPolicy // ignore: cast_nullable_to_non_nullable
as PenaltyClockPolicy,rulesVersion: null == rulesVersion ? _self.rulesVersion : rulesVersion // ignore: cast_nullable_to_non_nullable
as String,stoppedClockPhases: null == stoppedClockPhases ? _self._stoppedClockPhases : stoppedClockPhases // ignore: cast_nullable_to_non_nullable
as Set<MatchPhase>,overtimePeriods: null == overtimePeriods ? _self.overtimePeriods : overtimePeriods // ignore: cast_nullable_to_non_nullable
as int,suddenDeathEnabled: null == suddenDeathEnabled ? _self.suddenDeathEnabled : suddenDeathEnabled // ignore: cast_nullable_to_non_nullable
as bool,presetName: null == presetName ? _self.presetName : presetName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
