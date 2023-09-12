import 'package:flutter/cupertino.dart';
import 'package:xo_game/constants.dart';
import 'package:xo_game/enum/cell_type.dart';
import 'package:xo_game/enum/player.dart';

class GameResult {
  final CellType? winner;
  final bool isDraw;

  GameResult.draw()
      : isDraw = true,
        winner = null;

  GameResult.withResult(this.winner) : isDraw = false;

  @override
  String toString() {
    if (isDraw) return "GameResult: Draw";
    return "GameResult: Winner (${winner?.value})";
  }
}

class GameProvider extends ChangeNotifier {
  static final GameProvider _mInstance = GameProvider._internal();

  factory GameProvider() => _mInstance;

  Player _currentPlayer = Player.first;

  final Map<Player, CellType> _playerHand = {Player.first: CellType.o, Player.second: CellType.x};

  final Map<int, CellType> _cellValues = {
    0: CellType.empty,
    1: CellType.empty,
    2: CellType.empty,
    3: CellType.empty,
    4: CellType.empty,
    5: CellType.empty,
    6: CellType.empty,
    7: CellType.empty,
    8: CellType.empty,
  };

  GameProvider._internal();

  void reset() {
    for (var key in _cellValues.keys) {
      _cellValues[key] = CellType.empty;
    }
  }

  CellType valueInCell(int index) => _cellValues[index]!;

  void markCell(BuildContext context, int index) {
    CellType cellValueType = _cellValues[index]!;
    if (cellValueType.value.isNotEmpty) return;

    //  set cell value
    _cellValues[index] = _playerHand[_currentPlayer]!;

    //  switch player turn
    _currentPlayer = _playerHand.keys.firstWhere(
      (element) => element != _currentPlayer,
    );

    //  evaluate win
    _evaluate(context);

    notifyListeners();
  }

  void _evaluate(BuildContext context) {
    for (Iterable<int> winCondition in winConditions) {
      Iterable<CellType> row = winCondition.map((e) => _cellValues[e]!);
      bool hasValidRow = row.every(
        (element) => element != CellType.empty && element == row.first,
      );
      if (hasValidRow) {
        GameResult result = GameResult.withResult(row.first);
        debugPrint("GameProvider._evaluate: $result");
        return;
      }
    }

    bool isEveryCellMarked = _cellValues.values.every(
      (element) => element != CellType.empty,
    );
    if (isEveryCellMarked) {
      GameResult result = GameResult.draw();
      debugPrint("GameProvider._evaluate: $result");
    }
  }

  void _endRound() {}
}
