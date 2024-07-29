part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

class LoadingState extends TodoState {}

 class SuccessState extends TodoState  {
  final List<TodoModel>todolist;

  SuccessState({required this.todolist});
 }
 class ResponseState extends TodoState {
  final String responseMsg;

  ResponseState({required this.responseMsg});
 }
 class ErrorState extends TodoState {
  final String errorMsg;

  ErrorState({required this.errorMsg});
 }