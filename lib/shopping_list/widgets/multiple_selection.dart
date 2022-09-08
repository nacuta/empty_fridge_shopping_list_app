import 'package:flutter/material.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/widgets.dart';
import 'package:mobi_lab_shopping_list_app/utils/utils.dart';

class MultipleSelectItems extends StatefulWidget {
  const MultipleSelectItems({super.key, required this.shoppingList});
  final List<ShoppingModel> shoppingList;

  @override
  State<MultipleSelectItems> createState() => _MultipleSelectItemsState();
}

class _MultipleSelectItemsState extends State<MultipleSelectItems> {
  ScrollController listScrollController = ScrollController();

  List<ShoppingModel> get listToShop => widget.shoppingList.isToShop();
  List<ShoppingModel> get doneList => widget.shoppingList.isShop();

  @override
  Widget build(BuildContext context) {
    final reorderScrollController = ScrollController();
    return SingleChildScrollView(
      child: Column(
        children: [
          // reordable list with to shop items
          ReorderableListView.builder(
            scrollController: reorderScrollController,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            buildDefaultDragHandles: false,
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
            itemBuilder: (BuildContext context, int i) {
              //wrap the ListTile with dismisible widget
              return DismisibleWidget(
                key: ValueKey(listToShop[i].id),
                index: i,
                listToShop: listToShop,
              );
            },
            itemCount: listToShop.length,
          ),
          // buttons and divider
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
          // Lisview with in cart  list
          ListView.builder(
            controller: listScrollController,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: doneList.length,
            itemBuilder: (context, i) => SelectableListTile(
              key: ValueKey(doneList[i]),
              shoppingModel: doneList[i],
              oddNumber: i,
            ),
          ),
        ],
      ),
    );
  }
}
