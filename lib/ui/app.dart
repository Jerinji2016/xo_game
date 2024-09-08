import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/game_state.dart';
import '../game_provider/game_provider.dart';
import 'pages/game_page.dart';
import 'pages/menu_page.dart';
import 'pages/result_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final gameState = gameProvider.gameState;

    return Scaffold(
      body: Builder(
        builder: (context) {
          switch (gameState) {
            case GameState.menu:
              return const MenuPage();
            case GameState.inGame:
              return const GamePage();
            case GameState.result:
              return const ResultPage();
          }
        },
      ),
    );
  }
}
