import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddToListScreen extends StatelessWidget {
  const AddToListScreen({super.key});

  void _onSubmit(BuildContext context, TextEditingController controller) {
    Navigator.of(context).pop(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      body: Form(
        child: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            // border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            hintText: 'what you need?',
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          minLines: 1,
          maxLines: 1000,
          onSubmitted: (text) => _onSubmit(context, controller),
        ),
      ),
    );
  }
}
