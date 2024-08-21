class GameResultPlayer {
  final int playerId;
  final List<double> accuracies;
  final int attackCount;
  final double averageAccuracy;

  GameResultPlayer({
    required this.playerId,
    required this.accuracies,
  })  : attackCount = accuracies.length,
        averageAccuracy = accuracies.isEmpty ? 0.0 : accuracies.reduce((a, b) => a + b) / accuracies.length;
}
