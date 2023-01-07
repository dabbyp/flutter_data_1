# flutter_data_1

- DB 데이터 연결

- dependency
# pubspec.yaml
```DART
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.0.6
  sqflite: ^2.0.0+3
  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
```

## 프로젝트 구성
- main<br>
  lib/main.dart
```DART
import 'package:flutter/material.dart';
import 'package:flutter_data_1/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
```

- 화면<br>
  lib/screens/list_screen.dart<br>
  lib/screens/login_screen.dart<br>
  lib/screens/news_screen.dart<br>
  lib/screens/splash_screen.dart<br>
  lib/providers/todo_default.dart<br>
  lib/models/todo.dart<br>
  
- 환경설정 목적의 단순한 key-value db : SharedPreferences
```DART
// SharedPreferences
import 'package:shared_preferences/shared_preferences.dart';

class _SplashScreenState extends State<SplashScreen> {
// read
  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    print("[*] isLogin : " + isLogin.toString());
    return isLogin;
  }
// write
  Future setLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogi', true);
  }
}
```

- 람다식, _
```DART
            onPressed: () {
              // 파라미터변수가 있긴한데 사용하지 않을 예정이면 '_' 로 기재할 수 있음
              setLogin().then((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ListScreen()));
              });
            },
```DART

- 경량화 DB, sqlite
```DART
// TODO
```

## 실행화면
- TODO
