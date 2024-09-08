import 'package:flutter/material.dart';

import '../widgets/game_result.dart';
import '../widgets/logo.dart';
import '../widgets/score_board.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Logo(),
            ),
          ),
          const Expanded(
            child: Center(
              child: ScoreBoard(),
            ),
          ),
          Expanded(
            child: Center(
              child: GameResult(
                onPlayAgainTapped: () {},
                onGoToMenuTapped: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
