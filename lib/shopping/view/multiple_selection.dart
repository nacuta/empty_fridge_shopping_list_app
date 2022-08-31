import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping/cubit/shopping_cubit.dart';
import 'package:mobi_lab_shopping_list_app/shopping/view/shopping_page.dart';
import 'package:mobi_lab_shopping_list_app/shopping/widgets/multiple_selected_list_tile_widget.dart';

class MultipleSelectionPage extends StatefulWidget {
  const MultipleSelectionPage({super.key});

  @override
  State<MultipleSelectionPage> createState() => _MultipleSelectionPageState();
}

class _MultipleSelectionPageState extends State<MultipleSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // context
              //     .read<ShoppingCubit>()
              //     .addShoppingsToList(ceva.copyWith(isCompleted: isCheck));
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            // color: Colors.red,
            child: StreamBuilder<QuerySnapshot>(
              stream: context.read<ShoppingCubit>().readShoppingList(),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  var iterableDocumentsMap =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    final data = document.data()! as Map<String, dynamic>;
                    return data;
                  });

                  return MultipleSelectItems2(
                    shoppingList: iterableDocumentsMap,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
