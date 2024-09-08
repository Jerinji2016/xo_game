import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game_provider/game_provider.dart';
import '../widgets/logo.dart';
import '../widgets/play_area.dart';
import '../widgets/primary_button.dart';
import '../widgets/score_board.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  void _onBackTapped() {
    Provider.of<GameProvider>(context, listen: false).returnToMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Expanded(
          flex: 3,
          child: Center(
            child: PlayArea(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: PrimaryButton(
            text: 'Go Back',
            onTap: _onBackTapped,
          ),
        ),
      ],
    );
  }
}
