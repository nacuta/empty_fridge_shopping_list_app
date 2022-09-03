import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';

class ListButtons extends StatelessWidget {
  const ListButtons({super.key});

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

                cntBloc.add(DatabaseUncheckAll());
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
                //method to delete all
                final list = cntBloc.state.listOfShoppingItems
                    .where((element) => element.isCompleted!)
                    .toList();
                cntBloc.add(DatabaseRemoveAll(listToDelete: list));
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
}
