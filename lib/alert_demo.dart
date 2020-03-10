import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlertDemo extends StatefulWidget {
  // const AlertDemo({ Key? key }) : super(key: key);

  @override
  _AlertDemoState createState() => _AlertDemoState();
}

class _AlertDemoState extends State<AlertDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("对话框"),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: _showAlert,
            child: Text("对话框"),
          ),
          TextButton(
            child: Text("iOS对话框"),
            onPressed: _showiOSAlert,
          ),
          TextButton(
            child: Text("simple对话框"),
            onPressed: _showSimpleAlert,
          ),
          TextButton(
            child: Text("date对话框"),
            onPressed: _showDatePicker1,
          ),
          TextButton(
            child: Text("ios date对话框"),
            onPressed: _showDatePicker2,
          ),
          TextButton(
            child: Text("loading对话框"),
            onPressed: showLoadingDialog,
          ),
          TextButton(
            child: Text("loading2对话框"),
            onPressed: showLoadingDialog2,
          ),
          TextButton(
            child: Text("sheet对话框"),
            onPressed: _showModalBottomSheet,
          ),
        ],
      ),
    );
  }

// 弹出底部菜单列表模态对话框
  Future<int> _showModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      },
    );
  }

  showLoadingDialog2() {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 280,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(
                    value: .1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: Text("正在加载，请稍后..."),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  Future<DateTime> _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(
        //未来30天可选
        Duration(days: 30),
      ),
    );
  }

  Future<DateTime> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              print(value);
            },
          ),
        );
      },
    );
  }

  _showSimpleAlert() async {
    List list = List();
    for (int i = 0; i < 20; i++) {
      list.add(i);
    }
    SimpleDialog alert = SimpleDialog(
      title: Text("这是标题"),
      children: list
          .map((e) => GestureDetector(
                child: Text(e.toString()),
                onTap: () {
                  Navigator.pop(context, e);
                },
              ))
          .toList(),
    );
    int index = await showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
    print(" index : " + index.toString());
  }

  _showiOSAlert() async {
    print("abc");
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text("这是标题"),
      content: Text("这是内容"),
      actions: [
        FlatButton(
            onPressed: () {
              print("ok...");
              Navigator.of(context).pop(true);
            },
            child: Text("确定")),
        FlatButton(
            onPressed: () {
              print("cel...");
              Navigator.of(context).pop(false);
            },
            child: Text("取消")),
      ],
    );

    bool result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return alert;
        });

    print(" result : " + result.toString());
  }

  _showAlert() async {
    print("abc");
    AlertDialog alert = AlertDialog(
      title: Text("这是标题"),
      content: Text("这是内容"),
      actions: [
        FlatButton(
            onPressed: () {
              print("ok...");
              Navigator.of(context).pop(true);
            },
            child: Text("确定")),
        FlatButton(
            onPressed: () {
              print("cel...");
              Navigator.of(context).pop(false);
            },
            child: Text("取消")),
      ],
    );

    bool result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return alert;
        });

    print(" result : " + result.toString());
  }
}

class DialogRoute extends StatefulWidget {
  @override
  _DialogRouteState createState() => _DialogRouteState();
}

class _DialogRouteState extends State<DialogRoute> {
  bool withTree = false; // 复选框选中状态

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text("对话框2"),
          onPressed: () async {
            bool delete = await showDeleteConfirmDialog2();
            if (delete == null) {
              print("取消删除");
            } else {
              print("同时删除子目录: $delete");
            }
          },
        ),
      ],
    );
  }

  Future<bool> showDeleteConfirmDialog2() {
    withTree = false; // 默认复选框不选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  Checkbox(
                    value: withTree,
                    onChanged: (bool value) {
                      //复选框选中状态发生变化时重新构建UI
                      setState(() {
                        //更新复选框状态
                        withTree = !withTree;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //执行删除操作
                Navigator.of(context).pop(withTree);
              },
            ),
          ],
        );
      },
    );
  }
}
