part of 'synced_bg_animation.dart';

mixin _SyncBgAnimMixin on State<SyncedBackgroundAnimation> {
  late Size beginSize = _getNewSize();
  late Size endSize = _getNewSize();

  late BorderRadius beginBorderRadius = _getNewBorderRadius(beginSize);
  late BorderRadius endBorderRadius = _getNewBorderRadius(endSize);

  late Offset beginOffset = _getNewOffset();
  late Offset endOffset = _getNewOffset();

  Size _getNewSize() {
    final size = MediaQuery.of(context).size;
    final ratio = 1 - size.shortestSide / size.longestSide;
    final random = Random().nextInt(50);

    final width = size.width / 2 * (random * ratio * 0.1);
    final height = size.height / 2 * (random * ratio * 0.1);
    return Size(max(100, width), max(150, height));
  }

  BorderRadius _getNewBorderRadius(Size size) {
    final random = Random();
    return BorderRadius.only(
      topLeft: Radius.circular(random.nextDouble() * beginSize.height),
      topRight: Radius.circular(random.nextDouble() * beginSize.width),
      bottomLeft: Radius.circular(random.nextDouble() * beginSize.height),
      bottomRight: Radius.circular(random.nextDouble() * beginSize.width),
    );
  }

  Offset _getNewOffset() {
    final size = MediaQuery.of(context).size;
    final ratio = 1 - size.shortestSide / size.longestSide;
    final random = Random().nextInt(50);

    final dx = size.width * (random * ratio * 0.1);
    final dy = size.height * (random * ratio * 0.1);

    return Offset(dx, dy);
  }

  void _animationListener(AnimationController controller) {
    if (controller.status != AnimationStatus.completed) return;
    beginSize = endSize;
    endSize = _getNewSize();

    beginOffset = endOffset;
    endOffset = _getNewOffset();

    beginBorderRadius = endBorderRadius;
    endBorderRadius = _getNewBorderRadius(endSize);

    controller.forward(from: 0);
  }
}
