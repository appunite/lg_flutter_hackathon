import 'package:lg_flutter_hackathon/battle/domain/entities/game_results_player_entity.dart';
import 'package:rxdart/rxdart.dart';

class GameResultPlayerStorage {
  final BehaviorSubject<List<GameResultPlayer>> _gameResultPlayerSubject = BehaviorSubject.seeded([]);

  Future<List<GameResultPlayer>> get getGameResultPlayer async => await _gameResultPlayerSubject.first;

  void setGameResultPlayer(List<GameResultPlayer> stats) => _gameResultPlayerSubject.add(stats);

  void clear() => _gameResultPlayerSubject.add([]);
}
