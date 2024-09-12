import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/features/todos/controllers/todos_controller.dart';
import 'package:todo_list_provider/features/todos/widgets/loading_error_widget.dart';
import 'package:todo_list_provider/features/todos/widgets/todo_checkbox_widget.dart';
import 'package:todo_list_provider/features/todos/widgets/todo_date_widget.dart';
import 'package:todo_list_provider/features/todos/widgets/todo_title_and_description_widget.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';
import 'package:todo_list_provider/shared/widgets/texts/text_widget.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {

  bool isLoading = true;
  String? error;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadTodosAndDoneTodos();
    });
    super.initState();
  }

  Future<void> loadTodosAndDoneTodos() async {
    isLoading = true;
    error = null;

    final todosCtrl = context.read<TodosController>();

    final String? errorLoadingTodos = await todosCtrl.loadTodos();
    final String? errorLoadingDonesTodos = await todosCtrl.loadDonesTodos();
    

    if(errorLoadingTodos != null || errorLoadingDonesTodos != null) {
      setState(() {
        error = errorLoadingTodos ?? errorLoadingDonesTodos;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final todosCtrl = context.watch<TodosController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("To do List"),
        actions: [
          AddTodoIconWidget()
        ],
      ),

      body: isLoading || error != null ? LoadingErrorWidget(
          isLoading: isLoading,
          error: error,
          loadTodosAndDoneTodos: loadTodosAndDoneTodos,
        ) 
        : todosCtrl.todos.isEmpty 
          ? const Center(child: TextWidget("Você não possui nenuma tarefa."),)
          : ListView.builder(
            itemCount: todosCtrl.todos.length,
            itemBuilder: (_, int index) {
              final TodoModel todo = todosCtrl.todos[index];
              return Row(
                children: <Widget>[
                  TodoCheckboxWidget(todo),

                  const SizedBox(width: 12,),

                  TodoTitleAndDescriptionWidget(todo),

                  TodoDateWidget(todo),
                ],
              );
            }
          ),
    );
  }
}