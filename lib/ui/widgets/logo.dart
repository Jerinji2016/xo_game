import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/asset_config.dart';

class Logo extends StatelessWidget {
  const Logo({super.key = const Key('logo')});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FittedBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SvgPicture.asset(
                Assets.logo,
                height: 48,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFF1F1F1),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'XO GAME',
                style: TextStyle(
                  fontSize: 48,
                  color: Color(0xFFF1F1F1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
