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
    required TResult Function() initial,
    required TResult Function(int playersHealthPoints) loaded,
    required TResult Function(int damage) monsterAttack,
    required TResult Function(int damage) playerAttack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int playersHealthPoints)? loaded,
    TResult? Function(int damage)? monsterAttack,
    TResult? Function(int damage)? playerAttack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int playersHealthPoints)? loaded,
    TResult Function(int damage)? monsterAttack,
    TResult Function(int damage)? playerAttack,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_MonsterAttack value) monsterAttack,
    required TResult Function(_PlayerAttack value) playerAttack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_MonsterAttack value)? monsterAttack,
    TResult? Function(_PlayerAttack value)? playerAttack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$BattleStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'BattleState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int playersHealthPoints) loaded,
    required TResult Function(int damage) monsterAttack,
    required TResult Function(int damage) playerAttack,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int playersHealthPoints)? loaded,
    TResult? Function(int damage)? monsterAttack,
    TResult? Function(int damage)? playerAttack,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int playersHealthPoints)? loaded,
    TResult Function(int damage)? monsterAttack,
    TResult Function(int damage)? playerAttack,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_MonsterAttack value) monsterAttack,
    required TResult Function(_PlayerAttack value) playerAttack,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_MonsterAttack value)? monsterAttack,
    TResult? Function(_PlayerAttack value)? playerAttack,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_MonsterAttack value)? monsterAttack,
    TResult Function(_PlayerAttack value)? playerAttack,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements BattleState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int playersHealthPoints});
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
    Object? playersHealthPoints = null,
  }) {
    return _then(_$LoadedImpl(
      playersHealthPoints: null == playersHealthPoints
          ? _value.playersHealthPoints
          : playersHealthPoints // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({required this.playersHealthPoints});

  @override
  final int playersHealthPoints;

  @override
  String toString() {
    return 'BattleState.loaded(playersHealthPoints: $playersHealthPoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.playersHealthPoints, playersHealthPoints) ||
                other.playersHealthPoints == playersHealthPoints));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playersHealthPoints);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int playersHealthPoints) loaded,
    required TResult Function(int damage) monsterAttack,
    required TResult Function(int damage) playerAttack,
  }) {
    return loaded(playersHealthPoints);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int playersHealthPoints)? loaded,
    TResult? Function(int damage)? monsterAttack,
    TResult? Function(int damage)? playerAttack,
  }) {
    return loaded?.call(playersHealthPoints);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int playersHealthPoints)? loaded,
    TResult Function(int damage)? monsterAttack,
    TResult Function(int damage)? playerAttack,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(playersHealthPoints);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_MonsterAttack value) monsterAttack,
    required TResult Function(_PlayerAttack value) playerAttack,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_MonsterAttack value)? monsterAttack,
    TResult? Function(_PlayerAttack value)? playerAttack,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
  const factory _Loaded({required final int playersHealthPoints}) =
      _$LoadedImpl;

  int get playersHealthPoints;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MonsterAttackImplCopyWith<$Res> {
  factory _$$MonsterAttackImplCopyWith(
          _$MonsterAttackImpl value, $Res Function(_$MonsterAttackImpl) then) =
      __$$MonsterAttackImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int damage});
}

/// @nodoc
class __$$MonsterAttackImplCopyWithImpl<$Res>
    extends _$BattleStateCopyWithImpl<$Res, _$MonsterAttackImpl>
    implements _$$MonsterAttackImplCopyWith<$Res> {
  __$$MonsterAttackImplCopyWithImpl(
      _$MonsterAttackImpl _value, $Res Function(_$MonsterAttackImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? damage = null,
  }) {
    return _then(_$MonsterAttackImpl(
      damage: null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MonsterAttackImpl implements _MonsterAttack {
  const _$MonsterAttackImpl({required this.damage});

  @override
  final int damage;

  @override
  String toString() {
    return 'BattleState.monsterAttack(damage: $damage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonsterAttackImpl &&
            (identical(other.damage, damage) || other.damage == damage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, damage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonsterAttackImplCopyWith<_$MonsterAttackImpl> get copyWith =>
      __$$MonsterAttackImplCopyWithImpl<_$MonsterAttackImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int playersHealthPoints) loaded,
    required TResult Function(int damage) monsterAttack,
    required TResult Function(int damage) playerAttack,
  }) {
    return monsterAttack(damage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int playersHealthPoints)? loaded,
    TResult? Function(int damage)? monsterAttack,
    TResult? Function(int damage)? playerAttack,
  }) {
    return monsterAttack?.call(damage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int playersHealthPoints)? loaded,
    TResult Function(int damage)? monsterAttack,
    TResult Function(int damage)? playerAttack,
    required TResult orElse(),
  }) {
    if (monsterAttack != null) {
      return monsterAttack(damage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_MonsterAttack value) monsterAttack,
    required TResult Function(_PlayerAttack value) playerAttack,
  }) {
    return monsterAttack(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_MonsterAttack value)? monsterAttack,
    TResult? Function(_PlayerAttack value)? playerAttack,
  }) {
    return monsterAttack?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
  const factory _MonsterAttack({required final int damage}) =
      _$MonsterAttackImpl;

  int get damage;
  @JsonKey(ignore: true)
  _$$MonsterAttackImplCopyWith<_$MonsterAttackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PlayerAttackImplCopyWith<$Res> {
  factory _$$PlayerAttackImplCopyWith(
          _$PlayerAttackImpl value, $Res Function(_$PlayerAttackImpl) then) =
      __$$PlayerAttackImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int damage});
}

/// @nodoc
class __$$PlayerAttackImplCopyWithImpl<$Res>
    extends _$BattleStateCopyWithImpl<$Res, _$PlayerAttackImpl>
    implements _$$PlayerAttackImplCopyWith<$Res> {
  __$$PlayerAttackImplCopyWithImpl(
      _$PlayerAttackImpl _value, $Res Function(_$PlayerAttackImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? damage = null,
  }) {
    return _then(_$PlayerAttackImpl(
      damage: null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PlayerAttackImpl implements _PlayerAttack {
  const _$PlayerAttackImpl({required this.damage});

  @override
  final int damage;

  @override
  String toString() {
    return 'BattleState.playerAttack(damage: $damage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerAttackImpl &&
            (identical(other.damage, damage) || other.damage == damage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, damage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerAttackImplCopyWith<_$PlayerAttackImpl> get copyWith =>
      __$$PlayerAttackImplCopyWithImpl<_$PlayerAttackImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int playersHealthPoints) loaded,
    required TResult Function(int damage) monsterAttack,
    required TResult Function(int damage) playerAttack,
  }) {
    return playerAttack(damage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int playersHealthPoints)? loaded,
    TResult? Function(int damage)? monsterAttack,
    TResult? Function(int damage)? playerAttack,
  }) {
    return playerAttack?.call(damage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int playersHealthPoints)? loaded,
    TResult Function(int damage)? monsterAttack,
    TResult Function(int damage)? playerAttack,
    required TResult orElse(),
  }) {
    if (playerAttack != null) {
      return playerAttack(damage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_MonsterAttack value) monsterAttack,
    required TResult Function(_PlayerAttack value) playerAttack,
  }) {
    return playerAttack(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_MonsterAttack value)? monsterAttack,
    TResult? Function(_PlayerAttack value)? playerAttack,
  }) {
    return playerAttack?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
  const factory _PlayerAttack({required final int damage}) = _$PlayerAttackImpl;

  int get damage;
  @JsonKey(ignore: true)
  _$$PlayerAttackImplCopyWith<_$PlayerAttackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
