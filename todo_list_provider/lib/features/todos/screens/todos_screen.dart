import 'package:flutter/material.dart';
import 'package:todo_list_provider/features/todos/widgets/todo_checkbox_widget.dart';
import 'package:todo_list_provider/features/todos/widgets/todo_date_widget.dart';
import 'package:todo_list_provider/features/todos/widgets/todo_title_and_description_widget.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';

final List<TodoModel> todos = [
  TodoModel(title: "Task 1", description: "Description 1"),
  TodoModel(title: "Task 2", description: "Description 2")
];

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To do List"),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.add),
          )
        ],
      ),

      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (_, int index) {
          final TodoModel todo = todos[index];
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