import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobi_lab_shopping_list_app/adding_shopping_item/adding_shopping_item.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_repository_impl.dart';
import 'package:mobi_lab_shopping_list_app/auth/bloc/auth_bloc.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/network_conectivity/bloc/network_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/widgets.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';
import 'package:mobi_lab_shopping_list_app/utils/utils.dart';

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
        child: BlocBuilder<DatabaseBloc, DatabaseState>(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          height: 200,
                          width: 300,
                          child: Card(
                            color: Colors.grey.shade500,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Text(
                                    'Adding Items',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Text(
                                    'Tap "Add item" to type in items',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                final list = state.listOfShoppingItems.isToShop();
                final listbad = state.listOfShoppingItems.isShop();

                return Column(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: MultipleSelectItems(),
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
        ),
      ),
    );
  }
}
