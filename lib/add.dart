import 'package:flutter/material.dart';
//import 'package:fluttercruddb/list.dart';
import 'package:http/http.dart' as http;

import 'list.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerUmur = TextEditingController();

  void addData() {
    var url = Uri.parse(
        "https://fajardomain.000webhostapp.com/fluttercruddb/add.php");
    http.post(url,
        body: {"nama": controllerName.text, "umur": controllerUmur.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah data")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          TextField(
            controller: controllerName,
            // ignore: prefer_const_constructors
            decoration: InputDecoration(hintText: "Nama", labelText: "Nama"),
          ),
          TextField(
            controller: controllerUmur,
            // ignore: prefer_const_constructors
            decoration: InputDecoration(hintText: "Umur", labelText: "Umur"),
          ),
        ]),
      ),
      bottomNavigationBar: ElevatedButton(
        child: const Text("Tambah"),
        onPressed: () {
          addData();
          Navigator.of(context).pop(ListPage());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ListPage()),
          // );
          // Navigator.pop(
          //     context, MaterialPageRoute(builder: (context) => ListPage()));

          // setState(() {
          // Navigator.pop(context);
          // });
        },
      ),
    );
  }
}
