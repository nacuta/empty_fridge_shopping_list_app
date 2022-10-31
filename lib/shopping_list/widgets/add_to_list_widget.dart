import 'package:flutter/material.dart';
import 'package:empty_fridge_shopping_list_app/models/shopping_model.dart';

class AddToListWidget extends StatefulWidget {
  const AddToListWidget({super.key});

  @override
  State<AddToListWidget> createState() => _AddToListWidgetState();
}

class _AddToListWidgetState extends State<AddToListWidget> {
  final _shoppingItemController = TextEditingController();
  final _quantityItemController = TextEditingController();

  void _onSubmit(
    BuildContext context,
    TextEditingController _shoppingItemController,
    TextEditingController _quantityItemController,
  ) {
    final result = ShoppingModel(
      title: _shoppingItemController.text,
      quantity: int.parse(_quantityItemController.text),
    );
    Navigator.of(context).pop(result);
  }

  @override
  void dispose() {
    _shoppingItemController.dispose();
    _quantityItemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
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
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
            child: const Text('Save', style: TextStyle(fontSize: 22)),
          ),
        ],
      ),
    );
  }
}
