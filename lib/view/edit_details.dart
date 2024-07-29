import 'package:flutter/material.dart';

class EditDetails extends StatelessWidget {
  const EditDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Edit Details')),
      ),
      body: Padding(
        padding:  const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,         
              decoration: InputDecoration(
                labelText: "Text...",
                 border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                 )
              ),
            ),
            const SizedBox(height: 10,),
              TextFormField(
              keyboardType: TextInputType.name,         
              decoration: InputDecoration(
                labelText: "Text...",
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