# flutter_data_1

- DB 데이터 연결

# pubspec.yaml
```DART
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.0.6
  sqflite: ^2.0.0+3
  firebase_core: ^2.4.1
  #firebase_auth: ^3.3.4
  cloud_firestore: ^4.3.1
  cupertino_icons: ^1.0.2
  firebase_core_platform_interface: 4.5.2
```

## 프로젝트 구성
- main<br>
  lib/main.dart
```DART
import 'package:flutter/material.dart';
import 'package:flutter_data_1/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Firebase 인스턴스 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
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
  lib/screens/list_screen_from_firebase.dart<br>
```DART
/** 1.StreamBuilder<QuerySnapshot>
* Firebase에서 데이터를 조회하여 결과가 반환되면
* 화면(Scaffold)을 구성
**/
@override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: todoFirebase.todoStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            todos = todoFirebase.getTodos(snapshot);
            return Scaffold(
              appBar: AppBar(
                title: Text('할 일 목록 앱'),


```
  lib/screens/login_screen.dart<br>
  lib/screens/news_screen.dart<br>
  lib/screens/splash_screen.dart<br>
  lib/providers/todo_firebase.dart<br>
```DART
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_data_1/models/todo.dart';
import 'package:flutter/material.dart';

class TodoFirebase {
  late CollectionReference todosReference;
  late Stream<QuerySnapshot> todoStream;

  Future initDb() async {
    todosReference = FirebaseFirestore.instance.collection('todos');
    todoStream = todosReference.snapshots();
  }

  List<Todo> getTodos(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      return Todo.fromSnapshot(document);
    }).toList();
  }

  Future addTodo(Todo todo) async {
    todosReference.add(todo.toMap());
  }

  Future updateTodo(Todo todo) async {
    todo.reference?.update(todo.toMap());
  }

  Future deleteTodo(Todo todo) async {
    todo.reference?.delete();
  }
}
```  
  lib/models/todo.dart<br>
  
```DART
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  late int? id;
  late String title;
  late String description;
  late DocumentReference? reference;

  Todo({
    this.id,
    required this.title,
    required this.description,
    this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  Todo.fromMap(Map<dynamic, dynamic>? map) {
    id = map?['id'];
    title = map?['title'];
    description = map?['description'];
  }

  Todo.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    id = map['id'];
    title = map['title'];
    description = map['description'];
    reference = document.reference;
  }
}
```
## 실행화면
- [https://dabbyp.github.io/flutter_data_1/build/web/index.html](https://dabbyp.github.io/flutter_data_1/build/web/index.html)