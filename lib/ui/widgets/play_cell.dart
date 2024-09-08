import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/theme_config.dart';
import '../../game_provider/game_provider.dart';

class PlayCell extends StatelessWidget {
  const PlayCell({
    required this.index,
    super.key,
  });

  final int index;

  void _onCellTapped(BuildContext context) {
    Provider.of<GameProvider>(context, listen: false).onCellTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final cellValue = gameProvider.getCellValue(index);

    final padding = min<double>(
      12,
      MediaQuery.of(context).size.shortestSide * .02,
    );

    return Container(
      height: double.infinity,
      color: darkSecondary,
      padding: EdgeInsets.all(padding),
      child: Material(
        color: darkPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.transparent,
          onTap: cellValue == null ? () => _onCellTapped(context) : null,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.bounceInOut,
              child: cellValue == null
                  ? const SizedBox.shrink()
                  : Text(
                      cellValue.value,
                      style: TextStyle(
                        fontSize: 56,
                        color: cellValue.color,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
