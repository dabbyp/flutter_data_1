import 'dart:async';
import 'package:flutter_data_1/screens/list_screen_from_sqlite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_data_1/screens/list_screen.dart';
import 'package:flutter_data_1/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    print("[*] isLogin : " + isLogin.toString());
    return isLogin;
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      moveScreen();
    });
  }

  void moveScreen() async {
    await checkLogin().then((isLogin) {
      if (isLogin) {
        Navigator.of(context).pushReplacement(
            //MaterialPageRoute(builder: (context) => ListScreen()));
            MaterialPageRoute(builder: (context) => ListScreenFromSqlite()));
      } else {
        Navigator.of(context).pushReplacement(
            //MaterialPageRoute(builder: (context) => LoginScreen()));
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SplashScreen', style: TextStyle(fontSize: 20)),
            Text('나만의 일정 관리 : TODO 리스트 앱', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
