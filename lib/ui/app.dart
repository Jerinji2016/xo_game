import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../config/asset_config.dart';
import '../enum/game_state.dart';
import '../game_provider/game_provider.dart';
import 'widgets/game_result.dart';
import 'widgets/play_area.dart';
import 'widgets/play_button.dart';
import 'widgets/primary_button.dart';
import 'widgets/score_board.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: _buildLogo(),
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: ScoreBoard(),
                ),
              ),
              const GameBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SvgPicture.asset(
            Assets.logo,
            height: 48,
            colorFilter: const ColorFilter.mode(
              Color(0xFFF1F1F1),
              BlendMode.srcIn,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'XO GAME',
            style: TextStyle(
              fontSize: 48,
              color: Color(0xFFF1F1F1),
            ),
          ),
        ),
      ],
    );
  }
}

class GameBody extends StatelessWidget {
  const GameBody({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    int flex;
    Widget child;
    switch (gameProvider.gameState) {
      case GameState.menu:
        flex = 2;
        child = const PlayButton();

      case GameState.inGame:
        flex = 5;
        child = Column(
          children: [
            const Expanded(
              child: PlayArea(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: PrimaryButton(
                text: 'Go Back',
                onTap: Provider.of<GameProvider>(context).returnToMenu,
              ),
            ),
          ],
        );

      case GameState.result:
        flex = 3;
        child = const GameResult();
    }

    return Expanded(
      flex: flex,
      child: Center(
        child: child,
      ),
    );
  }
}
