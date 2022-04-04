import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}
class Users{
  String name;
  String city;

  Users(this.name, this.city);


  Users.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        city = json['city'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'cşty': city
  };
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool x=false;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // GET USERS
  List<Users> parseUsers(String response){
    var jsondata =json.decode(response);
    List<Users> list=List.empty(growable: true);
    for(var k in jsondata){
      var users = Users.fromJson(k);
      list.add(users);
    }
    return list;
  }

  Future<List<Users>> allUsers() async{
    setState(() {
      x=true;
    });
    var url = Uri.parse("https://mocki.io/v1/d4867d8b-b5d5-4a48-a4ab-79131b5809b8");

    var response = await http.get(url);

    return parseUsers(response.body);

  }

  Future<void> showUsers() async{
    var usr = await allUsers();
    for(var d in usr){
      print("-----------------");
      print("name : ${d.name}");
      print("city : ${d.city}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: ElevatedButton(
                onPressed: (){
                  showUsers();
                },
                child: Text("Test Me"),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
