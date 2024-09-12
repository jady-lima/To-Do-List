import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/features/todos/controllers/todos_controller.dart';
import 'package:todo_list_provider/features/todos/widgets/date_text_input_widget.dart';
import 'package:todo_list_provider/features/todos/widgets/description_text_input_widget.dart';
import 'package:todo_list_provider/features/todos/widgets/title_text_input_widget.dart';
import 'package:todo_list_provider/shared/mixins/snack_bar_mixin.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';
import 'package:todo_list_provider/shared/widgets/texts/text_widget.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> with SnackBarMixin{
  final _formKey = GlobalKey<FormState>();

  final _titleTec = TextEditingController();
  final _titleFn = FocusNode();

  final _descriptionTec = TextEditingController();
  final _descriptionFn = FocusNode();

  final _todoDateTec = TextEditingController();
  final _todoDateFn = FocusNode();

  late DateTime todoDate;

  @override
  void dispose(){
    _titleTec.dispose();
    _titleFn.dispose();

    _descriptionTec.dispose();
    _descriptionFn.dispose();

    _todoDateTec.dispose();
    _todoDateFn.dispose();

    super.dispose();
  }

  Future<void> _addTodo() async {
    if (_formKey.currentState!.validate()){
      final todoCtrl = Provider.of<TodosController>(context, listen: false);
      final String? error = await todoCtrl.addTodo(
        TodoModel(
          title: _titleTec.text,
          description: _descriptionTec.text,
          cDate: todoDate
        )
      );

      if (context.mounted) {
        if (error != null) {
          showSnackBar(error, context: context, isError: true);
        } else {
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget("Adicionar nova tarefa"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TitleTextInputWidget(
                  titleTec: _titleTec, 
                  titleFn: _titleFn, 
                  descriptionFn: _descriptionFn
                ),

                const SizedBox(height: 16,),

                DescriptionTextInputWidget(
                  descriptionTec: _descriptionTec, 
                  descriptionFn: _descriptionFn, 
                  todoDateFn: _todoDateFn
                ),

                const SizedBox(height: 16,),

                DateTextInputWidget(
                  addTodo: _addTodo,
                  setDate: (DateTime date) {
                    todoDate = date;
                  },
                  todoDateTec: _todoDateTec,
                  todoDateFn: _todoDateFn,
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}