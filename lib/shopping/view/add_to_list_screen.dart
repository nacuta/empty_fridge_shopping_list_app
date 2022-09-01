import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobi_lab_shopping_list_app/app/app.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';

class AddToListScreen extends StatelessWidget {
  const AddToListScreen({super.key});

  void _onSubmit(
    BuildContext context,
    TextEditingController _shoppingItemController,
    TextEditingController _quantityItemController,
  ) {
    var result = ShoppingModel(
      title: _shoppingItemController.text,
      quantity: int.parse(_quantityItemController.text),
    );
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final _shoppingItemController = TextEditingController();
    final _quantityItemController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _shoppingItemController,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            cursorColor: Colors.black,
            style: const TextStyle(color: Color.fromARGB(255, 156, 19, 19)),
            decoration: InputDecoration(
              // border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              hintText: 'what you need?',
              filled: true,
              // fillColor: Colors.blueAccent,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            minLines: 1,
            maxLines: 1000,
          ),
          TextField(
            controller: _quantityItemController,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              // border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              hintText: 'how many?',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            minLines: 1,
            maxLines: 1000,
          ),
          TextButton(
            onPressed: () => _onSubmit(
              context,
              _shoppingItemController,
              _quantityItemController,
            ),
            child: Text('Save', style: TextStyle(fontSize: 22)),
          ),
        ],
      ),
    );
  }
}
