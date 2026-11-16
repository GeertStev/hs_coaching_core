// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduler_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SchedulerConfig {

/// Speeltijd waarmee de vermoeidheid en de verwachte score rekenen.
 int get gameMinutes;/// Drempel voor een positie waar niemand meer bij kan: zo hoog dat geen
/// enkele kandidaat nog boven nul uitkomt.
 double get blockedThreshold;/// Aftrek voor een speler-positie zonder rating (mag daar niet spelen of
/// staat vast op een andere positie).
 double get noRatingPenalty;/// Bonus voor een schaarse positie: er zijn bijna evenveel vrije plaatsen
/// als kandidaten (verschil hoogstens [scarcePositionMargin]).
 double get scarcePositionBonus; int get scarcePositionMargin;/// Aftrek als de vrije plaatsen op de positie nodig zijn voor spelers die
/// daar vast staan.
 double get reservedSlotPenalty;/// Onder deze score telt een kandidaat niet meer mee voor het gemiddelde
/// en het aantal kandidaten van een positie.
 double get candidateCutoff;/// Ervaring: aantal minuten waartegen de speeltijd op een positie wordt
/// afgewogen.
 double get experienceMinutes;/// Het blad telt bij elke speeltijd dit kleine getal op, zodat er nooit
/// door nul gedeeld wordt.
 double get playtimeOffset;/// De opstellingen waaruit de trainer per ploeg kiest.
 List<TeamComposition> get compositions;/// Ploegnamen in de volgorde waarin ze voorgesteld worden. Een oefen-
/// wedstrijd is altijd de eerste tegen de tweede.
 List<String> get teamNames;
/// Create a copy of SchedulerConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchedulerConfigCopyWith<SchedulerConfig> get copyWith => _$SchedulerConfigCopyWithImpl<SchedulerConfig>(this as SchedulerConfig, _$identity);

  /// Serializes this SchedulerConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchedulerConfig&&(identical(other.gameMinutes, gameMinutes) || other.gameMinutes == gameMinutes)&&(identical(other.blockedThreshold, blockedThreshold) || other.blockedThreshold == blockedThreshold)&&(identical(other.noRatingPenalty, noRatingPenalty) || other.noRatingPenalty == noRatingPenalty)&&(identical(other.scarcePositionBonus, scarcePositionBonus) || other.scarcePositionBonus == scarcePositionBonus)&&(identical(other.scarcePositionMargin, scarcePositionMargin) || other.scarcePositionMargin == scarcePositionMargin)&&(identical(other.reservedSlotPenalty, reservedSlotPenalty) || other.reservedSlotPenalty == reservedSlotPenalty)&&(identical(other.candidateCutoff, candidateCutoff) || other.candidateCutoff == candidateCutoff)&&(identical(other.experienceMinutes, experienceMinutes) || other.experienceMinutes == experienceMinutes)&&(identical(other.playtimeOffset, playtimeOffset) || other.playtimeOffset == playtimeOffset)&&const DeepCollectionEquality().equals(other.compositions, compositions)&&const DeepCollectionEquality().equals(other.teamNames, teamNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gameMinutes,blockedThreshold,noRatingPenalty,scarcePositionBonus,scarcePositionMargin,reservedSlotPenalty,candidateCutoff,experienceMinutes,playtimeOffset,const DeepCollectionEquality().hash(compositions),const DeepCollectionEquality().hash(teamNames));

@override
String toString() {
  return 'SchedulerConfig(gameMinutes: $gameMinutes, blockedThreshold: $blockedThreshold, noRatingPenalty: $noRatingPenalty, scarcePositionBonus: $scarcePositionBonus, scarcePositionMargin: $scarcePositionMargin, reservedSlotPenalty: $reservedSlotPenalty, candidateCutoff: $candidateCutoff, experienceMinutes: $experienceMinutes, playtimeOffset: $playtimeOffset, compositions: $compositions, teamNames: $teamNames)';
}


}

