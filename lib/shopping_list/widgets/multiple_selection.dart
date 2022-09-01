import 'package:flutter/material.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/selectable_list_tiles.dart';

class MultipleSelectItems extends StatelessWidget {
  const MultipleSelectItems({super.key, required this.shoppingList});
  final List<ShoppingModel> shoppingList;

  List<Widget> isNotDone() {
    List<Widget> _widget = [SizedBox(height: 20.0)];
    for (final map in shoppingList) {
      final isChecked = map.isCompleted as bool;
      if (!isChecked) {
        _widget.add(
          SelectableListTile(
            shoppingModel: map,
          ),
        );
        _widget.add(SizedBox(height: 10.0));
      }
    }
    return _widget;
  }

  List<Widget> isDone() {
    List<Widget> _widget = [SizedBox(height: 20.0)];
    for (final map in shoppingList) {
      final isChecked = map.isCompleted as bool;
      if (isChecked) {
        _widget.add(
          SelectableListTile(
            shoppingModel: map,
          ),
        );
        _widget.add(SizedBox(height: 10.0));
      }
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isNotDone().length < 2) Text("Hurray you have it all done!"),
            ...isNotDone(),
            if (isDone().length != 1)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Completed',
                  style: TextStyle(fontSize: 22),
                ),
              )
            else
              Container(),
            ...isDone(),
          ],
        ),
      ),
    );
  }
}
