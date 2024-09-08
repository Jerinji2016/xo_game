import 'package:flutter/material.dart';

class FadeOutTransition extends StatelessWidget {
  const FadeOutTransition({
    required this.controller,
    required this.child,
    this.begin = 0,
    this.end = 1,
    super.key,
  });

  final AnimationController controller;
  final double begin;
  final double end;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 30),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(begin, end, curve: Curves.ease),
      ),
    );

    final opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
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
}
