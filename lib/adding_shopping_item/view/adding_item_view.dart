import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/adding_shopping_item/bloc/add_shopping_item_bloc.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';

class AddShoppingItem extends StatelessWidget {
  const AddShoppingItem({super.key});

  @override
  Widget build(BuildContext context) {
    final _shoppingItemController = TextEditingController();

    bool _isTextEditingNotEmpthy() {
      return _shoppingItemController.text.isNotEmpty;
    }

    return BlocBuilder<AddShoppingItemBloc, AddShoppingItemState>(
      builder: (context, state) {
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
                style: const TextStyle(color: Colors.black),
                controller: _shoppingItemController,
                decoration: InputDecoration(
                  suffixIcon: SizedBox(
                    width: 98,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _shoppingItemController.clear,
                        ),
                        //condition
                        if (_isTextEditingNotEmpthy())
                          IconButton(
                            icon: const Icon(Icons.check_box),
                            onPressed: () {
                              context.read<AddShoppingItemBloc>().add(
                                    AddShoppingFormSubmitted(),
                                  );
                              FocusScope.of(context).unfocus();
                              _shoppingItemController.clear();
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
                },
                minLines: 1,
                maxLines: 1000,
              ),
            ),
          ),
        );
      },
    );
  }
}
