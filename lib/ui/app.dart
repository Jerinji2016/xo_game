import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/asset_config.dart';
import 'widgets/play_area.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: Center(
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
              ),
              Expanded(
                child: Center(
                  child: PlayArea(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
