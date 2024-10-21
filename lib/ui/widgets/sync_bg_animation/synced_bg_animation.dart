import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

import '../../../config/asset_config.dart';
import '../../../config/theme_config.dart';

part 'sync_bg_anim.mixin.dart';

class SyncedBackgroundAnimation extends StatefulWidget {
  const SyncedBackgroundAnimation({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<SyncedBackgroundAnimation> createState() => _SyncedBackgroundAnimationState();
}

class _SyncedBackgroundAnimationState extends State<SyncedBackgroundAnimation>
    with TickerProviderStateMixin, _SyncBgAnimMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  );

  @override
  void initState() {
    super.initState();

    _animationController.addListener(
      () => _animationListener(_animationController),
    );

    SchedulerBinding.instance.addPostFrameCallback(
      (timestamp) => _animationController.forward(),
    );
  }

  Size get blurBlobSize => Tween<Size>(begin: beginSize, end: endSize)
      .animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.linear,
        ),
      )
      .value;

  Offset get blurBlobOffset => Tween<Offset>(begin: beginOffset, end: endOffset)
      .animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.ease,
        ),
      )
      .value;

  BorderRadius get blurBlobBorderRadius => Tween<BorderRadius>(
        begin: beginBorderRadius,
        end: endBorderRadius,
      )
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.linear,
            ),
          )
          .value;

  @override
  Widget build(BuildContext context) {
    _getNewOffset();
    return ColoredBox(
      color: darkPrimary,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                top: blurBlobOffset.dx,
                left: blurBlobOffset.dy,
                child: Container(
                  width: blurBlobSize.width,
                  height: blurBlobSize.height,
                  decoration: BoxDecoration(
                    // color: Colors.orange.shade900.withOpacity(0.8),
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade900,
                        Colors.blue.shade900,
                        Colors.purple.shade700,
                        Colors.pink.shade700,
                      ],
                    ),
                    borderRadius: blurBlobBorderRadius,
                  ),
                ),
              );
            },
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Opacity(
              opacity: 0.7,
              child: SizedBox.expand(
                child: Lottie.asset(
                  Assets.bgAnim,
                  repeat: true,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 1,
              sigmaX: 1,
            ),
            child: widget.child,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
