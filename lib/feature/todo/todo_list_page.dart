import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sqlite_with_bloc_todo_app/feature/todo/todobloc/todobloc_bloc.dart';
import 'package:flutter_sqlite_with_bloc_todo_app/feature/todo/widgets/showbottom_sheet_widget.dart';
import 'package:flutter_sqlite_with_bloc_todo_app/feature/todo/widgets/todo_add_form.dart';
import 'package:sqflite/sqflite.dart';

class ToDoListPage extends StatefulWidget {
  final Future<Database> database;
  final bool isExists;

  const ToDoListPage(
      {super.key, required this.database, required this.isExists});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  late final todoBloc;
  @override
  void initState() {
    todoBloc = TodoblocBloc(databse: widget.database, isExists: widget.isExists);
   todoBloc.add(TodoBlocInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todos App with Sqflite with bloc'),
        centerTitle: true,
      ),
      body: BlocConsumer<TodoblocBloc,TodoblocState>(
          buildWhen: (previous, current) => current is !TodoblocActionState,
          listenWhen: (previous, current) => current is TodoblocActionState,
          bloc: todoBloc,
          listener: (BuildContext context, Object? state) {},
          builder: (context, state) {
            if (state is TodoblocLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
             if (state is TodoblocLoadedState) {

               if(state.todoList.isEmpty){
                 return const Center(
                   child: Text('No todo found!'),
                 );
               }
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) {
                    final itemList = state.todoList[index];
                    return ListTile(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ShowBottomSheet(
                              database: widget.database,
                              isExists: widget.isExists,
                              item: itemList,
                          todoBloc: todoBloc),
                        );
                      },
                      title: Text(itemList.title.toString()),
                      subtitle: Text(itemList.description.toString()),
                      trailing: IconButton(
                          onPressed: () {
                            todoBloc.add(DeleteTodo(itemList.id!.toInt()));
                          },
                          icon: const Icon(Icons.delete)),
                    );
                  },
                ),
              );
            }

            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: AddToDoPage(database: widget.database, isExists: widget.isExists,todoBloc: todoBloc),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
