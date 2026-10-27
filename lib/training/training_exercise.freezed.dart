// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingExercise {

 String get id; String get title; int get repeatCount; List<TrainingExerciseGroup> get groups;
/// Create a copy of TrainingExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingExerciseCopyWith<TrainingExercise> get copyWith => _$TrainingExerciseCopyWithImpl<TrainingExercise>(this as TrainingExercise, _$identity);

  /// Serializes this TrainingExercise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.repeatCount, repeatCount) || other.repeatCount == repeatCount)&&const DeepCollectionEquality().equals(other.groups, groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,repeatCount,const DeepCollectionEquality().hash(groups));

@override
String toString() {
  return 'TrainingExercise(id: $id, title: $title, repeatCount: $repeatCount, groups: $groups)';
}


}

/// @nodoc
abstract mixin class $TrainingExerciseCopyWith<$Res>  {
  factory $TrainingExerciseCopyWith(TrainingExercise value, $Res Function(TrainingExercise) _then) = _$TrainingExerciseCopyWithImpl;
@useResult
$Res call({
 String id, String title, int repeatCount, List<TrainingExerciseGroup> groups
});




}
/// @nodoc
class _$TrainingExerciseCopyWithImpl<$Res>
    implements $TrainingExerciseCopyWith<$Res> {
  _$TrainingExerciseCopyWithImpl(this._self, this._then);

  final TrainingExercise _self;
  final $Res Function(TrainingExercise) _then;

/// Create a copy of TrainingExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? repeatCount = null,Object? groups = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,repeatCount: null == repeatCount ? _self.repeatCount : repeatCount // ignore: cast_nullable_to_non_nullable
as int,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<TrainingExerciseGroup>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingExercise].
extension TrainingExercisePatterns on TrainingExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingExercise value)  $default,){
final _that = this;
switch (_that) {
case _TrainingExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingExercise value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int repeatCount,  List<TrainingExerciseGroup> groups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingExercise() when $default != null:
return $default(_that.id,_that.title,_that.repeatCount,_that.groups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int repeatCount,  List<TrainingExerciseGroup> groups)  $default,) {final _that = this;
switch (_that) {
case _TrainingExercise():
return $default(_that.id,_that.title,_that.repeatCount,_that.groups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int repeatCount,  List<TrainingExerciseGroup> groups)?  $default,) {final _that = this;
switch (_that) {
case _TrainingExercise() when $default != null:
return $default(_that.id,_that.title,_that.repeatCount,_that.groups);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _TrainingExercise implements TrainingExercise {
  const _TrainingExercise({required this.id, required this.title, this.repeatCount = 1, final  List<TrainingExerciseGroup> groups = const <TrainingExerciseGroup>[]}): _groups = groups;
  factory _TrainingExercise.fromJson(Map<String, dynamic> json) => _$TrainingExerciseFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  int repeatCount;
 final  List<TrainingExerciseGroup> _groups;
@override@JsonKey() List<TrainingExerciseGroup> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}


/// Create a copy of TrainingExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingExerciseCopyWith<_TrainingExercise> get copyWith => __$TrainingExerciseCopyWithImpl<_TrainingExercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.repeatCount, repeatCount) || other.repeatCount == repeatCount)&&const DeepCollectionEquality().equals(other._groups, _groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,repeatCount,const DeepCollectionEquality().hash(_groups));

@override
String toString() {
  return 'TrainingExercise(id: $id, title: $title, repeatCount: $repeatCount, groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$TrainingExerciseCopyWith<$Res> implements $TrainingExerciseCopyWith<$Res> {
  factory _$TrainingExerciseCopyWith(_TrainingExercise value, $Res Function(_TrainingExercise) _then) = __$TrainingExerciseCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int repeatCount, List<TrainingExerciseGroup> groups
});




}
/// @nodoc
class __$TrainingExerciseCopyWithImpl<$Res>
    implements _$TrainingExerciseCopyWith<$Res> {
  __$TrainingExerciseCopyWithImpl(this._self, this._then);

  final _TrainingExercise _self;
  final $Res Function(_TrainingExercise) _then;

/// Create a copy of TrainingExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? repeatCount = null,Object? groups = null,}) {
  return _then(_TrainingExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,repeatCount: null == repeatCount ? _self.repeatCount : repeatCount // ignore: cast_nullable_to_non_nullable
as int,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<TrainingExerciseGroup>,
  ));
}


}

// dart format on
