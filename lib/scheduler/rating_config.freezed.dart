// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankTier {

 int get threshold; String get name; double get multiplier;
/// Create a copy of RankTier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankTierCopyWith<RankTier> get copyWith => _$RankTierCopyWithImpl<RankTier>(this as RankTier, _$identity);

  /// Serializes this RankTier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankTier&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.name, name) || other.name == name)&&(identical(other.multiplier, multiplier) || other.multiplier == multiplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,threshold,name,multiplier);

@override
String toString() {
  return 'RankTier(threshold: $threshold, name: $name, multiplier: $multiplier)';
}


}

/// @nodoc
abstract mixin class $RankTierCopyWith<$Res>  {
  factory $RankTierCopyWith(RankTier value, $Res Function(RankTier) _then) = _$RankTierCopyWithImpl;
@useResult
$Res call({
 int threshold, String name, double multiplier
});




}
/// @nodoc
class _$RankTierCopyWithImpl<$Res>
    implements $RankTierCopyWith<$Res> {
  _$RankTierCopyWithImpl(this._self, this._then);

  final RankTier _self;
  final $Res Function(RankTier) _then;

/// Create a copy of RankTier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? threshold = null,Object? name = null,Object? multiplier = null,}) {
  return _then(_self.copyWith(
threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RankTier].
extension RankTierPatterns on RankTier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankTier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankTier() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankTier value)  $default,){
final _that = this;
switch (_that) {
case _RankTier():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankTier value)?  $default,){
final _that = this;
switch (_that) {
case _RankTier() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int threshold,  String name,  double multiplier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankTier() when $default != null:
return $default(_that.threshold,_that.name,_that.multiplier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int threshold,  String name,  double multiplier)  $default,) {final _that = this;
switch (_that) {
case _RankTier():
return $default(_that.threshold,_that.name,_that.multiplier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int threshold,  String name,  double multiplier)?  $default,) {final _that = this;
switch (_that) {
case _RankTier() when $default != null:
return $default(_that.threshold,_that.name,_that.multiplier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankTier implements RankTier {
  const _RankTier({required this.threshold, required this.name, required this.multiplier});
  factory _RankTier.fromJson(Map<String, dynamic> json) => _$RankTierFromJson(json);

@override final  int threshold;
@override final  String name;
@override final  double multiplier;

/// Create a copy of RankTier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankTierCopyWith<_RankTier> get copyWith => __$RankTierCopyWithImpl<_RankTier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankTierToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankTier&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.name, name) || other.name == name)&&(identical(other.multiplier, multiplier) || other.multiplier == multiplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,threshold,name,multiplier);

@override
String toString() {
  return 'RankTier(threshold: $threshold, name: $name, multiplier: $multiplier)';
}


}

/// @nodoc
abstract mixin class _$RankTierCopyWith<$Res> implements $RankTierCopyWith<$Res> {
  factory _$RankTierCopyWith(_RankTier value, $Res Function(_RankTier) _then) = __$RankTierCopyWithImpl;
@override @useResult
$Res call({
 int threshold, String name, double multiplier
});




}
/// @nodoc
class __$RankTierCopyWithImpl<$Res>
    implements _$RankTierCopyWith<$Res> {
  __$RankTierCopyWithImpl(this._self, this._then);

  final _RankTier _self;
  final $Res Function(_RankTier) _then;

/// Create a copy of RankTier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? threshold = null,Object? name = null,Object? multiplier = null,}) {
  return _then(_RankTier(
threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$RatingConfig {

/// Elo-schaal: 400 punten verschil is 10 tegen 1.
 double get eloScale;/// Vermoeidheid: de sterkte van een speler zakt per minuut tot dit deel.
 double get fatiguePerMinute;/// De ploegsterkte is de gewogen som gedeeld door dit getal.
 double get teamRatingDivisor;/// Een wedstrijd van zoveel minuten telt voor 1.
 double get referenceDurationMinutes;/// Relevantie = 1 / ([relevanceOffset] - min(k, [relevanceCap])), met k
/// het kleinste aantal wedstrijden van een speler-positie in de wedstrijd.
 int get relevanceOffset; int get relevanceCap; RelevanceCounting get relevanceCounting;/// Meeneem-effect naar alle posities van de speler: deel van de
/// dagwijziging bij winst en bij verlies of niet gespeeld.
 double get crossPositionWinShare; double get crossPositionLossShare;/// Een positie onder deze rating die niet de beste van de speler is, zakt
/// niet mee door het meeneem-effect.
 double get crossPositionFloorRating;/// Reeksbonus: winstaandeel over de laatste [streakWindow] wedstrijden.
 int get streakWindow; double get streakHighShare; double get streakLowShare; double get streakBonus;/// Datum van de eerste, lege kolom in het blad (`yyyy-MM-dd`). Zie
/// SHEET-1 in `rating_engine.dart`. `null` = geen lege eerste stap.
 String? get timelineStart; List<RankTier> get rankTiers;
/// Create a copy of RatingConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingConfigCopyWith<RatingConfig> get copyWith => _$RatingConfigCopyWithImpl<RatingConfig>(this as RatingConfig, _$identity);

  /// Serializes this RatingConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingConfig&&(identical(other.eloScale, eloScale) || other.eloScale == eloScale)&&(identical(other.fatiguePerMinute, fatiguePerMinute) || other.fatiguePerMinute == fatiguePerMinute)&&(identical(other.teamRatingDivisor, teamRatingDivisor) || other.teamRatingDivisor == teamRatingDivisor)&&(identical(other.referenceDurationMinutes, referenceDurationMinutes) || other.referenceDurationMinutes == referenceDurationMinutes)&&(identical(other.relevanceOffset, relevanceOffset) || other.relevanceOffset == relevanceOffset)&&(identical(other.relevanceCap, relevanceCap) || other.relevanceCap == relevanceCap)&&(identical(other.relevanceCounting, relevanceCounting) || other.relevanceCounting == relevanceCounting)&&(identical(other.crossPositionWinShare, crossPositionWinShare) || other.crossPositionWinShare == crossPositionWinShare)&&(identical(other.crossPositionLossShare, crossPositionLossShare) || other.crossPositionLossShare == crossPositionLossShare)&&(identical(other.crossPositionFloorRating, crossPositionFloorRating) || other.crossPositionFloorRating == crossPositionFloorRating)&&(identical(other.streakWindow, streakWindow) || other.streakWindow == streakWindow)&&(identical(other.streakHighShare, streakHighShare) || other.streakHighShare == streakHighShare)&&(identical(other.streakLowShare, streakLowShare) || other.streakLowShare == streakLowShare)&&(identical(other.streakBonus, streakBonus) || other.streakBonus == streakBonus)&&(identical(other.timelineStart, timelineStart) || other.timelineStart == timelineStart)&&const DeepCollectionEquality().equals(other.rankTiers, rankTiers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eloScale,fatiguePerMinute,teamRatingDivisor,referenceDurationMinutes,relevanceOffset,relevanceCap,relevanceCounting,crossPositionWinShare,crossPositionLossShare,crossPositionFloorRating,streakWindow,streakHighShare,streakLowShare,streakBonus,timelineStart,const DeepCollectionEquality().hash(rankTiers));

@override
String toString() {
  return 'RatingConfig(eloScale: $eloScale, fatiguePerMinute: $fatiguePerMinute, teamRatingDivisor: $teamRatingDivisor, referenceDurationMinutes: $referenceDurationMinutes, relevanceOffset: $relevanceOffset, relevanceCap: $relevanceCap, relevanceCounting: $relevanceCounting, crossPositionWinShare: $crossPositionWinShare, crossPositionLossShare: $crossPositionLossShare, crossPositionFloorRating: $crossPositionFloorRating, streakWindow: $streakWindow, streakHighShare: $streakHighShare, streakLowShare: $streakLowShare, streakBonus: $streakBonus, timelineStart: $timelineStart, rankTiers: $rankTiers)';
}


}

/// @nodoc
abstract mixin class $RatingConfigCopyWith<$Res>  {
  factory $RatingConfigCopyWith(RatingConfig value, $Res Function(RatingConfig) _then) = _$RatingConfigCopyWithImpl;
@useResult
$Res call({
 double eloScale, double fatiguePerMinute, double teamRatingDivisor, double referenceDurationMinutes, int relevanceOffset, int relevanceCap, RelevanceCounting relevanceCounting, double crossPositionWinShare, double crossPositionLossShare, double crossPositionFloorRating, int streakWindow, double streakHighShare, double streakLowShare, double streakBonus, String? timelineStart, List<RankTier> rankTiers
});




}
/// @nodoc
class _$RatingConfigCopyWithImpl<$Res>
    implements $RatingConfigCopyWith<$Res> {
  _$RatingConfigCopyWithImpl(this._self, this._then);

  final RatingConfig _self;
  final $Res Function(RatingConfig) _then;

/// Create a copy of RatingConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eloScale = null,Object? fatiguePerMinute = null,Object? teamRatingDivisor = null,Object? referenceDurationMinutes = null,Object? relevanceOffset = null,Object? relevanceCap = null,Object? relevanceCounting = null,Object? crossPositionWinShare = null,Object? crossPositionLossShare = null,Object? crossPositionFloorRating = null,Object? streakWindow = null,Object? streakHighShare = null,Object? streakLowShare = null,Object? streakBonus = null,Object? timelineStart = freezed,Object? rankTiers = null,}) {
  return _then(_self.copyWith(
eloScale: null == eloScale ? _self.eloScale : eloScale // ignore: cast_nullable_to_non_nullable
as double,fatiguePerMinute: null == fatiguePerMinute ? _self.fatiguePerMinute : fatiguePerMinute // ignore: cast_nullable_to_non_nullable
as double,teamRatingDivisor: null == teamRatingDivisor ? _self.teamRatingDivisor : teamRatingDivisor // ignore: cast_nullable_to_non_nullable
as double,referenceDurationMinutes: null == referenceDurationMinutes ? _self.referenceDurationMinutes : referenceDurationMinutes // ignore: cast_nullable_to_non_nullable
as double,relevanceOffset: null == relevanceOffset ? _self.relevanceOffset : relevanceOffset // ignore: cast_nullable_to_non_nullable
as int,relevanceCap: null == relevanceCap ? _self.relevanceCap : relevanceCap // ignore: cast_nullable_to_non_nullable
as int,relevanceCounting: null == relevanceCounting ? _self.relevanceCounting : relevanceCounting // ignore: cast_nullable_to_non_nullable
as RelevanceCounting,crossPositionWinShare: null == crossPositionWinShare ? _self.crossPositionWinShare : crossPositionWinShare // ignore: cast_nullable_to_non_nullable
as double,crossPositionLossShare: null == crossPositionLossShare ? _self.crossPositionLossShare : crossPositionLossShare // ignore: cast_nullable_to_non_nullable
as double,crossPositionFloorRating: null == crossPositionFloorRating ? _self.crossPositionFloorRating : crossPositionFloorRating // ignore: cast_nullable_to_non_nullable
as double,streakWindow: null == streakWindow ? _self.streakWindow : streakWindow // ignore: cast_nullable_to_non_nullable
as int,streakHighShare: null == streakHighShare ? _self.streakHighShare : streakHighShare // ignore: cast_nullable_to_non_nullable
as double,streakLowShare: null == streakLowShare ? _self.streakLowShare : streakLowShare // ignore: cast_nullable_to_non_nullable
as double,streakBonus: null == streakBonus ? _self.streakBonus : streakBonus // ignore: cast_nullable_to_non_nullable
as double,timelineStart: freezed == timelineStart ? _self.timelineStart : timelineStart // ignore: cast_nullable_to_non_nullable
as String?,rankTiers: null == rankTiers ? _self.rankTiers : rankTiers // ignore: cast_nullable_to_non_nullable
as List<RankTier>,
  ));
}

}


/// Adds pattern-matching-related methods to [RatingConfig].
extension RatingConfigPatterns on RatingConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatingConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatingConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatingConfig value)  $default,){
final _that = this;
switch (_that) {
case _RatingConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatingConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RatingConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double eloScale,  double fatiguePerMinute,  double teamRatingDivisor,  double referenceDurationMinutes,  int relevanceOffset,  int relevanceCap,  RelevanceCounting relevanceCounting,  double crossPositionWinShare,  double crossPositionLossShare,  double crossPositionFloorRating,  int streakWindow,  double streakHighShare,  double streakLowShare,  double streakBonus,  String? timelineStart,  List<RankTier> rankTiers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatingConfig() when $default != null:
return $default(_that.eloScale,_that.fatiguePerMinute,_that.teamRatingDivisor,_that.referenceDurationMinutes,_that.relevanceOffset,_that.relevanceCap,_that.relevanceCounting,_that.crossPositionWinShare,_that.crossPositionLossShare,_that.crossPositionFloorRating,_that.streakWindow,_that.streakHighShare,_that.streakLowShare,_that.streakBonus,_that.timelineStart,_that.rankTiers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double eloScale,  double fatiguePerMinute,  double teamRatingDivisor,  double referenceDurationMinutes,  int relevanceOffset,  int relevanceCap,  RelevanceCounting relevanceCounting,  double crossPositionWinShare,  double crossPositionLossShare,  double crossPositionFloorRating,  int streakWindow,  double streakHighShare,  double streakLowShare,  double streakBonus,  String? timelineStart,  List<RankTier> rankTiers)  $default,) {final _that = this;
switch (_that) {
case _RatingConfig():
return $default(_that.eloScale,_that.fatiguePerMinute,_that.teamRatingDivisor,_that.referenceDurationMinutes,_that.relevanceOffset,_that.relevanceCap,_that.relevanceCounting,_that.crossPositionWinShare,_that.crossPositionLossShare,_that.crossPositionFloorRating,_that.streakWindow,_that.streakHighShare,_that.streakLowShare,_that.streakBonus,_that.timelineStart,_that.rankTiers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double eloScale,  double fatiguePerMinute,  double teamRatingDivisor,  double referenceDurationMinutes,  int relevanceOffset,  int relevanceCap,  RelevanceCounting relevanceCounting,  double crossPositionWinShare,  double crossPositionLossShare,  double crossPositionFloorRating,  int streakWindow,  double streakHighShare,  double streakLowShare,  double streakBonus,  String? timelineStart,  List<RankTier> rankTiers)?  $default,) {final _that = this;
switch (_that) {
case _RatingConfig() when $default != null:
return $default(_that.eloScale,_that.fatiguePerMinute,_that.teamRatingDivisor,_that.referenceDurationMinutes,_that.relevanceOffset,_that.relevanceCap,_that.relevanceCounting,_that.crossPositionWinShare,_that.crossPositionLossShare,_that.crossPositionFloorRating,_that.streakWindow,_that.streakHighShare,_that.streakLowShare,_that.streakBonus,_that.timelineStart,_that.rankTiers);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _RatingConfig extends RatingConfig {
  const _RatingConfig({this.eloScale = 400, this.fatiguePerMinute = 0.99, this.teamRatingDivisor = 6, this.referenceDurationMinutes = 30, this.relevanceOffset = 11, this.relevanceCap = 10, this.relevanceCounting = RelevanceCounting.allGames, this.crossPositionWinShare = 0.25, this.crossPositionLossShare = 0.1, this.crossPositionFloorRating = 1000, this.streakWindow = 25, this.streakHighShare = 0.65, this.streakLowShare = 0.35, this.streakBonus = 10, this.timelineStart, final  List<RankTier> rankTiers = defaultRankTiers}): _rankTiers = rankTiers,super._();
  factory _RatingConfig.fromJson(Map<String, dynamic> json) => _$RatingConfigFromJson(json);

/// Elo-schaal: 400 punten verschil is 10 tegen 1.
@override@JsonKey() final  double eloScale;
/// Vermoeidheid: de sterkte van een speler zakt per minuut tot dit deel.
@override@JsonKey() final  double fatiguePerMinute;
/// De ploegsterkte is de gewogen som gedeeld door dit getal.
@override@JsonKey() final  double teamRatingDivisor;
/// Een wedstrijd van zoveel minuten telt voor 1.
@override@JsonKey() final  double referenceDurationMinutes;
/// Relevantie = 1 / ([relevanceOffset] - min(k, [relevanceCap])), met k
/// het kleinste aantal wedstrijden van een speler-positie in de wedstrijd.
@override@JsonKey() final  int relevanceOffset;
@override@JsonKey() final  int relevanceCap;
@override@JsonKey() final  RelevanceCounting relevanceCounting;
/// Meeneem-effect naar alle posities van de speler: deel van de
/// dagwijziging bij winst en bij verlies of niet gespeeld.
@override@JsonKey() final  double crossPositionWinShare;
@override@JsonKey() final  double crossPositionLossShare;
/// Een positie onder deze rating die niet de beste van de speler is, zakt
/// niet mee door het meeneem-effect.
@override@JsonKey() final  double crossPositionFloorRating;
/// Reeksbonus: winstaandeel over de laatste [streakWindow] wedstrijden.
@override@JsonKey() final  int streakWindow;
@override@JsonKey() final  double streakHighShare;
@override@JsonKey() final  double streakLowShare;
@override@JsonKey() final  double streakBonus;
/// Datum van de eerste, lege kolom in het blad (`yyyy-MM-dd`). Zie
/// SHEET-1 in `rating_engine.dart`. `null` = geen lege eerste stap.
@override final  String? timelineStart;
 final  List<RankTier> _rankTiers;
@override@JsonKey() List<RankTier> get rankTiers {
  if (_rankTiers is EqualUnmodifiableListView) return _rankTiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rankTiers);
}


/// Create a copy of RatingConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingConfigCopyWith<_RatingConfig> get copyWith => __$RatingConfigCopyWithImpl<_RatingConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatingConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatingConfig&&(identical(other.eloScale, eloScale) || other.eloScale == eloScale)&&(identical(other.fatiguePerMinute, fatiguePerMinute) || other.fatiguePerMinute == fatiguePerMinute)&&(identical(other.teamRatingDivisor, teamRatingDivisor) || other.teamRatingDivisor == teamRatingDivisor)&&(identical(other.referenceDurationMinutes, referenceDurationMinutes) || other.referenceDurationMinutes == referenceDurationMinutes)&&(identical(other.relevanceOffset, relevanceOffset) || other.relevanceOffset == relevanceOffset)&&(identical(other.relevanceCap, relevanceCap) || other.relevanceCap == relevanceCap)&&(identical(other.relevanceCounting, relevanceCounting) || other.relevanceCounting == relevanceCounting)&&(identical(other.crossPositionWinShare, crossPositionWinShare) || other.crossPositionWinShare == crossPositionWinShare)&&(identical(other.crossPositionLossShare, crossPositionLossShare) || other.crossPositionLossShare == crossPositionLossShare)&&(identical(other.crossPositionFloorRating, crossPositionFloorRating) || other.crossPositionFloorRating == crossPositionFloorRating)&&(identical(other.streakWindow, streakWindow) || other.streakWindow == streakWindow)&&(identical(other.streakHighShare, streakHighShare) || other.streakHighShare == streakHighShare)&&(identical(other.streakLowShare, streakLowShare) || other.streakLowShare == streakLowShare)&&(identical(other.streakBonus, streakBonus) || other.streakBonus == streakBonus)&&(identical(other.timelineStart, timelineStart) || other.timelineStart == timelineStart)&&const DeepCollectionEquality().equals(other._rankTiers, _rankTiers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eloScale,fatiguePerMinute,teamRatingDivisor,referenceDurationMinutes,relevanceOffset,relevanceCap,relevanceCounting,crossPositionWinShare,crossPositionLossShare,crossPositionFloorRating,streakWindow,streakHighShare,streakLowShare,streakBonus,timelineStart,const DeepCollectionEquality().hash(_rankTiers));

@override
String toString() {
  return 'RatingConfig(eloScale: $eloScale, fatiguePerMinute: $fatiguePerMinute, teamRatingDivisor: $teamRatingDivisor, referenceDurationMinutes: $referenceDurationMinutes, relevanceOffset: $relevanceOffset, relevanceCap: $relevanceCap, relevanceCounting: $relevanceCounting, crossPositionWinShare: $crossPositionWinShare, crossPositionLossShare: $crossPositionLossShare, crossPositionFloorRating: $crossPositionFloorRating, streakWindow: $streakWindow, streakHighShare: $streakHighShare, streakLowShare: $streakLowShare, streakBonus: $streakBonus, timelineStart: $timelineStart, rankTiers: $rankTiers)';
}


}

/// @nodoc
abstract mixin class _$RatingConfigCopyWith<$Res> implements $RatingConfigCopyWith<$Res> {
  factory _$RatingConfigCopyWith(_RatingConfig value, $Res Function(_RatingConfig) _then) = __$RatingConfigCopyWithImpl;
@override @useResult
$Res call({
 double eloScale, double fatiguePerMinute, double teamRatingDivisor, double referenceDurationMinutes, int relevanceOffset, int relevanceCap, RelevanceCounting relevanceCounting, double crossPositionWinShare, double crossPositionLossShare, double crossPositionFloorRating, int streakWindow, double streakHighShare, double streakLowShare, double streakBonus, String? timelineStart, List<RankTier> rankTiers
});




}
/// @nodoc
class __$RatingConfigCopyWithImpl<$Res>
    implements _$RatingConfigCopyWith<$Res> {
  __$RatingConfigCopyWithImpl(this._self, this._then);

  final _RatingConfig _self;
  final $Res Function(_RatingConfig) _then;

/// Create a copy of RatingConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eloScale = null,Object? fatiguePerMinute = null,Object? teamRatingDivisor = null,Object? referenceDurationMinutes = null,Object? relevanceOffset = null,Object? relevanceCap = null,Object? relevanceCounting = null,Object? crossPositionWinShare = null,Object? crossPositionLossShare = null,Object? crossPositionFloorRating = null,Object? streakWindow = null,Object? streakHighShare = null,Object? streakLowShare = null,Object? streakBonus = null,Object? timelineStart = freezed,Object? rankTiers = null,}) {
  return _then(_RatingConfig(
eloScale: null == eloScale ? _self.eloScale : eloScale // ignore: cast_nullable_to_non_nullable
as double,fatiguePerMinute: null == fatiguePerMinute ? _self.fatiguePerMinute : fatiguePerMinute // ignore: cast_nullable_to_non_nullable
as double,teamRatingDivisor: null == teamRatingDivisor ? _self.teamRatingDivisor : teamRatingDivisor // ignore: cast_nullable_to_non_nullable
as double,referenceDurationMinutes: null == referenceDurationMinutes ? _self.referenceDurationMinutes : referenceDurationMinutes // ignore: cast_nullable_to_non_nullable
as double,relevanceOffset: null == relevanceOffset ? _self.relevanceOffset : relevanceOffset // ignore: cast_nullable_to_non_nullable
as int,relevanceCap: null == relevanceCap ? _self.relevanceCap : relevanceCap // ignore: cast_nullable_to_non_nullable
as int,relevanceCounting: null == relevanceCounting ? _self.relevanceCounting : relevanceCounting // ignore: cast_nullable_to_non_nullable
as RelevanceCounting,crossPositionWinShare: null == crossPositionWinShare ? _self.crossPositionWinShare : crossPositionWinShare // ignore: cast_nullable_to_non_nullable
as double,crossPositionLossShare: null == crossPositionLossShare ? _self.crossPositionLossShare : crossPositionLossShare // ignore: cast_nullable_to_non_nullable
as double,crossPositionFloorRating: null == crossPositionFloorRating ? _self.crossPositionFloorRating : crossPositionFloorRating // ignore: cast_nullable_to_non_nullable
as double,streakWindow: null == streakWindow ? _self.streakWindow : streakWindow // ignore: cast_nullable_to_non_nullable
as int,streakHighShare: null == streakHighShare ? _self.streakHighShare : streakHighShare // ignore: cast_nullable_to_non_nullable
as double,streakLowShare: null == streakLowShare ? _self.streakLowShare : streakLowShare // ignore: cast_nullable_to_non_nullable
as double,streakBonus: null == streakBonus ? _self.streakBonus : streakBonus // ignore: cast_nullable_to_non_nullable
as double,timelineStart: freezed == timelineStart ? _self.timelineStart : timelineStart // ignore: cast_nullable_to_non_nullable
as String?,rankTiers: null == rankTiers ? _self._rankTiers : rankTiers // ignore: cast_nullable_to_non_nullable
as List<RankTier>,
  ));
}


}

// dart format on
