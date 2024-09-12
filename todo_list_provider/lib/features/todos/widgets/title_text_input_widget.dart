import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/widgets/inputs/text_input_widget.dart';

class TitleTextInputWidget extends StatelessWidget {
  final TextEditingController titleTec;
  final FocusNode titleFn;
  final FocusNode descriptionFn;

  const TitleTextInputWidget({
    super.key, 
    required this.titleTec, 
    required this.titleFn, 
    required this.descriptionFn
  });
  
  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      controller: titleTec, 
      focusNode: titleFn, 
      label: "Titulo",
      autoFocus: true,
      textCapitalization: TextCapitalization.words,
      onFieldSubmitted: (_) => descriptionFn.requestFocus,
      validator: (String? title) {
        if(title == null || title.isEmpty) {
          return 'Você precisa adicionar um título';
        }
        return null;
      },
    );
  }
}