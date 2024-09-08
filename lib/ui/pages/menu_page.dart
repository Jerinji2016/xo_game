import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game_provider/game_provider.dart';
import '../widgets/logo.dart';
import '../widgets/play_button.dart';
import '../widgets/score_board.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  void _onTap() {
    // to-do: animation
    Provider.of<GameProvider>(context, listen: false).onPlayTapped();
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
        Expanded(
          child: Center(
            child: PlayButton(
              onTap: _onTap,
            ),
          ),
        ),
      ],
    );
  }
}
