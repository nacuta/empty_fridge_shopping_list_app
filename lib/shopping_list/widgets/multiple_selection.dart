import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/reordable_widget.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/widgets.dart';
import 'package:mobi_lab_shopping_list_app/utils/utils.dart';

class MultipleSelectItems extends StatefulWidget {
  const MultipleSelectItems({super.key});

  @override
  State<MultipleSelectItems> createState() => _MultipleSelectItemsState();
}

class _MultipleSelectItemsState extends State<MultipleSelectItems> {
  final listScrollController = ScrollController();

  @override
  void dispose() {
    listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkedItemsList =
        context.watch<DatabaseBloc>().state.listOfShoppingItems.isShop();
    return SingleChildScrollView(
      child: Column(
        children: [
          // reordable list with to shop items
          const ReordableWidget(),
          // buttons and divider
          if (checkedItemsList.isNotEmpty)
            const ListButtons(
              key: GlobalObjectKey(2),
            ),
          if (checkedItemsList.isNotEmpty)
            const Divider(
              key: GlobalObjectKey(3),
              height: 1,
              color: Colors.grey,
            ),
          // Lisview with 'in cart' list
          ListView.builder(
            controller: listScrollController,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: checkedItemsList.length,
            itemBuilder: (context, i) => SelectableListTile(
              key: ValueKey(checkedItemsList[i]),
              shoppingModel: checkedItemsList[i],
              oddNumber: i,
            ),
          ),
        ],
      ),
    );
  }
}
