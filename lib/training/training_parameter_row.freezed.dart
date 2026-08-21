// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_parameter_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingParameterRow {

 String get id; int? get reps; int? get distance; String? get stroke; int? get intensity; String? get zone;
/// Create a copy of TrainingParameterRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingParameterRowCopyWith<TrainingParameterRow> get copyWith => _$TrainingParameterRowCopyWithImpl<TrainingParameterRow>(this as TrainingParameterRow, _$identity);

  /// Serializes this TrainingParameterRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingParameterRow&&(identical(other.id, id) || other.id == id)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.stroke, stroke) || other.stroke == stroke)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.zone, zone) || other.zone == zone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reps,distance,stroke,intensity,zone);

@override
String toString() {
  return 'TrainingParameterRow(id: $id, reps: $reps, distance: $distance, stroke: $stroke, intensity: $intensity, zone: $zone)';
}


}

/// @nodoc
abstract mixin class $TrainingParameterRowCopyWith<$Res>  {
  factory $TrainingParameterRowCopyWith(TrainingParameterRow value, $Res Function(TrainingParameterRow) _then) = _$TrainingParameterRowCopyWithImpl;
@useResult
$Res call({
 String id, int? reps, int? distance, String? stroke, int? intensity, String? zone
});




}
/// @nodoc
class _$TrainingParameterRowCopyWithImpl<$Res>
    implements $TrainingParameterRowCopyWith<$Res> {
  _$TrainingParameterRowCopyWithImpl(this._self, this._then);

  final TrainingParameterRow _self;
  final $Res Function(TrainingParameterRow) _then;

/// Create a copy of TrainingParameterRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reps = freezed,Object? distance = freezed,Object? stroke = freezed,Object? intensity = freezed,Object? zone = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reps: freezed == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int?,stroke: freezed == stroke ? _self.stroke : stroke // ignore: cast_nullable_to_non_nullable
as String?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int?,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingParameterRow].
extension TrainingParameterRowPatterns on TrainingParameterRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingParameterRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingParameterRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingParameterRow value)  $default,){
final _that = this;
switch (_that) {
case _TrainingParameterRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingParameterRow value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingParameterRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int? reps,  int? distance,  String? stroke,  int? intensity,  String? zone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingParameterRow() when $default != null:
return $default(_that.id,_that.reps,_that.distance,_that.stroke,_that.intensity,_that.zone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int? reps,  int? distance,  String? stroke,  int? intensity,  String? zone)  $default,) {final _that = this;
switch (_that) {
case _TrainingParameterRow():
return $default(_that.id,_that.reps,_that.distance,_that.stroke,_that.intensity,_that.zone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int? reps,  int? distance,  String? stroke,  int? intensity,  String? zone)?  $default,) {final _that = this;
switch (_that) {
case _TrainingParameterRow() when $default != null:
return $default(_that.id,_that.reps,_that.distance,_that.stroke,_that.intensity,_that.zone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingParameterRow implements TrainingParameterRow {
  const _TrainingParameterRow({required this.id, this.reps, this.distance, this.stroke, this.intensity, this.zone});
  factory _TrainingParameterRow.fromJson(Map<String, dynamic> json) => _$TrainingParameterRowFromJson(json);

@override final  String id;
@override final  int? reps;
@override final  int? distance;
@override final  String? stroke;
@override final  int? intensity;
@override final  String? zone;

/// Create a copy of TrainingParameterRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingParameterRowCopyWith<_TrainingParameterRow> get copyWith => __$TrainingParameterRowCopyWithImpl<_TrainingParameterRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingParameterRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingParameterRow&&(identical(other.id, id) || other.id == id)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.stroke, stroke) || other.stroke == stroke)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.zone, zone) || other.zone == zone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reps,distance,stroke,intensity,zone);

@override
String toString() {
  return 'TrainingParameterRow(id: $id, reps: $reps, distance: $distance, stroke: $stroke, intensity: $intensity, zone: $zone)';
}


}

/// @nodoc
abstract mixin class _$TrainingParameterRowCopyWith<$Res> implements $TrainingParameterRowCopyWith<$Res> {
  factory _$TrainingParameterRowCopyWith(_TrainingParameterRow value, $Res Function(_TrainingParameterRow) _then) = __$TrainingParameterRowCopyWithImpl;
@override @useResult
$Res call({
 String id, int? reps, int? distance, String? stroke, int? intensity, String? zone
});




}
/// @nodoc
class __$TrainingParameterRowCopyWithImpl<$Res>
    implements _$TrainingParameterRowCopyWith<$Res> {
  __$TrainingParameterRowCopyWithImpl(this._self, this._then);

  final _TrainingParameterRow _self;
  final $Res Function(_TrainingParameterRow) _then;

/// Create a copy of TrainingParameterRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reps = freezed,Object? distance = freezed,Object? stroke = freezed,Object? intensity = freezed,Object? zone = freezed,}) {
  return _then(_TrainingParameterRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reps: freezed == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int?,stroke: freezed == stroke ? _self.stroke : stroke // ignore: cast_nullable_to_non_nullable
as String?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as int?,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
