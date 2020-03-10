import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioDemo extends StatefulWidget {
  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<DioDemo> {
  Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _dio.options.baseUrl = "https://www.jianshu.com/";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dio 网络"),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: _getAction,
            child: Text("get"),
          ),
          RaisedButton(
            onPressed: _getAction,
            child: Text("get"),
          ),
          RaisedButton(
            onPressed: _getAction,
            child: Text("get"),
          ),
          RaisedButton(
            onPressed: _getAction,
            child: Text("get"),
          ),
        ],
      ),
    );
  }

  void _getAction() async {
    var result = await _dio
        .get("shakespeare/notes/90741479/included_collections?page=1&count=7");
    print(result);

    if (result.statusCode == 200) {
      print('请求成功');
    }
  }
}
