import 'package:flutter/material.dart';

import '../../config/theme_config.dart';

class PlayCell extends StatelessWidget {
  const PlayCell({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: darkSecondary,
      padding: const EdgeInsets.all(12),
      child: Material(
        color: darkPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.transparent,
          onTap: () {},
          child: const SizedBox.shrink(),
        ),
      ),
    );
  }
}
