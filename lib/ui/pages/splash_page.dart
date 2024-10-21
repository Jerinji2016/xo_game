import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../widgets/logo.dart';
import 'menu_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (_) => _navigateToMenuAfterDelay(),
    );
  }

  Future<void> _navigateToMenuAfterDelay() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    unawaited(
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute<void>(
          builder: (context) => const MenuPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Logo(),
      ),
    );
  }
}
