// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttercruddb/add.dart';
import 'package:fluttercruddb/details.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ListPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List> getData() async {
    final response = await http.get(Uri.parse(
        "https://fajardomain.000webhostapp.com/fluttercruddb/list.php"));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar nama"),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          // ignore: avoid_print
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(list: snapshot.data ?? [])
              : const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddData()))
              .then((value) => getData());
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return const AddData();
          // })).then((value) => value ? getData() : null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  final List list;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ItemList({required this.list});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) =>
                            DetailOrang(widget.list, index))));
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return DetailOrang(widget.list, index);
                    // }));
                  },
                  child: const Text("Detail"),
                ),
              ],
            )
          ],
        ));
      },
    );
  }
}
