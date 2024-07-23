import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_model.dart';
import '../todobloc/todobloc_bloc.dart';

class UpdateForm extends StatefulWidget {
  final Future<Database> database;
  final bool isExists;
  final String title;
  final int id;
  final String description;
  final TodoblocBloc todoBloc;
  const UpdateForm({super.key, required this.database, required this.isExists,required this.todoBloc,required this.title,required this.description,required this.id});

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {

  final _titleController = TextEditingController();
  final _desController = TextEditingController();


  @override
  void initState() {
    _titleController.text = widget.title;
    _desController.text = widget.description;
    super.initState();
  }

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
          ElevatedButton(onPressed: (){
            Todo todo = Todo(
                title: _titleController.text,
                description: _desController.text,
                id: widget.id
            );
            print(
                todo.title);
            print(todo.description);
            widget.todoBloc.add(UpdateTodo(todo));
            Navigator.pop(context);
            Navigator.pop(context);
          }, child: const Text('UPDATE'))
        ],
      ),
    );


  }
}
