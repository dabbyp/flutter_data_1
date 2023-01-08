# flutter_data_1

- DB 데이터 연결

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
```DART
/** 1.ListView.separated
* ListView.builder와 유사하지만 List의 각 요소들 사이에 구분자(Divider)를 넣어주는 기능을 제공
* 동일 리스트 아이템을 반복적으로 보여줄때 사용
**/
  body: isLoading
      ? Center(
          child: CircularProgressIndicator(),
        )
      : ListView.separated(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(todos[index].title),

/** 2.Timer를 활용한 데이터 초기화
**/
class _ListScreenState extends State<ListScreen> {
  late List<Todo> todos;
  TodoDefault todoDefault = TodoDefault();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print("[start] initState");
    Timer(Duration(seconds: 2), () {
      todos = todoDefault.getTodos();
      setState(() {
        isLoading = false;
      });
    });
    print("[end] initState");
  }

/** 3.AlertDialog
* alert 팝업창에 버튼추가가 필요한 경우 사용
**/
  floatingActionButton: FloatingActionButton(
    child: Text('+', style: TextStyle(fontSize: 25)),
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            String title = '';
            String description = '';
            return AlertDialog(
              title: Text('할 일 추가하기'),
              content: Container(
                height: 200,
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: InputDecoration(labelText: '제목'),
                    ),
                    TextField(
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: InputDecoration(labelText: '설명'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('추가'),
                  onPressed: () {
                    setState(() {
                      print("[UI] ADD");
                      todoDefault.addTodo(
                        Todo(title: title, description: description),
                      );
                    });
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('취소'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    },
  ),

/** 4.SimpleDialog
* alert 팝업창에 버튼추가가 필요없는 경우 사용
**/
return SimpleDialog(
  title: Text('할 일'),
  children: [
    Container(
      padding: EdgeInsets.all(10),
      child: Text('제목 : ' + todos[index].title),
    ),
    Container(
      padding: EdgeInsets.all(10),
      child: Text('설명 : ' + todos[index].description),
    ),
  ],
);

/** 5.hintText
* TextField의 속성으로 기본값을 지정할때 사용
**/
  TextField(
    onChanged: (value) {
      title = value;
    },
    decoration: InputDecoration(
      hintText: todos[index].title,
    ),
  ),

/** 6.DB insert & view
* DB에 입력하고 DB 입력된 리스트를 출력
**/
  // DB insert & view
  TextButton(
    child: Text('추가'),
    onPressed: () async {
      await todoSqlite.addTodo(
        Todo(title: title, description: description),
      );
      List<Todo> newTodos = await todoSqlite.getTodos();
      setState(() {
        print("[UI] ADD]");
        todos = newTodos;
      });

      Navigator.of(context).pop();
    },
  ),

```
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
```

- 경량화 DB, sqlite
```DART
import 'package:flutter_data_1/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoSqlite {
  late Database db;

  Future initDb() async {
    db = await openDatabase('my_db.db');
    await db.execute(
      'CREATE TABLE IF NOT EXISTS MyTodo (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, description TEXT)',
    );
  }

  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    List<Map> maps =
        await db.query('MyTodo', columns: ['id', 'title', 'description']);
    maps.forEach((map) {
      todos.add(Todo.fromMap(map));
    });
    return todos;
  }

  Future<Todo?> getTodo(int id) async {
    List<Map> map = await db.query('MyTodo',
        columns: ['id', 'title', 'description'],
        where: 'id = ?',
        whereArgs: [id]);
    if (map.length > 0) {
      return Todo.fromMap(map[0]);
    }
  }

  Future addTodo(Todo todo) async {
    int id = await db.insert('MyTodo', todo.toMap());
  }

  Future deleteTodo(int id) async {
    await db.delete('MyTodo', where: 'id = ?', whereArgs: [id]);
  }

  Future updateTodo(Todo todo) async {
    await db
        .update('MyTodo', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }
}
```

## 실행화면
- TODO
