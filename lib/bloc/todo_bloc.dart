import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/model.dart';
import 'package:todo_app/repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ToDoRepo todoRepo;
  TodoBloc(this.todoRepo) : super(TodoInitial()) {
    on<InitialFetchEvents>(initialFetchEvents);
    on<AddEvent>(addEvent);
    on<UpdateEvent>(updateEvent);
    on<DeleteEvent>(deleteEvent);
  }

  FutureOr<void> initialFetchEvents(
    InitialFetchEvents event, Emitter<TodoState> emit)async {
      emit(LoadingState());
       try {
      await Future.delayed(Duration(seconds: 2));
      List<TodoModel> todolist = await todoRepo.getAllToDo();
      emit(SuccessState(todolist: todolist));
    } catch (e) {
      emit(ErrorState(errorMsg: e.toString()));
    }
  }

  FutureOr<void> addEvent(
    AddEvent event, Emitter<TodoState> emit)async {
     emit(LoadingState());
    try {
      final response = await todoRepo.addToDo(event.todo.title!, event.todo.description!);
      if (response == 201) {
        emit(ResponseState(responseMsg: 'Todo added successfully'));
        add(InitialFetchEvents()); 
      } else {
        emit(ErrorState(errorMsg: 'Failed to add todo'));
      }
    } catch (e) {
      emit(ErrorState(errorMsg: e.toString()));
    }
  }

  FutureOr<void> updateEvent(
    UpdateEvent event, Emitter<TodoState> emit)async {
    emit(LoadingState());
     try {
      final response = await todoRepo.updateData(event.todo);
      if (response == 200) {
        emit(ResponseState(responseMsg: 'Todo updated successfully'));
        add(InitialFetchEvents()); // Fetch updated list
      } else {
        emit(ErrorState(errorMsg: 'Failed to update todo'));
      }
    } catch (e) {
      emit(ErrorState(errorMsg: e.toString()));
    }
  }

  FutureOr<void> deleteEvent(
    DeleteEvent event, Emitter<TodoState> emit)async {
    emit(LoadingState());
    
  }
}
