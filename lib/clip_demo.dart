import 'package:flutter/material.dart';

class ClipDemo extends StatefulWidget {
  @override
  _ClipDemoState createState() => _ClipDemoState();
}

class _ClipDemoState extends State<ClipDemo> {
  Widget avatar = Image.asset(
    "images/bbb.png",
    width: 60.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("裁剪"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            avatar, // 不裁剪
            ClipOval(child: avatar), // 圆形
            ClipRRect(
              child: avatar,
              borderRadius: BorderRadius.circular(5.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5, // 宽度设为原来宽度的一半，另一半会溢出
                  child: avatar,
                ),
                Text(
                  "hello world",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRect(
                  child: Align(
                    child: Align(
                        alignment: Alignment.topLeft,
                        widthFactor: 0.5,
                        child: avatar),
                  ),
                ),
                Text(
                  "hello world",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
