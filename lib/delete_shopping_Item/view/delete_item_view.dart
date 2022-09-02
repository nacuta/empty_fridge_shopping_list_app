import 'package:flutter/material.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';

class DeleteItemView extends StatelessWidget {
  const DeleteItemView({super.key, required this.editShopping});
  final ShoppingModel editShopping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Shopping'),
      ),
      // ignore: use_colored_box
      body: Container(
        color: Colors.red,
        child: Text(editShopping.title),
      ),
    );
  }
}
