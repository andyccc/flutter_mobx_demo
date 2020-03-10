import 'package:flutter/material.dart';

class RouteDemo extends StatefulWidget {
  @override
  _RouteDemoState createState() => _RouteDemoState();
}

class _RouteDemoState extends State<RouteDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("路由"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              child: Text("test"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RouteDemo2();
                    },
                  ),
                );
              },
            ),
            TextButton(
              child: Text("test1"),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration:
                        Duration(milliseconds: 500), // 动画时间为500毫秒
                    pageBuilder: (BuildContext context, Animation animation,
                        Animation secondAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: RouteDemo2(), // 路由b
                      );
                    },
                  ),
                );
              },
            ),
            TextButton(
              child: Text("test2"),
              onPressed: () {
                Navigator.push(
                  context,
                  FadeRoute(builder: (context) {
                    return RouteDemo2();
                  }),
                );
              },
            ),
            TextButton(
              child: Text("test3"),
              onPressed: () {
                Navigator.push(
                  context,
                  FadeRoute2(builder: (context) {
                    return RouteDemo2();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RouteDemo2 extends StatefulWidget {
  @override
  _RouteDemo2State createState() => _RouteDemo2State();
}

class _RouteDemo2State extends State<RouteDemo2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("路由2"),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class FadeRoute extends PageRoute {
  final WidgetBuilder builder;
  @override
  final Duration transitionDuration;

  @override
  final bool opaque;
  @override
  final bool barrierDismissible;
  @override
  final Color barrierColor;
  @override
  final String barrierLabel;
  @override
  final bool maintainState;

  FadeRoute(
      {@required this.builder,
      this.transitionDuration,
      this.opaque,
      this.barrierDismissible,
      this.barrierColor,
      this.barrierLabel,
      this.maintainState});

  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  Widget buildTransition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: builder(context));
  }
}

class FadeRoute2 extends PageRoute {
  FadeRoute2({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (isActive) {
      // 当前路由被激活，是打开新路由
      return FadeTransition(
        opacity: animation,
        child: builder(context),
      );
    } else {
      // 是返回，则不应该用过渡动画
      return Padding(padding: EdgeInsets.zero);
    }
  }
}
