import 'dart:convert';
import 'package:flutter/material.dart';
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
    final response = await http
        .get(Uri.parse("https://fajardomain.000webhostapp.com/list.php"));
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
        ));
  }
}

class ItemList extends StatelessWidget {
  final List list;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // ignore: unnecessary_null_comparison
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, index) {
        return Card(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(list[index]['nama']),
              ],
            ),
            // ignore: prefer_const_literals_to_create_immutables
            Column(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text("Detail"),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Edit"),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Hapus"),
                )
              ],
            )
          ],
        ));
      },
    );
  }
}
