import 'package:flutter/material.dart';

class HeroDemo extends StatefulWidget {
  @override
  _HeroDemoState createState() => _HeroDemoState();
}

class _HeroDemoState extends State<HeroDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hero动画"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            InkWell(
              child: Hero(
                tag: "avatar",
                child: ClipOval(
                  child: Image.asset(
                    "./images/bbb.png",
                    width: 50.0,
                  ),
                ),
              ),
              onTap: () {
                // 打开B路由
                // Navigator.push(
                //   context,
                //   PageRouteBuilder(
                //     pageBuilder: (BuildContext context, Animation animation,
                //         Animation secondaryAnimation) {
                //       return FadeTransition(
                //         opacity: animation,
                //         child: Scaffold(
                //           appBar: AppBar(
                //             title: Text("原图"),
                //           ),
                //           body: HeroAnimationRouteB(),
                //         ),
                //       );
                //     },
                //   ),
                // );

// StaggerRoute

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (BuildContext context) {
                //     return Scaffold(
                //       appBar: AppBar(
                //         title: Text("交织动画"),
                //       ),
                //       body: StaggerRoute(),
                //     );
                //   }),
                // );

                // AnimatedSwithcerCounter
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text("切换动画"),
                        ),
                        body: AnimatedSwithcerCounter(),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(tag: "avatar", child: Image.asset("./images/bbb.png")),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    // 高度动画
    height = Tween<double>(begin: .0, end: 300.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.6, // 间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.6, // 间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    padding = Tween<EdgeInsets>(
            begin: EdgeInsets.only(left: .0), end: EdgeInsets.only(left: 100.0))
        .animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6,
          1.0, // 间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}

class StaggerRoute extends StatefulWidget {
  @override
  _StaggerRouteState createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
  }

  Future<Null> _playAnimation() async {
    try {
      // 先正向执行动画
      await _controller.forward().orCancel;
      // 再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _playAnimation();
      },
      child: Center(
        child: Container(
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // 调用我们定义的交织动画Widget
          child: StaggerAnimation(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}

class AnimatedSwithcerCounter extends StatefulWidget {
  @override
  _AnimatedSwithcerCounterState createState() =>
      _AnimatedSwithcerCounterState();
}

class _AnimatedSwithcerCounterState extends State<AnimatedSwithcerCounter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              // 执行缩放动画
              // return ScaleTransition(
              //   scale: animation,
              //   child: child,
              // );

              // var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
              // return MySlideTransition(
              //   child: child,
              //   position: tween.animate(animation),
              // );
              var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
              return SlideTransitionX(
                position: animation,
                child: child,
                direction: AxisDirection.left,
              );
            },
            child: Text(
              "$_count",
              key: ValueKey(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
            child: Text('+1'),
          ),
        ],
      ),
    );
  }
}

class MySlideTransition extends AnimatedWidget {
  MySlideTransition(
      {Key key,
      @required Animation<Offset> position,
      this.transformHitTests = true,
      this.child})
      : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    // 动画反向执行时，调整x偏移，实现”从左滑出隐藏“
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }

    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX(
      {Key key,
      @required Animation<double> position,
      this.transformHitTests = true,
      this.child,
      this.direction = AxisDirection.down})
      : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;
  final bool transformHitTests;

  final Widget child;

// 退场 （出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
      }
    }

    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
