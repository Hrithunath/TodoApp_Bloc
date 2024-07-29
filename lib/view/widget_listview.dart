import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todo_bloc.dart';

class widgetListView extends StatelessWidget {
  final SuccessState state;
  const widgetListView({
    super.key,required this.state
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Card(
            child: ListTile(
              leading: const CircleAvatar(),
              title:const  Text('hello'), 
              subtitle: const Text("hello"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit)
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete)
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: state.todolist.length,
    );
  }
}
