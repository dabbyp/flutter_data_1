import 'package:flutter/material.dart';
import 'package:flutter_data_1/screens/list_screen.dart';
import 'package:flutter_data_1/screens/list_screen_from_sqlite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future setLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogi', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          width: MediaQuery.of(context).size.width * 0.85,
          child: ElevatedButton(
            onPressed: () {
              setLogin().then((_) {
                Navigator.of(context).pushReplacement(
                    //MaterialPageRoute(builder: (context) => ListScreen()));
                    MaterialPageRoute(
                        builder: (context) => ListScreenFromSqlite()));
              });
            },
            child: Text('로그인'),
          ),
        ),
      ),
    );
  }
}
