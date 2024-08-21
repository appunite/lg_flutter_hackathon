// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'players_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayersEntity {
  double get healthPoints => throw _privateConstructorUsedError;
  int get numberOfPlayers => throw _privateConstructorUsedError;
  int get damage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayersEntityCopyWith<PlayersEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayersEntityCopyWith<$Res> {
  factory $PlayersEntityCopyWith(
          PlayersEntity value, $Res Function(PlayersEntity) then) =
      _$PlayersEntityCopyWithImpl<$Res, PlayersEntity>;
  @useResult
  $Res call({double healthPoints, int numberOfPlayers, int damage});
}

/// @nodoc
class _$PlayersEntityCopyWithImpl<$Res, $Val extends PlayersEntity>
    implements $PlayersEntityCopyWith<$Res> {
  _$PlayersEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? healthPoints = null,
    Object? numberOfPlayers = null,
    Object? damage = null,
  }) {
    return _then(_value.copyWith(
      healthPoints: null == healthPoints
          ? _value.healthPoints
          : healthPoints // ignore: cast_nullable_to_non_nullable
              as double,
      numberOfPlayers: null == numberOfPlayers
          ? _value.numberOfPlayers
          : numberOfPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      damage: null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayersEntityImplCopyWith<$Res>
    implements $PlayersEntityCopyWith<$Res> {
  factory _$$PlayersEntityImplCopyWith(
          _$PlayersEntityImpl value, $Res Function(_$PlayersEntityImpl) then) =
      __$$PlayersEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double healthPoints, int numberOfPlayers, int damage});
}

/// @nodoc
class __$$PlayersEntityImplCopyWithImpl<$Res>
    extends _$PlayersEntityCopyWithImpl<$Res, _$PlayersEntityImpl>
    implements _$$PlayersEntityImplCopyWith<$Res> {
  __$$PlayersEntityImplCopyWithImpl(
      _$PlayersEntityImpl _value, $Res Function(_$PlayersEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? healthPoints = null,
    Object? numberOfPlayers = null,
    Object? damage = null,
  }) {
    return _then(_$PlayersEntityImpl(
      healthPoints: null == healthPoints
          ? _value.healthPoints
          : healthPoints // ignore: cast_nullable_to_non_nullable
              as double,
      numberOfPlayers: null == numberOfPlayers
          ? _value.numberOfPlayers
          : numberOfPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      damage: null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PlayersEntityImpl implements _PlayersEntity {
  const _$PlayersEntityImpl(
      {required this.healthPoints,
      required this.numberOfPlayers,
      required this.damage});

  @override
  final double healthPoints;
  @override
  final int numberOfPlayers;
  @override
  final int damage;

  @override
  String toString() {
    return 'PlayersEntity(healthPoints: $healthPoints, numberOfPlayers: $numberOfPlayers, damage: $damage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayersEntityImpl &&
            (identical(other.healthPoints, healthPoints) ||
                other.healthPoints == healthPoints) &&
            (identical(other.numberOfPlayers, numberOfPlayers) ||
                other.numberOfPlayers == numberOfPlayers) &&
            (identical(other.damage, damage) || other.damage == damage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, healthPoints, numberOfPlayers, damage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayersEntityImplCopyWith<_$PlayersEntityImpl> get copyWith =>
      __$$PlayersEntityImplCopyWithImpl<_$PlayersEntityImpl>(this, _$identity);
}

abstract class _PlayersEntity implements PlayersEntity {
  const factory _PlayersEntity(
      {required final double healthPoints,
      required final int numberOfPlayers,
      required final int damage}) = _$PlayersEntityImpl;

  @override
  double get healthPoints;
  @override
  int get numberOfPlayers;
  @override
  int get damage;
  @override
  @JsonKey(ignore: true)
  _$$PlayersEntityImplCopyWith<_$PlayersEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
