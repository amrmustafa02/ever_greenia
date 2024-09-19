import 'package:flutter/material.dart';

class ArrowAnimation extends StatefulWidget {
  final int seconds;
  final Color color;

  const ArrowAnimation({
    super.key,
    required this.seconds,
    required this.color,
  });

  @override
  State<ArrowAnimation> createState() => _ArrowAnimationState();
}

class _ArrowAnimationState extends State<ArrowAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: widget.seconds),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 5).animate(controller);
    controller.forward();
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      // builder: (context, child) {
      //   return Transform.rotate(
      //     angle: animation.value,
      //     child: child,
      //   );
      // },
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          // angle: animation.value,
          offset: Offset(animation.value, 0),
          child: child,
        );
      },
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: widget.color,
        size: 20,
      ),
    );
    // return Icon(
    //   Icons.arrow_forward_ios_rounded,
    //   color: Colors.white.withOpacity(0.3),
    //   size: 20,
    // );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
