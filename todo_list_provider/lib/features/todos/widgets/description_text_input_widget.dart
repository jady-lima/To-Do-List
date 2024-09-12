import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/widgets/inputs/text_input_widget.dart';

class DescriptionTextInputWidget extends StatelessWidget {
  final TextEditingController descriptionTec;
  final FocusNode descriptionFn;
  final FocusNode todoDateFn;

  const DescriptionTextInputWidget({
    super.key, 
    required this.descriptionTec, 
    required this.descriptionFn,
    required this.todoDateFn,
  });
  
  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      controller: descriptionTec, 
      focusNode: descriptionFn, 
      label: "Descrição",
      minLines: 4,
      maxLines: 6,
      textCapitalization: TextCapitalization.sentences,
      onFieldSubmitted: (_) => todoDateFn.requestFocus(),
    );
  }
}