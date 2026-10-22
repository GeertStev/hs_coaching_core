// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Training {

 List<TrainingNode> get children;// --- Runtime status (Firestore, zelfde document als configuratie) ---
 TrainingStatus get status;/// Start moment van de lopende run vanaf [currentStepIndex], expressed in RTDB server-clock
/// milliseconds (zie `serverNowMillis` in
/// `core/providers/server_time_offset_provider.dart`).
 int get authoritativeStartTimeMillis;/// Tijd geaccumuleerd sinds [currentStepIndex] vóór de lopende run —
/// zelfde pauze-boekhouding als Chrono/Tabata.
 int get accumulatedElapsedMillis;/// Index in `flattenTraining(this)` van de stap waar de klok voor het
/// laatst (her)startte — zie de doc comment hierboven. `-1` zolang de
/// sessie nog niet gestart is.
 int get currentStepIndex;
/// Create a copy of Training
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingCopyWith<Training> get copyWith => _$TrainingCopyWithImpl<Training>(this as Training, _$identity);

  /// Serializes this Training to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Training&&const DeepCollectionEquality().equals(other.children, children)&&(identical(other.status, status) || other.status == status)&&(identical(other.authoritativeStartTimeMillis, authoritativeStartTimeMillis) || other.authoritativeStartTimeMillis == authoritativeStartTimeMillis)&&(identical(other.accumulatedElapsedMillis, accumulatedElapsedMillis) || other.accumulatedElapsedMillis == accumulatedElapsedMillis)&&(identical(other.currentStepIndex, currentStepIndex) || other.currentStepIndex == currentStepIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(children),status,authoritativeStartTimeMillis,accumulatedElapsedMillis,currentStepIndex);

@override
String toString() {
  return 'Training(children: $children, status: $status, authoritativeStartTimeMillis: $authoritativeStartTimeMillis, accumulatedElapsedMillis: $accumulatedElapsedMillis, currentStepIndex: $currentStepIndex)';
}


}

