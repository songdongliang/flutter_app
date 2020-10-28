
import 'package:flutter/material.dart';
import 'package:flutterapp/demo/bubble/bubble_painter.dart';

class BubbleTipWidget extends StatefulWidget {

  // 控件高度
  final double height;
  // 控件宽度
  final double width;
  // 控件圆角
  final double radius;
  // 控件显示的内容
  final String text;
  // 三角指示的x
  final double x;
  // 三角指示的y
  final double y;
  // 三角显示的位置
  final ArrowLocation arrowLocation;
  // 点击回调
  final VoidCallback voidCallback;

  const BubbleTipWidget({
    this.height,
    this.width,
    this.radius,
    this.text = '',
    this.x = 0,
    this.y = 0,
    this.arrowLocation = ArrowLocation.BOTTOM,
    this.voidCallback
  });

  @override
  State<StatefulWidget> createState() => _BubbleTipWidgetState();

}

class _BubbleTipWidgetState extends State<BubbleTipWidget> {

  final GlobalKey paintKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    double arrowHeight = 10;
    double arrowWidth = 10;

    double x = widget.x;
    double y = widget.y;
    Size size = MediaQuery.of(context).size;


    if (widget.arrowLocation == ArrowLocation.TOP
        || widget.arrowLocation == ArrowLocation.BOTTOM) {
      x = widget.x - widget.width / 2;
    } else {
      y = widget.y - widget.height / 2;
    }

    // 宽度是否超出
    bool widthOut = (widget.width + x) > size.width || x < 0;
    // 高度是否超出
    bool heightOut = (widget.height + y) > size.height || y < 0;

    if (x < 0) {
      x = 0;
    } else if (widthOut) {
      x = size.width - widget.width;
    }
    if (y < 0) {
      y = 0;
    } else if (heightOut) {
      y = size.height - widget.height;
    }

    // 箭头在这个状态下是否需要居中
    bool arrowCenter = (widget.arrowLocation == ArrowLocation.TOP
        || widget.arrowLocation == ArrowLocation.BOTTOM)
      ? !widthOut
      : !heightOut;

    // 箭头的绘制起始点, 因为箭头可能不是居中的
    double arrowPosition = (widget.arrowLocation == ArrowLocation.TOP
        || widget.arrowLocation == ArrowLocation.BOTTOM)
        ? (widget.x - x - arrowWidth / 2)
        : (widget.y - y - arrowHeight / 2);

    // 箭头的位置是按照弹出框的左边为起点计算的
    if (widget.arrowLocation == ArrowLocation.TOP
        || widget.arrowLocation == ArrowLocation.BOTTOM) {
      if (arrowPosition < widget.radius + 2) {
        arrowPosition = widget.radius + 4;
      } else if (arrowPosition > widget.width - widget.radius - 2) {
        arrowPosition = widget.width - widget.radius - 4;
      }
    } else {
      if (arrowPosition < widget.radius + 2) {
        arrowPosition = widget.radius + 4;
      } else if (arrowPosition > widget.height - widget.radius - 4) {
        arrowPosition = widget.height - widget.radius - 4;
      }
    }

    EdgeInsets margin = EdgeInsets.zero;
    if (widget.arrowLocation == ArrowLocation.TOP) {
      margin = EdgeInsets.only(top: arrowHeight, right: 5, left: 5);
    }

    var bubbleBuild = BubbleBuilder()
      ..mAngel = widget.radius
      ..arrowCenter = arrowCenter
      ..mArrowWidth = arrowWidth
      ..mArrowHeight = arrowHeight
      ..mArrowPosition = arrowPosition
      ..mArrowLocation = widget.arrowLocation;
    var alignment = Alignment.centerLeft;
    if (widget.arrowLocation == ArrowLocation.TOP
        || widget.arrowLocation == ArrowLocation.BOTTOM) {
      alignment = Alignment.center;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        // 透明可以点击
        behavior: HitTestBehavior.translucent,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: Container(
          alignment: Alignment.centerLeft,
          width: widget.width,
          height: widget.height,
          margin: EdgeInsets.only(left: x, top: y),
          child: Stack(
            children: <Widget>[
              CustomPaint(
                key: paintKey,
                size: Size(widget.width, widget.height),
                painter: bubbleBuild.build(),
              ),
              Align(
                alignment: alignment,
                child: Container(
                  margin: margin,
                  width: widget.width,
                  height: widget.height - arrowHeight,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        height: widget.height,
                        child: Icon(
                          Icons.notifications,
                          size: widget.height - 30,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              widget.text,
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails startDetails){}

  void _onPanUpdate(DragUpdateDetails updateDetails){}

  void _onPanEnd(DragEndDetails endDetails) {
    widget.voidCallback?.call();
  }

}

