import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/repo.dart';
import 'package:todo_app/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ToDoRepo(),
      child: BlocProvider(
        create: (context) =>
            TodoBloc(context.read<ToDoRepo>())..add(
              InitialFetchEvents()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home(),
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
            backgroundColor: Colors.yellow,
          )),
        ),
      ),
    );
  }
}
