import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/bloc.dart';

class EditItemView extends StatelessWidget {
  const EditItemView({super.key, required this.editShopping});
  final ShoppingModel editShopping;

  @override
  Widget build(BuildContext context) {
    var _titleController = TextEditingController(text: editShopping.title);
    var _quantityController =
        TextEditingController(text: editShopping.quantity.toString());
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<DatabaseBloc>().add(
                    DatabaseEditItem(
                      itemToEdit: editShopping.copyWith(
                        title: _titleController.text,
                        quantity: int.parse(_quantityController.text),
                      ),
                    ),
                  );
            },
            icon: Icon(Icons.save),
          )
        ],
        title: const Text('Edit Shopping'),
      ),
      // ignore: use_colored_box
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Quantity',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                QuantityContainer(
                  iconProvided: Icons.remove,
                  onPressed: () {},
                ),
                QuantityContainer(
                  iconProvided: Icons.add,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 60,
                  height: 40,
                  child: TextField(
                    controller: _quantityController,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class QuantityContainer extends StatelessWidget {
  const QuantityContainer({
    super.key,
    required this.iconProvided,
    this.onPressed,
  });
  final IconData iconProvided;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
      ),
      height: 40,
      width: 60,
      child: IconButton(
        icon: Icon(
          iconProvided,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {},
      ),
    );
  }
}
