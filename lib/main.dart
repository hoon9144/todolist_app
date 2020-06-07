import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist0604/join.dart';
import 'package:todolist0604/todolist.dart';

void main() => runApp(MaterialApp(
      home: IsLogined(),
    ));

class IsLogined extends StatefulWidget {
  @override
  _IsLoginedState createState() => _IsLoginedState();
}

class _IsLoginedState extends State<IsLogined> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLogin = false;



  TextEditingController emailTf = TextEditingController();
  TextEditingController pwdTf = TextEditingController();

  var result;
  //Future<http.Response>
  void _isLoginCheck() async {
      var data = jsonEncode({
        "email":emailTf.text.trim(),
        "pwd":pwdTf.text.trim()
      });
      var res = await http.post('http://192.168.0.8:3000/login' , body: data , headers: {'content-type': "application/json"});
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body.toString()}');
      result = jsonDecode(res.body);
      setState(() {
        _isLogin = result['result'];
        print('result => ${result['result']}');
        print('result => ${result['msg']}');
        show();
      });
      if(_isLogin){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TodoList()));
      }
  }

  void show(){
    scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(result['msg'])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://img.insight.co.kr/static/2016/06/13/2000/s2q33j23pj02068k8j7v.jpg'),
            SizedBox(height: 30),
            TextField(
              controller: emailTf,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: '이메일',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: pwdTf,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호',
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                     _isLoginCheck();
                    print('email => ${emailTf.text} pwd => ${pwdTf.text}');
                  },
                  child: Text('로그인'),
                  color: Colors.orangeAccent,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Join()));
                  },
                  child: Text('회원가입'),
                  color: Colors.orangeAccent,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
