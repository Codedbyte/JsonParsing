import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

List _data;
void main() async{
  _data = await fetchData();
  print(_data);

  runApp(new MaterialApp(
    title: 'parsingJson',
    home: new MyApp(),
  ));
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _MyAppState();
  }
}
class _MyAppState extends State<MyApp>{
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ParsingJson'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: new Center(
        child: ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (BuildContext context, int i){
              if(i.isOdd) return new Divider(color: Colors.black54,);
              final index = i~/2;
               return  new ListTile(
                 title: new Text('${_data[index]['name']}',
                 style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                 ),
                 subtitle: new Text('${_data[index]['capital']}',
              style: new TextStyle(fontSize: 14.0,fontStyle: FontStyle.italic),),
                 leading: new CircleAvatar(
                   backgroundColor: Colors.red,
                   child: new Text('${_data[index]['alpha2Code']}'),
                 ),
                 onTap: (){_showmessage(context, _data[index]['name']);}
               );
            })
      ),
    );
  }

  void _showmessage(BuildContext context, message) {
      var alert = new AlertDialog(
        title: new Text('Country Name'),
        content: new Text(message),
        actions: <Widget>[
          new FlatButton(onPressed: (){Navigator.pop(context);},
              child: new Text('OK'))
        ],
      );
      showDialog(context: context, child: alert);
  }
}
Future<List> fetchData() async {
  String url = 'https://restcountries.eu/rest/v2/all';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

