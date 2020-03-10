import 'package:flutter/material.dart';

class Demo05 extends StatefulWidget {
  @override
  _Demo05State createState() => _Demo05State();
}

class _Demo05State extends State<Demo05> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("性能优化"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.red,
          ),
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.yellow,
            child: CountDemo(),
          ),
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class CountDemo extends StatefulWidget {
  @override
  _CountDemoState createState() => _CountDemoState();
}

class _CountDemoState extends State<CountDemo> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(count.toString()),
      onTap: () {
        setState(() {
          count++;
        });
      },
    );
  }
}
