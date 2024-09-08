import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../game_provider/game_provider.dart';
import '../transition_mixin/fade_transition.mixin.dart';
import '../widgets/game_result.dart';
import '../widgets/logo.dart';
import '../widgets/score_board.dart';
import 'menu_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin, FadeTransitionMixin {
  late final _entryController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  late final _exitController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
          (timestamp) => _entryController.forward(),
    );
  }

  void _onPlayAgainTapped() {
    if(_exitController.isAnimating) return;

    _exitController.forward().then(
      (value) {
        Provider.of<GameProvider>(context, listen: false).reset();
        Navigator.of(context).pop();
      },
    );
  }

  void _onBackToMenuTapped() {
    if(_exitController.isAnimating) return;

    _exitController.forward().then(
      (value) {
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute<void>(builder: (context) => const MenuPage()),
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _entryController,
        builder: (context, child) {
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
                  child: AnimatedBuilder(
                    animation: _exitController,
                    builder: (context, child) => fadeOut(
                      controller: _exitController,
                      child: child!,
                    ),
                    child: fadeIn(
                      controller: _entryController,
                      child: GameResult(
                        onPlayAgainTapped: _onPlayAgainTapped,
                        onGoToMenuTapped: _onBackToMenuTapped,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _entryController.dispose();
    _exitController.dispose();
  }
}
