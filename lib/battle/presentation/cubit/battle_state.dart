part of 'battle_cubit.dart';

@freezed
class BattleState with _$BattleState {
  const factory BattleState.initial() = _Initial;

  const factory BattleState.loaded({
    required int playersHealthPoints,
  }) = _Loaded;

  const factory BattleState.monsterAttack({
    required int damage,
  }) = _MonsterAttack;

  const factory BattleState.playerAttack({
    required int damage,
  }) = _PlayerAttack;
}
