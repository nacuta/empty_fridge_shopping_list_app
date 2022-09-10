import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/reordable_widget.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/widgets.dart';
import 'package:mobi_lab_shopping_list_app/utils/utils.dart';

class MultipleSelectItems extends StatelessWidget {
  const MultipleSelectItems({super.key});

  @override
  Widget build(BuildContext context) {
    var doneList =
        context.watch<DatabaseBloc>().state.listOfShoppingItems.isShop();
    final listScrollController = ScrollController();
    return SingleChildScrollView(
      child: Column(
        children: [
          // reordable list with to shop items
          const ReordableWidget(),
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
          // Lisview with 'in cart' list
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
