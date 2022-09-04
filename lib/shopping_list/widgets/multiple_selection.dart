import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/dismissible_widget.dart';
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
          DismisibleWidget(
            key: ValueKey(listToShop[i].id),
            index: i,
            listToShop: listToShop,
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
