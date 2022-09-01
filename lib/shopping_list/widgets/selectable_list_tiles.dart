import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/delete_shopping_Item/bloc/delete_item_bloc.dart';
import 'package:mobi_lab_shopping_list_app/delete_shopping_Item/view/delete_item_view.dart';
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
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Card(
      child: ListTile(
        onLongPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
                child: DeleteItemView(
                  editShopping: shoppingModel,
                ),
              ),
            ),
          );
        },
        leading: Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isCheck,
          shape: const CircleBorder(),
          onChanged: (bool? value) {
            final updatedStatusModel =
                shoppingModel.copyWith(isCompleted: !isCheck);
            context.read<DatabaseBloc>().add(
                  DatabaseWrite(updatedStatusModel),
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
        subtitle: Text(
          shoppingModel.quantity.toString(),
        ),
        trailing: const Icon(Icons.edit),
      ),
    );
  }
}
