import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'JSON_data/album.dart';
import 'JSON_data/getAlbum.dart';
import 'Local_data/local_data.dart';

class anasayfa extends StatelessWidget {
  const anasayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber.shade900,
            elevation: 10,
            toolbarHeight: 10,
            bottom: TabBar(
              tabs: <Widget>[
                Text(
                  'Local Data',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  'JSON Data',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            ),
          ),
          body: TabBarView(
              children: <Widget>[localData_extend(), jsonData_extends()]),
        ),
      ),
    );
  }
}

class localData_extend extends StatefulWidget {
  const localData_extend({Key? key}) : super(key: key);

  @override
  State<localData_extend> createState() => _localData_extendState();
}

class _localData_extendState extends State<localData_extend> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: MyListBuilder(),
      ),
    );
  }
}

class jsonData_extends extends StatefulWidget {
  const jsonData_extends({Key? key}) : super(key: key);

  @override
  State<jsonData_extends> createState() => _jsonData_extendsState();
}

class _jsonData_extendsState extends State<jsonData_extends> {
  late Future<MyPost> album;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    album = getAlbum();
    fetchPost();
  }

  var url = "https://jsonplaceholder.typicode.com/albums";
  var _postJson = [];
  void fetchPost() async {
    try {
      final response1 = await get(Uri.parse(url));
      final jsonData = jsonDecode(response1.body) as List;
      setState(() {
        _postJson = jsonData;
      });
    } catch (err) {
      print("Error1");
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchPost();
    return Scaffold(
      body: FutureBuilder(
          future: album,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: _postJson.length,
                itemBuilder: (BuildContext context, int i) {
                  final post = _postJson[i];
                  return InkWell(
                    onTap: () {},
                    splashColor: Colors.amber.shade900,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, right: 5),
                      child: Container(
                        height: 100,
                        width: 250,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.amber.shade700,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 30,
                              child: Icon(
                                Icons.face_outlined,
                                color: Colors.pink,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "User ID ${post["id"]}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "Title : ${post["title"]}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return Center(
              child: const CircularProgressIndicator(),
            );
          }),
    );
  }

  //extra try***
  Container buildContainer(int index, AsyncSnapshot<dynamic> snapshot) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
        borderRadius: BorderRadius.circular(9),
        color: Colors.amber.shade700,
      ),
      child: ListTile(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.amber.shade700,
          ),
          width: double.infinity,
          height: 40,
          child: Row(
            children: [
              Column(
                children: [
                  Icon(
                    Icons.face_outlined,
                    color: Colors.purple,
                  ),
                  Text(
                    'USER ID ${snapshot.data.userId} ',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Center(
                child: Text(
                  'ID ${snapshot.data.id} : '
                  '${snapshot.data.title}',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
