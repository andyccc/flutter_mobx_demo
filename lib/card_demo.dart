import 'package:flutter/material.dart';

class CardDemo extends StatefulWidget {
  @override
  _CardDemoState createState() => _CardDemoState();
}

class _CardDemoState extends State<CardDemo> {
  List<Map> list = List<Map>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      list.add({"age": 10 * i, "name": "wang" + i.toString()});
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.blue,
      elevation: 10,
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Text(list[index]["name"]),
          Text(list[index]["age"].toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("card 演示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        // child: ListView.builder(
        //   itemBuilder: _itemBuilder,
        //   itemCount: list.length,
        // ),
        child: ListView(
          children: [
            ListTile(
              title: Text("data"),
              tileColor: Colors.red,
              subtitle: Text("data2"),
              leading: Icon(Icons.add),
              trailing: Icon(Icons.arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}
