import 'package:flutter/material.dart';
import 'package:flutter_sqlite_with_bloc_todo_app/feature/todo/models/todo_model.dart';
import 'package:flutter_sqlite_with_bloc_todo_app/feature/todo/todobloc/todobloc_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AddToDoPage extends StatelessWidget {

  final Future<Database> database;
  final bool isExists;
  final TodoblocBloc todoBloc;

  AddToDoPage({super.key, required this.database, required this.isExists,required this.todoBloc});


  final _titleController = TextEditingController();

  final _desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: 200,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: 'Title'
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(controller: _desController,
                decoration: const InputDecoration(
                    hintText: 'Description'
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(onPressed: () {
                Todo todo = Todo(
                  title: _titleController.text,
                  description: _desController.text
                );
                  todoBloc.add(AddTodo(todo));
                Navigator.pop(context);
              }, child: Text('Add'))
            ],
          ),
        );


  }
}
