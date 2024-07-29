import 'package:flutter/material.dart';
import 'package:todo_app/model.dart';

class AddDetails extends StatelessWidget {
  TodoModel ?todolist;
   AddDetails({super.key,this.todolist});
   final titleController = TextEditingController();
   final  descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Details')),
      ),
      body: Padding(
        padding:  const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              keyboardType: TextInputType.name,         
              decoration: InputDecoration(
                labelText: "Title",
                 border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                 )
              ),
            ),
            const SizedBox(height: 10,),
              TextFormField(
                controller: descriptionController,
              keyboardType: TextInputType.name,         
              decoration: InputDecoration(
                labelText: "Description",
                 border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                 )
              ),
            ),
            ElevatedButton(onPressed: (){}, child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}