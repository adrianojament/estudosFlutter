import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buscadorgifs/ui/git_page.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getGits() async {
    http.Response response;
    if (this._search == null || this._search.isEmpty)
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=uF6JLoKBhoJFFMv2Wsp5qq1I7Kh4SyEK&limit=20&rating=G");
    else
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=uF6JLoKBhoJFFMv2Wsp5qq1I7Kh4SyEK&q=&q=$_search&limit=19&offset=$_offset&rating=G&lang=en");

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGits().then((map) {
      print(map);
    });
  }

  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.network(
              "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Pesquisar Gifs",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder()),
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                  textAlign: TextAlign.center,
                  onSubmitted: (String text) {
                    setState(() {
                      _search = text;
                      _offset = 0;
                    });
                  },
                )),
            Expanded(
                child: FutureBuilder(
                    future: _getGits(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Container(
                              width: 200.00,
                              height: 200.00,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                                strokeWidth: 5.0,
                              ));
                          break;
                        default:
                          if (snapshot.hasError)
                            return Container();
                          else
                            return _createGitTable(context, snapshot);
                      }
                    }))
          ],
        ));
  }

  Widget _createGitTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.00),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.00, mainAxisSpacing: 10.00),
        itemCount: _getCount(snapshot.data["data"]),
        itemBuilder: (context, index) {
          if (_search == null || index < snapshot.data["data"].length)            
            return GestureDetector(
              child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, 
                image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                height: 250.0,
                fit: BoxFit.cover
                ),              
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index])));
              },
              onLongPress: (){
                Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
              },
              );
          else
            return Container(
              child: GestureDetector(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,  
                  children: <Widget>[
                  Icon(Icons.add, color: Colors.blueGrey, size: 70.00),
                  Text(
                    "Carregar mais",
                    style: TextStyle(color: Colors.black, fontSize: 22.0),
                  )
                ],
              ),
              onTap: (){
                setState(() {
                  _offset += 19;
                });
              },
              ),
            );
        });
  }
}
