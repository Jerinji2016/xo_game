import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../game_provider/game_provider.dart';
import '../transition_mixin/fade_transition.mixin.dart';
import '../widgets/logo.dart';
import '../widgets/play_area.dart';
import '../widgets/primary_button.dart';
import '../widgets/score_board.dart';

typedef GamePageState = _GamePageState;

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin, FadeTransitionMixin {
  late final _entryController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  late final _exitController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timestamp) {
        Provider.of<GameProvider>(context, listen: false).reset();
        _entryController.forward();
      },
    );
  }

  void exitAnimation(VoidCallback onAnimationComplete) {
    if (_exitController.isAnimating) return;

    _exitController.forward().then(
      (value) async {
        onAnimationComplete();
        await Future<void>.delayed(const Duration(milliseconds: 800));
        if (mounted) {
          _exitController.reset();
        }
      },
    );
  }

  void _onBackTapped() => exitAnimation(
        Navigator.of(context).pop,
      );

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
                flex: 3,
                child: Center(
                  child: fadeIn(
                    controller: _entryController,
                    end: 0.7,
                    child: AnimatedBuilder(
                      animation: _exitController,
                      builder: (context, child) => fadeOut(
                        controller: _exitController,
                        child: child!,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(24),
                        child: PlayArea(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AnimatedBuilder(
                  animation: _exitController,
                  builder: (context, child) => fadeOut(
                    controller: _exitController,
                    child: child!,
                  ),
                  child: fadeIn(
                    controller: _entryController,
                    begin: 0.3,
                    child: PrimaryButton(
                      text: 'Go Back',
                      onTap: _onBackTapped,
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
