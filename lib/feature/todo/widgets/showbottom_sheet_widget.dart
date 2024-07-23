import 'package:flutter/material.dart';
import 'package:flutter_sqlite_with_bloc_todo_app/feature/todo/todobloc/todobloc_bloc.dart';
import 'package:flutter_sqlite_with_bloc_todo_app/feature/todo/widgets/update_add_form.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_model.dart';

class ShowBottomSheet extends StatefulWidget {
  final Future<Database> database;
  final bool isExists;
  final Todo item;
  final TodoblocBloc todoBloc;
  const ShowBottomSheet({super.key,required this.database,required this.isExists,required this.item,required this.todoBloc});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {

  @override
  Widget build(BuildContext context) {

            return Container(
              padding: EdgeInsets.all(25),
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Details',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: UpdateForm(database: widget.database, isExists: widget.isExists, todoBloc: widget.todoBloc, title: widget.item.title.toString(), description: widget.item.description.toString(),id: widget.item.id!.toInt()),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit))
                    ],
                  ),
                  Divider(
                    height: 3,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.item.title.toString()),
                  Text(widget.item.description.toString()),
                  Text(widget.item.status.toString())
                ],
              ),
            );


  }
}
