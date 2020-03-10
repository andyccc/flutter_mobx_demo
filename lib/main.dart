import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_testmobx/provider/count_provider.dart';
import 'package:provider/provider.dart';

import 'GradientCircularProgressIndicator.dart';
import 'GradientCircularProgressRoute.dart';
import 'alert_demo.dart';
import 'animated_demo2.dart';
import 'animation_demo.dart';
import 'animation_test.dart';
import 'asyncui_demo.dart';
import 'card_demo.dart';
import 'clip_demo.dart';
import 'counter_page.dart';
import 'demo05.dart';
import 'dio_demo.dart';
import 'eventbus_demo.dart';
import 'gesture_demo.dart';
import 'hero_demo.dart';
import 'method_channel_demo.dart';
import 'noti2_demo.dart';
import 'noti_demo.dart';
import 'painter_demo.dart';
import 'point_demo.dart';
import 'provider/provider_demo.dart';
import 'route_demo.dart';
import 'table_demo.dart';
import 'zuhe_demo.dart';

void reportErrorAndLog(details) {
  print("异常：" + details.toString());
}

void collectLog(line) {
  print("log: " + line);
}

String makeDetails(obj, stack) {
  return obj.toString() + " - " + stack.toString();
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountProvider()),
      ],
      child: MyApp(),
    ),

    // ChangeNotifierProvider(
    //   create: (context) => CountProvider(),
    //   child: MyApp(),
    // ),
  );
}

void main2() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };
  runZoned(
    () => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CountProvider()),
        ],
        child: MyApp(),
      ),

      // ChangeNotifierProvider(
      //   create: (context) => CountProvider(),
      //   child: MyApp(),
      // ),
    ),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line); // 收集日志
      },
    ),
    onError: (Object obj, StackTrace stack) {
      var details = makeDetails(obj, stack);
      reportErrorAndLog(details);
    },
  );
}

//
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // home: CounterPage(),
      routes: {
        "count": (context) => CounterPage(),
        "alert": (context) => AlertDemo(),
        "table": (context) => TableDemo(),
        "card": (context) => CardDemo(),
        "demo05": (context) => Demo05(),
        "providerDemo": (context) => ProviderDemo(),
        "providerDemo2": (context) => ProviderDemo2(),
        "dioDemo": (context) => DioDemo(),
        "ClipDemo": (context) => ClipDemo(),
        "AsyncuiDemo": (context) => AsyncuiDemo(),
        "AsyncuiPageDemo": (context) => AsyncuiPageDemo(),
        "Asyncui2PageDemo": (context) => Asyncui2PageDemo(),
        "PointerDemo": (context) => PointerDemo(),
        "GestureDemo": (context) => GestureDemo(),
        "EventBusDemo": (context) => EventBusDemo(),
        "EventBusDemo2": (context) => EventBusDemo2(),
        "notidemo": (context) => NotiDemo(),
        "notidemo2": (context) => Noti2Demo(),
        "AnimationDemo": (context) => AnimationDemo(),
        "RouteDemo": (context) => RouteDemo(),
        "HeroDemo": (context) => HeroDemo(),
        "AnimatedDecoratedBox": (context) => AnimatedDecoratedBoxDemo(),
        "AnimatedWidgetsTest": (context) => AnimatedWidgetsTest(),
        "GradientButtonRoute": (context) => GradientButtonRoute(),
        "CustomPaintRoute": (context) => CustomPaintRoute(),
        "GradientCircularProgressRoute": (context) =>
            GradientCircularProgressRoute(),
        "ChannelMethodDemo": (context) => ChannelMethodDemo(),
      },
      initialRoute: "ChannelMethodDemo",

      onGenerateRoute: (RouteSettings s) {
        print(s.name);
        switch (s.name) {
          case "dioDemo00":
            return MaterialPageRoute(builder: (context) {
              return DioDemo();
            });
            break;
          default:
        }
        return null;
      },
    );
  }
}
