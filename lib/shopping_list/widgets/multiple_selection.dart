import 'package:flutter/material.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/list_buttons.dart';
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
    final reorderScrollController = ScrollController();
    final listaBuna = widget.shoppingList
        .where((element) => element.isCompleted == false)
        .toList();
    final listaRea =
        widget.shoppingList.where((element) => element.isCompleted!).toList();
    return Container(
      // margin: EdgeInsets.only(right: Responsive.width(5, context)),
      child: ReorderableListView(
        scrollController: reorderScrollController,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        // itemCount: widget.shoppingList.length,
        // itemBuilder: (context, index) {
        // final itemList = widget.shoppingList[index];
        // return SelectableListTile(
        //   key: ValueKey(itemList),
        //   shoppingModel: itemList,
        // ),
        children: [
          for (final itemList in listaBuna)
            SelectableListTile(
              key: ValueKey(itemList),
              shoppingModel: itemList,
            ),
          if (listaRea.isNotEmpty)
            const ListButtons(
              key: GlobalObjectKey(2),
            ),
          if (listaRea.isNotEmpty)
            const Divider(
              key: GlobalObjectKey(3),
              height: 1,
              color: Colors.grey,
            ),
          for (final itemList in listaRea)
            SelectableListTile(
              key: ValueKey(itemList),
              shoppingModel: itemList,
            ),
        ],

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
