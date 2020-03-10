import 'package:flutter/material.dart';

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);

    // 图片宽高 从0 到300
    // animation = Tween(begin: 0.0, end: 300.0).animate(controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });

// 图片宽高 从0 到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画执行结束时反向执行动画
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // 动画恢复到初始状态时执行动画（正向）
          controller.forward();
        }
      });

    // 启动动画 正向执行
    controller.forward();
  }

  @override
  void dispose() {
    // 路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画'),
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       TextButton(
      //         onPressed: () {
      //           controller.forward();
      //         },
      //         child: Text("开始动画"),
      //       ),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Image.asset(
      //         "./images/bbb.png",
      //         width: animation.value,
      //         height: animation.value,
      //       ),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       TextButton(
      //         onPressed: () {
      //           controller.reverse();
      //         },
      //         child: Text("后退动画"),
      //       ),
      //     ],
      //   ),
      // ),

      // body: AnimatedImage(animation: animation),

      // body: AnimatedBuilder(
      //   animation: animation,
      //   child: Image.asset("images/bbb.png"),
      //   builder: (bc, child) {
      //     return Center(
      //       child: Container(
      //         child: child,
      //         height: animation.value,
      //         width: animation.value,
      //       ),
      //     );
      //   },
      // ),

      body: GrowTransition(
        child: Image.asset("images/bbb.png"),
        animation: animation,
      ),
    );
  }
}

/**
 
 用 AnimatedBuilder 的好处
不用显式的去添加帧监听器，然后再调用setState() 了，这个好处和AnimatedWidget是一样的。

动画构建的范围缩小了，如果没有builder，setState()将会在父组件上下文中调用，这将会导致父组件的build方法重新调用；而有了builder之后，只会导致动画widget自身的build重新调用，避免不必要的rebuild。

通过AnimatedBuilder可以封装常见的过渡效果来复用动画。下面我们通过封装一个GrowTransition来说明，它可以对子widget实现放大动画：




 */

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        "./images/bbb.png",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const GrowTransition({Key key, this.animation, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        child: child,
        animation: animation,
        builder: (bc, child) {
          return Container(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
      ),
    );
  }
}
