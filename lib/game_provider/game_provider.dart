import 'package:flutter/cupertino.dart';

import '../enum/game_state.dart';
import '../enum/player.dart';
import '../modals/game_result.dart';

part 'constants.dart';

class GameProvider extends ChangeNotifier {
  late final _cellValues = Map<int, Player?>.from(kDefaultCell);

  int _playerIndex = 0;

  Player? getCellValue(int index) => _cellValues[index];

  GameState _gameState = GameState.menu;

  GameState get gameState => _gameState;

  GameResult? _gameResult;

  GameResult? get gameResult => _gameResult;

  void _reset() {
    _cellValues
      ..clear()
      ..addAll(kDefaultCell);
    _gameResult = null;
    _playerIndex = 0;
  }

  void returnToMenu() {
    _gameState = GameState.menu;
    notifyListeners();
  }

  void onPlayTapped() {
    _reset();
    _gameState = GameState.inGame;
    notifyListeners();
  }

  void onCellTapped(int index) {
    _cellValues[index] = Player.values.elementAt(_playerIndex);
    final canContinue = _evaluate();
    if (!canContinue) return;

    _playerIndex++;
    _playerIndex %= Player.values.length;
    notifyListeners();
  }

  bool _evaluate() {
    final nonNullValues = _cellValues.values.where((a) => a != null);
    if (nonNullValues.length < 5) return true;

    final player = Player.values.elementAt(_playerIndex);
    final index = kWinConditions.indexWhere(
      (condition) => condition.every(
        (e) => _cellValues[e] == player,
      ),
    );

    if (index != -1) {
      final winCondition = kWinConditions[index];
      _gameResult = GameResult.winner(
        winner: player,
        winCondition: winCondition,
      );
      _gameState = GameState.result;
      notifyListeners();
      return false;
    }

    if (nonNullValues.length == 9) {
      notifyListeners();
      _gameResult = GameResult.draw();
      _gameState = GameState.result;
      return false;
    }

    return index == -1;
  }
}
