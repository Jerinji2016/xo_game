import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'app.dart';
import 'widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(
      (timestamp) => Future<void>.delayed(const Duration(seconds: 1)).then(
        (value) => Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (context) => const App(),
          ),
        ),
      ),
    );

    return const Scaffold(
      body: Center(
        child: Hero(
          tag: 'logo-from-splash',
          child: Logo(),
        ),
      ),
    );
  }
}
