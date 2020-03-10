import 'package:flutter/material.dart';
import 'package:flutter_testmobx/utils/event_bus.dart';

class EventBusDemo extends StatefulWidget {
  @override
  _EventBusDemoState createState() => _EventBusDemoState();
}

class _EventBusDemoState extends State<EventBusDemo> {
  @override
  void initState() {
    super.initState();
    bus.on("login", (params) {
      print(" login: " + params.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("事件总线"),
      ),
      body: Container(
        child: Column(children: [
          TextButton(
            child: Text("test"),
            onPressed: () {},
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            child: Text("go to login"),
            onPressed: () {
              Navigator.pushNamed(context, "EventBusDemo2");
            },
          ),
        ]),
      ),
    );
  }
}

class EventBusDemo2 extends StatefulWidget {
  @override
  _EventBusDemo2State createState() => _EventBusDemo2State();
}

class _EventBusDemo2State extends State<EventBusDemo2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("事件总线2"),
      ),
      body: Container(
        child: Column(children: [
          TextButton(
            child: Text("login"),
            onPressed: () {
              bus.emit("login", {"id", "123"});
              Navigator.pop(context);
            },
          ),
        ]),
      ),
    );
  }
}
