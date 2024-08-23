import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/game_results_player_entity.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/level_enum.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/players_entity.dart';
import 'package:lg_flutter_hackathon/dependencies.dart';
import 'package:lg_flutter_hackathon/utils/storage.dart';

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

  final gameResultPlayerStorage = sl<GameResultPlayerStorage>();

  void playerAttack({required double accuracy}) {
    state.mapOrNull(
      loaded: (result) async {
        emit(const BattleState.playerAttack());
        final damage = _players.damage * accuracy / 1000;
        var monsterHealthPointsAfterDamage = result.currentMonsterHealthPoints - damage;

        final nextPlayerIndex =
            result.currentPlayerIndex == _players.numberOfPlayers - 1 ? 0 : result.currentPlayerIndex + 1;
        final monsterHealthPointsAfterHit = monsterHealthPointsAfterDamage <= 0 ? 0.0 : monsterHealthPointsAfterDamage;

        updateStats(result, accuracy);

        emit(
          result.copyWith(
            currentMonsterHealthPoints: monsterHealthPointsAfterHit,
            currentPlayerIndex: nextPlayerIndex,
          ),
        );
      },
    );
  }

  Future<void> updateStats(result, double accuracy) async {
    final stats = await gameResultPlayerStorage.getGameResultPlayer;
    final playerStat = stats.firstWhere((stat) => stat.playerId == result.currentPlayerIndex,
        orElse: () => GameResultPlayer(playerId: result.currentPlayerIndex, accuracies: []));

    final updatedPlayerStat =
        GameResultPlayer(playerId: result.currentPlayerIndex, accuracies: [...playerStat.accuracies, accuracy]);

    final newStats = [
      ...stats..removeWhere((el) => el.playerId == result.currentPlayerIndex),
    ]..insert(result.currentPlayerIndex, updatedPlayerStat);

    gameResultPlayerStorage.setGameResultPlayer(newStats);
  }
}
