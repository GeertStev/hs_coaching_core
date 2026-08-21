// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
TrainingNode _$TrainingNodeFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'group':
          return TrainingNodeGroup.fromJson(
            json
          );
                case 'exercise':
          return TrainingNodeExercise.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'TrainingNode',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$TrainingNode {



  /// Serializes this TrainingNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingNode);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TrainingNode()';
}


}

/// @nodoc
class $TrainingNodeCopyWith<$Res>  {
$TrainingNodeCopyWith(TrainingNode _, $Res Function(TrainingNode) __);
}


/// Adds pattern-matching-related methods to [TrainingNode].
extension TrainingNodePatterns on TrainingNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TrainingNodeGroup value)?  group,TResult Function( TrainingNodeExercise value)?  exercise,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TrainingNodeGroup() when group != null:
return group(_that);case TrainingNodeExercise() when exercise != null:
return exercise(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TrainingNodeGroup value)  group,required TResult Function( TrainingNodeExercise value)  exercise,}){
final _that = this;
switch (_that) {
case TrainingNodeGroup():
return group(_that);case TrainingNodeExercise():
return exercise(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TrainingNodeGroup value)?  group,TResult? Function( TrainingNodeExercise value)?  exercise,}){
final _that = this;
switch (_that) {
case TrainingNodeGroup() when group != null:
return group(_that);case TrainingNodeExercise() when exercise != null:
return exercise(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( TrainingGroup group)?  group,TResult Function( TrainingExercise exercise)?  exercise,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TrainingNodeGroup() when group != null:
return group(_that.group);case TrainingNodeExercise() when exercise != null:
return exercise(_that.exercise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( TrainingGroup group)  group,required TResult Function( TrainingExercise exercise)  exercise,}) {final _that = this;
switch (_that) {
case TrainingNodeGroup():
return group(_that.group);case TrainingNodeExercise():
return exercise(_that.exercise);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( TrainingGroup group)?  group,TResult? Function( TrainingExercise exercise)?  exercise,}) {final _that = this;
switch (_that) {
case TrainingNodeGroup() when group != null:
return group(_that.group);case TrainingNodeExercise() when exercise != null:
return exercise(_that.exercise);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class TrainingNodeGroup extends TrainingNode {
  const TrainingNodeGroup({required this.group, final  String? $type}): $type = $type ?? 'group',super._();
  factory TrainingNodeGroup.fromJson(Map<String, dynamic> json) => _$TrainingNodeGroupFromJson(json);

 final  TrainingGroup group;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TrainingNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingNodeGroupCopyWith<TrainingNodeGroup> get copyWith => _$TrainingNodeGroupCopyWithImpl<TrainingNodeGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingNodeGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingNodeGroup&&(identical(other.group, group) || other.group == group));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,group);

@override
String toString() {
  return 'TrainingNode.group(group: $group)';
}


}

/// @nodoc
abstract mixin class $TrainingNodeGroupCopyWith<$Res> implements $TrainingNodeCopyWith<$Res> {
  factory $TrainingNodeGroupCopyWith(TrainingNodeGroup value, $Res Function(TrainingNodeGroup) _then) = _$TrainingNodeGroupCopyWithImpl;
@useResult
$Res call({
 TrainingGroup group
});


$TrainingGroupCopyWith<$Res> get group;

}
/// @nodoc
class _$TrainingNodeGroupCopyWithImpl<$Res>
    implements $TrainingNodeGroupCopyWith<$Res> {
  _$TrainingNodeGroupCopyWithImpl(this._self, this._then);

  final TrainingNodeGroup _self;
  final $Res Function(TrainingNodeGroup) _then;

/// Create a copy of TrainingNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? group = null,}) {
  return _then(TrainingNodeGroup(
group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as TrainingGroup,
  ));
}

/// Create a copy of TrainingNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingGroupCopyWith<$Res> get group {
  
  return $TrainingGroupCopyWith<$Res>(_self.group, (value) {
    return _then(_self.copyWith(group: value));
  });
}
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class TrainingNodeExercise extends TrainingNode {
  const TrainingNodeExercise({required this.exercise, final  String? $type}): $type = $type ?? 'exercise',super._();
  factory TrainingNodeExercise.fromJson(Map<String, dynamic> json) => _$TrainingNodeExerciseFromJson(json);

 final  TrainingExercise exercise;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TrainingNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingNodeExerciseCopyWith<TrainingNodeExercise> get copyWith => _$TrainingNodeExerciseCopyWithImpl<TrainingNodeExercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingNodeExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingNodeExercise&&(identical(other.exercise, exercise) || other.exercise == exercise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exercise);

@override
String toString() {
  return 'TrainingNode.exercise(exercise: $exercise)';
}


}

/// @nodoc
abstract mixin class $TrainingNodeExerciseCopyWith<$Res> implements $TrainingNodeCopyWith<$Res> {
  factory $TrainingNodeExerciseCopyWith(TrainingNodeExercise value, $Res Function(TrainingNodeExercise) _then) = _$TrainingNodeExerciseCopyWithImpl;
@useResult
$Res call({
 TrainingExercise exercise
});


$TrainingExerciseCopyWith<$Res> get exercise;

}
/// @nodoc
class _$TrainingNodeExerciseCopyWithImpl<$Res>
    implements $TrainingNodeExerciseCopyWith<$Res> {
  _$TrainingNodeExerciseCopyWithImpl(this._self, this._then);

  final TrainingNodeExercise _self;
  final $Res Function(TrainingNodeExercise) _then;

/// Create a copy of TrainingNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exercise = null,}) {
  return _then(TrainingNodeExercise(
exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as TrainingExercise,
  ));
}

/// Create a copy of TrainingNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingExerciseCopyWith<$Res> get exercise {
  
  return $TrainingExerciseCopyWith<$Res>(_self.exercise, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}

// dart format on
