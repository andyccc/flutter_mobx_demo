import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureDemo extends StatefulWidget {
  @override
  _GestureDemoState createState() => _GestureDemoState();
}

class _GestureDemoState extends State<GestureDemo>
    with SingleTickerProviderStateMixin {
  String _operation = "123";

  void _updateText(title) {
    setState(() {
      _operation = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手势"),
      ),
      // body: Center(
      //   child: GestureDetector(
      //     child: Container(
      //       alignment: Alignment.center,
      //       color: Colors.red,
      //       width: 200.0,
      //       height: 100.0,
      //       child: Text(
      //         _operation,
      //         style: TextStyle(
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     onTap: () => _updateText("tap"),
      //     onDoubleTap: () => _updateText("double tap"),
      //     onLongPress: () => _updateText("long press"),
      //   ),
      // ),

      // body: Drag(),
      // body: DragVertial(),
      // body: ScaleTestRoute(),
      // body: GestureRecongnizerTestRoute(),
      // body: BothDirectionTestRoute(),
      body: GestureConflictTestRoute(),
    );
  }
}

class Drag extends StatefulWidget {
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  double _top = 0.0; // 距离顶部的偏移
  double _left = 0.0; // 距离左边的偏移

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text("A"),
            ),
            onPanDown: (DragDownDetails e) {
              // 打印手淫按下的位置，相对于屏幕
              print("用户手指按下： ${e.globalPosition}");
            },
            onPanUpdate: (DragUpdateDetails e) {
              // 用户手指滑动是，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              // 打印滑动结束时x、y轴上的速度
              print(e.velocity);
            },
          ),
        ),
      ],
    );
  }
}

class DragVertial extends StatefulWidget {
  @override
  _DragVertialState createState() => _DragVertialState();
}

class _DragVertialState extends State<DragVertial> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _top,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text("A"),
            ),
            onVerticalDragUpdate: (DragUpdateDetails e) {
              setState(() {
                _top += e.delta.dy;
              });
            },
          ),
        ),
      ],
    );
  }
}

class ScaleTestRoute extends StatefulWidget {
  @override
  _ScaleTestRouteState createState() => _ScaleTestRouteState();
}

class _ScaleTestRouteState extends State<ScaleTestRoute> {
  double _width = 200.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Image.asset(
          "./images/bbb.png",
          width: _width,
        ),
        onScaleUpdate: (ScaleUpdateDetails e) {
          setState(() {
            // 缩放倍数在0.8 到 10 倍之间
            _width = 200 * e.scale.clamp(0.8, 10.0);
          });
        },
      ),
    );
  }
}

class GestureRecongnizerTestRoute extends StatefulWidget {
  @override
  _GestureRecongnizerTestRouteState createState() =>
      _GestureRecongnizerTestRouteState();
}

class _GestureRecongnizerTestRouteState
    extends State<GestureRecongnizerTestRoute> {
  TapGestureRecognizer _tgr = TapGestureRecognizer();
  bool _toggle = false; // 变色开关

  @override
  void dispose() {
    // 用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tgr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: "hello word"),
            TextSpan(
              text: "点我变色",
              style: TextStyle(
                fontSize: 30.0,
                color: _toggle ? Colors.blue : Colors.red,
              ),
              recognizer: _tgr
                ..onTap = () {
                  setState(() {
                    _toggle = !_toggle;
                  });
                },
            ),
            TextSpan(text: "helloword2"),
          ],
        ),
      ),
    );
  }
}

class BothDirectionTestRoute extends StatefulWidget {
  @override
  _BothDirectionTestRouteState createState() => _BothDirectionTestRouteState();
}

class _BothDirectionTestRouteState extends State<BothDirectionTestRoute> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text("A"),
            ),
            onVerticalDragUpdate: (DragUpdateDetails e) {
              setState(() {
                _top += e.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails e) {
              setState(() {
                _left += e.delta.dx;
                // print("left : " + _left.toString());
              });
            },
          ),
        ),
      ],
    );
  }
}

class GestureConflictTestRoute extends StatefulWidget {
  @override
  _GestureConflictTestRouteState createState() =>
      _GestureConflictTestRouteState();
}

class _GestureConflictTestRouteState extends State<GestureConflictTestRoute> {
  double _left = 0.0;
  double _leftB = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text("A"),
            ),
            onHorizontalDragUpdate: (DragUpdateDetails e) {
              setState(() {
                _left += e.delta.dx;
              });
            },
            onHorizontalDragEnd: (DragEndDetails e) {
              print("onHorizontalDragEnd");
            },
            onTapDown: (e) {
              print("down");
            },
            onTapUp: (e) {
              print("up");
            },
          ),
        ),
        Positioned(
          top: 100.0,
          left: _leftB,
          child: Listener(
            onPointerDown: (e) {
              print("down");
            },
            onPointerUp: (e) {
              print("up");
            },
            child: GestureDetector(
              child: CircleAvatar(
                child: Text("B"),
              ),
              onHorizontalDragUpdate: (DragUpdateDetails e) {
                setState(() {
                  _leftB += e.delta.dx;
                });
              },
              onHorizontalDragEnd: (e) {
                print("onHorizontalDragEnd");
              },
            ),
          ),
        ),
      ],
    );
  }
}
