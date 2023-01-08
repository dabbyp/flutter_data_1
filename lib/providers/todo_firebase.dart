import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_data_1/models/todo.dart';
import 'package:flutter/material.dart';

class TodoFirebase {
  late CollectionReference todoReference;
  late Stream<QuerySnapshot> todoStream;

  Future initDb() async {
    todoReference = FirebaseFirestore.instance.collection('todos');
    todoStream = todoReference.snapshots();
  }

  List<Todo> getTodos(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      return Todo.fromSnapshot(document);
    }).toList();
  }
  //TODO
}
