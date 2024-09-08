import 'package:flutter/material.dart';

mixin FadeTransitionMixin {
  Widget fadeIn({
    required AnimationController controller,
    required Widget child,
    double begin = 0,
    double end = 1,
  }) {
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

  Widget fadeOut({
    required AnimationController controller,
    required Widget child,
    double begin = 0,
    double end = 1,
  }) {
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
