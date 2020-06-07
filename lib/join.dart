import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist0604/model/user.dart';
class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {

  var _id = '아이디 중복체크';
  var _color = Colors.blue;

  TextEditingController emailTf = TextEditingController();
  TextEditingController pwdTf = TextEditingController();
  TextEditingController nameTf = TextEditingController();
  TextEditingController ageTf = TextEditingController();
  TextEditingController addressTf = TextEditingController();
  
  
  void _idCheck() async{

    var data = jsonEncode({
      'uemail':emailTf.text
    });
    
    var res = await http.post('http://192.168.0.8:3000/join/idcheck' , body: data , headers: {'content-type': "application/json"});
    var parse = jsonDecode(res.body);
    setState(() {
      _id = parse['msg'];
      bool check = parse['color'];
      print(check);
      check ? _color = Colors.green : _color = Colors.red;
    });
  }
  
  void userJoin(BuildContext context) async{

    var data = jsonEncode({
      'email' : emailTf.text,
      'name':nameTf.text,
      'age':ageTf.text,
      'address':addressTf.text,
      'pwd':pwdTf.text
    });

    var res = await http.post('http://192.168.0.8:3000/join/user',body: data ,headers: {'content-type' : 'application/json'});
    if(res.statusCode == 200){
      _showDialog(context);
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("회원가입 성공"),
          content: new Text("환영합니다 로그인후 사용해주세요!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
                goLogin();
              },
            ),
          ],
        );
      },
    );
  }

  void goLogin(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('회원가입')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Image.network('https://dimg.donga.com/wps/NEWS/IMAGE/2019/10/13/97852357.2.jpg'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailTf,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'email',
                  border: OutlineInputBorder(),
                )
              ),
              FlatButton(
                  color: _color,
                  onPressed: (){
                    _idCheck();
                    print('email => ${emailTf.text}');
              }, child: Text(_id))
              ,
              SizedBox(height: 10),
              TextField(
                controller: pwdTf,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'pwd',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameTf,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'uname',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: ageTf,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'uage',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: addressTf,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'uaddress',
                  border: OutlineInputBorder(),
                ),
              ),
              FlatButton(
                  color: Colors.deepPurple,
                  onPressed: (){
                    userJoin(context);
                  print('''
                  email => ${emailTf.text}
                  pwd => ${pwdTf.text}
                  name => ${nameTf.text}
                  age => ${ageTf.text}
                  address => ${addressTf.text}
                  ''');
              }, child: Text('회원가입'))
            ],
          ),
        ));
  }
}
