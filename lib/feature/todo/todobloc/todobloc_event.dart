part of 'todobloc_bloc.dart';

@immutable
sealed class TodoblocEvent {}


///load todos
class TodoBlocInitialEvent extends TodoblocEvent{}

///add todos
class AddTodo extends TodoblocEvent{
  final Todo todo;
  AddTodo(this.todo);
}
///update todos

class UpdateTodo extends TodoblocEvent{
  final Todo todo;
  UpdateTodo(this.todo);

}

///delete todos

class DeleteTodo extends TodoblocEvent{
  final int id;
  DeleteTodo(this.id);
}
