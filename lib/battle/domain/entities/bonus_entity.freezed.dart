// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bonus_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BonusEntity {
  BonusEnum get type => throw _privateConstructorUsedError;
  int get strength => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BonusEntityCopyWith<BonusEntity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonusEntityCopyWith<$Res> {
  factory $BonusEntityCopyWith(BonusEntity value, $Res Function(BonusEntity) then) =
      _$BonusEntityCopyWithImpl<$Res, BonusEntity>;
  @useResult
  $Res call({BonusEnum type, int strength});
}

/// @nodoc
class _$BonusEntityCopyWithImpl<$Res, $Val extends BonusEntity> implements $BonusEntityCopyWith<$Res> {
  _$BonusEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? strength = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BonusEnum,
      strength: null == strength
          ? _value.strength
          : strength // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BonusEntityImplCopyWith<$Res> implements $BonusEntityCopyWith<$Res> {
  factory _$$BonusEntityImplCopyWith(_$BonusEntityImpl value, $Res Function(_$BonusEntityImpl) then) =
      __$$BonusEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BonusEnum type, int strength});
}

/// @nodoc
class __$$BonusEntityImplCopyWithImpl<$Res> extends _$BonusEntityCopyWithImpl<$Res, _$BonusEntityImpl>
    implements _$$BonusEntityImplCopyWith<$Res> {
  __$$BonusEntityImplCopyWithImpl(_$BonusEntityImpl _value, $Res Function(_$BonusEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? strength = null,
  }) {
    return _then(_$BonusEntityImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BonusEnum,
      strength: null == strength
          ? _value.strength
          : strength // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BonusEntityImpl implements _BonusEntity {
  const _$BonusEntityImpl({required this.type, required this.strength});

  @override
  final BonusEnum type;
  @override
  final int strength;

  @override
  String toString() {
    return 'BonusEntity(type: $type, strength: $strength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BonusEntityImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.strength, strength) || other.strength == strength));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, strength);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BonusEntityImplCopyWith<_$BonusEntityImpl> get copyWith =>
      __$$BonusEntityImplCopyWithImpl<_$BonusEntityImpl>(this, _$identity);
}

abstract class _BonusEntity implements BonusEntity {
  const factory _BonusEntity({required final BonusEnum type, required final int strength}) = _$BonusEntityImpl;

  @override
  BonusEnum get type;
  @override
  int get strength;
  @override
  @JsonKey(ignore: true)
  _$$BonusEntityImplCopyWith<_$BonusEntityImpl> get copyWith => throw _privateConstructorUsedError;
}
