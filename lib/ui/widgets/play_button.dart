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
  bool _isHovered = false;

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: _isHovered ? 20 :10,
      shadowColor: _isHovered ? Colors.grey.shade600 : Colors.grey.shade800,
      borderRadius: BorderRadius.circular(16),
      child: GlassmorphicContainer(
        width: 280,
        height: 90,
        blur: 3,
        border: 2,
        borderRadius: 16,
        linearGradient: LinearGradient(
          begin: _isHovered ? const Alignment(0.2, -1) : Alignment.topLeft,
          end: _isHovered ? Alignment.bottomCenter : Alignment.bottomRight,
          colors: const [
            darkPrimary,
            darkPrimary,
            accentColor,
          ],
        ),
        borderGradient: LinearGradient(
          begin: _isHovered ? const Alignment(0.2, -1) : Alignment.topLeft,
          end: _isHovered ? Alignment.bottomCenter : Alignment.bottomRight,
          colors: const [
            darkPrimary,
            darkPrimary,
            accentColor,
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            onHover: (hover) => setState(() => _isHovered = hover),
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

    if(_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.dispose();
  }
}