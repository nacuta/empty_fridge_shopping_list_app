import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/delete_shopping_Item/bloc/delete_item_bloc.dart';
import 'package:mobi_lab_shopping_list_app/delete_shopping_Item/view/delete_item_view.dart';
import 'package:mobi_lab_shopping_list_app/edit_item/view/edit_item_view.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository_impl.dart';

class SelectableListTile extends StatelessWidget {
  const SelectableListTile({
    super.key,
    required this.shoppingModel,
  });

  final ShoppingModel shoppingModel;

  @override
  Widget build(BuildContext context) {
    var isCheck = shoppingModel.isCompleted!;
    bool isSelected = false;
    final ceva = shoppingModel;

    Color getColor(Set<MaterialState> states) {
      const interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return Theme.of(context).primaryColor;
      }

      return Colors.grey.shade600;
    }

    return Container(
      color: !isCheck ? Colors.white : Colors.grey.shade700,
      child: ListTile(
        textColor: isCheck ? Colors.white : Colors.grey.shade600,
        key: ValueKey(shoppingModel),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditItemView(editShopping: shoppingModel),
            )),
        leading: Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isCheck,
          onChanged: (bool? value) {
            context.read<DatabaseBloc>().add(
                  DatabaseChangedCompletionToggled(
                    isCompleted: !isCheck,
                    shopItem: shoppingModel,
                  ),
                );
          },
        ),
        title: isCheck
            ? Text(
                shoppingModel.title,
                style: const TextStyle(decoration: TextDecoration.lineThrough),
              )
            : Text(
                shoppingModel.title,
              ),

        // trailing: const Icon(Icons.edit),
      ),
    );
  }
}
