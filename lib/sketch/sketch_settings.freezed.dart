// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sketch_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SketchSettings {

 String? get currentId; List<String> get sketchTags; List<SketchBackground> get backgrounds;
/// Create a copy of SketchSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SketchSettingsCopyWith<SketchSettings> get copyWith => _$SketchSettingsCopyWithImpl<SketchSettings>(this as SketchSettings, _$identity);

  /// Serializes this SketchSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SketchSettings&&(identical(other.currentId, currentId) || other.currentId == currentId)&&const DeepCollectionEquality().equals(other.sketchTags, sketchTags)&&const DeepCollectionEquality().equals(other.backgrounds, backgrounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentId,const DeepCollectionEquality().hash(sketchTags),const DeepCollectionEquality().hash(backgrounds));

@override
String toString() {
  return 'SketchSettings(currentId: $currentId, sketchTags: $sketchTags, backgrounds: $backgrounds)';
}


}

/// @nodoc
abstract mixin class $SketchSettingsCopyWith<$Res>  {
  factory $SketchSettingsCopyWith(SketchSettings value, $Res Function(SketchSettings) _then) = _$SketchSettingsCopyWithImpl;
@useResult
$Res call({
 String? currentId, List<String> sketchTags, List<SketchBackground> backgrounds
});




}
/// @nodoc
class _$SketchSettingsCopyWithImpl<$Res>
    implements $SketchSettingsCopyWith<$Res> {
  _$SketchSettingsCopyWithImpl(this._self, this._then);

  final SketchSettings _self;
  final $Res Function(SketchSettings) _then;

/// Create a copy of SketchSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentId = freezed,Object? sketchTags = null,Object? backgrounds = null,}) {
  return _then(_self.copyWith(
currentId: freezed == currentId ? _self.currentId : currentId // ignore: cast_nullable_to_non_nullable
as String?,sketchTags: null == sketchTags ? _self.sketchTags : sketchTags // ignore: cast_nullable_to_non_nullable
as List<String>,backgrounds: null == backgrounds ? _self.backgrounds : backgrounds // ignore: cast_nullable_to_non_nullable
as List<SketchBackground>,
  ));
}

}


/// Adds pattern-matching-related methods to [SketchSettings].
extension SketchSettingsPatterns on SketchSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SketchSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SketchSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SketchSettings value)  $default,){
final _that = this;
switch (_that) {
case _SketchSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SketchSettings value)?  $default,){
final _that = this;
switch (_that) {
case _SketchSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? currentId,  List<String> sketchTags,  List<SketchBackground> backgrounds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SketchSettings() when $default != null:
return $default(_that.currentId,_that.sketchTags,_that.backgrounds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? currentId,  List<String> sketchTags,  List<SketchBackground> backgrounds)  $default,) {final _that = this;
switch (_that) {
case _SketchSettings():
return $default(_that.currentId,_that.sketchTags,_that.backgrounds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? currentId,  List<String> sketchTags,  List<SketchBackground> backgrounds)?  $default,) {final _that = this;
switch (_that) {
case _SketchSettings() when $default != null:
return $default(_that.currentId,_that.sketchTags,_that.backgrounds);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SketchSettings implements SketchSettings {
  const _SketchSettings({this.currentId, final  List<String> sketchTags = const <String>[], final  List<SketchBackground> backgrounds = const <SketchBackground>[]}): _sketchTags = sketchTags,_backgrounds = backgrounds;
  factory _SketchSettings.fromJson(Map<String, dynamic> json) => _$SketchSettingsFromJson(json);

@override final  String? currentId;
 final  List<String> _sketchTags;
@override@JsonKey() List<String> get sketchTags {
  if (_sketchTags is EqualUnmodifiableListView) return _sketchTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sketchTags);
}

 final  List<SketchBackground> _backgrounds;
@override@JsonKey() List<SketchBackground> get backgrounds {
  if (_backgrounds is EqualUnmodifiableListView) return _backgrounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backgrounds);
}


/// Create a copy of SketchSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SketchSettingsCopyWith<_SketchSettings> get copyWith => __$SketchSettingsCopyWithImpl<_SketchSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SketchSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SketchSettings&&(identical(other.currentId, currentId) || other.currentId == currentId)&&const DeepCollectionEquality().equals(other._sketchTags, _sketchTags)&&const DeepCollectionEquality().equals(other._backgrounds, _backgrounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentId,const DeepCollectionEquality().hash(_sketchTags),const DeepCollectionEquality().hash(_backgrounds));

@override
String toString() {
  return 'SketchSettings(currentId: $currentId, sketchTags: $sketchTags, backgrounds: $backgrounds)';
}


}

/// @nodoc
abstract mixin class _$SketchSettingsCopyWith<$Res> implements $SketchSettingsCopyWith<$Res> {
  factory _$SketchSettingsCopyWith(_SketchSettings value, $Res Function(_SketchSettings) _then) = __$SketchSettingsCopyWithImpl;
@override @useResult
$Res call({
 String? currentId, List<String> sketchTags, List<SketchBackground> backgrounds
});




}
/// @nodoc
class __$SketchSettingsCopyWithImpl<$Res>
    implements _$SketchSettingsCopyWith<$Res> {
  __$SketchSettingsCopyWithImpl(this._self, this._then);

  final _SketchSettings _self;
  final $Res Function(_SketchSettings) _then;

/// Create a copy of SketchSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentId = freezed,Object? sketchTags = null,Object? backgrounds = null,}) {
  return _then(_SketchSettings(
currentId: freezed == currentId ? _self.currentId : currentId // ignore: cast_nullable_to_non_nullable
as String?,sketchTags: null == sketchTags ? _self._sketchTags : sketchTags // ignore: cast_nullable_to_non_nullable
as List<String>,backgrounds: null == backgrounds ? _self._backgrounds : backgrounds // ignore: cast_nullable_to_non_nullable
as List<SketchBackground>,
  ));
}


}

// dart format on
