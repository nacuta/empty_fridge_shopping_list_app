import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/shopping/view/add_to_list_screen.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository_impl.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/view/new_textfield.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/add_new_item_button.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/multiple_selection.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/selectable_list_tiles.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
      child: const ShoppingView(),
    );
  }
}

class ShoppingView extends StatelessWidget {
  const ShoppingView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 120.0,
        leading: const Icon(Icons.shopping_bag),
        title: Text(l10n.shoppingAppBarTitle),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cached),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_add),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size(40, 60),
          child: Search(),
        ),
        // centerTitle: true,
      ),
      body: BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          context.read<DatabaseBloc>().add(DatabaseFetched());
          // }
          if (state.status == DatabaseStateStatus.loading) {
            context.read<DatabaseBloc>().add(DatabaseFetched());
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == DatabaseStateStatus.success) {
            if (state.listOfShoppingItems.isEmpty) {
              return const Center(
                child: Text('no data'),
              );
            } else {
              final isEmptyList = (state.listOfShoppingItems
                      .where((element) => element.isCompleted!)
                      .toList())
                  .isEmpty;

              return Column(
                children: [
                  MultipleSelectItems(
                    shoppingList: state.listOfShoppingItems
                        .where((element) => !element.isCompleted!)
                        .toList(),
                  ),
                  if (!isEmptyList)
                    Container(
                      height: 60,
                      color: Colors.grey.shade700,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Theme.of(context).primaryColor,
                                onSurface: Colors.grey,
                                shape: const RoundedRectangleBorder(
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
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Theme.of(context).primaryColor,
                                onSurface: Colors.grey,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: const Text(
                                'DELETE ALL',
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  MultipleSelectItems(
                    shoppingList: state.listOfShoppingItems
                        .where((element) => element.isCompleted!)
                        .toList(),
                  ),
                  if (!isEmptyList)
                    Expanded(
                      // ignore: use_colored_box
                      child: Container(color: Colors.grey.shade700),
                    )
                ],
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
