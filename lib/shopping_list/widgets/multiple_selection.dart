import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/list_buttons.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/shopping_list_tile.dart';

class MultipleSelectItems extends StatefulWidget {
  const MultipleSelectItems({super.key, required this.shoppingList});
  final List<ShoppingModel> shoppingList;

  @override
  State<MultipleSelectItems> createState() => _MultipleSelectItemsState();
}

class _MultipleSelectItemsState extends State<MultipleSelectItems> {
  @override
  Widget build(BuildContext context) {
    final reorderScrollController = ScrollController();
    final listToShop = widget.shoppingList
        .where((element) => element.isCompleted == false)
        .toList();
    final doneList =
        widget.shoppingList.where((element) => element.isCompleted!).toList();
    return ReorderableListView(
      scrollController: reorderScrollController,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      buildDefaultDragHandles: false,
      children: [
        for (var i = 0; i < listToShop.length; i++)
          // for (final itemList in listToShop)
          Dismissible(
            key: Key(listToShop[i].id),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                //remove the item
                context
                    .read<DatabaseBloc>()
                    .add(DatabaseRemoveOne(shopItemToDelete: listToShop[i]));
                listToShop.removeAt(i);
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
            // Show a red background as the item is swiped away.
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
              key: ValueKey(listToShop[i]),
              shoppingModel: listToShop[i],
              oddNumber: i,
            ),
          ),
        if (doneList.isNotEmpty)
          const ListButtons(
            key: GlobalObjectKey(2),
          ),
        if (doneList.isNotEmpty)
          const Divider(
            key: GlobalObjectKey(3),
            height: 1,
            color: Colors.grey,
          ),
        for (var i = 0; i < doneList.length; i++)
          SelectableListTile(
            key: ValueKey(doneList[i]),
            shoppingModel: doneList[i],
            oddNumber: i,
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        //TODO change this setState with bloc
        setState(() {
          if (newIndex > oldIndex) {
            newIndex = newIndex - 1;
          }
          final element = widget.shoppingList.removeAt(oldIndex);
          widget.shoppingList.insert(newIndex, element);
        });
      },
    );
  }
}
