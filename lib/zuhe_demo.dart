import 'package:flutter/material.dart';

class GradientButtonRoute extends StatefulWidget {
  @override
  GradientButtonRouteState createState() => GradientButtonRouteState();
}

class GradientButtonRouteState extends State<GradientButtonRoute> {
  void _onTap() {
    print("click ...");
  }

  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("组合现有组件"),
      ),
      body: Column(
        children: [
          GradientButton(
            child: Text("Submit"),
            colors: [Colors.orange, Colors.red],
            height: 50.0,
            width: double.infinity,
            onPressed: _onTap,
          ),
          GradientButton(
            child: Text("Submit"),
            colors: [Colors.lightGreen, Colors.green[700]],
            height: 50.0,
            width: double.infinity,
            onPressed: _onTap,
          ),
          GradientButton(
            child: Text("Submit"),
            colors: [Colors.lightBlue[300], Colors.blueAccent],
            height: 50.0,
            width: double.infinity,
            onPressed: _onTap,
          ),
          SizedBox(
            height: 10,
          ),
          // Spacer(
          //     // flex: 00,
          //     ),
          TurnBox(
            turns: _turns,
            speed: 500,
            child: Icon(
              Icons.refresh,
              size: 50,
            ),
          ),
          TurnBox(
            turns: _turns,
            speed: 1000,
            child: Icon(
              Icons.refresh,
              size: 150,
            ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                _turns += 0.2;
              });
            },
            child: Text("顺时针旋转1/5圈"),
          )
        ],
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  GradientButton({
    this.colors,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    @required this.child,
  });

  // 渐变色数组
  final List<Color> colors;
  // 按钮宽高
  final double width;
  final double height;

  final Widget child;
  final BorderRadius borderRadius;

  // 点击回调
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // 确保colors数组不为空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints:
                BoxConstraints.tightForFinite(height: height, width: width),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TurnBox extends StatefulWidget {
  TurnBox({
    Key key,
    this.turns = .0,
    this.speed = 200,
    this.child,
  });

  final double turns;
  final int speed;
  final Widget child;

  @override
  _TurnBoxState createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed ?? 200),
        curve: Curves.easeOut,
      );
    }
  }
}

class MyRichText extends StatefulWidget {
  const MyRichText({
    Key key,
    this.text,
    this.linkStyle,
  }) : super(key: key);

  final String text;
  final TextStyle linkStyle;

  @override
  _MyRichTextState createState() => _MyRichTextState();
}

class _MyRichTextState extends State<MyRichText> {
  TextSpan _textSpan;
  @override
  Widget build(BuildContext context) {
    return RichText(text: _textSpan);
  }

  TextSpan parseText(String text) {
    // 耗时操作：解析文本字符串，构建出TextSpan,
    // 省略具体实现。
  }

  @override
  void initState() {
    super.initState();
    _textSpan = parseText(widget.text);
  }

  @override
  void didUpdateWidget(MyRichText oldWidget) {
    if (widget.text != oldWidget.text) {
      _textSpan = parseText(widget.text);
    }

    super.didUpdateWidget(oldWidget);
  }
}
