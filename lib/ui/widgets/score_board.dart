import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game_provider/game_provider.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({super.key});

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Hero(
      tag: 'score-board',
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 400),
        child: Material(
          color: Colors.white10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPlayerScore(
                  'Player X:',
                  gameProvider.cache.xWins.toString(),
                ),
                _buildPlayerScore(
                  'Player O:',
                  gameProvider.cache.oWins.toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerScore(String label, String score) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 12),
        Text(
          score,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
