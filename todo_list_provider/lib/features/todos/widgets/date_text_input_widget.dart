import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/extensions/date_extension.dart';
import 'package:todo_list_provider/shared/widgets/inputs/text_input_widget.dart';

class DateTextInputWidget extends StatelessWidget {
  final TextEditingController todoDateTec;
  final FocusNode todoDateFn;
  final void Function(DateTime date) setDate;

  const DateTextInputWidget({
    super.key, 
    required this.todoDateTec, 
    required this.todoDateFn, 
    required this.setDate,
  });
  
  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      controller: todoDateTec, 
      focusNode: todoDateFn, 
      label: "Data",
      validator: (String? newTodoDate) {
        if (newTodoDate == null || newTodoDate.isEmpty){
          return "Você precisa adicionar uma data para a tarefa.";
        } 
        return null;
      },

      textInputAction: TextInputAction.send,
      readOnly: true,
      onTap: () async {
        final DateTime? date = await showDatePicker(
          context: context, 
          initialDate: DateTime.now(),
          firstDate: DateTime.now(), 
          lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
        );

        
        String stringDate = "";
        if(date != null){
          setDate(date);
          stringDate = date.formatDate;
        }

        todoDateTec.text = stringDate;
      },
    );
  }
}