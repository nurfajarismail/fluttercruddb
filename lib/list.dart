import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'details.dart';

// ignore: must_be_immutable
class ItemList extends StatefulWidget {
  final List list;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ItemList({required this.list});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  Future<List> getData() async {
    final response = await http.get(Uri.parse(
        "https://fajardomain.000webhostapp.com/fluttercruddb/list.php"));
    return jsonDecode(response.body);
    // ignore: dead_code
  }

  FutureOr onGoBack(dynamic value) {
    getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // ignore: unnecessary_null_comparison
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, index) {
        return Card(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(widget.list[index]['nama']),
              ],
            ),
            // ignore: prefer_const_literals_to_create_immutables
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(
                      builder: (context) => DetailOrang(widget.list, index),
                    );

                    Navigator.push(context, route).then((onGoBack));
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: ((context) =>
                    //         DetailOrang(widget.list, index))));
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return DetailOrang(widget.list, index);
                    // }));
                  },
                  child: const Text("Detail"),
                ),
                ElevatedButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Peringatan'),
                      content:
                          const Text('Apakah anda yakin ingin menghapus ini?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Kembali'),
                        ),
                        TextButton(
                          onPressed: () {
                            // deleteData();
                            Navigator.of(context).pop();
                          },
                          child: const Text('YA'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text("Hapus"),
                ),
              ],
            )
          ],
        ));
      },
    );
  }

  // void deleteData() {
  //   var url = Uri.parse(
  //       "https://fajardomain.000webhostapp.com/fluttercruddb/delete.php");
  //   http.post(url, body: {'id': list[index]['id']});
  // }
}
