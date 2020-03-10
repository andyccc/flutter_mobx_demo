import 'dart:developer';

import 'package:flutter_testmobx/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_testmobx/mobx_ext.dart';

class CounterPage extends StatelessWidget {
  final Counter counter = Counter();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Flutter and MobX'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Counter',
                style: TextStyle(fontSize: 30.0),
              ),
              // Observer(
              //   builder: (_) =>
              //       Text('${counter.value}', style: TextStyle(fontSize: 42.0)),
              // ),
              buildTest(),
              // buildTest2(),
              Text('mobx ext ：${counter.cvalue}', style: TextStyle(fontSize: 42.0)).mobxObserver(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Add'),
                    onPressed: counter.increment,
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.remove),
                    label: Text('Remove'),
                    onPressed: counter.decrement,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildTest(){

    return Observer(
          builder: (_) =>
              Text('${counter.value}', style: TextStyle(fontSize: 42.0)),
        );
  }
  Widget buildTest2() {

   return Text('mobx ext ：${counter.cvalue}', style: TextStyle(fontSize: 42.0)).mobxObserver();

  }


}