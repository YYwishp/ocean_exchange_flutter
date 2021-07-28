import 'package:flutter/material.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'dart:math' as math;
class RefreshLogo extends StatefulWidget {
  const RefreshLogo(

      {
        Key? key,
        required this.mode,
        required this.offset,
      }
  ) : super(key: key);
  final double offset;
  final RefreshIndicatorMode? mode;

  @override
  _RefreshLogoState createState() => _RefreshLogoState();
}

class _RefreshLogoState extends State<RefreshLogo>
    with TickerProviderStateMixin {
  late AnimationController rotateController;
  late CurvedAnimation rotateCurveAnimation;
  late Animation<double> rotateAnimation;
  double angle = 0.0;

  bool animating = false;

  @override
  void initState() {
    rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    rotateCurveAnimation = CurvedAnimation(
      parent: rotateController,
      curve: Curves.ease,
    );
    rotateAnimation =
        Tween<double>(begin: 0.0, end: 2.0).animate(rotateCurveAnimation);
    super.initState();
  }

  void startAnimate() {
    animating = true;
    rotateController.repeat();
  }

  void stopAnimate() {
    animating = false;
    rotateController
      ..stop()
      ..reset();
  }

  Widget get logo => Image.asset(
    'assets/images/lollipop-without-stick.png',
    height: math.min(widget.offset, 50),
  );

  @override
  Widget build(BuildContext context) {
    if (widget.mode == null) {
      return Container();
    }
    if (!animating && widget.mode == RefreshIndicatorMode.refresh) {
      startAnimate();
    } else if (widget.offset < 10.0 &&
        animating &&
        widget.mode != RefreshIndicatorMode.refresh) {
      stopAnimate();
    }
    return Container(
      width: math.min(widget.offset, 50),
      height: math.min(widget.offset, 50),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Image.asset(
              'assets/images/lollipop.png',
            ),
          ),
          if (animating)
            RotationTransition(
              turns: rotateAnimation,
              child: logo,
            )
          else
            logo,
        ],
      ),
    );
  }
}