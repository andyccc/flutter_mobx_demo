import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelMethodDemo extends StatefulWidget {
  @override
  _ChannelMethodDemoState createState() => _ChannelMethodDemoState();
}

// https://www.cnblogs.com/mengqd/p/13844339.html
// https://blog.csdn.net/vitaviva/article/details/104253660
// https://blog.csdn.net/u013491829/article/details/109329668
// https://juejin.cn/post/6844903784733229069
/*
PlatformChannel分为BasicMessageChannel、MethodChannel以及EventChannel三种。其各自的主要用途如下：

BasicMessageChannel: 用于传递数据。Flutter与原生项目的资源是不共享的，可以通过BasicMessageChannel来获取Native项目的图标等资源。
MethodChannel: 传递方法调用。Flutter主动调用Native的方法，并获取相应的返回值。比如获取系统电量，发起Toast等调用系统API，可以通过这个来完成。
EventChannel: 传递事件。这里是Native将事件通知到Flutter。比如Flutter需要监听网络情况，这时候MethodChannel就无法胜任这个需求了。EventChannel可以将Flutter的一个监听交给Native，Native去做网络广播的监听，当收到广播后借助EventChannel调用Flutter注册的监听，完成对Flutter的事件通知。

其实可以看到，无论传方法还是传事件，其本质上都是数据的传递，不过上层包的一些逻辑不同而已。

作者：沐沐小火柴
链接：https://juejin.cn/post/6844903784733229069
来源：掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

*/

class _ChannelMethodDemoState extends State<ChannelMethodDemo> {
  var _methodChannel = MethodChannel("samples.flutter.io");

  // eventchannel 单向数据无返回值
  var _eventChannel = EventChannel("samples.flutter.event");

  static const messageChannel1 = const BasicMessageChannel(
      "samples.flutter.io/message1", StandardMessageCodec());
  static const messageChannel2 = const BasicMessageChannel(
      "samples.flutter.io/message2", StandardMessageCodec());

  var batteryLevel = "";
  var timer = "";
  var eventData = "";

  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();

    // flutter 接收原生发送的数据
    _methodChannel.setMethodCallHandler(_methodCallHandler);

    // event
    _streamSubscription = _eventChannel.receiveBroadcastStream().listen(
      (dynamic event) {
        print('Received event: $event');
        setState(() {
          eventData = event;
        });
      },
      onError: (dynamic error) {
        print('Received error: ${error.message}');
      },
      cancelOnError: true,
    );

    _receiveMessage();
  }

  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }

    super.dispose();
  }

  Future<dynamic> _methodCallHandler(MethodCall call) {
    if (call.method == "sendtoFlutter") {
      setState(() {
        timer = call.arguments["time"].toString();
      });
    }
    return Future.value("ok");
  }

  Future<String> _sendMessage() async {
    String reply = await messageChannel1.send("发送给原生端的数据");
    print("replay: $reply");
    return reply;
  }

  void _getBattery() async {
    var result = "";
    try {
      result = await _methodChannel.invokeMethod(
        "getBatterLevel",
        {
          "name": "abc",
          "id": 11,
        },
      );
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      batteryLevel = result.toString();
    });
  }

  void _receiveMessage() {
    messageChannel2.setMessageHandler((message) async {
      print("message: $message");
      return "返回原生的数据";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("交互"),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: _getBattery,
              child: Text("获取电量"),
            ),
            Text("电量：$batteryLevel"),
            Text("原生数据：$timer"),
            Text("收到的event数据：$eventData"),
            RaisedButton(
              onPressed: _sendMessage,
              child: Text("测试发送数据给原生"),
            ),
            Text("收到原生的数据：$eventData"),
          ],
        ),
      ),
    );
  }
}
