import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../config/shared_pref_config.dart';
import '../enum/player.dart';
import '../modals/game_cache.dart';
import '../modals/game_result.dart';
import '../ui/pages/game_page.dart';
import '../ui/pages/result_page.dart';

part 'constants.dart';

const kGameCacheKey = 'game-cache';

class GameProvider extends ChangeNotifier {
  GameProvider() {
    final cache = sharedPreferences.get(kGameCacheKey);
    if (cache == null) return;

    final json = Map<String, int?>.from(jsonDecode(cache as String) as Map);
    _gameCache = GameCache.fromJson(json);
  }

  GameCache _gameCache = GameCache();

  GameCache get cache => _gameCache;

  late final _cellValues = Map<int, Player?>.from(kDefaultCell);

  int _playerIndex = 0;

  Player? getCellValue(int index) => _cellValues[index];

  GameResult? _gameResult;

  GameResult? get gameResult => _gameResult;

  void reset() {
    _cellValues
      ..clear()
      ..addAll(kDefaultCell);
    _gameResult = null;
    _playerIndex = 0;
    notifyListeners();
  }

  void _saveWinnerResult(Player player) {
    _gameCache = GameCache(
      xWins: player == Player.x ? _gameCache.xWins + 1 : _gameCache.xWins,
      oWins: player == Player.o ? _gameCache.oWins + 1 : _gameCache.oWins,
    );
    sharedPreferences.setString(kGameCacheKey, jsonEncode(_gameCache.toJson()));
  }

  void onCellTapped(BuildContext context, int index) {
    _cellValues[index] = Player.values.elementAt(_playerIndex);
    final canContinue = _evaluate();
    if (!canContinue) {
      final player = Player.values[_playerIndex];
      _saveWinnerResult(player);

      final state = context.findAncestorStateOfType<GamePageState>();

      void onComplete() => Navigator.of(context).push(
            CupertinoPageRoute<void>(
              builder: (context) => const ResultPage(),
            ),
          );

      if (state != null) {
        state.exitAnimation(onComplete);
      } else {
        onComplete();
      }
      return;
    }

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
      notifyListeners();
      return false;
    }

    if (nonNullValues.length == 9) {
      notifyListeners();
      _gameResult = GameResult.draw();
      return false;
    }

    return index == -1;
  }
}
