import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config/theme_config.dart';
import 'game_provider/game_provider.dart';
import 'ui/splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const XOGame());
}

class XOGame extends StatelessWidget {
  const XOGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: 'LuckiestGuy',
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        scaffoldBackgroundColor: darkPrimary,
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (context) => GameProvider(),
          child: child,
        );
      },
    );
  }
}
