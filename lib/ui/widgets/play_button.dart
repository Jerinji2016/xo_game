import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../config/theme_config.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 100)
  );

  void _onHover(bool isHovered) => isHovered ? _animationController.forward() : _animationController.reverse();

  Animation<Alignment> _getAlignmentAnimation(Alignment begin, Alignment end) => AlignmentTween(
        begin: begin,
        end: end,
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final beginValue = _getAlignmentAnimation(
            const Alignment(0.2, -1),
            Alignment.topLeft,
          ).value;

          final endValue = _getAlignmentAnimation(
            Alignment.bottomCenter,
            Alignment.bottomRight,
          ).value;

          return GlassmorphicContainer(
            width: 280,
            height: 90,
            blur: 3,
            border: 2,
            borderRadius: 16,
            linearGradient: LinearGradient(
              begin: beginValue,
              end: endValue,
              colors: [
                darkPrimary.withOpacity(0.3),
                accentColor.withOpacity(0.3),
              ],
            ),
            borderGradient: LinearGradient(
              begin: beginValue,
              end: endValue,
              colors: [
                Colors.purple.withOpacity(0.6),
                accentColor,
              ],
            ),
            child: child,
          );
        },
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            onHover: _onHover,
            highlightColor: Colors.white.withOpacity(0.05),
            splashColor: Colors.white10,
            borderRadius: BorderRadius.circular(16),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 48),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Play',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.dispose();
  }
}
