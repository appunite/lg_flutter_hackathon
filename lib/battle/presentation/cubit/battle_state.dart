part of 'battle_cubit.dart';

@freezed
class BattleState with _$BattleState {
  const factory BattleState.loaded({
    required double currentPlayersHealthPoints,
    required double currentMonsterHealthPoints,
    required int currentPlayerIndex,
  }) = _Loaded;

  const factory BattleState.monsterAttack() = _MonsterAttack;

  const factory BattleState.playerAttack() = _PlayerAttack;

  const factory BattleState.gameOver() = _GameOver;

  const factory BattleState.victory() = _Victory;
}
