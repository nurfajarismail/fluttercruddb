// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttercruddb/add.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'list.dart';

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
    // ignore: dead_code
  }

  FutureOr onGoBack(dynamic value) {
    getData();
    setState(() {});
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => const AddData());
    Navigator.push(context, route).then(onGoBack);
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
          navigateSecondPage();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
