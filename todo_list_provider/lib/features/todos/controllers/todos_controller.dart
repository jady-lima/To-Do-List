import 'package:flutter/foundation.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';
import 'package:todo_list_provider/shared/services/local_storage/todos_local_storage_service.dart';

class TodosController extends ChangeNotifier{
  final TodosLocalStorageService _todosLocalStorageService;

  TodosController(this._todosLocalStorageService);

  final List<TodoModel> todos = [];
  final List<String> doneTodos = [];

  Future<String?> loadTodos() async {
    final (String? error, List<TodoModel>? loadedTodos) = await _todosLocalStorageService.getTodos();

    if(error == null){
      todos..clear()
           ..addAll(loadedTodos!);

      sortTodosByDate();
    }
  }

  void sortTodosByDate(){
    todos.sort((todoA, todoB) => todoA.date.compareTo(todoB.date));
    notifyListeners();
  }
}