import 'package:flutter/material.dart';
import 'package:flutter_testmobx/counter.dart';

class AsyncuiDemo extends StatefulWidget {
  @override
  _AsyncuiDemoState createState() => _AsyncuiDemoState();
}

class _AsyncuiDemoState extends State<AsyncuiDemo> {
  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "这是返回的数据");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("async异步ui"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, "Asyncui2PageDemo");
          },
          child: Text("点击"),
        ),
      ),
    );
  }
}

// enum ConnectionState {
//   /// 当没有异步任务，比如【FutureBuilder】的【Future】为null时
//   none,

//   /// 异步任务出于等待状态
//   waiting,

//   /// Stream出于激活状态（流上已经有数传递了），对于FutureBuilder没有该状态。
//   active,

//   /// 异步任务已经终止。
//   done,
// }

class AsyncuiPageDemo extends StatefulWidget {
  @override
  _AsyncuiPageDemoState createState() => _AsyncuiPageDemoState();
}

class _AsyncuiPageDemoState extends State<AsyncuiPageDemo> {
  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "这是返回的数据");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("async异步ui"),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: mockNetworkData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                // 请求成功，显示数据
                return Text("Contents: ${snapshot.data}");
              }
            } else {
              // 请求未结束，显示loading
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class Asyncui2PageDemo extends StatefulWidget {
  @override
  _Asyncui2PageDemoState createState() => _Asyncui2PageDemoState();
}

class _Asyncui2PageDemoState extends State<Asyncui2PageDemo> {
  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Steam 数据"),
      ),
      body: Center(
        child: StreamBuilder(
          stream: counter(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text("Error : ${snapshot.error}");
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("没有Stream");
              case ConnectionState.waiting:
                return Text("等待数据...");
              case ConnectionState.active:
                return Text("active: ${snapshot.data}");
              case ConnectionState.done:
                return Text("Stream已关闭");
            }
            return null;
          },
        ),
      ),
    );
  }
}
