import 'package:flutter/material.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final _shoppingItemController = TextEditingController();
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
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextField(
            controller: _shoppingItemController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _shoppingItemController.text = '';
                },
              ),
              hintText: 'Add item',
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            minLines: 1,
            maxLines: 1000,
          ),
        ),
      ),
    );
  }
}
