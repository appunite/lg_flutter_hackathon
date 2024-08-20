import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/level_enum.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/players_entity.dart';

part 'battle_cubit.freezed.dart';
part 'battle_state.dart';

class BattleCubit extends Cubit<BattleState> {
  BattleCubit(
    this._level,
    this._players,
  ) : super(
          BattleState.loaded(
            currentMonsterHealthPoints: _level.monster.healthPoints,
            currentPlayersHealthPoints: _players.healthPoints,
            currentPlayerIndex: 0,
          ),
        );

  final LevelEnum _level;
  final PlayersEntity _players;

  void monsterAttack({
    required double accuracy,
  }) {
    state.mapOrNull(
      loaded: (result) {
        emit(const BattleState.monsterAttack());

        final damageAfterPlayerDefence = (_level.monster.damage * ((100 - accuracy) / 100));
        final playerHealthPointsAfterHit = result.currentPlayersHealthPoints - damageAfterPlayerDefence;

        emit(
          result.copyWith(
            currentPlayersHealthPoints: playerHealthPointsAfterHit <= 0 ? 0 : playerHealthPointsAfterHit,
          ),
        );
      },
    );
  }

  void playerAttack({required double accuracy}) {
    state.mapOrNull(
      loaded: (result) {
        emit(const BattleState.playerAttack());

        final damage = _players.damage * (accuracy / 100);
        final monsterHealthPointsAfterDamage = result.currentMonsterHealthPoints - damage;
        final nextPlayerIndex =
            result.currentPlayerIndex == _players.numberOfPlayers - 1 ? 0 : result.currentPlayerIndex + 1;
        final monsterHealthPointsAfterHit = monsterHealthPointsAfterDamage <= 0 ? 0.0 : monsterHealthPointsAfterDamage;

        emit(
          result.copyWith(
            currentMonsterHealthPoints: monsterHealthPointsAfterHit,
            currentPlayerIndex: nextPlayerIndex,
          ),
        );
      },
    );
  }

  void victory() {
    emit(const BattleState.victory());
  }

  void gameOver() {
    emit(const BattleState.gameOver());
  }
}
