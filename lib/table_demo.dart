import 'package:flutter/material.dart';

class TableDemo extends StatefulWidget {
  @override
  _TableDemoState createState() => _TableDemoState();
}

class _TableDemoState extends State<TableDemo> {
  List list = List();
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      list.add({
        "name": "w" * i,
        "sex": i % 2 == 0 ? "男" : "女",
        "sel": false,
        "age": i,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("表格演示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        // child: Table(
        //   border: TableBorder.all(
        //     color: Colors.grey,
        //   ),
        //   children: list
        //       .map((e) => TableRow(children: [
        //             Text(e["name"]),
        //             Text(e["sex"]),
        //           ]))
        //       .toList(),
        // ),

        child: DataTable(
          onSelectAll: (v) {
            for (int i = 0; i < list.length; i++) {
              if (list[i]["sel"] != v) {
                setState(() {
                  list[i]["sel"] = v;
                });
              }
            }
          },
          columns: [
            DataColumn(
              label: Text("姓名"),
              onSort: (columnIndex, ascending) {
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = ascending;
                  list.sort((a, b) {
                    if (!ascending) {
                      var c = a;
                      a = b;
                      b = c;
                    }
                    return a["name"]
                        .toString()
                        .length
                        .compareTo(b["name"].toString().length);
                  });
                });
              },
            ),
            DataColumn(
              label: Text("年龄"),
              onSort: (columnIndex, ascending) {
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = ascending;
                  list.sort((a, b) {
                    if (!ascending) {
                      var c = a;
                      a = b;
                      b = c;
                    }
                    return a["age"].compareTo(b["age"]);
                  });
                });
              },
            ),
            DataColumn(label: Text("性别")),
          ],
          rows: list
              .map((e) => DataRow(
                  selected: e["sel"],
                  cells: [
                    DataCell(Text(e["name"])),
                    DataCell(Text(e["age"].toString())),
                    DataCell(Text(e["sex"])),
                  ],
                  onSelectChanged: (v) {
                    if (e["sel"] != v) {
                      setState(() {
                        e["sel"] = v;
                      });
                    }
                  }))
              .toList(),
          sortAscending: _sortAscending,
          sortColumnIndex: _sortColumnIndex,
        ),
      ),
    );
  }
}
