import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../widgets/logo.dart';
import '../widgets/play_button.dart';
import '../widgets/score_board.dart';
import 'game_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
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
          (value) => Navigator.pushReplacement(
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
                  child: _fadeIn(
                    begin: 0,
                    end: 0.7,
                    child: const ScoreBoard(),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _exitController,
                    builder: (context, child) => _fadeOut(child: child!),
                    child: _fadeIn(
                      begin: 0.3,
                      end: 1,
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

  Widget _fadeIn({required double begin, required double end, required Widget child}) {
    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 30),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: Interval(begin, end, curve: Curves.ease),
      ),
    );

    final opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: Interval(begin, end, curve: Curves.ease),
      ),
    );

    return Opacity(
      opacity: opacityAnimation.value,
      child: Transform.translate(
        offset: offsetAnimation.value,
        child: child,
      ),
    );
  }

  Widget _fadeOut({required Widget child}) {
    final offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 30),
    ).animate(
      CurvedAnimation(
        parent: _exitController,
        curve: Curves.ease,
      ),
    );

    final opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _exitController,
        curve: Curves.ease,
      ),
    );

    return Opacity(
      opacity: opacityAnimation.value,
      child: Transform.translate(
        offset: offsetAnimation.value,
        child: child,
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
