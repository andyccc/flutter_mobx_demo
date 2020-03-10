import 'package:flutter/material.dart';

class PointerDemo extends StatefulWidget {
  @override
  _PointerDemoState createState() => _PointerDemoState();
}

class _PointerDemoState extends State<PointerDemo> {
//定义一个状态，保存当前指针位置
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("原始事件指针"),
      ),
      body: Column(
        children: [
          Listener(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 300.0,
              height: 150.0,
              child: Text(_event?.toString() ?? "",
                  style: TextStyle(color: Colors.white)),
            ),
            onPointerDown: (PointerDownEvent event) =>
                setState(() => _event = event),
            onPointerMove: (PointerMoveEvent event) =>
                setState(() => _event = event),
            onPointerUp: (PointerUpEvent event) =>
                setState(() => _event = event),
          ),
          SizedBox(
            height: 100,
          ),
          Stack(
            children: <Widget>[
              Listener(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(300.0, 200.0)),
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue)),
                ),
                onPointerDown: (event) => print("down0"),
              ),
              Listener(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                  child: Center(child: Text("左上角200*100范围内非文本区域点击")),
                ),
                onPointerDown: (event) => print("down1"),
                // behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
                // behavior: HitTestBehavior.opaque, //放开此行注释后可以"点透"
              )
            ],
          ),
          Listener(
            child: AbsorbPointer(
              // 会输出当前 IgnorePointer 全部不输出
              child: Listener(
                child: Container(
                  color: Colors.red,
                  width: 200.0,
                  height: 100.0,
                ),
                onPointerDown: (event) => print("in"),
              ),
            ),
            onPointerDown: (event) => print("up"),
          ),
          SizedBox(
            height: 10,
          ),
          Listener(
            child: IgnorePointer(
              // 会输出当前 IgnorePointer 全部不输出
              child: Listener(
                child: Container(
                  color: Colors.red,
                  width: 200.0,
                  height: 100.0,
                ),
                onPointerDown: (event) => print("in"),
              ),
            ),
            onPointerDown: (event) => print("up"),
          ),
        ],
      ),
    );
  }
}
