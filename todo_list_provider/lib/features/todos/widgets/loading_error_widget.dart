import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/widgets/texts/text_widget.dart';

class LoadingErrorWidget extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final void Function() loadTodosAndDoneTodos;

  const LoadingErrorWidget({
    super.key, 
    required this.isLoading, 
    required this.loadTodosAndDoneTodos, 
    this.error
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading 
        ? const CircularProgressIndicator() 
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextWidget(error!, textAlign: TextAlign.center,),
            const SizedBox(height: 8,),
            ElevatedButton(
              onPressed: loadTodosAndDoneTodos, 
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 127, 29, 22)),
              ),
              child: const TextWidget("Tentar novamente")
            ),
          ],
        ),
    );
  }
}