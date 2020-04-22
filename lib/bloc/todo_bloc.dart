import 'dart:async';

import 'package:flutter_app_local_caching/model/todo.dart';
import 'package:flutter_app_local_caching/repository/todo_repository.dart';

class TodoBloc {
  final _todoRepository = TodoRepository();

  // Stream is the admin that manags the state of our stream of data
  // like adding data, change the sate of the stream
  //and broadcast it to observers/subscribers

  final _todoController = StreamController<List<Todo>>.broadcast();

  get todos => _todoController.stream;

  TodoBloc() {
    getTodos();
  }

  void getTodos({String query}) async {
    // sink is a way of adding data reactively to the stream
    // by registering a new event

    _todoController.sink.add(await _todoRepository.getAllTodos(query: query));
  }

  addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
    getTodos();
  }

  updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    getTodos();
  }

  dispose() {
    _todoController.close();
  }
}
