import 'package:flutter/material.dart';

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

class _PlayButtonState extends State<PlayButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white10,
            blurRadius: 10,
            offset: _isHovered ? const Offset(-5, 5) : const Offset(5, 5),
          )
        ],
        gradient: LinearGradient(
          begin: _isHovered ? Alignment.topCenter : Alignment.topLeft,
          end: _isHovered ? Alignment.bottomCenter : Alignment.bottomRight,
          colors: const [
            darkSecondary,
            darkSecondary,
            accentColor,
          ],
        ),
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
              mainAxisSize: MainAxisSize.min,
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
    );
  }
}
