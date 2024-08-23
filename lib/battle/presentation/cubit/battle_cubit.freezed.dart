// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BattleState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)
        loaded,
    required TResult Function() monsterAttack,
    required TResult Function() playerAttack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)?
        loaded,
    TResult? Function()? monsterAttack,
    TResult? Function()? playerAttack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)?
        loaded,
    TResult Function()? monsterAttack,
    TResult Function()? playerAttack,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_MonsterAttack value) monsterAttack,
    required TResult Function(_PlayerAttack value) playerAttack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_MonsterAttack value)? monsterAttack,
    TResult? Function(_PlayerAttack value)? playerAttack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_MonsterAttack value)? monsterAttack,
    TResult Function(_PlayerAttack value)? playerAttack,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleStateCopyWith<$Res> {
  factory $BattleStateCopyWith(
          BattleState value, $Res Function(BattleState) then) =
      _$BattleStateCopyWithImpl<$Res, BattleState>;
}

/// @nodoc
class _$BattleStateCopyWithImpl<$Res, $Val extends BattleState>
    implements $BattleStateCopyWith<$Res> {
  _$BattleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {double currentPlayersHealthPoints,
      double currentMonsterHealthPoints,
      int currentPlayerIndex});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$BattleStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPlayersHealthPoints = null,
    Object? currentMonsterHealthPoints = null,
    Object? currentPlayerIndex = null,
  }) {
    return _then(_$LoadedImpl(
      currentPlayersHealthPoints: null == currentPlayersHealthPoints
          ? _value.currentPlayersHealthPoints
          : currentPlayersHealthPoints // ignore: cast_nullable_to_non_nullable
              as double,
      currentMonsterHealthPoints: null == currentMonsterHealthPoints
          ? _value.currentMonsterHealthPoints
          : currentMonsterHealthPoints // ignore: cast_nullable_to_non_nullable
              as double,
      currentPlayerIndex: null == currentPlayerIndex
          ? _value.currentPlayerIndex
          : currentPlayerIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required this.currentPlayersHealthPoints,
      required this.currentMonsterHealthPoints,
      required this.currentPlayerIndex});

  @override
  final double currentPlayersHealthPoints;
  @override
  final double currentMonsterHealthPoints;
  @override
  final int currentPlayerIndex;

  @override
  String toString() {
    return 'BattleState.loaded(currentPlayersHealthPoints: $currentPlayersHealthPoints, currentMonsterHealthPoints: $currentMonsterHealthPoints, currentPlayerIndex: $currentPlayerIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.currentPlayersHealthPoints,
                    currentPlayersHealthPoints) ||
                other.currentPlayersHealthPoints ==
                    currentPlayersHealthPoints) &&
            (identical(other.currentMonsterHealthPoints,
                    currentMonsterHealthPoints) ||
                other.currentMonsterHealthPoints ==
                    currentMonsterHealthPoints) &&
            (identical(other.currentPlayerIndex, currentPlayerIndex) ||
                other.currentPlayerIndex == currentPlayerIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentPlayersHealthPoints,
      currentMonsterHealthPoints, currentPlayerIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)
        loaded,
    required TResult Function() monsterAttack,
    required TResult Function() playerAttack,
  }) {
    return loaded(currentPlayersHealthPoints, currentMonsterHealthPoints,
        currentPlayerIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)?
        loaded,
    TResult? Function()? monsterAttack,
    TResult? Function()? playerAttack,
  }) {
    return loaded?.call(currentPlayersHealthPoints, currentMonsterHealthPoints,
        currentPlayerIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)?
        loaded,
    TResult Function()? monsterAttack,
    TResult Function()? playerAttack,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(currentPlayersHealthPoints, currentMonsterHealthPoints,
          currentPlayerIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_MonsterAttack value) monsterAttack,
    required TResult Function(_PlayerAttack value) playerAttack,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_MonsterAttack value)? monsterAttack,
    TResult? Function(_PlayerAttack value)? playerAttack,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_MonsterAttack value)? monsterAttack,
    TResult Function(_PlayerAttack value)? playerAttack,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements BattleState {
  const factory _Loaded(
      {required final double currentPlayersHealthPoints,
      required final double currentMonsterHealthPoints,
      required final int currentPlayerIndex}) = _$LoadedImpl;

  double get currentPlayersHealthPoints;
  double get currentMonsterHealthPoints;
  int get currentPlayerIndex;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MonsterAttackImplCopyWith<$Res> {
  factory _$$MonsterAttackImplCopyWith(
          _$MonsterAttackImpl value, $Res Function(_$MonsterAttackImpl) then) =
      __$$MonsterAttackImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MonsterAttackImplCopyWithImpl<$Res>
    extends _$BattleStateCopyWithImpl<$Res, _$MonsterAttackImpl>
    implements _$$MonsterAttackImplCopyWith<$Res> {
  __$$MonsterAttackImplCopyWithImpl(
      _$MonsterAttackImpl _value, $Res Function(_$MonsterAttackImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MonsterAttackImpl implements _MonsterAttack {
  const _$MonsterAttackImpl();

  @override
  String toString() {
    return 'BattleState.monsterAttack()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MonsterAttackImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)
        loaded,
    required TResult Function() monsterAttack,
    required TResult Function() playerAttack,
  }) {
    return monsterAttack();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)?
        loaded,
    TResult? Function()? monsterAttack,
    TResult? Function()? playerAttack,
  }) {
    return monsterAttack?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)?
        loaded,
    TResult Function()? monsterAttack,
    TResult Function()? playerAttack,
    required TResult orElse(),
  }) {
    if (monsterAttack != null) {
      return monsterAttack();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_MonsterAttack value) monsterAttack,
    required TResult Function(_PlayerAttack value) playerAttack,
  }) {
    return monsterAttack(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_MonsterAttack value)? monsterAttack,
    TResult? Function(_PlayerAttack value)? playerAttack,
  }) {
    return monsterAttack?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_MonsterAttack value)? monsterAttack,
    TResult Function(_PlayerAttack value)? playerAttack,
    required TResult orElse(),
  }) {
    if (monsterAttack != null) {
      return monsterAttack(this);
    }
    return orElse();
  }
}

