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
          const BattleState.loaded(playersHealthPoints: 100),
        );

  final LevelEnum _level;
  final PlayersEntity players;

  void monsterAttack() {
    final currentState = state;

    emit(
      BattleState.monsterAttack(damage: _level.monster.damage),
    );

    emit(currentState);
  }

  void playerAttack({required double accuracy}) {
    final currentState = state;

    final int damageWithAccuracy = (players.damage * accuracy).floor();
    emit(BattleState.playerAttack(damage: damageWithAccuracy));

    emit(currentState);
  }
}
