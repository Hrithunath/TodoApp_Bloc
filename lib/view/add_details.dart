import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/model.dart';

class AddDetails extends StatelessWidget {
  final TodoModel? todolist;
  AddDetails({super.key, this.todolist});

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Details')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is SuccessState) {
              showDialog(
                context: context,
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
            } else if (state is ResponseState) {
              Navigator.of(context).pop();
              Navigator.of(context).pop(true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.responseMsg)),
              );
            }
          },
          child: Column(
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
              ElevatedButton(
                onPressed: () => saveButton(context),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveButton(BuildContext context) {
    final title = titleController.text;
    final description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      final todo = TodoModel(title: title, description: description);
      context.read<TodoBloc>().add(AddEvent(todo: todo));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }
}
