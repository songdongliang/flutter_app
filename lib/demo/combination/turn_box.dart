import 'package:flutter/material.dart';

class TurnBox extends StatefulWidget {

  const TurnBox({
    Key key,
    this.turns = .0, // 旋转的"圈"数，一圈360度
    this.speed = 200, // 过渡动画执行的总时长
    this.child
  });

  final double turns;
  final int speed;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _TurnBoxState();

}

class _TurnBoxState extends State<TurnBox>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity
    );
    _controller.value = widget.turns;
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: _controller,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
          widget.turns,
          duration: Duration(milliseconds: widget.speed ?? 200),
          curve: Curves.easeOut
      );
    }
  }

}