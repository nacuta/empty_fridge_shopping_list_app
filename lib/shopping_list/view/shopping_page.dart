import 'package:empty_fridge_shopping_list_app/adding_shopping_item/adding_shopping_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:empty_fridge_shopping_list_app/authentification/auth/bloc/auth_bloc.dart';
import 'package:empty_fridge_shopping_list_app/l10n/l10n.dart';
import 'package:empty_fridge_shopping_list_app/models/shopping_model.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/cubit/list_cubit.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/database/database.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/view/add_list.dart';
import 'package:empty_fridge_shopping_list_app/utils/utils.dart';

/// [ShoppingPage] holds the [MultiBlocProvider] that provides
/// accesability for [Bloc] into entire application.
class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  static MaterialPage<void> page() => const MaterialPage(child: ShoppingPage());
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (context) => const ShoppingPage(),
      );
  @override
  Widget build(BuildContext context) {
    // createList(listx);
    return BlocProvider(
      create: (context) => ListCubit(
        DatabaseRepositoryImpl(),
      ),
      child: const ShoppingView(),
    );
  }
}

class ShoppingView extends StatefulWidget {
  const ShoppingView({super.key});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    context.read<ListCubit>().getLists();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ListCubit>().getLists();
    return BlocBuilder<ListCubit, ListState>(
      buildWhen: (previous, current) =>
          previous.shoppingItemsList.length != current.shoppingItemsList.length,
      builder: (context, state) {
        final l10n = context.l10n;
        final listShoppingModels = <ShoppingModel>[];
        return Scaffold(
          drawer: _drawer(context),
          appBar: AppBar(
            // toolbarHeight: 120.0,
            // leading: IconButton(
            //     onPressed: () {
            //       _drawer();
            //     },
            //     icon: Icon(Icons.shopping_bag)),
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
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () =>
                    context.read<AuthBloc>().add(AppLogoutRequested()),
              )
            ],
          ),
          body: (state.status == ListStateStatus.initial)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (state.shoppingItemsList.isNotEmpty)
                  ? Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: ListView.builder(
                            itemCount: state.shoppingItemsList.length,
                            itemBuilder: (context, index) {
                              final listList =
                                  state.shoppingItemsList[index].list;
                              listList!.forEach(
                                (key, value) {
                                  final doc = value as Map<String, dynamic>;
                                  final listElements =
                                      ShoppingModel.fromJson(doc);

                                  listShoppingModels.add(listElements);
                                },
                              );
                              final listbad = listShoppingModels.isShop();
                              return Dismissible(
                                key: Key(listShoppingModels[index].id),
                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    context.read<ListCubit>().removeList(
                                          state.shoppingItemsList[index].listId,
                                          index,
                                        );
                                  }
                                },
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (direction) async {
                                  return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Delete Confirmation'),
                                        content: const Text(
                                          'Are you sure you want to delete'
                                          ' this list?',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text('Delete'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                // add background when is dismiss the item.
                                background: ColoredBox(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Icon(Icons.delete, color: Colors.white),
                                        Text(
                                          'Move to trash',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    final listShoppingModels2 =
                                        <ShoppingModel>[];
                                    final listList =
                                        state.shoppingItemsList[index].list;
                                    listList!.forEach(
                                      (key, value) {
                                        final doc =
                                            value as Map<String, dynamic>;
                                        final listElements =
                                            ShoppingModel.fromJson(doc);

                                        listShoppingModels2.add(listElements);
                                      },
                                    );
                                    Navigator.of(context).push(
                                      AddList.route(
                                        state.shoppingItemsList[index].listId,
                                        listShoppingModels2,
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        state.shoppingItemsList[index].listId,
                                        style: TextStyle(
                                          color: Colors.grey.shade900,
                                        ),
                                      ),
                                      trailing: Text(
                                        '${listbad.length}/${listList.length}',
                                        style: TextStyle(
                                          color: Colors.grey.shade900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const Center(child: Text('Add List')),
          floatingActionButton: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push<void>(ListDialog.route());
              }),
        );
      },
    );
  }
}

Widget _drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: const Text('Drawer Header'),
        ),
        const ListTile(
          title: Text('Home'),
        )
      ],
    ),
  );
}

class ListDialog extends StatefulWidget {
  const ListDialog({super.key});

  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (context) => const ListDialog(),
      );

  @override
  State<ListDialog> createState() => _ListDialogState();
}

class _ListDialogState extends State<ListDialog> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListCubit(
        DatabaseRepositoryImpl(),
      ),
      child: Builder(
        builder: (context) => Scaffold(
          body: AlertDialog(
            title: const Text('List Name'),
            content: TextField(
              style: const TextStyle(color: Colors.black),
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: 'Add New List'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Return'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    AddList.route(
                      _textEditingController.text,
                      [],
                    ),
                  );
                },
                child: const Text('Submit'),
              ),
            ],
            actionsAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
      ),
    );
  }
}

// /// First view [ShoppingView] for shopping list items
// class ShoppingView extends StatelessWidget {
//   const ShoppingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //acces to internalization
//     final l10n = context.l10n;
//     return Scaffold(
//       appBar: AppBar(
//         // toolbarHeight: 120.0,
//         leading: const Icon(Icons.shopping_bag),
//         title: Text(l10n.shoppingAppBarTitle),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.cached),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.person_add),
//           ),
//           IconButton(
//             icon: const Icon(Icons.exit_to_app),
//             onPressed: () => context.read<AuthBloc>().add(
//            AppLogoutRequested()),
//           )
//         ],
//         bottom: const PreferredSize(
//           preferredSize: Size(40, 60),
//           child: AddShoppingItem(),
//         ),
//       ),
//       body: BlocBuilder<DatabaseBloc, DatabaseState>(
//         builder: (context, state) {
//           // ignore: unnecessary_statements
//           context.watch<AddShoppingItemBloc>().state.changedValue.value;
//           context.read<DatabaseBloc>().add(DatabaseFetchData());
//           // }
//           if (state.status == DatabaseStateStatus.loading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.status == DatabaseStateStatus.success) {
//             if (state.listOfShoppingItems.isEmpty) {
//               return Center(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: SizedBox(
//                         height: 200,
//                         width: 300,
//                         child: Card(
//                           color: Colors.grey.shade500,
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(18),
//                                 child: Text(
//                                   'Adding Items',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headlineSmall!
//                                       .copyWith(
//                                         color: Colors.white,
//                                       ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(18),
//                                 child: Text(
//                                   'Tap "Add item" to type in items',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyLarge!
//                                       .copyWith(
//                                         color: Colors.white,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               final list = state.listOfShoppingItems.isToShop();
//               final listbad = state.listOfShoppingItems.isShop();

//               return Column(
//                 children: [
//                   const Expanded(
//                     flex: 5,
//                     child: MultipleSelectItems(),
//                   ),
//                   Container(
//                     height: 50,
//                     width: Responsive.width(100, context),
//                     color: Colors.black,
//                     padding: const EdgeInsets.all(8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           'Items in cart: ${list.length}',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodySmall!
//                               .copyWith(color: Colors.white),
//                         ),
//                         Text(
//                           'Items in list: ${listbad.length}',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodySmall!
//                               .copyWith(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
