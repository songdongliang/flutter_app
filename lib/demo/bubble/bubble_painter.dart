import 'package:flutter/material.dart';
import 'dart:math' as Math;

class BubblePainter extends CustomPainter {

  Paint mPaint = Paint();
  Path mPath = Path();
  Rect mRect;

  double mAngel;
  double mArrowWidth;
  double mArrowHeight;
  double mArrowPosition;
  Color bubbleColor;
  BubbleType bubbleType;
  ArrowLocation mArrowLocation;
  bool arrowCenter = true;

  BubblePainter(BubbleBuilder builder) {
    this.mAngel = builder.mAngel;
    this.mArrowWidth = builder.mArrowWidth;
    this.mArrowHeight = builder.mArrowHeight;
    this.mArrowPosition = builder.mArrowPosition;
    this.bubbleColor = builder.bubbleColor;
    this.bubbleType = builder.bubbleType;
    this.mArrowLocation = builder.mArrowLocation;
    this.arrowCenter = builder.arrowCenter;
  }

  @override
  void paint(Canvas canvas, Size size) {
    switch (bubbleType) {
      case BubbleType.COLOR:
        mPaint.color = bubbleColor;
        break;
      case BubbleType.BITMAP:
        break;
    }
    mRect ??= Rect.fromLTRB(0, 0, size.width, size.height);
    setUpPath(mArrowLocation, mPath);
    canvas.drawPath(mPath, mPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  // This is a method
  void setUpPath(ArrowLocation mArrowLocation, Path mPath) {
    switch (mArrowLocation) {
      case ArrowLocation.TOP: {
        setUpTopPath(mRect, mPath);
        break;
      }
      case ArrowLocation.LEFT:
        setUpLeftPath(mRect, mPath);
        break;
      case ArrowLocation.RIGHT:
        setUpRightPath(mRect, mPath);
        break;
      case ArrowLocation.BOTTOM:
        setUpBottomPath(mRect, mPath);
        break;
    }

  }

  /// 绘制上边三角形
  void setUpTopPath(Rect rect, Path path) {
    if (arrowCenter) {
      mArrowPosition = (rect.right - rect.left) / 2 - mArrowWidth / 2;
    }

    path.moveTo(rect.left + Math.min(mArrowPosition, mAngel), rect.top + mArrowHeight);
    path.lineTo(rect.left + mArrowPosition, rect.top + mArrowHeight);
    path.lineTo(rect.left + mArrowPosition + mArrowWidth / 2, rect.top);
    path.lineTo(rect.left + mArrowPosition + mArrowWidth, rect.top + mArrowHeight);

    path.addRRect(RRect.fromLTRBR(rect.left, rect.top + mArrowHeight,
        rect.right, rect.bottom, Radius.circular(mAngel)));

    path.close();
  }

  /// 绘制左边三角形
  void setUpLeftPath(Rect rect, Path path) {
    if (arrowCenter) {
      mArrowPosition = (rect.bottom - rect.top) / 2 - mArrowHeight / 2;
    }
    path.moveTo(rect.left + mArrowWidth, mArrowPosition + mArrowHeight);
    path.lineTo(rect.left + mArrowWidth, mArrowPosition + mArrowHeight);
    path.lineTo(rect.left, mArrowPosition + mArrowHeight / 2);
    path.lineTo(rect.left + mArrowWidth, mArrowPosition);
    path.lineTo(rect.left + mArrowWidth, rect.top + mAngel);

    path.addRRect(RRect.fromLTRBR(rect.left + mArrowWidth, rect.top,
        rect.right, rect.bottom, Radius.circular(mAngel)));
    path.close();
  }

  ///绘制右边三角形
  void setUpRightPath(Rect rect, Path path) {
    if (arrowCenter) {
      mArrowPosition = (rect.bottom - rect.top) / 2 - mArrowHeight / 2;
    }

    path.moveTo(rect.right - mArrowWidth, mArrowPosition);

    path.lineTo(rect.right - mArrowWidth, mArrowPosition);
    path.lineTo(rect.right, mArrowPosition + mArrowHeight / 2);
    path.lineTo(rect.right - mArrowWidth, mArrowPosition + mArrowHeight);

    path.moveTo(rect.left + mAngel, rect.top);

    path.addRRect(RRect.fromLTRBR(rect.left, rect.top,
        rect.right - mArrowHeight, rect.bottom, Radius.circular(mAngel)));

    path.close();
  }

  ///绘制底部三角形
  void setUpBottomPath(Rect rect, Path path) {
    if (arrowCenter) {
      mArrowPosition = (rect.right - rect.left) / 2 - mArrowWidth / 2;
    }
    path.moveTo(
        rect.left + mArrowWidth + mArrowPosition, rect.bottom - mArrowHeight);
    path.lineTo(
        rect.left + mArrowWidth + mArrowPosition, rect.bottom - mArrowHeight);
    path.lineTo(rect.left + mArrowPosition + mArrowWidth / 2, rect.bottom);
    path.lineTo(rect.left + mArrowPosition, rect.bottom - mArrowHeight);

    path.addRRect(RRect.fromLTRBR(rect.left, rect.top, rect.right,
        rect.bottom - mArrowHeight, Radius.circular(mAngel)));

    path.close();
  }

}

// This is a function
//void setUpPath(ArrowLocation mArrowLocation, Path mPath) {}

class BubbleBuilder {
  static const double DEFAULT_ARROW_WIDTH = 15;
  static const double DEFAULT_ARROW_HEIGHT = 15;
  static const double DEFAULT_ANGLE = 20;
  static const double DEFAULT_ARROW_POSITION = 50;
  static const Color DEFAULT_BUBBLE_COLOR = Colors.white;

  // 默认圆角
  double mAngel = DEFAULT_ANGLE;
  // 箭头宽度
  double mArrowWidth = DEFAULT_ARROW_WIDTH;
  // 箭头高度
  double mArrowHeight = DEFAULT_ARROW_HEIGHT;
  // 箭头位置
  double mArrowPosition = DEFAULT_ARROW_POSITION;
  // 背景颜色
  Color bubbleColor = DEFAULT_BUBBLE_COLOR;
  // 背景类型
  BubbleType bubbleType = BubbleType.COLOR;
  // 箭头位置
  ArrowLocation mArrowLocation = ArrowLocation.BOTTOM;
  // 箭头是否需要居中
  bool arrowCenter = true;

  build() {
    return BubblePainter(this);
  }
}

enum ArrowLocation {
  LEFT, RIGHT, TOP, BOTTOM
}

enum BubbleType {
  COLOR, BITMAP
}