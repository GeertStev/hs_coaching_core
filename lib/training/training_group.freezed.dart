// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingGroup {

 String get id; String? get title; int get repeatCount; List<TrainingNode> get children;
/// Create a copy of TrainingGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingGroupCopyWith<TrainingGroup> get copyWith => _$TrainingGroupCopyWithImpl<TrainingGroup>(this as TrainingGroup, _$identity);

  /// Serializes this TrainingGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.repeatCount, repeatCount) || other.repeatCount == repeatCount)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,repeatCount,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'TrainingGroup(id: $id, title: $title, repeatCount: $repeatCount, children: $children)';
}


}

/// @nodoc
abstract mixin class $TrainingGroupCopyWith<$Res>  {
  factory $TrainingGroupCopyWith(TrainingGroup value, $Res Function(TrainingGroup) _then) = _$TrainingGroupCopyWithImpl;
@useResult
$Res call({
 String id, String? title, int repeatCount, List<TrainingNode> children
});




}
/// @nodoc
class _$TrainingGroupCopyWithImpl<$Res>
    implements $TrainingGroupCopyWith<$Res> {
  _$TrainingGroupCopyWithImpl(this._self, this._then);

  final TrainingGroup _self;
  final $Res Function(TrainingGroup) _then;

/// Create a copy of TrainingGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = freezed,Object? repeatCount = null,Object? children = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,repeatCount: null == repeatCount ? _self.repeatCount : repeatCount // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<TrainingNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingGroup].
extension TrainingGroupPatterns on TrainingGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingGroup value)  $default,){
final _that = this;
switch (_that) {
case _TrainingGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingGroup value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? title,  int repeatCount,  List<TrainingNode> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingGroup() when $default != null:
return $default(_that.id,_that.title,_that.repeatCount,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? title,  int repeatCount,  List<TrainingNode> children)  $default,) {final _that = this;
switch (_that) {
case _TrainingGroup():
return $default(_that.id,_that.title,_that.repeatCount,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? title,  int repeatCount,  List<TrainingNode> children)?  $default,) {final _that = this;
switch (_that) {
case _TrainingGroup() when $default != null:
return $default(_that.id,_that.title,_that.repeatCount,_that.children);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _TrainingGroup implements TrainingGroup {
  const _TrainingGroup({required this.id, this.title, this.repeatCount = 1, final  List<TrainingNode> children = const <TrainingNode>[]}): _children = children;
  factory _TrainingGroup.fromJson(Map<String, dynamic> json) => _$TrainingGroupFromJson(json);

@override final  String id;
@override final  String? title;
@override@JsonKey() final  int repeatCount;
 final  List<TrainingNode> _children;
@override@JsonKey() List<TrainingNode> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of TrainingGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingGroupCopyWith<_TrainingGroup> get copyWith => __$TrainingGroupCopyWithImpl<_TrainingGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.repeatCount, repeatCount) || other.repeatCount == repeatCount)&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,repeatCount,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'TrainingGroup(id: $id, title: $title, repeatCount: $repeatCount, children: $children)';
}


}

/// @nodoc
abstract mixin class _$TrainingGroupCopyWith<$Res> implements $TrainingGroupCopyWith<$Res> {
  factory _$TrainingGroupCopyWith(_TrainingGroup value, $Res Function(_TrainingGroup) _then) = __$TrainingGroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String? title, int repeatCount, List<TrainingNode> children
});




}
/// @nodoc
class __$TrainingGroupCopyWithImpl<$Res>
    implements _$TrainingGroupCopyWith<$Res> {
  __$TrainingGroupCopyWithImpl(this._self, this._then);

  final _TrainingGroup _self;
  final $Res Function(_TrainingGroup) _then;

/// Create a copy of TrainingGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? repeatCount = null,Object? children = null,}) {
  return _then(_TrainingGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,repeatCount: null == repeatCount ? _self.repeatCount : repeatCount // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<TrainingNode>,
  ));
}


}

// dart format on
