import 'package:flutter/material.dart';

class Noti2Demo extends StatefulWidget {
  @override
  _Noti2DemoState createState() => _Noti2DemoState();
}

class _Noti2DemoState extends State<Noti2Demo> {
  String _msg = "123";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义noti"),
      ),
      body: NotificationListener<MyNoti>(
        onNotification: (noti) {
          setState(() {
            _msg += noti.msg + "  ";
          });
          return true;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // RaisedButton(
              //   onPressed: () {
              //     // 这里没效果哎
              //     MyNoti("hi").dispatch(context);
              //   },
              //   child: Text("send noti"),
              // ),
              Builder(
                builder: (context) {
                  return RaisedButton(
                    onPressed: () {
                      MyNoti("hi").dispatch(context);
                    },
                    child: Text("send noti"),
                  );
                },
              ),
              Text(_msg),
              RaisedButton(
                onPressed: () {
                  // 这里没效果哎
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Noti3Demo();
                      },
                    ),
                  );
                },
                child: Text("阻止冒泡"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyNoti extends Notification {
  MyNoti(this.msg);
  final String msg;
}

class Noti3Demo extends StatefulWidget {
  @override
  _Noti3DemoState createState() => _Noti3DemoState();
}

class _Noti3DemoState extends State<Noti3Demo> {
  String _msg = "123";
  // 防止冒泡
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义noti"),
      ),
      body: NotificationListener<MyNoti>(
        onNotification: (noti) {
          print(noti.msg); // 打印通知
          return false;
        },
        child: NotificationListener<MyNoti>(
          onNotification: (noti) {
            print(noti.msg + " -> "); // 打印通知

            setState(() {
              _msg += noti.msg + "  ";
            });
            return false; // true 阻止继续向父节点冒泡传递事件通知
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // RaisedButton(
                //   onPressed: () {
                //     // 这里没效果哎
                //     MyNoti("hi").dispatch(context);
                //   },
                //   child: Text("send noti"),
                // ),
                Builder(
                  builder: (context) {
                    return RaisedButton(
                      onPressed: () {
                        MyNoti("hi").dispatch(context);
                      },
                      child: Text("send noti"),
                    );
                  },
                ),
                Text(_msg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
