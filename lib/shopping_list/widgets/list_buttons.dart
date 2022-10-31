import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';

class ListButtons extends StatelessWidget {
  const ListButtons({super.key, required this.listId});
  final String listId;

  @override
  Widget build(BuildContext context) {
    final cntBloc = context.read<DatabaseBloc>();

    return Container(
      height: 60,
      color: Colors.grey.shade700,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 40,
            width: 150,
            child: TextButton(
              onPressed: () {
                //send to uncheck a list to bloc

                cntBloc.add(DatabaseUncheckAll(listId));
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
                shape: const RoundedRectangleBorder(
                  // ignore: avoid_redundant_argument_values
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text(
                'UNCHECK ALL',
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 150,
            child: TextButton(
              onPressed: () {
                //alert dialog to ask if user whants to delete all
                deleteDialog(context).then(
                  (value) {
                    if (value == true) {
                      final list = cntBloc.state.listOfShoppingItems
                          .where((element) => element.isCompleted!)
                          .toList();
                      cntBloc.add(
                        DatabaseRemoveAll(
                          listToDelete: list,
                          listId: listId,
                        ),
                      );
                    }
                  },
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                disabledForegroundColor: Colors.grey,
                shape: const RoundedRectangleBorder(
                  // ignore: avoid_redundant_argument_values
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text(
                'DELETE ALL',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> deleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text(
            'Are you sure you want to delete this item?',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
