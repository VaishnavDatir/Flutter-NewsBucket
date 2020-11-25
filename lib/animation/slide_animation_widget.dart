import 'package:flutter/material.dart';
import './slide_animation.dart';

class SlideAnimationWidget extends StatefulWidget {
  final Widget widgetToAnimate;
  final int index;
  final int itemCount;

  SlideAnimationWidget({this.widgetToAnimate, this.index, this.itemCount});
  @override
  _SlideAnimationWidgetState createState() => _SlideAnimationWidgetState();
}

class _SlideAnimationWidgetState extends State<SlideAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
        position: widget.index,
        itemCount: widget.itemCount,
        slideDirection: SlideDirection.fromTop,
        animationController: _animationController,
        child: widget.widgetToAnimate);
  }
}
