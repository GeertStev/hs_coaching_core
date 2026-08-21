// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_exercise_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingExerciseGroup {

 String get id; String get name; List<TrainingParameterRow> get parameterRows; int get workSeconds; int get restSeconds; int get deltaSeconds;
/// Create a copy of TrainingExerciseGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingExerciseGroupCopyWith<TrainingExerciseGroup> get copyWith => _$TrainingExerciseGroupCopyWithImpl<TrainingExerciseGroup>(this as TrainingExerciseGroup, _$identity);

  /// Serializes this TrainingExerciseGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingExerciseGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.parameterRows, parameterRows)&&(identical(other.workSeconds, workSeconds) || other.workSeconds == workSeconds)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.deltaSeconds, deltaSeconds) || other.deltaSeconds == deltaSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(parameterRows),workSeconds,restSeconds,deltaSeconds);

@override
String toString() {
  return 'TrainingExerciseGroup(id: $id, name: $name, parameterRows: $parameterRows, workSeconds: $workSeconds, restSeconds: $restSeconds, deltaSeconds: $deltaSeconds)';
}


}

/// @nodoc
abstract mixin class $TrainingExerciseGroupCopyWith<$Res>  {
  factory $TrainingExerciseGroupCopyWith(TrainingExerciseGroup value, $Res Function(TrainingExerciseGroup) _then) = _$TrainingExerciseGroupCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<TrainingParameterRow> parameterRows, int workSeconds, int restSeconds, int deltaSeconds
});




}
/// @nodoc
class _$TrainingExerciseGroupCopyWithImpl<$Res>
    implements $TrainingExerciseGroupCopyWith<$Res> {
  _$TrainingExerciseGroupCopyWithImpl(this._self, this._then);

  final TrainingExerciseGroup _self;
  final $Res Function(TrainingExerciseGroup) _then;

/// Create a copy of TrainingExerciseGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? parameterRows = null,Object? workSeconds = null,Object? restSeconds = null,Object? deltaSeconds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,parameterRows: null == parameterRows ? _self.parameterRows : parameterRows // ignore: cast_nullable_to_non_nullable
as List<TrainingParameterRow>,workSeconds: null == workSeconds ? _self.workSeconds : workSeconds // ignore: cast_nullable_to_non_nullable
as int,restSeconds: null == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int,deltaSeconds: null == deltaSeconds ? _self.deltaSeconds : deltaSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingExerciseGroup].
extension TrainingExerciseGroupPatterns on TrainingExerciseGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingExerciseGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingExerciseGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingExerciseGroup value)  $default,){
final _that = this;
switch (_that) {
case _TrainingExerciseGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingExerciseGroup value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingExerciseGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<TrainingParameterRow> parameterRows,  int workSeconds,  int restSeconds,  int deltaSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingExerciseGroup() when $default != null:
return $default(_that.id,_that.name,_that.parameterRows,_that.workSeconds,_that.restSeconds,_that.deltaSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<TrainingParameterRow> parameterRows,  int workSeconds,  int restSeconds,  int deltaSeconds)  $default,) {final _that = this;
switch (_that) {
case _TrainingExerciseGroup():
return $default(_that.id,_that.name,_that.parameterRows,_that.workSeconds,_that.restSeconds,_that.deltaSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<TrainingParameterRow> parameterRows,  int workSeconds,  int restSeconds,  int deltaSeconds)?  $default,) {final _that = this;
switch (_that) {
case _TrainingExerciseGroup() when $default != null:
return $default(_that.id,_that.name,_that.parameterRows,_that.workSeconds,_that.restSeconds,_that.deltaSeconds);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _TrainingExerciseGroup implements TrainingExerciseGroup {
  const _TrainingExerciseGroup({required this.id, this.name = '', final  List<TrainingParameterRow> parameterRows = const <TrainingParameterRow>[], this.workSeconds = 0, this.restSeconds = 0, this.deltaSeconds = 0}): _parameterRows = parameterRows;
  factory _TrainingExerciseGroup.fromJson(Map<String, dynamic> json) => _$TrainingExerciseGroupFromJson(json);

@override final  String id;
@override@JsonKey() final  String name;
 final  List<TrainingParameterRow> _parameterRows;
@override@JsonKey() List<TrainingParameterRow> get parameterRows {
  if (_parameterRows is EqualUnmodifiableListView) return _parameterRows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parameterRows);
}

@override@JsonKey() final  int workSeconds;
@override@JsonKey() final  int restSeconds;
@override@JsonKey() final  int deltaSeconds;

/// Create a copy of TrainingExerciseGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingExerciseGroupCopyWith<_TrainingExerciseGroup> get copyWith => __$TrainingExerciseGroupCopyWithImpl<_TrainingExerciseGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingExerciseGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingExerciseGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._parameterRows, _parameterRows)&&(identical(other.workSeconds, workSeconds) || other.workSeconds == workSeconds)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.deltaSeconds, deltaSeconds) || other.deltaSeconds == deltaSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_parameterRows),workSeconds,restSeconds,deltaSeconds);

@override
String toString() {
  return 'TrainingExerciseGroup(id: $id, name: $name, parameterRows: $parameterRows, workSeconds: $workSeconds, restSeconds: $restSeconds, deltaSeconds: $deltaSeconds)';
}


}

/// @nodoc
abstract mixin class _$TrainingExerciseGroupCopyWith<$Res> implements $TrainingExerciseGroupCopyWith<$Res> {
  factory _$TrainingExerciseGroupCopyWith(_TrainingExerciseGroup value, $Res Function(_TrainingExerciseGroup) _then) = __$TrainingExerciseGroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<TrainingParameterRow> parameterRows, int workSeconds, int restSeconds, int deltaSeconds
});




}
/// @nodoc
class __$TrainingExerciseGroupCopyWithImpl<$Res>
    implements _$TrainingExerciseGroupCopyWith<$Res> {
  __$TrainingExerciseGroupCopyWithImpl(this._self, this._then);

  final _TrainingExerciseGroup _self;
  final $Res Function(_TrainingExerciseGroup) _then;

/// Create a copy of TrainingExerciseGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? parameterRows = null,Object? workSeconds = null,Object? restSeconds = null,Object? deltaSeconds = null,}) {
  return _then(_TrainingExerciseGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,parameterRows: null == parameterRows ? _self._parameterRows : parameterRows // ignore: cast_nullable_to_non_nullable
as List<TrainingParameterRow>,workSeconds: null == workSeconds ? _self.workSeconds : workSeconds // ignore: cast_nullable_to_non_nullable
as int,restSeconds: null == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int,deltaSeconds: null == deltaSeconds ? _self.deltaSeconds : deltaSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
