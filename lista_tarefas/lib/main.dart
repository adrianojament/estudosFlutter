import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];

  final _toDoController = TextEditingController();

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newTodo = Map();

      newTodo["title"] = _toDoController.text;
      newTodo["ok"] = false;

      _toDoController.text = "";

      _toDoList.add(newTodo);
      _saveData();
    });
  }

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _toDoController,
                  decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Colors.blueAccent)),
                )),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Incluir"),
                  textColor: Colors.white,
                  onPressed: _addToDo,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: _toDoList.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_toDoList[index]["title"]),
                    value: _toDoList[index]["ok"],
                    secondary: CircleAvatar(
                      child: Icon(
                          _toDoList[index]["ok"] ? Icons.check : Icons.error),
                    ),
                    onChanged: (bool check) {
                      setState(() {
                        _toDoList[index]["ok"] = check;
                        _saveData();
                      });
                    },
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/tarefas.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