/// @nodoc
abstract mixin class $TrainingCopyWith<$Res>  {
  factory $TrainingCopyWith(Training value, $Res Function(Training) _then) = _$TrainingCopyWithImpl;
@useResult
$Res call({
 List<TrainingNode> children, TrainingStatus status, int authoritativeStartTimeMillis, int accumulatedElapsedMillis, int currentStepIndex
});




}
/// @nodoc
class _$TrainingCopyWithImpl<$Res>
    implements $TrainingCopyWith<$Res> {
  _$TrainingCopyWithImpl(this._self, this._then);

  final Training _self;
  final $Res Function(Training) _then;

/// Create a copy of Training
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? children = null,Object? status = null,Object? authoritativeStartTimeMillis = null,Object? accumulatedElapsedMillis = null,Object? currentStepIndex = null,}) {
  return _then(_self.copyWith(
children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<TrainingNode>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TrainingStatus,authoritativeStartTimeMillis: null == authoritativeStartTimeMillis ? _self.authoritativeStartTimeMillis : authoritativeStartTimeMillis // ignore: cast_nullable_to_non_nullable
as int,accumulatedElapsedMillis: null == accumulatedElapsedMillis ? _self.accumulatedElapsedMillis : accumulatedElapsedMillis // ignore: cast_nullable_to_non_nullable
as int,currentStepIndex: null == currentStepIndex ? _self.currentStepIndex : currentStepIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Training].
extension TrainingPatterns on Training {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Training value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Training() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Training value)  $default,){
final _that = this;
switch (_that) {
case _Training():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Training value)?  $default,){
final _that = this;
switch (_that) {
case _Training() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TrainingNode> children,  TrainingStatus status,  int authoritativeStartTimeMillis,  int accumulatedElapsedMillis,  int currentStepIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Training() when $default != null:
return $default(_that.children,_that.status,_that.authoritativeStartTimeMillis,_that.accumulatedElapsedMillis,_that.currentStepIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TrainingNode> children,  TrainingStatus status,  int authoritativeStartTimeMillis,  int accumulatedElapsedMillis,  int currentStepIndex)  $default,) {final _that = this;
switch (_that) {
case _Training():
return $default(_that.children,_that.status,_that.authoritativeStartTimeMillis,_that.accumulatedElapsedMillis,_that.currentStepIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TrainingNode> children,  TrainingStatus status,  int authoritativeStartTimeMillis,  int accumulatedElapsedMillis,  int currentStepIndex)?  $default,) {final _that = this;
switch (_that) {
case _Training() when $default != null:
return $default(_that.children,_that.status,_that.authoritativeStartTimeMillis,_that.accumulatedElapsedMillis,_that.currentStepIndex);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Training implements Training {
  const _Training({final  List<TrainingNode> children = const <TrainingNode>[], this.status = TrainingStatus.idle, this.authoritativeStartTimeMillis = 0, this.accumulatedElapsedMillis = 0, this.currentStepIndex = -1}): _children = children;
  factory _Training.fromJson(Map<String, dynamic> json) => _$TrainingFromJson(json);

 final  List<TrainingNode> _children;
@override@JsonKey() List<TrainingNode> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}

// --- Runtime status (Firestore, zelfde document als configuratie) ---
@override@JsonKey() final  TrainingStatus status;
/// Start moment van de lopende run vanaf [currentStepIndex], expressed in RTDB server-clock
/// milliseconds (zie `serverNowMillis` in
/// `core/providers/server_time_offset_provider.dart`).
@override@JsonKey() final  int authoritativeStartTimeMillis;
/// Tijd geaccumuleerd sinds [currentStepIndex] vóór de lopende run —
/// zelfde pauze-boekhouding als Chrono/Tabata.
@override@JsonKey() final  int accumulatedElapsedMillis;
/// Index in `flattenTraining(this)` van de stap waar de klok voor het
/// laatst (her)startte — zie de doc comment hierboven. `-1` zolang de
/// sessie nog niet gestart is.
@override@JsonKey() final  int currentStepIndex;

/// Create a copy of Training
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingCopyWith<_Training> get copyWith => __$TrainingCopyWithImpl<_Training>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Training&&const DeepCollectionEquality().equals(other._children, _children)&&(identical(other.status, status) || other.status == status)&&(identical(other.authoritativeStartTimeMillis, authoritativeStartTimeMillis) || other.authoritativeStartTimeMillis == authoritativeStartTimeMillis)&&(identical(other.accumulatedElapsedMillis, accumulatedElapsedMillis) || other.accumulatedElapsedMillis == accumulatedElapsedMillis)&&(identical(other.currentStepIndex, currentStepIndex) || other.currentStepIndex == currentStepIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_children),status,authoritativeStartTimeMillis,accumulatedElapsedMillis,currentStepIndex);

@override
String toString() {
  return 'Training(children: $children, status: $status, authoritativeStartTimeMillis: $authoritativeStartTimeMillis, accumulatedElapsedMillis: $accumulatedElapsedMillis, currentStepIndex: $currentStepIndex)';
}


}

/// @nodoc
abstract mixin class _$TrainingCopyWith<$Res> implements $TrainingCopyWith<$Res> {
  factory _$TrainingCopyWith(_Training value, $Res Function(_Training) _then) = __$TrainingCopyWithImpl;
@override @useResult
$Res call({
 List<TrainingNode> children, TrainingStatus status, int authoritativeStartTimeMillis, int accumulatedElapsedMillis, int currentStepIndex
});




}
/// @nodoc
class __$TrainingCopyWithImpl<$Res>
    implements _$TrainingCopyWith<$Res> {
  __$TrainingCopyWithImpl(this._self, this._then);

  final _Training _self;
  final $Res Function(_Training) _then;

/// Create a copy of Training
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? children = null,Object? status = null,Object? authoritativeStartTimeMillis = null,Object? accumulatedElapsedMillis = null,Object? currentStepIndex = null,}) {
  return _then(_Training(
children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<TrainingNode>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TrainingStatus,authoritativeStartTimeMillis: null == authoritativeStartTimeMillis ? _self.authoritativeStartTimeMillis : authoritativeStartTimeMillis // ignore: cast_nullable_to_non_nullable
as int,accumulatedElapsedMillis: null == accumulatedElapsedMillis ? _self.accumulatedElapsedMillis : accumulatedElapsedMillis // ignore: cast_nullable_to_non_nullable
as int,currentStepIndex: null == currentStepIndex ? _self.currentStepIndex : currentStepIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
