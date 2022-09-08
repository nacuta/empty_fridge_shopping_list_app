import 'package:automatic_animated_list/automatic_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/dismissible_widget.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/list_buttons.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/shopping_list_tile.dart';
import 'package:uuid/uuid.dart';

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
    ScrollController listScrollController = ScrollController();
    final listToShop = widget.shoppingList
        .where((element) => element.isCompleted == false)
        .toList();
    final doneList =
        widget.shoppingList.where((element) => element.isCompleted!).toList();
    return AutomaticAnimatedList<ShoppingModel>(
      items: listToShop,
      insertDuration: Duration(seconds: 1),
      removeDuration: Duration(seconds: 1),
      keyingFunction: (ShoppingModel item) => Key(item.id),
      itemBuilder: (BuildContext context, ShoppingModel item,
          Animation<double> animation) {
        return FadeTransition(
          key: Key(item.id),
          opacity: animation,
          child: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            ),
            child: SelectableListTile(
              key: ValueKey(item),
              shoppingModel: item,
              oddNumber: listToShop.indexOf(item),
            ),
          ),
        );
      },
    );
    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       // // reordable list
    //       // ReorderableListView.builder(
    //       //   scrollController: reorderScrollController,
    //       //   physics: const NeverScrollableScrollPhysics(),
    //       //   shrinkWrap: true,
    //       //   buildDefaultDragHandles: false,
    //       //   // children: [],
    //       //   onReorder: (int oldIndex, int newIndex) {
    //       //     //TODO change this setState with bloc
    //       //     setState(() {
    //       //       if (newIndex > oldIndex) {
    //       //         newIndex = newIndex - 1;
    //       //       }
    //       //       final element = widget.shoppingList.removeAt(oldIndex);
    //       //       widget.shoppingList.insert(newIndex, element);
    //       //     });
    //       //   },
    //       //   itemBuilder: (BuildContext context, int i) {
    //       //     return DismisibleWidget(
    //       //       key: ValueKey(listToShop[i].id),
    //       //       index: i,
    //       //       listToShop: listToShop,
    //       //     );
    //       //   },
    //       //   itemCount: listToShop.length,
    //       // ),
    //       // buttons and divider
    //       if (doneList.isNotEmpty)
    //         const ListButtons(
    //           key: GlobalObjectKey(2),
    //         ),
    //       if (doneList.isNotEmpty)
    //         const Divider(
    //           key: GlobalObjectKey(3),
    //           height: 1,
    //           color: Colors.grey,
    //         ),
    //       // // Lisview with done list

    //       // ListView.builder(
    //       //   controller: listScrollController,
    //       //   physics: const NeverScrollableScrollPhysics(),
    //       //   shrinkWrap: true,
    //       //   itemCount: doneList.length,
    //       //   itemBuilder: (context, i) => SelectableListTile(
    //       //     key: ValueKey(doneList[i]),
    //       //     shoppingModel: doneList[i],
    //       //     oddNumber: i,
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }
}
