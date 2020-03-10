import 'package:flutter/material.dart';

class NotiDemo extends StatefulWidget {
  @override
  _NotiDemoState createState() => _NotiDemoState();
}

/**
 * 通知的冒泡事件传递事件可以中止，触摸的冒泡事件不可以中止
 * 
 */

class _NotiDemoState extends State<NotiDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通知"),
      ),
      body: NotificationListener(
        onNotification: (noti) {
          switch (noti.runtimeType) {
            case ScrollStartNotification:
              print("开始滚动");
              break;
            case ScrollUpdateNotification:
              print("正在滚动");
              break;
            case ScrollEndNotification:
              print("滚动停止");
              break;
            case OverscrollNotification:
              print("滚动到边界");
              break;
            default:
              break;
          }
          return false;
        },
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
            );
          },
        ),
      ),
    );
  }
}
