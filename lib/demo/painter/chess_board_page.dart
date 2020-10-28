import 'package:flutter/material.dart';

class ChessBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chess Board"),
      ),
      body: Center(
        child: ChessBoard(),
      ),
    );
  }

}


class ChessBoard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 300),
      painter: ChessBoardPainter(),
    );
  }

}

class ChessBoardPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    double itemWidth = size.width / 14;
    double itemHeight = size.height / 14;

    // 棋盘背景画笔
    var paint = Paint()
                    ..isAntiAlias = true
                    ..style = PaintingStyle.fill // 填充
                    ..color = Color(0x77cdb175); // 颜色为纸黄色
//    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);
    canvas.drawRect(Offset.zero & size, paint);

    paint..color = Colors.black ..style = PaintingStyle.stroke;

    double dx = 0;
    for (int i = 0; i < 15; i++) { // 画竖线
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
      dx += itemWidth;
    }

    double dy = 0;
    for (int j = 0; j < 15; j++) { // 画横线
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
      dy += itemHeight;
    }

    // 中心画一个红点，斜方画一个黑子和一个白子
    paint..style = PaintingStyle.fill ..color = Colors.red;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 2, paint);

    paint..color = Colors.black;
    canvas.drawCircle(Offset(size.width / 2 - itemWidth, size.height / 2 - itemHeight), 6, paint);

    paint..color = Colors.white;
    canvas.drawCircle(Offset(size.width / 2 + itemWidth, size.height / 2 + itemHeight), 6, paint);
  }

  // 在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}