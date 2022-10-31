import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/database/database.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/widgets/reordable_widget.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/widgets/widgets.dart';
import 'package:empty_fridge_shopping_list_app/utils/utils.dart';

class MultipleSelectItems extends StatefulWidget {
  const MultipleSelectItems({super.key, required this.listId});
  final String listId;

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
          ReordableWidget(listId: widget.listId),
          Container(
            height: 30,
            // padding: const EdgeInsets.all(8),
            alignment: const Alignment(-0.8, 0),
            margin: const EdgeInsets.all(8),
            child: Text(
              'IN YOUR CART',
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey.shade600),
            ),
          ),
          // buttons and divider
          if (checkedItemsList.isNotEmpty)
            ListButtons(
              listId: widget.listId,
              key: const GlobalObjectKey(2),
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
              listId: widget.listId,
            ),
          ),
        ],
      ),
    );
  }
}
