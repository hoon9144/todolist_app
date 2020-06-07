import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist0604/model/user.dart';

class TodoList extends StatefulWidget {
  var uid;
  TodoList({this.uid});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<User> userList = [];

  _mytodolist() async {
    var res = await http.get('http://192.168.0.8:3000/user/${widget.uid}');
    List<User> parse =
        jsonDecode(res.body).map<User>((json) => User.FromJson(json)).toList();
    setState(() {
      userList.clear();
      userList.addAll(parse);
    });
  }

//  @override
//  void setState(fn) {
//    // TODO: implement setState
//    super.setState(fn);
//    _mytodolist();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ㅁㅔ인화면'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _mytodolist();
                })
          ],
        ),
        body: FutureBuilder(
            future: _mytodolist(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
              if (snapshot.hasData == null) {
                return CircularProgressIndicator();
              } //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }
              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
              else {
                return Row(
                  children: <Widget>[
                    Text(
                      '이메일 :${userList[0].uemail} 이름 : ${userList[0].uname} 나이 : ${userList[0].uage} 주소 : ${userList[0].uaddress}',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                );
              }
            }));
  }
}
