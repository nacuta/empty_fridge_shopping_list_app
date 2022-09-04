import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/delete_shopping_Item/view/delete_item_view.dart';
import 'package:mobi_lab_shopping_list_app/edit_item/view/edit_item_view.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository_impl.dart';

class SelectableListTile extends StatelessWidget {
  const SelectableListTile({
    super.key,
    required this.shoppingModel,
    required this.oddNumber,
  });

  final ShoppingModel shoppingModel;
  final int oddNumber;

  @override
  Widget build(BuildContext context) {
    final isCheck = shoppingModel.isCompleted!;

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

    return BlocListener<DatabaseBloc, DatabaseState>(
      listener: (context, state) {
        if (state is DatabaseEditItem) {
          context.read<DatabaseBloc>().add(DatabaseFetchData());
        }

        //TODO add edit bloc and listen here to rebuild the UI
      },
      child: isCheck
          ? ColoredBox(
              color: Colors.grey.shade700,
              child: ListTile(
                textColor: Colors.white,
                key: ValueKey(shoppingModel),
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
                title: Text(
                  shoppingModel.title,
                  style:
                      const TextStyle(decoration: TextDecoration.lineThrough),
                ),
              ),
            )
          : BlocConsumer<DatabaseBloc, DatabaseState>(
              listener: (context, state) {
                print(state);
                if (state is DatabaseEditItem) {
                  context.select(
                    (value) {
                      return true;
                    },
                  );
                }
              },
              builder: (context, state) => ListTile(
                tileColor:
                    oddNumber.isOdd ? Colors.white : Colors.grey.shade100,
                textColor: const Color(0xff545154),
                trailing: ReorderableDragStartListener(
                  index: oddNumber,
                  child: const Icon(Icons.drag_handle),
                ),
                key: ValueKey(shoppingModel),
                onTap: () => Navigator.of(context).push(
                  EditItemPage.route(editShopping: shoppingModel),
                ),

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => BlocProvider(
                //       create: (context) =>
                //           DatabaseBloc(DatabaseRepositoryImpl()),
                //       child: EditItemView(editShopping: shoppingModel),
                //     ),
                //   ),
                // ),
                onLongPress: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            DatabaseBloc(DatabaseRepositoryImpl()),
                        child: DeleteItemView(editShopping: shoppingModel),
                      ),
                    ),
                  );
                  context.read<DatabaseBloc>().add(DatabaseFetchData());
                },
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
                title: Text(
                  shoppingModel.title,
                ),
              ),
            ),
    );
  }
}
