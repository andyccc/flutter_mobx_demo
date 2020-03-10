import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintRoute extends StatefulWidget {
  @override
  _CustomPaintRouteState createState() => _CustomPaintRouteState();
}

class _CustomPaintRouteState extends State<CustomPaintRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自绘组件"),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    // 画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill // 填充
      ..color = Color(0x77cbb175); // 背景色为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    // 画棋盘网络
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    // 画一个黑子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 2 + eWidth / 2, size.height / 2 - eHeight / 2),
        min(eWidth / 2, eHeight / 2) - 2,
        paint);
  }

  // 在实际场景中正确利用此回调可以避免重绘开销，本实例我们简单返回true
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
