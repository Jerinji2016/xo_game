import '../enum/player.dart';

class GameResult {
  GameResult.winner({
    required Player this.winner,
    required List<int> this.winCondition,
  });

  GameResult.draw()
      : winner = null,
        winCondition = null;

  final Player? winner;
  final List<int>? winCondition;
}
