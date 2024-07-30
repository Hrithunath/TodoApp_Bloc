import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/model.dart';
import 'package:todo_app/view/home.dart';

class EditDetails extends StatelessWidget {
  final TodoModel todo;

  const EditDetails({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Edit Todo')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const AlertDialog(
                  title: Text("Saving..."),
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text('Please Wait'),
                    ],
                  ),
                ),
              );
            } else if (state is SuccessState) {
              Navigator.of(context).pop(); 
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                (route) => false, // Remove all routes
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Todo updated successfully')),
              );
            } else if (state is ErrorState) {
              Navigator.of(context).pop(); 
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to update Todo')),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final updatedTodo = TodoModel(
                    id: todo.id, 
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  context.read<TodoBloc>().add(UpdateEvent(todo: updatedTodo));
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
