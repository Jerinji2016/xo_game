import 'package:flutter/material.dart';

enum Player {
  x('X', Color(0xFFF1F1F1)),
  o('O', Color(0xFF1677FF));

  const Player(
    this.value,
    this.color,
  );

  final String value;
  final Color color;
}
