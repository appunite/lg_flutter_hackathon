import 'package:freezed_annotation/freezed_annotation.dart';

part 'players_entity.freezed.dart';

@freezed
class PlayersEntity with _$PlayersEntity {
  const factory PlayersEntity({
    required double healthPoints,
    required int numberOfPlayers,
    required int damage,
  }) = _PlayersEntity;
}
