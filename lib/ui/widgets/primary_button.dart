import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    required this.onTap,
    this.height = 48,
    this.width = 120,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    super.key,
  });

  final double width;
  final double height;
  final String text;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      height: height,
      width: width,
      borderRadius: 8,
      blur: 3,
      linearGradient: LinearGradient(
        colors: [
          Colors.blue.withOpacity(0.3),
          Colors.purple.withOpacity(0.3),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blue.withOpacity(0.6),
          Colors.purple.withOpacity(0.6),
        ],
      ),
      border: 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.white10,
          highlightColor: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: padding,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
