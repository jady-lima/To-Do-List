import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';
import 'package:todo_list_provider/shared/widgets/texts/text_widget.dart';

class TodoTitleAndDescriptionWidget extends StatelessWidget {
  final TodoModel todo;

  const TodoTitleAndDescriptionWidget(this.todo, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextWidget(
            todo.title,
            cFontSize: 18,
          ),

          if(todo.description != null)
            TextWidget(
              todo.description!,
            ),
        ],
      )
    );
  }
}