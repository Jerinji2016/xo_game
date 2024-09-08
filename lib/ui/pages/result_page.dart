import 'package:flutter/material.dart';

import '../widgets/game_result.dart';
import '../widgets/logo.dart';
import '../widgets/score_board.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: Center(
            child: Logo(),
          ),
        ),
        Expanded(
          child: Center(
            child: ScoreBoard(),
          ),
        ),
        Expanded(
          child: Center(
            child: GameResult(),
          ),
        ),
      ],
    );
  }
}
