import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../transition_mixin/fade_transition.mixin.dart';
import '../widgets/logo.dart';
import '../widgets/play_button.dart';
import '../widgets/score_board.dart';
import 'game_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin, FadeTransitionMixin {
  late final _entryController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  late final _exitController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (timestamp) => _entryController.forward(),
    );
  }

  void _onTap() {
    if (_exitController.isAnimating) return;

    _exitController.reverse().then(
          (value) => Navigator.push(
            context,
            CupertinoPageRoute<void>(
              builder: (context) => const GamePage(),
            ),
          ),
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
              Expanded(
                child: Center(
                  child: fadeIn(
                    controller: _entryController,
                    end: 0.7,
                    child: const ScoreBoard(),
                  ),
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
                      begin: 0.3,
                      child: PlayButton(onTap: _onTap),
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
