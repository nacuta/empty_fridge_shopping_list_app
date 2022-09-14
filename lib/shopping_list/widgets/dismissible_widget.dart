import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/shopping_list_tile.dart';

class DismisibleWidget extends StatelessWidget {
  const DismisibleWidget({
    super.key,
    required this.listToShop,
    required this.index,
  });
  final List<ShoppingModel> listToShop;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Dismissible(
        key: Key(listToShop[index].id),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            //remove the item
            context
                .read<DatabaseBloc>()
                .add(DatabaseRemoveOne(shopItemToDelete: listToShop[index]));
            listToShop.removeAt(index);
          }
        },
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Delete Confirmation'),
                content: const Text(
                  'Are you sure you want to delete this item?',
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Delete'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        // add background when is dismiss the item.
        background: ColoredBox(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.delete, color: Colors.white),
                Text(
                  'Move to trash',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        child: SelectableListTile(
          key: ValueKey(listToShop[index]),
          shoppingModel: listToShop[index],
          oddNumber: index,
        ),
      ),
    );
  }
}
