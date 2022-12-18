import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_firebase/todo_list.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text(snapshot.error.toString())),
          );
        } 
         if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
        child: CircularProgressIndicator());
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TodoList(),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[900],
            primarySwatch: Colors.pink,
          ),
        );
      },
    );
  }
}