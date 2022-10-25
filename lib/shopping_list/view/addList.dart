import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobi_lab_shopping_list_app/adding_shopping_item/bloc/add_shopping_item_bloc.dart';
import 'package:mobi_lab_shopping_list_app/adding_shopping_item/view/adding_item_view.dart';
import 'package:mobi_lab_shopping_list_app/authentification/auth/bloc/auth_bloc.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/models/list.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/cubit/list_cubit.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository_impl.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/widgets/multiple_selection.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';
import 'package:mobi_lab_shopping_list_app/utils/utils.dart';

class AddList extends StatelessWidget {
  const AddList({
    super.key,
    required this.listname,
    required this.lista,
  });
  final String listname;
  final List<ShoppingModel> lista;

  static MaterialPageRoute<void> route(String _ids, List<ShoppingModel> list) =>
      MaterialPageRoute(
        builder: (context) => AddList(
          listname: _ids,
          lista: list,
        ),
      );
  @override
  Widget build(BuildContext context) {
    // createList(listx);
    return RepositoryProvider(
      create: (context) => DatabaseRepositoryImpl(),
      child: MultiBlocProvider(
        providers: [
          // Database connection bloc
          BlocProvider(
            create: (context) => DatabaseBloc(
              context.read<DatabaseRepositoryImpl>(),
            ),
          ),
          //  new item bloc
          BlocProvider(
            create: (context) => AddShoppingItemBloc(
              context.read<DatabaseRepositoryImpl>(),
            ),
          ),
          BlocProvider(
            create: (context) => ListCubit(
              DatabaseRepositoryImpl(),
            ),
          ),
        ],
        child: TextFieldForm(listname: listname, lista: lista),
      ),
    );
  }
}

class TextFieldForm extends StatefulWidget {
  const TextFieldForm({super.key, required this.listname, required this.lista});
  final String listname;
  final List<ShoppingModel> lista;

  @override
  State<TextFieldForm> createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  late TextEditingController _textEditingController;
  late List<ShoppingModel> shopping_list;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    context.read<DatabaseBloc>().add(DatabaseChanged(widget.lista));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
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
            onPressed: () => context.read<AuthBloc>().add(AppLogoutRequested()),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size(40, 60),
          child: AddShoppingItem(
            listName: widget.listname,
          ),
        ),
      ),
      body: BlocConsumer<AddShoppingItemBloc, AddShoppingItemState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            context.read<ListCubit>().getLists();
            context
                .read<DatabaseBloc>()
                .add(DatabaseFetchData(widget.listname));
          }
        },
        buildWhen: (previous, current) =>
            current.status == FormzStatus.submissionSuccess,
        builder: (context, state) {
          return BlocBuilder<DatabaseBloc, DatabaseState>(
            buildWhen: (previous, current) =>
                previous.listOfShoppingItems != current.listOfShoppingItems,
            builder: (context, state) {
              // ignore: unnecessary_statements
              // context.watch<AddShoppingItemBloc>().state.changedValue.value;
              // context
              //     .read<DatabaseBloc>()
              //     .add(DatabaseFetchData(widget.listname));

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
                      Expanded(
                        flex: 5,
                        child: MultipleSelectItems(listId: widget.listname),
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
        },
      ),
    );
  }
}

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({super.key});

  @override
  Widget build(BuildContext context) {
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
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        'Tap "Add item" to type in items',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
  }
}
