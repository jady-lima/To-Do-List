import 'dart:developer';

import 'package:todo_list_provider/shared/consts/message_const.dart';
import 'package:todo_list_provider/shared/errors/local_storage_exceptions.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';
import 'package:todo_list_provider/shared/services/local_storage/local_storage_service.dart';

class TodosLocalStorageService {
  final LocalStorageService _localStorageService;

  TodosLocalStorageService(
    this._localStorageService
  );

  Future<String?> setTodos(List<TodoModel> todos) async {
    try {

    } on LocalStorageException {
      return "Erro saving task";
    } catch (error, st) {
      log("Error saving todos", error: error, stackTrace: st);
      return defaultErrorMassage;
    }
  }
}