import 'package:flutter/material.dart';
import 'package:fluttercruddb/list.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class DetailOrang extends StatelessWidget {
  List list;
  int index;
  DetailOrang(this.list, this.index, {Key? key}) : super(key: key);

  void deleteData() {
    var url = Uri.parse(
        "https://fajardomain.000webhostapp.com/fluttercruddb/delete.php");
    http.post(url, body: {'id': list[index]['id']});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Orang")),
      body: ListView(
          children: [Text(list[index]['nama']), Text(list[index]['umur'])]),
      bottomNavigationBar:
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(onPressed: () {}, child: const Text("Edit")),
        ElevatedButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Peringatan'),
              content: const Text('Apakah anda yakin ingin menghapus ini?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('kembali'),
                ),
                TextButton(
                  onPressed: () {
                    deleteData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListPage()),
                    );
                  },
                  child: const Text('YA'),
                ),
              ],
            ),
          ),
          child: const Text('Delete'),
        )
      ]),
    );
  }
}
