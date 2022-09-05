import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobi_lab_shopping_list_app/adding_shopping_item/view/adding_item_view.dart';
import 'package:mobi_lab_shopping_list_app/adding_shopping_item/bloc/add_shopping_item_bloc.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/network_conectivity/bloc/network_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository_impl.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/multiple_selection.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';

/// [ShoppingPage] holds the [MultiBlocProvider] that provides
/// accesability for [Bloc] into entire application.
class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // check connectivity to internet
        BlocProvider(
          create: (context) => NetworkBloc()..add(NetworkObserve()),
        ),
        // Database connection bloc
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
        ),
        //  new item bloc
        BlocProvider(
          create: (context) => AddShoppingItemBloc(DatabaseRepositoryImpl()),
        ),
      ],
      child: const ShoppingView(),
    );
  }
}

/// First view [ShoppingView] for shopping list items
class ShoppingView extends StatelessWidget {
  const ShoppingView({super.key});

  @override
  Widget build(BuildContext context) {
    //acces to internalization
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
          child: AddShoppingItem(),
        ),
        // centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              if (state is NetworkFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'No Internet Connection',
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.amberAccent,
                    padding: EdgeInsets.all(20),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
          BlocListener<AddShoppingItemBloc, AddShoppingItemState>(
            listener: (context, state) {
              if (state.status == FormzStatus.submissionSuccess) {
                context.read<DatabaseBloc>().add(DatabaseFetchData());
              }
            },
            // Bloc that Listen for changes and build accordingly
          ),
        ],
        child: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            if (state is NetworkFailure) {
              return SizedBox(
                width: Responsive.width(100, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'No Internet Connection',
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.wifi_off),
                  ],
                ),
              );
            } else {
              return BlocBuilder<DatabaseBloc, DatabaseState>(
                builder: (context, state) {
                  context.read<DatabaseBloc>().add(DatabaseFetchData());
                  // }
                  if (state.status == DatabaseStateStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == DatabaseStateStatus.success) {
                    if (state.listOfShoppingItems.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            const Text('No data retrived'),
                            FloatingActionButton(
                              tooltip: 'Refresh',
                              child: const Icon(Icons.refresh),
                              onPressed: () {
                                context
                                    .read<DatabaseBloc>()
                                    .add(DatabaseFetchData());
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      final list = state.listOfShoppingItems
                          .where((element) => element.isCompleted!)
                          .toList();
                      final listbad = state.listOfShoppingItems
                          .where((element) => element.isCompleted == false)
                          .toList();

                      return Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: MultipleSelectItems(
                              shoppingList: state.listOfShoppingItems,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: Responsive.width(100, context),
                            color: Colors.black,
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Items in cart: ${list.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  'Items in list: ${listbad.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
