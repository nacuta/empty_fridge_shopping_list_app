import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/add_to_list_widget.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(400, 60)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add),
            Text('Add new Item'),
          ],
        ),
        onPressed: () async {
          final newItem = await showDialog<AddToListWidget>(
            context: context,
            builder: (context) {
              return const AddToListWidget();
            },
          );
          setState(() {
            if (newItem != null) _call(context, newItem as ShoppingModel);
          });
        },
      ),
    );
  }
}

void _call(BuildContext context, ShoppingModel newItem) {
  // context.read<DatabaseBloc>().add(DatabaseWrite(listId: ,newData: newItem));
}
