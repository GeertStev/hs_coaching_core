// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'infringement_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InfringementStep {

/// Elke optie is een combinatie van sancties die samen opgelegd worden
/// (bv. team caution én 2 minuten).
 List<List<Sanction>> get options;/// De "*" uit de tabel: de scheidsrechter kiest vrij tussen de opties.
 bool get refereeChoice;
/// Create a copy of InfringementStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<InfringementStep> get copyWith => _$InfringementStepCopyWithImpl<InfringementStep>(this as InfringementStep, _$identity);

  /// Serializes this InfringementStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfringementStep&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.refereeChoice, refereeChoice) || other.refereeChoice == refereeChoice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(options),refereeChoice);

@override
String toString() {
  return 'InfringementStep(options: $options, refereeChoice: $refereeChoice)';
}


}

/// @nodoc
abstract mixin class $InfringementStepCopyWith<$Res>  {
  factory $InfringementStepCopyWith(InfringementStep value, $Res Function(InfringementStep) _then) = _$InfringementStepCopyWithImpl;
@useResult
$Res call({
 List<List<Sanction>> options, bool refereeChoice
});




}
/// @nodoc
class _$InfringementStepCopyWithImpl<$Res>
    implements $InfringementStepCopyWith<$Res> {
  _$InfringementStepCopyWithImpl(this._self, this._then);

  final InfringementStep _self;
  final $Res Function(InfringementStep) _then;

/// Create a copy of InfringementStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? options = null,Object? refereeChoice = null,}) {
  return _then(_self.copyWith(
options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<List<Sanction>>,refereeChoice: null == refereeChoice ? _self.refereeChoice : refereeChoice // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InfringementStep].
extension InfringementStepPatterns on InfringementStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InfringementStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InfringementStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InfringementStep value)  $default,){
final _that = this;
switch (_that) {
case _InfringementStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InfringementStep value)?  $default,){
final _that = this;
switch (_that) {
case _InfringementStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<List<Sanction>> options,  bool refereeChoice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InfringementStep() when $default != null:
return $default(_that.options,_that.refereeChoice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<List<Sanction>> options,  bool refereeChoice)  $default,) {final _that = this;
switch (_that) {
case _InfringementStep():
return $default(_that.options,_that.refereeChoice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<List<Sanction>> options,  bool refereeChoice)?  $default,) {final _that = this;
switch (_that) {
case _InfringementStep() when $default != null:
return $default(_that.options,_that.refereeChoice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InfringementStep implements InfringementStep {
  const _InfringementStep({required final  List<List<Sanction>> options, this.refereeChoice = false}): _options = options;
  factory _InfringementStep.fromJson(Map<String, dynamic> json) => _$InfringementStepFromJson(json);

/// Elke optie is een combinatie van sancties die samen opgelegd worden
/// (bv. team caution én 2 minuten).
 final  List<List<Sanction>> _options;
/// Elke optie is een combinatie van sancties die samen opgelegd worden
/// (bv. team caution én 2 minuten).
@override List<List<Sanction>> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

/// De "*" uit de tabel: de scheidsrechter kiest vrij tussen de opties.
@override@JsonKey() final  bool refereeChoice;

/// Create a copy of InfringementStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfringementStepCopyWith<_InfringementStep> get copyWith => __$InfringementStepCopyWithImpl<_InfringementStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InfringementStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InfringementStep&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.refereeChoice, refereeChoice) || other.refereeChoice == refereeChoice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_options),refereeChoice);

@override
String toString() {
  return 'InfringementStep(options: $options, refereeChoice: $refereeChoice)';
}


}

/// @nodoc
abstract mixin class _$InfringementStepCopyWith<$Res> implements $InfringementStepCopyWith<$Res> {
  factory _$InfringementStepCopyWith(_InfringementStep value, $Res Function(_InfringementStep) _then) = __$InfringementStepCopyWithImpl;
@override @useResult
$Res call({
 List<List<Sanction>> options, bool refereeChoice
});




}
/// @nodoc
class __$InfringementStepCopyWithImpl<$Res>
    implements _$InfringementStepCopyWith<$Res> {
  __$InfringementStepCopyWithImpl(this._self, this._then);

  final _InfringementStep _self;
  final $Res Function(_InfringementStep) _then;

/// Create a copy of InfringementStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? options = null,Object? refereeChoice = null,}) {
  return _then(_InfringementStep(
options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<List<Sanction>>,refereeChoice: null == refereeChoice ? _self.refereeChoice : refereeChoice // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Infringement {

/// Sleutel die in events als `infringementCode` bewaard wordt. Meestal het
/// regelnummer; 16.3.8 komt drie keer voor en krijgt een achtervoegsel.
 String get id;/// Regelnummers (16.3.x) van de overtreding.
 List<String> get rules; String get name;/// Naam van het handsignaal zoals in de tabel, met de regelnummers
/// (13.1.x) erbij.
 String get handSignal; List<String> get handSignalRules; String? get note;/// `null` = grijs vak in de tabel: deze overtreding kan niet accidenteel
/// zijn.
 InfringementStep? get firstAccidental; InfringementStep get firstDeliberate; InfringementStep? get secondAccidental; InfringementStep get secondDeliberate; InfringementStep get thirdOrMore;
/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfringementCopyWith<Infringement> get copyWith => _$InfringementCopyWithImpl<Infringement>(this as Infringement, _$identity);

  /// Serializes this Infringement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Infringement&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.rules, rules)&&(identical(other.name, name) || other.name == name)&&(identical(other.handSignal, handSignal) || other.handSignal == handSignal)&&const DeepCollectionEquality().equals(other.handSignalRules, handSignalRules)&&(identical(other.note, note) || other.note == note)&&(identical(other.firstAccidental, firstAccidental) || other.firstAccidental == firstAccidental)&&(identical(other.firstDeliberate, firstDeliberate) || other.firstDeliberate == firstDeliberate)&&(identical(other.secondAccidental, secondAccidental) || other.secondAccidental == secondAccidental)&&(identical(other.secondDeliberate, secondDeliberate) || other.secondDeliberate == secondDeliberate)&&(identical(other.thirdOrMore, thirdOrMore) || other.thirdOrMore == thirdOrMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(rules),name,handSignal,const DeepCollectionEquality().hash(handSignalRules),note,firstAccidental,firstDeliberate,secondAccidental,secondDeliberate,thirdOrMore);

@override
String toString() {
  return 'Infringement(id: $id, rules: $rules, name: $name, handSignal: $handSignal, handSignalRules: $handSignalRules, note: $note, firstAccidental: $firstAccidental, firstDeliberate: $firstDeliberate, secondAccidental: $secondAccidental, secondDeliberate: $secondDeliberate, thirdOrMore: $thirdOrMore)';
}


}

/// @nodoc
abstract mixin class $InfringementCopyWith<$Res>  {
  factory $InfringementCopyWith(Infringement value, $Res Function(Infringement) _then) = _$InfringementCopyWithImpl;
@useResult
$Res call({
 String id, List<String> rules, String name, String handSignal, List<String> handSignalRules, String? note, InfringementStep? firstAccidental, InfringementStep firstDeliberate, InfringementStep? secondAccidental, InfringementStep secondDeliberate, InfringementStep thirdOrMore
});


$InfringementStepCopyWith<$Res>? get firstAccidental;$InfringementStepCopyWith<$Res> get firstDeliberate;$InfringementStepCopyWith<$Res>? get secondAccidental;$InfringementStepCopyWith<$Res> get secondDeliberate;$InfringementStepCopyWith<$Res> get thirdOrMore;

}
/// @nodoc
class _$InfringementCopyWithImpl<$Res>
    implements $InfringementCopyWith<$Res> {
  _$InfringementCopyWithImpl(this._self, this._then);

  final Infringement _self;
  final $Res Function(Infringement) _then;

/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rules = null,Object? name = null,Object? handSignal = null,Object? handSignalRules = null,Object? note = freezed,Object? firstAccidental = freezed,Object? firstDeliberate = null,Object? secondAccidental = freezed,Object? secondDeliberate = null,Object? thirdOrMore = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<String>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handSignal: null == handSignal ? _self.handSignal : handSignal // ignore: cast_nullable_to_non_nullable
as String,handSignalRules: null == handSignalRules ? _self.handSignalRules : handSignalRules // ignore: cast_nullable_to_non_nullable
as List<String>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,firstAccidental: freezed == firstAccidental ? _self.firstAccidental : firstAccidental // ignore: cast_nullable_to_non_nullable
as InfringementStep?,firstDeliberate: null == firstDeliberate ? _self.firstDeliberate : firstDeliberate // ignore: cast_nullable_to_non_nullable
as InfringementStep,secondAccidental: freezed == secondAccidental ? _self.secondAccidental : secondAccidental // ignore: cast_nullable_to_non_nullable
as InfringementStep?,secondDeliberate: null == secondDeliberate ? _self.secondDeliberate : secondDeliberate // ignore: cast_nullable_to_non_nullable
as InfringementStep,thirdOrMore: null == thirdOrMore ? _self.thirdOrMore : thirdOrMore // ignore: cast_nullable_to_non_nullable
as InfringementStep,
  ));
}
/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<$Res>? get firstAccidental {
    if (_self.firstAccidental == null) {
    return null;
  }

  return $InfringementStepCopyWith<$Res>(_self.firstAccidental!, (value) {
    return _then(_self.copyWith(firstAccidental: value));
  });
}/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<$Res> get firstDeliberate {
  
  return $InfringementStepCopyWith<$Res>(_self.firstDeliberate, (value) {
    return _then(_self.copyWith(firstDeliberate: value));
  });
}/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<$Res>? get secondAccidental {
    if (_self.secondAccidental == null) {
    return null;
  }

  return $InfringementStepCopyWith<$Res>(_self.secondAccidental!, (value) {
    return _then(_self.copyWith(secondAccidental: value));
  });
}/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<$Res> get secondDeliberate {
  
  return $InfringementStepCopyWith<$Res>(_self.secondDeliberate, (value) {
    return _then(_self.copyWith(secondDeliberate: value));
  });
}/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<$Res> get thirdOrMore {
  
  return $InfringementStepCopyWith<$Res>(_self.thirdOrMore, (value) {
    return _then(_self.copyWith(thirdOrMore: value));
  });
}
}


/// Adds pattern-matching-related methods to [Infringement].
extension InfringementPatterns on Infringement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Infringement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Infringement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Infringement value)  $default,){
final _that = this;
switch (_that) {
case _Infringement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Infringement value)?  $default,){
final _that = this;
switch (_that) {
case _Infringement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<String> rules,  String name,  String handSignal,  List<String> handSignalRules,  String? note,  InfringementStep? firstAccidental,  InfringementStep firstDeliberate,  InfringementStep? secondAccidental,  InfringementStep secondDeliberate,  InfringementStep thirdOrMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Infringement() when $default != null:
return $default(_that.id,_that.rules,_that.name,_that.handSignal,_that.handSignalRules,_that.note,_that.firstAccidental,_that.firstDeliberate,_that.secondAccidental,_that.secondDeliberate,_that.thirdOrMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<String> rules,  String name,  String handSignal,  List<String> handSignalRules,  String? note,  InfringementStep? firstAccidental,  InfringementStep firstDeliberate,  InfringementStep? secondAccidental,  InfringementStep secondDeliberate,  InfringementStep thirdOrMore)  $default,) {final _that = this;
switch (_that) {
case _Infringement():
return $default(_that.id,_that.rules,_that.name,_that.handSignal,_that.handSignalRules,_that.note,_that.firstAccidental,_that.firstDeliberate,_that.secondAccidental,_that.secondDeliberate,_that.thirdOrMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<String> rules,  String name,  String handSignal,  List<String> handSignalRules,  String? note,  InfringementStep? firstAccidental,  InfringementStep firstDeliberate,  InfringementStep? secondAccidental,  InfringementStep secondDeliberate,  InfringementStep thirdOrMore)?  $default,) {final _that = this;
switch (_that) {
case _Infringement() when $default != null:
return $default(_that.id,_that.rules,_that.name,_that.handSignal,_that.handSignalRules,_that.note,_that.firstAccidental,_that.firstDeliberate,_that.secondAccidental,_that.secondDeliberate,_that.thirdOrMore);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Infringement implements Infringement {
  const _Infringement({required this.id, required final  List<String> rules, required this.name, required this.handSignal, final  List<String> handSignalRules = const <String>[], this.note, this.firstAccidental, required this.firstDeliberate, this.secondAccidental, required this.secondDeliberate, required this.thirdOrMore}): _rules = rules,_handSignalRules = handSignalRules;
  factory _Infringement.fromJson(Map<String, dynamic> json) => _$InfringementFromJson(json);

/// Sleutel die in events als `infringementCode` bewaard wordt. Meestal het
/// regelnummer; 16.3.8 komt drie keer voor en krijgt een achtervoegsel.
@override final  String id;
/// Regelnummers (16.3.x) van de overtreding.
 final  List<String> _rules;
/// Regelnummers (16.3.x) van de overtreding.
@override List<String> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}

@override final  String name;
/// Naam van het handsignaal zoals in de tabel, met de regelnummers
/// (13.1.x) erbij.
@override final  String handSignal;
 final  List<String> _handSignalRules;
@override@JsonKey() List<String> get handSignalRules {
  if (_handSignalRules is EqualUnmodifiableListView) return _handSignalRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_handSignalRules);
}

@override final  String? note;
/// `null` = grijs vak in de tabel: deze overtreding kan niet accidenteel
/// zijn.
@override final  InfringementStep? firstAccidental;
@override final  InfringementStep firstDeliberate;
@override final  InfringementStep? secondAccidental;
@override final  InfringementStep secondDeliberate;
@override final  InfringementStep thirdOrMore;

/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfringementCopyWith<_Infringement> get copyWith => __$InfringementCopyWithImpl<_Infringement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InfringementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Infringement&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._rules, _rules)&&(identical(other.name, name) || other.name == name)&&(identical(other.handSignal, handSignal) || other.handSignal == handSignal)&&const DeepCollectionEquality().equals(other._handSignalRules, _handSignalRules)&&(identical(other.note, note) || other.note == note)&&(identical(other.firstAccidental, firstAccidental) || other.firstAccidental == firstAccidental)&&(identical(other.firstDeliberate, firstDeliberate) || other.firstDeliberate == firstDeliberate)&&(identical(other.secondAccidental, secondAccidental) || other.secondAccidental == secondAccidental)&&(identical(other.secondDeliberate, secondDeliberate) || other.secondDeliberate == secondDeliberate)&&(identical(other.thirdOrMore, thirdOrMore) || other.thirdOrMore == thirdOrMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_rules),name,handSignal,const DeepCollectionEquality().hash(_handSignalRules),note,firstAccidental,firstDeliberate,secondAccidental,secondDeliberate,thirdOrMore);

@override
String toString() {
  return 'Infringement(id: $id, rules: $rules, name: $name, handSignal: $handSignal, handSignalRules: $handSignalRules, note: $note, firstAccidental: $firstAccidental, firstDeliberate: $firstDeliberate, secondAccidental: $secondAccidental, secondDeliberate: $secondDeliberate, thirdOrMore: $thirdOrMore)';
}


}

/// @nodoc
abstract mixin class _$InfringementCopyWith<$Res> implements $InfringementCopyWith<$Res> {
  factory _$InfringementCopyWith(_Infringement value, $Res Function(_Infringement) _then) = __$InfringementCopyWithImpl;
@override @useResult
$Res call({
 String id, List<String> rules, String name, String handSignal, List<String> handSignalRules, String? note, InfringementStep? firstAccidental, InfringementStep firstDeliberate, InfringementStep? secondAccidental, InfringementStep secondDeliberate, InfringementStep thirdOrMore
});


@override $InfringementStepCopyWith<$Res>? get firstAccidental;@override $InfringementStepCopyWith<$Res> get firstDeliberate;@override $InfringementStepCopyWith<$Res>? get secondAccidental;@override $InfringementStepCopyWith<$Res> get secondDeliberate;@override $InfringementStepCopyWith<$Res> get thirdOrMore;

}
/// @nodoc
class __$InfringementCopyWithImpl<$Res>
    implements _$InfringementCopyWith<$Res> {
  __$InfringementCopyWithImpl(this._self, this._then);

  final _Infringement _self;
  final $Res Function(_Infringement) _then;

/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rules = null,Object? name = null,Object? handSignal = null,Object? handSignalRules = null,Object? note = freezed,Object? firstAccidental = freezed,Object? firstDeliberate = null,Object? secondAccidental = freezed,Object? secondDeliberate = null,Object? thirdOrMore = null,}) {
  return _then(_Infringement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<String>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handSignal: null == handSignal ? _self.handSignal : handSignal // ignore: cast_nullable_to_non_nullable
as String,handSignalRules: null == handSignalRules ? _self._handSignalRules : handSignalRules // ignore: cast_nullable_to_non_nullable
as List<String>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,firstAccidental: freezed == firstAccidental ? _self.firstAccidental : firstAccidental // ignore: cast_nullable_to_non_nullable
as InfringementStep?,firstDeliberate: null == firstDeliberate ? _self.firstDeliberate : firstDeliberate // ignore: cast_nullable_to_non_nullable
as InfringementStep,secondAccidental: freezed == secondAccidental ? _self.secondAccidental : secondAccidental // ignore: cast_nullable_to_non_nullable
as InfringementStep?,secondDeliberate: null == secondDeliberate ? _self.secondDeliberate : secondDeliberate // ignore: cast_nullable_to_non_nullable
as InfringementStep,thirdOrMore: null == thirdOrMore ? _self.thirdOrMore : thirdOrMore // ignore: cast_nullable_to_non_nullable
as InfringementStep,
  ));
}

/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<$Res>? get firstAccidental {
    if (_self.firstAccidental == null) {
    return null;
  }

  return $InfringementStepCopyWith<$Res>(_self.firstAccidental!, (value) {
    return _then(_self.copyWith(firstAccidental: value));
  });
}/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<$Res> get firstDeliberate {
  
  return $InfringementStepCopyWith<$Res>(_self.firstDeliberate, (value) {
    return _then(_self.copyWith(firstDeliberate: value));
  });
}/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<$Res>? get secondAccidental {
    if (_self.secondAccidental == null) {
    return null;
  }

  return $InfringementStepCopyWith<$Res>(_self.secondAccidental!, (value) {
    return _then(_self.copyWith(secondAccidental: value));
  });
}/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<$Res> get secondDeliberate {
  
  return $InfringementStepCopyWith<$Res>(_self.secondDeliberate, (value) {
    return _then(_self.copyWith(secondDeliberate: value));
  });
}/// Create a copy of Infringement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfringementStepCopyWith<$Res> get thirdOrMore {
  
  return $InfringementStepCopyWith<$Res>(_self.thirdOrMore, (value) {
    return _then(_self.copyWith(thirdOrMore: value));
  });
}
}