abstract class _MonsterAttack implements BattleState {
  const factory _MonsterAttack() = _$MonsterAttackImpl;
}

/// @nodoc
abstract class _$$PlayerAttackImplCopyWith<$Res> {
  factory _$$PlayerAttackImplCopyWith(
          _$PlayerAttackImpl value, $Res Function(_$PlayerAttackImpl) then) =
      __$$PlayerAttackImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlayerAttackImplCopyWithImpl<$Res>
    extends _$BattleStateCopyWithImpl<$Res, _$PlayerAttackImpl>
    implements _$$PlayerAttackImplCopyWith<$Res> {
  __$$PlayerAttackImplCopyWithImpl(
      _$PlayerAttackImpl _value, $Res Function(_$PlayerAttackImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PlayerAttackImpl implements _PlayerAttack {
  const _$PlayerAttackImpl();

  @override
  String toString() {
    return 'BattleState.playerAttack()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PlayerAttackImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)
        loaded,
    required TResult Function() monsterAttack,
    required TResult Function() playerAttack,
  }) {
    return playerAttack();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)?
        loaded,
    TResult? Function()? monsterAttack,
    TResult? Function()? playerAttack,
  }) {
    return playerAttack?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double currentPlayersHealthPoints,
            double currentMonsterHealthPoints, int currentPlayerIndex)?
        loaded,
    TResult Function()? monsterAttack,
    TResult Function()? playerAttack,
    required TResult orElse(),
  }) {
    if (playerAttack != null) {
      return playerAttack();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_MonsterAttack value) monsterAttack,
    required TResult Function(_PlayerAttack value) playerAttack,
  }) {
    return playerAttack(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_MonsterAttack value)? monsterAttack,
    TResult? Function(_PlayerAttack value)? playerAttack,
  }) {
    return playerAttack?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_MonsterAttack value)? monsterAttack,
    TResult Function(_PlayerAttack value)? playerAttack,
    required TResult orElse(),
  }) {
    if (playerAttack != null) {
      return playerAttack(this);
    }
    return orElse();
  }
}

abstract class _PlayerAttack implements BattleState {
  const factory _PlayerAttack() = _$PlayerAttackImpl;
}
