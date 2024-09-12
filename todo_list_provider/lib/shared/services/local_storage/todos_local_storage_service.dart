import 'dart:convert';
import 'dart:developer';

import 'package:todo_list_provider/shared/consts/message_const.dart';
import 'package:todo_list_provider/shared/errors/local_storage_exceptions.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';
import 'package:todo_list_provider/shared/services/local_storage/local_storage_service.dart';

class TodosLocalStorageService {
  final String todosKey = "todosKey";
  final String doneTodosKey = "doneTodosKey";
  final LocalStorageService _localStorageService;

  TodosLocalStorageService(
    this._localStorageService
  );

  Future<String?> setTodos(List<TodoModel> todos) async {
    try {
      final String data = jsonEncode(todos.map((todo) => todo.toMap()).toList(),);

      await _localStorageService.set(todosKey, data);

      return null;
    } on LocalStorageException {
      return "Erro saving task";
    } catch (error, st) {
      log("Error saving todos", error: error, stackTrace: st);
      return defaultErrorMassage;
    }
  }

  Future<(String? error, List<TodoModel>? todos)> getTodos() async{
    try {
      final String? todosJson = await _localStorageService.get(todosKey);

      if(todosJson != null) {
        final todos = (jsonDecode(todosJson) as List)
                      .map<TodoModel>((todo) => TodoModel.fromMap(todo))
                      .toList();

        return (null, todos);
      }

      return (null, <TodoModel>[]);

    } on LocalStorageException {
      return ("Erro loading task", null);
    } catch (error, st) {
      log("Error loading todos", error: error, stackTrace: st);
      return (defaultErrorMassage, null);
    }
  }

  Future<String?> setDoneTodos(List<String> doneTodos) async {
    try {
      final String data = jsonEncode(doneTodos);

      await _localStorageService.set(doneTodosKey, data);

      return null;
    } on LocalStorageException {
      return "Erro saving done task";
    } catch (error, st) {
      log("Error saving done todos", error: error, stackTrace: st);
      return defaultErrorMassage;
    }
  }

  Future<(String? error, List<String>? doneTodos)> getDoneTodos() async{
    try {
      final String? doneTodosJson = await _localStorageService.get(doneTodosKey);

      if(doneTodosJson != null) {
        final doneTodos = (jsonDecode(doneTodosJson) as List)
                      .cast<String>();

        return (null, doneTodos);
      }

      return (null, <String>[]);

    } on LocalStorageException {
      return ("Erro loading done task", null);
    } catch (error, st) {
      log("Error loading done todos", error: error, stackTrace: st);
      return (defaultErrorMassage, null);
    }
  }
}