import 'package:flutter/material.dart';
import 'package:flutter_testmobx/provider/count_provider.dart';
import 'package:provider/provider.dart';

class ProviderDemo extends StatefulWidget {
  @override
  _ProviderDemoState createState() => _ProviderDemoState();
}

class _ProviderDemoState extends State<ProviderDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider 状态管理"),
      ),
      body: Column(
        children: [
          Text(Provider.of<CountProvider>(context).count.toString()),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, "providerDemo2");
            },
            child: Text("跳转"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CountProvider>().addCount();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProviderDemo2 extends StatefulWidget {
  @override
  _ProviderDemo2State createState() => _ProviderDemo2State();
}

class _ProviderDemo2State extends State<ProviderDemo2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("provider"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CountProvider>().addCount();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