/// @nodoc
mixin _$InfringementTable {

 String get rulesVersion; String get sourceRule; List<Infringement> get infringements;
/// Create a copy of InfringementTable
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfringementTableCopyWith<InfringementTable> get copyWith => _$InfringementTableCopyWithImpl<InfringementTable>(this as InfringementTable, _$identity);

  /// Serializes this InfringementTable to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfringementTable&&(identical(other.rulesVersion, rulesVersion) || other.rulesVersion == rulesVersion)&&(identical(other.sourceRule, sourceRule) || other.sourceRule == sourceRule)&&const DeepCollectionEquality().equals(other.infringements, infringements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rulesVersion,sourceRule,const DeepCollectionEquality().hash(infringements));

@override
String toString() {
  return 'InfringementTable(rulesVersion: $rulesVersion, sourceRule: $sourceRule, infringements: $infringements)';
}


}

/// @nodoc
abstract mixin class $InfringementTableCopyWith<$Res>  {
  factory $InfringementTableCopyWith(InfringementTable value, $Res Function(InfringementTable) _then) = _$InfringementTableCopyWithImpl;
@useResult
$Res call({
 String rulesVersion, String sourceRule, List<Infringement> infringements
});




}
/// @nodoc
class _$InfringementTableCopyWithImpl<$Res>
    implements $InfringementTableCopyWith<$Res> {
  _$InfringementTableCopyWithImpl(this._self, this._then);

  final InfringementTable _self;
  final $Res Function(InfringementTable) _then;

/// Create a copy of InfringementTable
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rulesVersion = null,Object? sourceRule = null,Object? infringements = null,}) {
  return _then(_self.copyWith(
rulesVersion: null == rulesVersion ? _self.rulesVersion : rulesVersion // ignore: cast_nullable_to_non_nullable
as String,sourceRule: null == sourceRule ? _self.sourceRule : sourceRule // ignore: cast_nullable_to_non_nullable
as String,infringements: null == infringements ? _self.infringements : infringements // ignore: cast_nullable_to_non_nullable
as List<Infringement>,
  ));
}

}


