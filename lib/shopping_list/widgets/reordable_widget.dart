import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/dismissible_widget.dart';
import 'package:mobi_lab_shopping_list_app/utils/utils.dart';

class ReordableWidget extends StatelessWidget {
  const ReordableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final reorderScrollController = ScrollController();

    var listToShop =
        context.watch<DatabaseBloc>().state.listOfShoppingItems.isToShop();
    return ReorderableListView.builder(
      scrollController: reorderScrollController,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      buildDefaultDragHandles: false,
      onReorder: (int oldIndex, int newIndex) {
        if (newIndex > oldIndex) {
          newIndex = newIndex - 1;
        }
        final element = listToShop.removeAt(oldIndex);
        listToShop.insert(newIndex, element);
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
    );
  }
}
