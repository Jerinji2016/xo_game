import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config/shared_pref_config.dart';
import 'config/theme_config.dart';
import 'game_provider/game_provider.dart';
import 'ui/pages/splash_page.dart';
import 'ui/widgets/sync_bg_animation/synced_bg_animation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPreferences();

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
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
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
        home: SyncedBackgroundAnimation(
          child: MaterialApp(
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
            home: const SplashPage(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
