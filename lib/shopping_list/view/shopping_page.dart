import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository_impl.dart';
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
        title: Text(l10n.shoppingAppBarTitle),
        centerTitle: true,
      ),
      bottomSheet: const AddNewItem(),
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
              return MultipleSelectItems(
                shoppingList: state.listOfShoppingItems,
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
