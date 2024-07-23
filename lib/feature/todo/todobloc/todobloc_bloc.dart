import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_model.dart';

part 'todobloc_event.dart';

part 'todobloc_state.dart';

class TodoblocBloc extends Bloc<TodoblocEvent, TodoblocState> {

  final Future<Database> databse;
  final bool isExists;

  TodoblocBloc({required this.databse,required this.isExists}) : super(TodoblocInitial()) {
    on<TodoBlocInitialEvent>(todoInitialAddEvent);
    on<AddTodo>(addTodo);
    on<DeleteTodo>(deleteTodo);
    on<UpdateTodo>(updateTodo);
  }

  Future<FutureOr<void>> todoInitialAddEvent(TodoBlocInitialEvent event, Emitter<TodoblocState> emit) async {

    emit(TodoblocLoadingState());
    try{
      if(!isExists){
        emit(TodoblocErrorState(errMsg: 'Database does not exist'));
      }

      final List<Todo> todos = await getTodos();
      print(todos);
      emit(TodoblocLoadedState(todos));

    }catch(e){
      emit(TodoblocErrorState(errMsg: e.toString()));
    }
  }

  Future<void> addTodo(AddTodo event, Emitter<TodoblocState> emit) async {
    emit(TodoblocLoadingState());
    try {

      if(!isExists){
        emit(TodoblocErrorState(errMsg: 'Database does not exist'));
      }

      await addTodos(event.todo);
      final List<Todo> todos = await getTodos();
      emit(TodoblocLoadedState(todos));

    } catch (e) {
        emit(TodoblocErrorState(errMsg: e.toString()));
    }
  }


  FutureOr<void> updateTodo(UpdateTodo event, Emitter<TodoblocState> emit)async {

    emit(TodoblocLoadingState());
    try{
      await updateTodos(event.todo);
      final todos = await getTodos();
      emit(TodoblocLoadedState(todos));
    }catch(e){
      emit(TodoblocErrorState(errMsg: e.toString()));
    }

  }

  FutureOr<void> deleteTodo(DeleteTodo event, Emitter<TodoblocState> emit) async{
    emit(TodoblocLoadingState());
    try{
      await deleteTodos(event.id);
      final List<Todo> todos = await getTodos();
      emit(TodoblocLoadedState(todos));
    }catch(e){
      emit(TodoblocErrorState(errMsg: e.toString()));
    }
  }

  Future<List<Todo>> getTodos()async{
    final Database db = await databse;
    final List<Map<String,dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (index) {
      print(maps[index]);
      return Todo.fromMap(maps[index]);
    });

  }

  Future<void> addTodos(Todo todo)async{

    final Database db = await databse;
    await db.insert('todos', todo.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);

  }

  Future<void> updateTodos(Todo todo)async{
    final Database db = await databse;
    await db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteTodos(int id)async{
    final Database db = await databse;
    await db.delete('todos',
        where: 'id = ?',
        whereArgs: [id],);
  }






}
