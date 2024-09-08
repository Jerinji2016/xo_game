import 'package:flutter/material.dart';

class FadeInTransition extends StatelessWidget {
  const FadeInTransition({
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
      begin: const Offset(0, 30),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(begin, end, curve: Curves.ease),
      ),
    );

    final opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
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