/// @nodoc
abstract mixin class $SchedulerConfigCopyWith<$Res>  {
  factory $SchedulerConfigCopyWith(SchedulerConfig value, $Res Function(SchedulerConfig) _then) = _$SchedulerConfigCopyWithImpl;
@useResult
$Res call({
 int gameMinutes, double blockedThreshold, double noRatingPenalty, double scarcePositionBonus, int scarcePositionMargin, double reservedSlotPenalty, double candidateCutoff, double experienceMinutes, double playtimeOffset, List<TeamComposition> compositions, List<String> teamNames
});




}
/// @nodoc
class _$SchedulerConfigCopyWithImpl<$Res>
    implements $SchedulerConfigCopyWith<$Res> {
  _$SchedulerConfigCopyWithImpl(this._self, this._then);

  final SchedulerConfig _self;
  final $Res Function(SchedulerConfig) _then;

/// Create a copy of SchedulerConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gameMinutes = null,Object? blockedThreshold = null,Object? noRatingPenalty = null,Object? scarcePositionBonus = null,Object? scarcePositionMargin = null,Object? reservedSlotPenalty = null,Object? candidateCutoff = null,Object? experienceMinutes = null,Object? playtimeOffset = null,Object? compositions = null,Object? teamNames = null,}) {
  return _then(_self.copyWith(
gameMinutes: null == gameMinutes ? _self.gameMinutes : gameMinutes // ignore: cast_nullable_to_non_nullable
as int,blockedThreshold: null == blockedThreshold ? _self.blockedThreshold : blockedThreshold // ignore: cast_nullable_to_non_nullable
as double,noRatingPenalty: null == noRatingPenalty ? _self.noRatingPenalty : noRatingPenalty // ignore: cast_nullable_to_non_nullable
as double,scarcePositionBonus: null == scarcePositionBonus ? _self.scarcePositionBonus : scarcePositionBonus // ignore: cast_nullable_to_non_nullable
as double,scarcePositionMargin: null == scarcePositionMargin ? _self.scarcePositionMargin : scarcePositionMargin // ignore: cast_nullable_to_non_nullable
as int,reservedSlotPenalty: null == reservedSlotPenalty ? _self.reservedSlotPenalty : reservedSlotPenalty // ignore: cast_nullable_to_non_nullable
as double,candidateCutoff: null == candidateCutoff ? _self.candidateCutoff : candidateCutoff // ignore: cast_nullable_to_non_nullable
as double,experienceMinutes: null == experienceMinutes ? _self.experienceMinutes : experienceMinutes // ignore: cast_nullable_to_non_nullable
as double,playtimeOffset: null == playtimeOffset ? _self.playtimeOffset : playtimeOffset // ignore: cast_nullable_to_non_nullable
as double,compositions: null == compositions ? _self.compositions : compositions // ignore: cast_nullable_to_non_nullable
as List<TeamComposition>,teamNames: null == teamNames ? _self.teamNames : teamNames // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SchedulerConfig].
extension SchedulerConfigPatterns on SchedulerConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SchedulerConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SchedulerConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SchedulerConfig value)  $default,){
final _that = this;
switch (_that) {
case _SchedulerConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SchedulerConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SchedulerConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gameMinutes,  double blockedThreshold,  double noRatingPenalty,  double scarcePositionBonus,  int scarcePositionMargin,  double reservedSlotPenalty,  double candidateCutoff,  double experienceMinutes,  double playtimeOffset,  List<TeamComposition> compositions,  List<String> teamNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SchedulerConfig() when $default != null:
return $default(_that.gameMinutes,_that.blockedThreshold,_that.noRatingPenalty,_that.scarcePositionBonus,_that.scarcePositionMargin,_that.reservedSlotPenalty,_that.candidateCutoff,_that.experienceMinutes,_that.playtimeOffset,_that.compositions,_that.teamNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gameMinutes,  double blockedThreshold,  double noRatingPenalty,  double scarcePositionBonus,  int scarcePositionMargin,  double reservedSlotPenalty,  double candidateCutoff,  double experienceMinutes,  double playtimeOffset,  List<TeamComposition> compositions,  List<String> teamNames)  $default,) {final _that = this;
switch (_that) {
case _SchedulerConfig():
return $default(_that.gameMinutes,_that.blockedThreshold,_that.noRatingPenalty,_that.scarcePositionBonus,_that.scarcePositionMargin,_that.reservedSlotPenalty,_that.candidateCutoff,_that.experienceMinutes,_that.playtimeOffset,_that.compositions,_that.teamNames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gameMinutes,  double blockedThreshold,  double noRatingPenalty,  double scarcePositionBonus,  int scarcePositionMargin,  double reservedSlotPenalty,  double candidateCutoff,  double experienceMinutes,  double playtimeOffset,  List<TeamComposition> compositions,  List<String> teamNames)?  $default,) {final _that = this;
switch (_that) {
case _SchedulerConfig() when $default != null:
return $default(_that.gameMinutes,_that.blockedThreshold,_that.noRatingPenalty,_that.scarcePositionBonus,_that.scarcePositionMargin,_that.reservedSlotPenalty,_that.candidateCutoff,_that.experienceMinutes,_that.playtimeOffset,_that.compositions,_that.teamNames);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SchedulerConfig implements SchedulerConfig {
  const _SchedulerConfig({this.gameMinutes = 30, this.blockedThreshold = 100000, this.noRatingPenalty = 10000, this.scarcePositionBonus = 2000, this.scarcePositionMargin = 1, this.reservedSlotPenalty = 10000, this.candidateCutoff = -5000, this.experienceMinutes = 6000, this.playtimeOffset = 0.01, final  List<TeamComposition> compositions = defaultCompositions, final  List<String> teamNames = defaultTeamNames}): _compositions = compositions,_teamNames = teamNames;
  factory _SchedulerConfig.fromJson(Map<String, dynamic> json) => _$SchedulerConfigFromJson(json);

/// Speeltijd waarmee de vermoeidheid en de verwachte score rekenen.
@override@JsonKey() final  int gameMinutes;
/// Drempel voor een positie waar niemand meer bij kan: zo hoog dat geen
/// enkele kandidaat nog boven nul uitkomt.
@override@JsonKey() final  double blockedThreshold;
/// Aftrek voor een speler-positie zonder rating (mag daar niet spelen of
/// staat vast op een andere positie).
@override@JsonKey() final  double noRatingPenalty;
/// Bonus voor een schaarse positie: er zijn bijna evenveel vrije plaatsen
/// als kandidaten (verschil hoogstens [scarcePositionMargin]).
@override@JsonKey() final  double scarcePositionBonus;
@override@JsonKey() final  int scarcePositionMargin;
/// Aftrek als de vrije plaatsen op de positie nodig zijn voor spelers die
/// daar vast staan.
@override@JsonKey() final  double reservedSlotPenalty;
/// Onder deze score telt een kandidaat niet meer mee voor het gemiddelde
/// en het aantal kandidaten van een positie.
@override@JsonKey() final  double candidateCutoff;
/// Ervaring: aantal minuten waartegen de speeltijd op een positie wordt
/// afgewogen.
@override@JsonKey() final  double experienceMinutes;
/// Het blad telt bij elke speeltijd dit kleine getal op, zodat er nooit
/// door nul gedeeld wordt.
@override@JsonKey() final  double playtimeOffset;
/// De opstellingen waaruit de trainer per ploeg kiest.
 final  List<TeamComposition> _compositions;
/// De opstellingen waaruit de trainer per ploeg kiest.
@override@JsonKey() List<TeamComposition> get compositions {
  if (_compositions is EqualUnmodifiableListView) return _compositions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_compositions);
}

/// Ploegnamen in de volgorde waarin ze voorgesteld worden. Een oefen-
/// wedstrijd is altijd de eerste tegen de tweede.
 final  List<String> _teamNames;
/// Ploegnamen in de volgorde waarin ze voorgesteld worden. Een oefen-
/// wedstrijd is altijd de eerste tegen de tweede.
@override@JsonKey() List<String> get teamNames {
  if (_teamNames is EqualUnmodifiableListView) return _teamNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teamNames);
}


/// Create a copy of SchedulerConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SchedulerConfigCopyWith<_SchedulerConfig> get copyWith => __$SchedulerConfigCopyWithImpl<_SchedulerConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SchedulerConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SchedulerConfig&&(identical(other.gameMinutes, gameMinutes) || other.gameMinutes == gameMinutes)&&(identical(other.blockedThreshold, blockedThreshold) || other.blockedThreshold == blockedThreshold)&&(identical(other.noRatingPenalty, noRatingPenalty) || other.noRatingPenalty == noRatingPenalty)&&(identical(other.scarcePositionBonus, scarcePositionBonus) || other.scarcePositionBonus == scarcePositionBonus)&&(identical(other.scarcePositionMargin, scarcePositionMargin) || other.scarcePositionMargin == scarcePositionMargin)&&(identical(other.reservedSlotPenalty, reservedSlotPenalty) || other.reservedSlotPenalty == reservedSlotPenalty)&&(identical(other.candidateCutoff, candidateCutoff) || other.candidateCutoff == candidateCutoff)&&(identical(other.experienceMinutes, experienceMinutes) || other.experienceMinutes == experienceMinutes)&&(identical(other.playtimeOffset, playtimeOffset) || other.playtimeOffset == playtimeOffset)&&const DeepCollectionEquality().equals(other._compositions, _compositions)&&const DeepCollectionEquality().equals(other._teamNames, _teamNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gameMinutes,blockedThreshold,noRatingPenalty,scarcePositionBonus,scarcePositionMargin,reservedSlotPenalty,candidateCutoff,experienceMinutes,playtimeOffset,const DeepCollectionEquality().hash(_compositions),const DeepCollectionEquality().hash(_teamNames));

@override
String toString() {
  return 'SchedulerConfig(gameMinutes: $gameMinutes, blockedThreshold: $blockedThreshold, noRatingPenalty: $noRatingPenalty, scarcePositionBonus: $scarcePositionBonus, scarcePositionMargin: $scarcePositionMargin, reservedSlotPenalty: $reservedSlotPenalty, candidateCutoff: $candidateCutoff, experienceMinutes: $experienceMinutes, playtimeOffset: $playtimeOffset, compositions: $compositions, teamNames: $teamNames)';
}


}

/// @nodoc
abstract mixin class _$SchedulerConfigCopyWith<$Res> implements $SchedulerConfigCopyWith<$Res> {
  factory _$SchedulerConfigCopyWith(_SchedulerConfig value, $Res Function(_SchedulerConfig) _then) = __$SchedulerConfigCopyWithImpl;
@override @useResult
$Res call({
 int gameMinutes, double blockedThreshold, double noRatingPenalty, double scarcePositionBonus, int scarcePositionMargin, double reservedSlotPenalty, double candidateCutoff, double experienceMinutes, double playtimeOffset, List<TeamComposition> compositions, List<String> teamNames
});




}
/// @nodoc
class __$SchedulerConfigCopyWithImpl<$Res>
    implements _$SchedulerConfigCopyWith<$Res> {
  __$SchedulerConfigCopyWithImpl(this._self, this._then);

  final _SchedulerConfig _self;
  final $Res Function(_SchedulerConfig) _then;

/// Create a copy of SchedulerConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gameMinutes = null,Object? blockedThreshold = null,Object? noRatingPenalty = null,Object? scarcePositionBonus = null,Object? scarcePositionMargin = null,Object? reservedSlotPenalty = null,Object? candidateCutoff = null,Object? experienceMinutes = null,Object? playtimeOffset = null,Object? compositions = null,Object? teamNames = null,}) {
  return _then(_SchedulerConfig(
gameMinutes: null == gameMinutes ? _self.gameMinutes : gameMinutes // ignore: cast_nullable_to_non_nullable
as int,blockedThreshold: null == blockedThreshold ? _self.blockedThreshold : blockedThreshold // ignore: cast_nullable_to_non_nullable
as double,noRatingPenalty: null == noRatingPenalty ? _self.noRatingPenalty : noRatingPenalty // ignore: cast_nullable_to_non_nullable
as double,scarcePositionBonus: null == scarcePositionBonus ? _self.scarcePositionBonus : scarcePositionBonus // ignore: cast_nullable_to_non_nullable
as double,scarcePositionMargin: null == scarcePositionMargin ? _self.scarcePositionMargin : scarcePositionMargin // ignore: cast_nullable_to_non_nullable
as int,reservedSlotPenalty: null == reservedSlotPenalty ? _self.reservedSlotPenalty : reservedSlotPenalty // ignore: cast_nullable_to_non_nullable
as double,candidateCutoff: null == candidateCutoff ? _self.candidateCutoff : candidateCutoff // ignore: cast_nullable_to_non_nullable
as double,experienceMinutes: null == experienceMinutes ? _self.experienceMinutes : experienceMinutes // ignore: cast_nullable_to_non_nullable
as double,playtimeOffset: null == playtimeOffset ? _self.playtimeOffset : playtimeOffset // ignore: cast_nullable_to_non_nullable
as double,compositions: null == compositions ? _self._compositions : compositions // ignore: cast_nullable_to_non_nullable
as List<TeamComposition>,teamNames: null == teamNames ? _self._teamNames : teamNames // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
