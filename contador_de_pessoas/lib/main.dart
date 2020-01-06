import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Contador de Pessoas",
      home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  int _lotacaoMaxima = 10;
  String _inforText = "Pode Entrar";

  void _changePeople(int delta){
    setState(() {
      _people += delta;
      if (_people < 0){
        _inforText = "Mundo invertido";
      }
      else if( _people <= _lotacaoMaxima){
        _inforText = "Pode Entrar";
      }
      else{
        _inforText = "Lotado";
        _people --;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset("images/restaurant.jpg", fit: BoxFit.cover, height: 1000.0),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Pessoas: $_people",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: FlatButton(
                  child: Text("+1",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    this._changePeople(1);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: FlatButton(
                  child: Text("-1",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    this._changePeople(-1);
                  },
                ),
              )
            ],
          ),
          Text("${this._inforText}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontStyle: FontStyle.italic))
        ],
      )
    ]);
  }
}
