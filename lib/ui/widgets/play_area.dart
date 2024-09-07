import 'dart:math';

import 'package:flutter/material.dart';

import '../../config/theme_config.dart';
import 'play_cell.dart';

class PlayArea extends StatelessWidget {
  const PlayArea({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dimension = min<double>(450, size.shortestSide);

    return SizedBox.square(
      dimension: dimension,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          color: darkSecondary,
          padding: const EdgeInsets.all(8),
          child: const Column(
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
