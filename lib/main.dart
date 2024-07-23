import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sqlite_with_bloc_todo_app/feature/todo/todo_list_page.dart';
import 'package:flutter_sqlite_with_bloc_todo_app/feature/todo/todobloc/todobloc_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE todos (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, description TEXT,status INTEGER )',
        );
      },
      version: 1
  );

  bool _databaseExists = await databaseExists(
      join(await getDatabasesPath(), 'todo_database.db'));

  runApp(MyApp(database: database, databaseExists: _databaseExists,));
}

class MyApp extends StatelessWidget {

  final Future<Database> database;
  final bool databaseExists;

  const MyApp(
      {super.key, required this.database, required this.databaseExists});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ToDoListPage(database: database,isExists: databaseExists),
    );
  }
}


