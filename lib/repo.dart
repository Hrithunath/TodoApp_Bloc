import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:todo_app/model.dart';

class ToDoRepo {

  Future<List<TodoModel>> getAllToDo() async {
    try {
      final response = await http.get(Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=10'));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)['items'] as List;
        return decodedData.map((todo) => TodoModel.fromJson(todo)).toList();
      } else {
        log('Failed to load todos, status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching todos: $e');
      return [];
    }
  }
  
  Future<int> addToDo(String title, String description) async {
    final body = {
      "title": title,
      "description": description,
      "is_completed": true,
    };

    try {
      final response = await http.post(
        Uri.parse("https://api.nstack.in/v1/todos"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return response.statusCode;
    } catch (e) {
      log('Error adding todo: $e');
      return 500; 
    }
  }

  Future<int> updateData(TodoModel todo) async {
    final body = {
      'title': todo.title,
      'description': todo.description,
      '_id': todo.id,
      'is_completed': false,
    };

    try {
      final response = await http.put(
        Uri.parse('https://api.nstack.in/v1/todos/${todo.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return response.statusCode;
    } catch (e) {
      log('Error updating todo: $e');
      return 500; 
    }
  }

  Future<int> deleteToDo(String id) async {
    try {
      final response = await http.delete(Uri.parse('https://api.nstack.in/v1/todos/$id'));
      return response.statusCode;
    } catch (e) {
      log('Error deleting todo: $e');
      return 500; 
    }
  }
}
