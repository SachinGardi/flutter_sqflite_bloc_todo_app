part of 'todobloc_bloc.dart';

@immutable
sealed class TodoblocState {}

abstract class  TodoblocActionState extends TodoblocState{}

final class TodoblocInitial extends TodoblocState {
}


///loading
class TodoblocLoadingState extends TodoblocState{}

///loaded
class TodoblocLoadedState extends TodoblocState{
  final List<Todo> todoList;
  TodoblocLoadedState(this.todoList);
}



///error
class TodoblocErrorState extends TodoblocActionState{
  final String errMsg;
  TodoblocErrorState({required this.errMsg});
}