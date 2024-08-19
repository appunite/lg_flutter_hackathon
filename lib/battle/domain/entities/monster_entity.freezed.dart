// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monster_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MonsterEntity {
  int get speed => throw _privateConstructorUsedError;
  double get healthPoints => throw _privateConstructorUsedError;
  int get damage => throw _privateConstructorUsedError;
  String get attackAnimation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MonsterEntityCopyWith<MonsterEntity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonsterEntityCopyWith<$Res> {
  factory $MonsterEntityCopyWith(MonsterEntity value, $Res Function(MonsterEntity) then) =
      _$MonsterEntityCopyWithImpl<$Res, MonsterEntity>;
  @useResult
  $Res call({int speed, double healthPoints, int damage, String attackAnimation});
}

/// @nodoc
class _$MonsterEntityCopyWithImpl<$Res, $Val extends MonsterEntity> implements $MonsterEntityCopyWith<$Res> {
  _$MonsterEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? healthPoints = null,
    Object? damage = null,
    Object? attackAnimation = null,
  }) {
    return _then(_value.copyWith(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int,
      healthPoints: null == healthPoints
          ? _value.healthPoints
          : healthPoints // ignore: cast_nullable_to_non_nullable
              as double,
      damage: null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as int,
      attackAnimation: null == attackAnimation
          ? _value.attackAnimation
          : attackAnimation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonsterEntityImplCopyWith<$Res> implements $MonsterEntityCopyWith<$Res> {
  factory _$$MonsterEntityImplCopyWith(_$MonsterEntityImpl value, $Res Function(_$MonsterEntityImpl) then) =
      __$$MonsterEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int speed, double healthPoints, int damage, String attackAnimation});
}

/// @nodoc
class __$$MonsterEntityImplCopyWithImpl<$Res> extends _$MonsterEntityCopyWithImpl<$Res, _$MonsterEntityImpl>
    implements _$$MonsterEntityImplCopyWith<$Res> {
  __$$MonsterEntityImplCopyWithImpl(_$MonsterEntityImpl _value, $Res Function(_$MonsterEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? healthPoints = null,
    Object? damage = null,
    Object? attackAnimation = null,
  }) {
    return _then(_$MonsterEntityImpl(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int,
      healthPoints: null == healthPoints
          ? _value.healthPoints
          : healthPoints // ignore: cast_nullable_to_non_nullable
              as double,
      damage: null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as int,
      attackAnimation: null == attackAnimation
          ? _value.attackAnimation
          : attackAnimation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MonsterEntityImpl implements _MonsterEntity {
  const _$MonsterEntityImpl(
      {required this.speed, required this.healthPoints, required this.damage, required this.attackAnimation});

  @override
  final int speed;
  @override
  final double healthPoints;
  @override
  final int damage;
  @override
  final String attackAnimation;

  @override
  String toString() {
    return 'MonsterEntity(speed: $speed, healthPoints: $healthPoints, damage: $damage, attackAnimation: $attackAnimation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonsterEntityImpl &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.healthPoints, healthPoints) || other.healthPoints == healthPoints) &&
            (identical(other.damage, damage) || other.damage == damage) &&
            (identical(other.attackAnimation, attackAnimation) || other.attackAnimation == attackAnimation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, speed, healthPoints, damage, attackAnimation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonsterEntityImplCopyWith<_$MonsterEntityImpl> get copyWith =>
      __$$MonsterEntityImplCopyWithImpl<_$MonsterEntityImpl>(this, _$identity);
}

abstract class _MonsterEntity implements MonsterEntity {
  const factory _MonsterEntity(
      {required final int speed,
      required final double healthPoints,
      required final int damage,
      required final String attackAnimation}) = _$MonsterEntityImpl;

  @override
  int get speed;
  @override
  double get healthPoints;
  @override
  int get damage;
  @override
  String get attackAnimation;
  @override
  @JsonKey(ignore: true)
  _$$MonsterEntityImplCopyWith<_$MonsterEntityImpl> get copyWith => throw _privateConstructorUsedError;
}
