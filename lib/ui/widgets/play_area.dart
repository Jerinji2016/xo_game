import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../config/theme_config.dart';
import 'play_cell.dart';

class PlayArea extends StatelessWidget {
  const PlayArea({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height - 200;
    final dimension = min(height, min<double>(350, size.shortestSide - 128));

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: GlassmorphicContainer(
        height: dimension,
        width: dimension,
        constraints: BoxConstraints(
          minWidth: dimension,
          minHeight: dimension,
        ),
        blur: 3,
        border: 4,
        borderRadius: 24,
        linearGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            darkPrimary.withOpacity(0.3),
            accentColor.withOpacity(0.3),
          ],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.purple.withOpacity(0.6),
            accentColor,
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: PlayCell(index: 0)),
                    Expanded(child: PlayCell(index: 1)),
                    Expanded(child: PlayCell(index: 2)),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: PlayCell(index: 3)),
                    Expanded(child: PlayCell(index: 4)),
                    Expanded(child: PlayCell(index: 5)),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: PlayCell(index: 6)),
                    Expanded(child: PlayCell(index: 7)),
                    Expanded(child: PlayCell(index: 8)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
