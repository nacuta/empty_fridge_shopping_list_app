import 'package:flutter/material.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/selectable_list_tiles.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';

class MultipleSelectItems extends StatefulWidget {
  const MultipleSelectItems({super.key, required this.shoppingList});
  final List<ShoppingModel> shoppingList;

  @override
  State<MultipleSelectItems> createState() => _MultipleSelectItemsState();
}

class _MultipleSelectItemsState extends State<MultipleSelectItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: Responsive.width(5, context)),
      child: ReorderableListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.shoppingList.length,
        itemBuilder: (context, index) {
          final itemList = widget.shoppingList[index];
          return SelectableListTile(
            key: ValueKey(itemList),
            shoppingModel: itemList,
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex = newIndex - 1;
            }
            final element = widget.shoppingList.removeAt(oldIndex);
            widget.shoppingList.insert(newIndex, element);
          });
        },
      ),
    );
  }
}
