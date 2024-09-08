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
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    reverseDuration: const Duration(milliseconds: 300),
  );

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (timestamp) => _animationController.forward(),
    );
  }

  void _onTap() {
    if(_animationController.isAnimating) return;

    _animationController.reverse().then(
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
        animation: _animationController,
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
                  child: _fadeIn(
                    begin: 0.3,
                    end: 1,
                    child: PlayButton(onTap: _onTap),
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
        parent: _animationController,
        curve: Interval(begin, end, curve: Curves.ease),
      ),
    );

    final opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
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

// @override
// void dispose() {
//   super.dispose();
//   _animationController.dispose();
// }
}
