import 'package:flutter/material.dart';

class AnimatedDecoratedBoxDemo extends StatefulWidget {
  @override
  _AnimatedDecoratedBoxDemoState createState() =>
      _AnimatedDecoratedBoxDemoState();
}

class _AnimatedDecoratedBoxDemoState extends State<AnimatedDecoratedBoxDemo> {
  Color _decorationColor = Colors.blue;
  var duration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("过渡组件"),
      ),
      body: AnimatedDecoratedBox1(
        duration: duration,
        decoration: BoxDecoration(color: _decorationColor),
        child: FlatButton(
          onPressed: () {
            setState(() {
              _decorationColor = Colors.red;
            });
          },
          child: Text(
            "AnimatedDecoratedBox1",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class AnimatedDecoratedBox1 extends StatefulWidget {
  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration resverseDuration;

  const AnimatedDecoratedBox1(
      {Key key,
      @required this.decoration,
      @required this.duration,
      this.curve = Curves.linear,
      this.resverseDuration,
      this.child});

  @override
  _AnimatedDecoratedBox1State createState() => _AnimatedDecoratedBox1State();
}

class _AnimatedDecoratedBox1State extends State<AnimatedDecoratedBox1>
    with SingleTickerProviderStateMixin {
  @protected
  AnimationController _controller;
  AnimationController get controller => _controller;

  Animation<double> _animation;
  Animation<double> get animation => _animation;

  DecorationTween _tween;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.resverseDuration,
    );

    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    if (widget.curve != null) {
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    } else {
      _animation = _controller;
    }
  }

  @override
  void didUpdateWidget(AnimatedDecoratedBox1 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.curve != oldWidget.curve) {
      _updateCurve();
    }
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.resverseDuration;
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }
}
