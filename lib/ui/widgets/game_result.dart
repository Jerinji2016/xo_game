import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game_provider/game_provider.dart';
import 'primary_button.dart';

class GameResult extends StatelessWidget {
  const GameResult({
    required this.onPlayAgainTapped,
    required this.onGoToMenuTapped,
    super.key,
  });

  final VoidCallback onPlayAgainTapped;
  final VoidCallback onGoToMenuTapped;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    final gameResult = gameProvider.gameResult!;

    final winner = gameResult.winner;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          winner == null ? "It's a Draw" : 'Player ${winner.value} Wins!',
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          runSpacing: 24,
          spacing: 24,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            PrimaryButton(
              text: 'Play Again',
              width: 130,
              onTap: onPlayAgainTapped,
            ),
            PrimaryButton(
              text: 'Go To Menu',
              width: 140,
              onTap: onGoToMenuTapped,
            ),
          ],
        ),
      ],
    );
  }
}