/// Adds pattern-matching-related methods to [InfringementTable].
extension InfringementTablePatterns on InfringementTable {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InfringementTable value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InfringementTable() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InfringementTable value)  $default,){
final _that = this;
switch (_that) {
case _InfringementTable():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InfringementTable value)?  $default,){
final _that = this;
switch (_that) {
case _InfringementTable() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rulesVersion,  String sourceRule,  List<Infringement> infringements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InfringementTable() when $default != null:
return $default(_that.rulesVersion,_that.sourceRule,_that.infringements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rulesVersion,  String sourceRule,  List<Infringement> infringements)  $default,) {final _that = this;
switch (_that) {
case _InfringementTable():
return $default(_that.rulesVersion,_that.sourceRule,_that.infringements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rulesVersion,  String sourceRule,  List<Infringement> infringements)?  $default,) {final _that = this;
switch (_that) {
case _InfringementTable() when $default != null:
return $default(_that.rulesVersion,_that.sourceRule,_that.infringements);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _InfringementTable extends InfringementTable {
  const _InfringementTable({required this.rulesVersion, required this.sourceRule, required final  List<Infringement> infringements}): _infringements = infringements,super._();
  factory _InfringementTable.fromJson(Map<String, dynamic> json) => _$InfringementTableFromJson(json);

@override final  String rulesVersion;
@override final  String sourceRule;
 final  List<Infringement> _infringements;
@override List<Infringement> get infringements {
  if (_infringements is EqualUnmodifiableListView) return _infringements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_infringements);
}


/// Create a copy of InfringementTable
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfringementTableCopyWith<_InfringementTable> get copyWith => __$InfringementTableCopyWithImpl<_InfringementTable>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InfringementTableToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InfringementTable&&(identical(other.rulesVersion, rulesVersion) || other.rulesVersion == rulesVersion)&&(identical(other.sourceRule, sourceRule) || other.sourceRule == sourceRule)&&const DeepCollectionEquality().equals(other._infringements, _infringements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rulesVersion,sourceRule,const DeepCollectionEquality().hash(_infringements));

@override
String toString() {
  return 'InfringementTable(rulesVersion: $rulesVersion, sourceRule: $sourceRule, infringements: $infringements)';
}


}

/// @nodoc
abstract mixin class _$InfringementTableCopyWith<$Res> implements $InfringementTableCopyWith<$Res> {
  factory _$InfringementTableCopyWith(_InfringementTable value, $Res Function(_InfringementTable) _then) = __$InfringementTableCopyWithImpl;
@override @useResult
$Res call({
 String rulesVersion, String sourceRule, List<Infringement> infringements
});




}
/// @nodoc
class __$InfringementTableCopyWithImpl<$Res>
    implements _$InfringementTableCopyWith<$Res> {
  __$InfringementTableCopyWithImpl(this._self, this._then);

  final _InfringementTable _self;
  final $Res Function(_InfringementTable) _then;

/// Create a copy of InfringementTable
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rulesVersion = null,Object? sourceRule = null,Object? infringements = null,}) {
  return _then(_InfringementTable(
rulesVersion: null == rulesVersion ? _self.rulesVersion : rulesVersion // ignore: cast_nullable_to_non_nullable
as String,sourceRule: null == sourceRule ? _self.sourceRule : sourceRule // ignore: cast_nullable_to_non_nullable
as String,infringements: null == infringements ? _self._infringements : infringements // ignore: cast_nullable_to_non_nullable
as List<Infringement>,
  ));
}


}

// dart format on
