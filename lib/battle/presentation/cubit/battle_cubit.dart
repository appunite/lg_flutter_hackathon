import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/level_enum.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/players_entity.dart';

part 'battle_cubit.freezed.dart';
part 'battle_state.dart';

class BattleCubit extends Cubit<BattleState> {
  BattleCubit(
    this._level,
    this.players,
  ) : super(
          BattleState.loaded(
            currentMonsterHealthPoints: _level.monster.healthPoints,
            currentPlayersHealthPoints: players.healthPoints,
            currentPlayerIndex: 0,
          ),
        );

  final LevelEnum _level;
  final PlayersEntity players;

  void monsterAttack() {
    state.mapOrNull(
      loaded: (result) {
        emit(const BattleState.monsterAttack());

        final playerHealthPointsAfterHit = result.currentPlayersHealthPoints - _level.monster.damage;

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

        final damage = players.damage * (accuracy / ~100);
        final monsterHealthPointsAfterHit = result.currentMonsterHealthPoints - damage;
        final nextPlayerIndex =
            result.currentPlayerIndex == players.numberOfPlayers - 1 ? 0 : result.currentPlayerIndex + 1;

        emit(
          result.copyWith(
            currentMonsterHealthPoints: monsterHealthPointsAfterHit <= 0 ? 0 : monsterHealthPointsAfterHit,
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
