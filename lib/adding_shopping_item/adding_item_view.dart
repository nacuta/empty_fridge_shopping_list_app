import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/adding_shopping_item/bloc/add_shopping_item_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';

class AddShoppingItem extends StatelessWidget {
  const AddShoppingItem({super.key});

  @override
  Widget build(BuildContext context) {
    final _shoppingItemController = TextEditingController();

    late String text;
    // @override
    // void initState() {
    //   super.initState();
    //   _shoppingItemController.addListener(_isTextEditingNotEmpthy);
    // }

    // @override
    // void dispose() {
    //   _shoppingItemController.dispose();
    //   super.dispose();
    // }

    bool _isTextEditingNotEmpthy() {
      print('object${_shoppingItemController.text}');
      return _shoppingItemController.text.isNotEmpty;
    }

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        // padding: const EdgeInsets.all( 8),
        margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
        width: Responsive.width(90, context),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextField(
            controller: _shoppingItemController,
            decoration: InputDecoration(
              suffixIcon: Container(
                width: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _shoppingItemController.text = '';
                      },
                    ),
                    if (!context.select(
                      (AddShoppingItemBloc formBloc) =>
                          formBloc.state.changedValue.pure,
                    ))
                      IconButton(
                        icon: const Icon(Icons.check_box),
                        onPressed: () {
                          context.read<AddShoppingItemBloc>().add(
                                AddShoppingFormSubmitted(),
                              );
                          _shoppingItemController.text = '';
                          context.watch<DatabaseBloc>().add(DatabaseChanged());
                        },
                      ),
                  ],
                ),
              ),
              hintText: 'Add item',
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              context
                  .read<AddShoppingItemBloc>()
                  .add(AddShoppingFormChanged(value));
              print(value);
            },
            minLines: 1,
            maxLines: 1000,
          ),
        ),
      ),
    );
  }
}
